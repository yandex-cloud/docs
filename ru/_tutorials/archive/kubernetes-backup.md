# Резервное копирование кластера {{ managed-k8s-name }} в {{ objstorage-name }}

Данные в [кластерах {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров {{ managed-k8s-name }} и хранить их в [{{ objstorage-full-name }}](../../storage/) или другом хранилище.

Вы можете создавать резервные копии данных из групп узлов кластера {{ managed-k8s-name }} с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../compute/concepts/disk.md) {{ yandex-cloud }} с помощью CSI-драйвера {{ k8s }}, и позволяет создавать моментальные [снимки дисков](../../compute/concepts/snapshot.md) [томов](../../managed-kubernetes/concepts/volume.md).

{% note tip %}

При работе с Velero вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero.

{% endnote %}

Из этой статьи вы узнаете, как создать резервную копию группы узлов одного кластера {{ k8s }} с помощью Velero, сохранить ее в {{ objstorage-name }}, а затем восстановить в группе узлов другого кластера:
1. [Создайте резервную копию группы узлов](#backup).
1. [Восстановите группу узлов другого кластера из резервной копии](#restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

  1. [Создайте два кластера {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в каждом со следующими настройками:
    * **Версия {{ k8s }}** — **1.22** или выше.
    * **Публичный адрес** — `Автоматически`.

    Один кластер {{ managed-k8s-name }} будет использован для создания резервной копии группы узлов, другой — для восстановления.
  1. [Создайте бакет в {{ objstorage-name }}](../../storage/operations/buckets/create.md).
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `compute.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) для работы с Velero.
  1. Выдайте [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) права **READ и WRITE** к [бакету](../../storage/concepts/bucket.md) в {{ objstorage-name }}. Для этого [выполните настройки ACL бакета](../../storage/operations/buckets/edit-acl.md).
  1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта и сохраните его идентификатор и значение. Получить значение ключа снова будет невозможно.

- С помощью Terraform

  1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации [velero-backup.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/velero-backup.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группы безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы кластеров {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правило для подключения к сервисам из интернета.
     * Два кластера {{ managed-k8s-name }} и их группы узлов.
     * Сервисный аккаунт, необходимый для работы кластеров и групп узлов {{ managed-k8s-name }}.
     * Сервисный аккаунт с ролью `compute.admin` для работы с Velero.
     * Статический ключ доступа для сервисного аккаунта, предназначенного для работы с Velero.
     * Бакет в {{ objstorage-name }}.
  1. Укажите в файле `velero-backup.tf`:
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
     * `k8s_version` — [версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) 1.22 или выше.
     * `zone_a_v4_cidr_blocks` — CIDR подсети, в которой будут размещены кластеры {{ managed-k8s-name }}.
     * `sa_name_k8s` — имя сервисного аккаунта кластеров {{ managed-k8s-name }}.
     * `sa_name_velero` — имя сервисного аккаунта для работы с Velero.
     * `storage_sa_id` — идентификатор сервисного аккаунта с ролью `storage.admin`. С помощью него будет создан бакет в {{ objstorage-name }} с разрешением `READ и WRITE` в [ACL](../../storage/concepts/acl.md) для сервисного аккаунта `sa_name_velero`.
     * `bucket_name` — имя бакета в {{ objstorage-name }}.
  1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

  1. Получите и сохраните идентификатор и значение статического ключа сервисного аккаунта, предназначенного для работы с Velero:
     * Идентификатор ключа:

       ```bash
       terraform output -raw access_key
       ```

     * Значение ключа:

       ```bash
       terraform output -raw secret_key
       ```

{% endlist %}

### Выполните дополнительные настройки {#additional-settings}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Выберите [клиентскую часть Velero](https://github.com/vmware-tanzu/velero/releases) версии `1.8.1` или ниже.
1. Скачайте клиентскую часть Velero, распакуйте архив и установите программу. Подробнее об установке программы читайте в [документации Velero](https://velero.io/docs/v1.5/basic-install/#install-the-cli).
1. Посмотрите описание любой команды Velero:

   ```bash
   velero --help
   ```

1. Создайте файл `credentials` с данными статического ключа доступа, полученными ранее:

   ```ini
   [default]
     aws_access_key_id=<идентификатор ключа>
     aws_secret_access_key=<значение ключа>
   ```

## Резервное копирование {#backup}

Чтобы выполнить резервное копирование данных группы узлов {{ managed-k8s-name }}:
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с первым кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. {% include [install-velero](../../_includes/managed-kubernetes/install-velero.md) %}

1. Выполните резервное копирование данных с группы узлов кластера {{ managed-k8s-name }}:

   ```bash
   velero backup create my-backup
   ```

   Результат:

   ```text
   Backup request "my-backup" submitted successfully.
   Run `velero backup describe my-backup` or `velero backup logs my-backup` for more details.
   ```

1. Дождитесь завершения резервного копирования. В графе `STATUS` появится значение `Completed`.

   ```bash
   velero backup get
   ```

   Результат:

   ```text
   NAME       STATUS     ERRORS  WARNINGS  CREATED                        EXPIRES  STORAGE LOCATION  SELECTOR
   my-backup  Completed  0       0         2020-10-19 17:13:25 +0300 MSK  29d      default           <none>
   ```

## Восстановление данных их резервной копии {#restore}

Чтобы восстановить данные группы узлов кластера {{ managed-k8s-name }}:
1. [Настройте kubectl](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) на работу со вторым кластером.

1. {% include [install-velero](../../_includes/managed-kubernetes/install-velero.md) %}

1. Проверьте, что в новом кластере отображается резервная копия данных:

   ```bash
   velero backup get
   ```

   Результат:

   ```text
   NAME       STATUS     ERRORS  WARNINGS  CREATED                        EXPIRES  STORAGE LOCATION  SELECTOR
   my-backup  Completed  0       0         2020-10-19 17:13:25 +0300 MSK  29d      default           <none>
   ```

1. Восстановите данные из резервной копии:

   ```bash
   velero restore create my-restore \
     --exclude-namespaces velero \
     --from-backup my-backup
   ```

   Где:
   * `--exclude-namespaces` — флаг, позволяющий не восстанавливать объекты из пространства имен `velero`.
   * `--from-backup` — имя резервной копии.

   Результат:

   ```text
   Restore request "my-restore" submitted successfully.
   Run `velero restore describe my-restore` or `velero restore logs my-restore` for more details.
   ```

1. Дождитесь завершения восстановления данных из резервной копии. В графе `STATUS` появится значение `Completed`.

   ```bash
   velero get restore
   ```

   Результат:

   ```text
   NAME        BACKUP     STATUS     STARTED                        COMPLETED                      ERRORS  WARNINGS  CREATED                        SELECTOR
   my-restore  my-backup  Completed  2020-10-20 14:04:55 +0300 MSK  2020-10-20 14:05:22 +0300 MSK  0       23        2020-10-20 14:04:55 +0300 MSK  <none>
   ```

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

{% list tabs %}

- Вручную

  * [Удалите кластеры {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  * Если вы зарезервировали для кластеров [публичные статические IP-адреса](../../vpc/concepts/address.md#public-addresses), [удалите их](../../vpc/operations/address-delete.md).
  * [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
  * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) для работы с Velero.

- С помощью {{ TF }}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  1. Удалите конфигурационный файл `velero-backup.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `velero-backup.tf`, будут удалены.

{% endlist %}