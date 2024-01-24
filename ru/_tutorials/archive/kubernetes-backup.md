# Резервное копирование кластера {{ managed-k8s-name }} в {{ objstorage-name }}

Данные в [кластерах {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре {{ yandex-cloud }}. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров {{ managed-k8s-name }} и хранить их в [{{ objstorage-full-name }}](../../storage/) или другом хранилище.

Вы можете создавать резервные копии данных из групп узлов кластера {{ managed-k8s-name }} с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../compute/concepts/disk.md) {{ yandex-cloud }} с помощью CSI-драйвера {{ k8s }}, и позволяет создавать моментальные [снимки дисков](../../compute/concepts/snapshot.md) [томов](../../managed-kubernetes/concepts/volume.md).

При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Velero, установленный из [{{ marketplace-name }}](/marketplace/products/yc/velero-yc-csi), плагин restic не включает.

Из этой статьи вы узнаете, как создать резервную копию группы узлов одного кластера {{ managed-k8s-name }} с помощью Velero, сохранить ее в {{ objstorage-name }}, а затем восстановить в группе узлов другого кластера:
1. [Создайте резервную копию группы узлов {{ managed-k8s-name }}](#backup).
1. [Восстановите группу узлов другого кластера {{ managed-k8s-name }} из резервной копии](#restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте два кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}.

     Один кластер {{ managed-k8s-name }} будет использован, чтобы создать резервную копию данных для группы узлов, другой — чтобы восстановить данные из копии.

     Если вы планируете работать с кластерами в пределах сети {{ yandex-cloud }}, выделять кластерам публичный IP-адрес не нужно. Для подключений извне предоставьте кластерам публичный адрес.

  1. [Создайте по группе узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в каждом кластере и выделите каждой группе публичный IP-адрес.
  1. [Создайте бакет в {{ objstorage-name }}](../../storage/operations/buckets/create.md).
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `compute.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) для работы с Velero.
  1. Выдайте [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) права **READ и WRITE** к [бакету](../../storage/concepts/bucket.md) в {{ objstorage-name }}. Для этого [выполните настройки ACL бакета](../../storage/operations/buckets/edit-acl.md).
  1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта и сохраните его идентификатор и значение. Получить значение ключа снова будет невозможно.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Скачайте в ту же рабочую директорию файл конфигурации [velero-backup.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/velero-backup.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группы безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы кластеров {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правило для подключения к сервисам из интернета.
     * Два кластера {{ managed-k8s-name }} и их группы узлов.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластеров {{ managed-k8s-name }} и групп узлов.
     * Сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) `compute.admin` для работы с Velero.
     * Статический ключ доступа для сервисного аккаунта, предназначенного для работы с Velero.
     * [Бакет](../../storage/concepts/bucket.md) в {{ objstorage-name }}.
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

1. Выберите [клиентскую часть Velero](https://github.com/vmware-tanzu/velero/releases) для своей платформы согласно [таблице совместимости](https://github.com/vmware-tanzu/velero#velero-compatibility-matrix).
1. Скачайте клиентскую часть Velero, распакуйте архив и установите программу. Подробнее об установке программы читайте в [документации Velero](https://velero.io/docs/main/basic-install/#install-the-cli).
1. Убедитесь, что клиентская часть Velero установлена. Для этого выполните команду:

   ```bash
   velero version
   ```

   Результат:

   ```text
   Client:
           Version: v1.10.3
           Git commit: 18ee078dffd9345df610e0ca9f61b31124e93f50
   ```

## Резервное копирование {#backup}

Чтобы выполнить резервное копирование данных группы узлов {{ managed-k8s-name }}:
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с первым кластером {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

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
1. [Настройте kubectl](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) на работу со вторым кластером {{ managed-k8s-name }}.

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

1. {% include [install-velero](../../_includes/managed-kubernetes/install-velero.md) %}
1. Проверьте, что в новом кластере {{ managed-k8s-name }} отображается резервная копия данных:

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

   * `--exclude-namespaces` — список пространств имен, которые необходимо исключить из процесса восстановления.
   * `--from-backup` — имя резервной копии для восстановления.

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

{% list tabs group=instructions %}

- Вручную {#manual}

  * [Удалите кластеры {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  * Если вы зарезервировали для кластеров {{ managed-k8s-name }} [публичные статические IP-адреса](../../vpc/concepts/address.md#public-addresses), [удалите их](../../vpc/operations/address-delete.md).
  * [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
  * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) для работы с Velero.

- {{ TF }} {#tf}

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
