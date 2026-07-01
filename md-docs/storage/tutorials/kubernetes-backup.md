# Резервное копирование кластера Managed Service for Kubernetes в Object Storage


Данные в [кластерах Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Однако в любой момент вы можете сделать резервные копии данных из [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) кластеров Managed Service for Kubernetes и хранить их в [Yandex Object Storage](../index.md) или другом хранилище.

Вы можете создавать резервные копии данных из групп узлов кластера Managed Service for Kubernetes с помощью инструмента [Velero](https://velero.io/). Этот инструмент поддерживает работу с [дисками](../../compute/concepts/disk.md) Yandex Cloud с помощью CSI-драйвера Kubernetes, и позволяет создавать моментальные [снимки дисков](../../compute/concepts/snapshot.md) [томов](../../managed-kubernetes/concepts/volume.md).

При работе с Velero, установленным вручную, вы можете использовать [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальный](https://kubernetes.io/docs/concepts/storage/volumes/#local) или любой другой тип тома, в котором нет встроенной поддержки моментальных снимков. Чтобы использовать такой тип тома, задействуйте [плагин restic](https://velero.io/docs/v1.8/restic/) при установке Velero. Плагин restic не включен в Velero, установленный из [Cloud Marketplace](https://yandex.cloud/ru/marketplace/products/yc/velero-yc-csi).

Из этой статьи вы узнаете, как создать резервную копию группы узлов одного кластера Managed Service for Kubernetes с помощью Velero, сохранить ее в Object Storage, а затем восстановить в группе узлов другого кластера:
1. [Создайте резервную копию группы узлов Managed Service for Kubernetes](#backup).
1. [Восстановите группу узлов другого кластера Managed Service for Kubernetes из резервной копии](#restore).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за каждый кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за ВМ (две группы узлов и ВМ для управления кластером без публичного доступа): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса для узлов кластеров ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за бакет Object Storage: хранение данных и выполнение операций с ними ([тарифы Object Storage](../../storage/pricing.md)).


## Перед началом работы {#before-you-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        Эти группы безопасности необходимо настроить для каждого кластера и группы узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. [Создайте два кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите группы безопасности, подготовленные ранее.

     Один кластер Managed Service for Kubernetes будет использован, чтобы создать резервную копию данных для группы узлов, другой — чтобы восстановить данные из копии.

     Если вы планируете работать с кластерами в пределах сети Yandex Cloud, выделять кластерам публичный IP-адрес не нужно. Для подключений извне предоставьте кластерам публичный адрес.

  1. [Создайте по группе узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) в каждом кластере. При создании выделите каждой группе публичный IP-адрес и укажите группы безопасности, подготовленные ранее.
  1. [Создайте бакет в Object Storage](../operations/buckets/create.md).
  1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) `compute.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) для работы с Velero.
  1. Выдайте [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) права **READ и WRITE** к [бакету](../concepts/bucket.md) в Object Storage. Для этого [выполните настройки ACL бакета](../operations/buckets/edit-acl.md).
  1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта и сохраните его идентификатор и значение. Получить значение ключа снова будет невозможно.

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

  1. Скачайте в ту же рабочую директорию файл конфигурации [velero-backup.tf](https://github.com/yandex-cloud-examples/yc-mk8s-velero-backup/blob/main/velero-backup.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * Два кластера Managed Service for Kubernetes и их группы узлов.
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластеров Managed Service for Kubernetes и групп узлов.
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        Эти группы безопасности будут использоваться обоими кластерами.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

     * Сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) `compute.admin` для работы с Velero.
     * Статический ключ доступа для сервисного аккаунта, предназначенного для работы с Velero.
     * [Бакет](../concepts/bucket.md) в Object Storage.
  1. Укажите в файле `velero-backup.tf`:
     * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут созданы ресурсы.
     * `k8s_version` — [версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) 1.22 или выше.
     * `zone_a_v4_cidr_blocks` — CIDR подсети, в которой будут размещены кластеры Managed Service for Kubernetes.
     * `sa_name_k8s` — имя сервисного аккаунта кластеров Managed Service for Kubernetes.
     * `sa_name_velero` — имя сервисного аккаунта для работы с Velero.
     * `storage_sa_id` — идентификатор сервисного аккаунта с ролью `storage.admin`. С помощью него будет создан бакет в Object Storage с разрешением `READ и WRITE` в [ACL](../concepts/acl.md) для сервисного аккаунта `sa_name_velero`.
     * `bucket_name` — имя бакета в Object Storage.
  1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, Terraform на них укажет.
  1. Создайте необходимую инфраструктуру:

     1. Выполните команду для просмотра планируемых изменений:
     
        ```bash
        terraform plan
        ```
     
        Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
     
     1. Если вас устраивают планируемые изменения, внесите их:
        1. Выполните команду:
     
           ```bash
           terraform apply
           ```
     
        1. Подтвердите изменение ресурсов.
        1. Дождитесь завершения операции.

     В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

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

Чтобы выполнить резервное копирование данных группы узлов Managed Service for Kubernetes:
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с первым кластером Managed Service for Kubernetes](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

1. Установите приложение Velero:
   
   {% list tabs group=instructions %}
   
   
   - Yandex Cloud Marketplace {#marketplace}
   
       Установите приложение Velero согласно [инструкции](../../managed-kubernetes/operations/applications/velero-yc-csi.md). В поле **Имя бакета Object Storage** укажите [созданный ранее](#before-you-begin) бакет.
   
       {% note warning  %}
   
       Если имя пространства имен, где установлено приложение Velero, отличается от `velero`, для всех последующих команд дополнительно используйте параметр `--namespace <пространство_имен_приложения_Velero>`.
   
       {% endnote %}
   
       {% note info %}
   
       Плагин restic для создания снимков томов [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальных](https://kubernetes.io/docs/concepts/storage/volumes/#local) и любых других типов томов без встроенной поддержки моментальных снимков, не включен в приложение Velero.
   
       {% endnote %}
   
   
   - Вручную {#manual}
   
       1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
   
           По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
       1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Velero.
       1. [Назначьте ему роль](../../iam/concepts/access-control/roles.md) `storage.editor` для доступа к [Yandex Object Storage](../index.md).
       1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:
   
           ```bash
           yc iam access-key create \
              --service-account-name=<имя_сервисного_аккаунта> \
              --format=json > sa-key.json
           ```
   
       1. Создайте файл `credentials` с данными статического ключа доступа, полученными ранее:
   
           ```ini
           [default]
           aws_access_key_id=<идентификатор_ключа>
           aws_secret_access_key=<секретная_часть_ключа>
           ```
   
       1. Установите серверную часть Velero в кластер Managed Service for Kubernetes:
   
           ```bash
           kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
           velero.io/csi-volumesnapshot-class="true" && \
           velero install \
             --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
             --bucket <имя_бакета> \
             --plugins velero/velero-plugin-for-aws:v1.5.2 \
             --provider aws \
             --secret-file <путь_к_файлу_credentials> \
             --features=EnableCSI \
             --use-volume-snapshots=true \
             --snapshot-location-config region=ru-central1 \
             --uploader-type=restic
           ```
   
           Где:
           * `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища Object Storage и регион.
           * `--bucket` — имя бакета Object Storage для хранения резервных копий, [созданного ранее](#before-you-begin).
           * `--plugins` — образы плагина для совместимости с AWS API.
           * `--provider` — имя провайдера объектного хранилища.
           * `--secret-file` — полный путь к файлу с данными статического ключа доступа.
           * `--features` — список активных функциональных возможностей.
           * `--snapshot-location-config` — зона доступности, в которой будут размещены снимки дисков.
           * (опционально) `--uploader-type=restic` — включение плагина restic для создания снимков томов [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальных](https://kubernetes.io/docs/concepts/storage/volumes/#local) и любых других типов томов без встроенной поддержки моментальных снимков.
   
           Результат:
   
           ```text
           CustomResourceDefinition/backups.velero.io: attempting to create resource
           CustomResourceDefinition/backups.velero.io: already exists, proceeding
           CustomResourceDefinition/backups.velero.io: created
           ...
           Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
           ```
   
       1. Убедитесь, что под Velero перешел в состояние `Running`:
   
           ```bash
           kubectl get pods --namespace velero
           ```
   
   {% endlist %}
1. Убедитесь, что квот на количество снимков дисков и их объем достаточно для создания резервной копии данных. Для этого можно использовать [сервис проверки квот](../../quota-manager/operations/read-quotas.md).
1. Выполните резервное копирование данных с группы узлов кластера Managed Service for Kubernetes:

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

## Восстановление данных из резервной копии {#restore}

Чтобы восстановить данные группы узлов кластера Managed Service for Kubernetes:
1. [Настройте kubectl](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) на работу со вторым кластером Managed Service for Kubernetes.

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

1. Установите приложение Velero:
   
   {% list tabs group=instructions %}
   
   
   - Yandex Cloud Marketplace {#marketplace}
   
       Установите приложение Velero согласно [инструкции](../../managed-kubernetes/operations/applications/velero-yc-csi.md). В поле **Имя бакета Object Storage** укажите [созданный ранее](#before-you-begin) бакет.
   
       {% note warning  %}
   
       Если имя пространства имен, где установлено приложение Velero, отличается от `velero`, для всех последующих команд дополнительно используйте параметр `--namespace <пространство_имен_приложения_Velero>`.
   
       {% endnote %}
   
       {% note info %}
   
       Плагин restic для создания снимков томов [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальных](https://kubernetes.io/docs/concepts/storage/volumes/#local) и любых других типов томов без встроенной поддержки моментальных снимков, не включен в приложение Velero.
   
       {% endnote %}
   
   
   - Вручную {#manual}
   
       1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
   
           По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
       1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Velero.
       1. [Назначьте ему роль](../../iam/concepts/access-control/roles.md) `storage.editor` для доступа к [Yandex Object Storage](../index.md).
       1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:
   
           ```bash
           yc iam access-key create \
              --service-account-name=<имя_сервисного_аккаунта> \
              --format=json > sa-key.json
           ```
   
       1. Создайте файл `credentials` с данными статического ключа доступа, полученными ранее:
   
           ```ini
           [default]
           aws_access_key_id=<идентификатор_ключа>
           aws_secret_access_key=<секретная_часть_ключа>
           ```
   
       1. Установите серверную часть Velero в кластер Managed Service for Kubernetes:
   
           ```bash
           kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
           velero.io/csi-volumesnapshot-class="true" && \
           velero install \
             --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
             --bucket <имя_бакета> \
             --plugins velero/velero-plugin-for-aws:v1.5.2 \
             --provider aws \
             --secret-file <путь_к_файлу_credentials> \
             --features=EnableCSI \
             --use-volume-snapshots=true \
             --snapshot-location-config region=ru-central1 \
             --uploader-type=restic
           ```
   
           Где:
           * `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища Object Storage и регион.
           * `--bucket` — имя бакета Object Storage для хранения резервных копий, [созданного ранее](#before-you-begin).
           * `--plugins` — образы плагина для совместимости с AWS API.
           * `--provider` — имя провайдера объектного хранилища.
           * `--secret-file` — полный путь к файлу с данными статического ключа доступа.
           * `--features` — список активных функциональных возможностей.
           * `--snapshot-location-config` — зона доступности, в которой будут размещены снимки дисков.
           * (опционально) `--uploader-type=restic` — включение плагина restic для создания снимков томов [nfs](https://kubernetes.io/docs/concepts/storage/volumes/#nfs), [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), [локальных](https://kubernetes.io/docs/concepts/storage/volumes/#local) и любых других типов томов без встроенной поддержки моментальных снимков.
   
           Результат:
   
           ```text
           CustomResourceDefinition/backups.velero.io: attempting to create resource
           CustomResourceDefinition/backups.velero.io: already exists, proceeding
           CustomResourceDefinition/backups.velero.io: created
           ...
           Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
           ```
   
       1. Убедитесь, что под Velero перешел в состояние `Running`:
   
           ```bash
           kubectl get pods --namespace velero
           ```
   
   {% endlist %}
1. Проверьте, что в новом кластере Managed Service for Kubernetes отображается резервная копия данных:

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

  * [Удалите кластеры Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  * Если вы зарезервировали для кластеров Managed Service for Kubernetes [публичные статические IP-адреса](../../vpc/concepts/address.md#public-addresses), [удалите их](../../vpc/operations/address-delete.md).
  * [Удалите бакет Object Storage](../operations/buckets/delete.md).
  * [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) для работы с Velero.

- Terraform {#tf}

  1. В терминале перейдите в директорию с планом инфраструктуры.
  
      {% note warning %}
  
      Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
  
      {% endnote %}
  
  1. Удалите ресурсы:
  
      1. Выполните команду:
  
          ```bash
          terraform destroy
          ```
  
      1. Подтвердите удаление ресурсов и дождитесь завершения операции.
  
      Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}