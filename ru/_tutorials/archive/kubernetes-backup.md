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

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Выберите [версию клиентской части Velero](https://github.com/vmware-tanzu/velero/releases) версии `1.8.1` или ниже для своей платформы.
1. Скачайте клиентскую часть Velero, распакуйте архив и установите программу. Подробнее об установке программы читайте в [документации Velero](https://velero.io/docs/v1.5/basic-install/#install-the-cli).
1. Посмотрите описание любой команды Velero:

   ```bash
   velero --help
   ```

1. [Создайте бакет](../../storage/operations/buckets/create.md) {{ objstorage-name }}:
   * **Имя** — `velero-backup`.
   * **Класс хранилища** — `Стандартное`.
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md):
   * **Имя** — `velero-sa`.
   * **Роли в каталоге** — `compute.admin`.
1. Выдайте сервисному аккаунту `velero-sa` права **READ и WRITE** к бакету `velero-backup`. Для этого [выполните настройки ACL бакета](../../storage/operations/buckets/edit-acl.md).
1. Создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `velero-sa`:

   ```bash
   yc iam access-key create --service-account-name velero-sa
   ```

   Результат:

   ```bash
   access_key:
     id: abcdo12h3j04odg56def
     service_account_id: ajego12h3j03slk16upe
     created_at: "2020-10-19T13:22:29Z"
     key_id: <идентификатор ключа>
   secret: <значение секретного ключа>
   ```

   {% note info %}

   Сохраните идентификатор и значение секретного ключа. Получить значение ключа снова будет невозможно.

   {% endnote %}

1. Создайте файл `credentials` с данными статического ключа доступа, полученными ранее:

   ```ini
   [default]
     aws_access_key_id=<идентификатор ключа>
     aws_secret_access_key=<значение секретного ключа>
   ```

## Резервное копирование {#backup}

Чтобы выполнить резервное копирование данных группы узлов:
1. [Создайте кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании группы узлов выберите автоматический способ назначения IP-адреса.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Установите серверную часть Velero в кластер {{ managed-k8s-name }}:

   ```bash
   kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
   velero.io/csi-volumesnapshot-class="true" && \
   velero install \
     --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
     --bucket velero-backup \
     --plugins velero/velero-plugin-for-aws:v1.3.0,velero/velero-plugin-for-csi:v0.2.0 \
     --provider aws \
     --secret-file ./credentials \
     --features=EnableCSI \
     --use-volume-snapshots=true \
     --snapshot-location-config region={{ region-id }} \
     --use-restic
   ```

   Где:
   * `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища {{ objstorage-name }} и регион.
   * `--bucket` — имя бакета для хранения резервных копий.
   * `--plugins` — образы плагина для совместимости с AWS API.
   * `--provider` — имя провайдера объектного хранилища.
   * `--secret-file` — полный путь к файлу с данными статического ключа доступа.
   * `--features` — список активных функциональных возможностей.
   * `--snapshot-location-config` — зона доступности, в которой будут размещены снимки дисков.
   * (опционально) `--use-restic` — включение плагина restic.

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
   kubectl get pods -n velero
   ```

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
1. [Создайте новый кластер {{ managed-k8s-name }} ](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании группы узлов выберите автоматический способ назначения IP-адреса.
1. [Настройте kubectl](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) на работу с новым кластером.
1. Установите серверную часть Velero в кластер {{ managed-k8s-name }}:

   ```bash
   kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
   velero.io/csi-volumesnapshot-class="true" && \
   velero install \
     --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
     --bucket velero-backup \
     --plugins velero/velero-plugin-for-aws:v1.3.0,velero/velero-plugin-for-csi:v0.2.0 \
     --provider aws \
     --secret-file ./credentials \
     --features=EnableCSI \
     --use-volume-snapshots=true \
     --snapshot-location-config region={{ region-id }} \
     --use-restic
   ```

   Где:
   * `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища {{ objstorage-name }} и регион.
   * `--bucket` — имя бакета для хранения резервных копий.
   * `--plugins` — образы плагина для совместимости с AWS API.
   * `--provider` — имя провайдера объектного хранилища.
   * `--secret-file` — полный путь к файлу с данными статического ключа доступа.
   * `--features` — список активных функциональных возможностей.
   * `--snapshot-location-config` — выбор зоны доступности для расположения снимков дисков.
   * (опционально) `--use-restic` — включение плагина restic.

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
   kubectl get pods -n velero
   ```

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
   velero restore create my-restore --exclude-namespaces velero --from-backup my-backup
   ```

   Где:
   * `--exclude-namespaces` — флаг, позволяющий не восстанавливать объекты из пространства имен `velero`.
   * `--from-backup` — имя бакета, в котором хранится резервная копия.

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

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:

1. [Удалите кластеры {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластеров публичные статические IP-адреса, [удалите их](../../vpc/operations/address-delete.md).
1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) `velero-sa`.