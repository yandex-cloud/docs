### Перенесите StatefulSets с PersistentVolumes {#statefulsets-persistent-volumes}

Для переноса StatefulSets с PersistentVolumes используйте [Velero](https://velero.io/) с резервным копированием файловой системы через `node-agent` с использованием Kopia. Этот способ не зависит от CSI-провайдера. Перед переносом проверьте [ограничения резервного копирования файловой системы](https://velero.io/docs/main/file-system-backup/#limitations) для ваших томов.

{% note tip %}

Если объем данных меньше 50 ГБ или Velero недоступен, можно перенести данные вручную с помощью `rsync`. Для этого потребуется прямая сетевая связность между кластерами.

{% endnote %}

Порядок действий:

1. Создайте бакет в [{{ objstorage-full-name }}](../../../storage/index.yaml) для хранения резервных копий.

1. Создайте файл `credentials-velero` с данными [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для [сервисного аккаунта](../../../iam/operations/sa/create.md), имеющего доступ к бакету:

   ```
   [default]
   aws_access_key_id = <идентификатор_ключа>
   aws_secret_access_key = <секретный_ключ>
   ```

1. [Установите Velero CLI](https://velero.io/docs/main/basic-install/) на машину, с которой будет выполняться перенос и есть `kubectl`-доступ к исходному и целевому кластерам.

   {% note info %}

   Версия плагина `velero-plugin-for-aws` в командах ниже может быть устаревшей. Актуальную версию смотрите в [документации Velero](https://velero.io/docs/main/supported-providers/).

   {% endnote %}

1. Установите Velero в исходном кластере:

   1. Убедитесь, что активен контекст исходного кластера:

      ```bash
      kubectl config current-context
      ```

   1. Создайте пространство имен для Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Установите Velero:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <имя_бакета> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

      Где:

      * `--provider aws` — использует плагин AWS, совместимый с {{ objstorage-name }}.
      * `--use-node-agent` — включает DaemonSet для резервного копирования файловой системы.
      * `--uploader-type=kopia` — рекомендуемый загрузчик, работает быстрее restic.
      * `--use-volume-snapshots=false` — отключает CSI-снапшоты, данные переносятся через kopia.

   1. Проверьте статус компонентов:

      ```bash
      kubectl get pods -n velero
      kubectl get backupstoragelocation -n velero
      velero backup-location get
      ```

      `BackupStorageLocation` должен перейти в статус `Available`.

1. Остановите запись приложений на переносимые PersistentVolumes в исходном кластере, при этом оставьте их смонтированными в подах.

1. Создайте резервную копию нужных пространств имен:

   ```bash
   velero backup create migration-backup \
     --include-namespaces <пространство_имен> \
     --default-volumes-to-fs-backup \
     --wait
   ```

   Проверить статус и логи можно командами:

   ```bash
   velero backup describe migration-backup --details
   velero backup logs migration-backup
   ```

1. Установите Velero в целевом кластере {{ managed-k8s-name }}:

   1. Переключитесь на контекст целевого кластера:

      ```bash
      kubectl config use-context <контекст_целевого_кластера>
      ```

   1. Создайте пространство имен для Velero:

      ```bash
      kubectl create namespace velero
      ```

   1. Установите Velero с теми же параметрами, что и в исходном кластере, указав тот же бакет:

      ```bash
      velero install \
        --provider aws \
        --plugins velero/velero-plugin-for-aws:v1.14.0 \
        --bucket <имя_бакета> \
        --secret-file ./credentials-velero \
        --backup-location-config \
          region=ru-central1,s3ForcePathStyle=true,s3Url=https://storage.yandexcloud.net \
        --use-volume-snapshots=false \
        --use-node-agent \
        --uploader-type=kopia
      ```

   1. Убедитесь, что резервная копия из исходного кластера видна в целевом:

      ```bash
      kubectl get pods -n velero
      velero backup-location get
      velero backup get
      ```

      `BackupStorageLocation` должен перейти в статус `Available`, а резервная копия `migration-backup` — в статус `Completed`.

1. Восстановите данные из резервной копии:

   ```bash
   velero restore create migration-restore \
     --from-backup migration-backup \
     --wait
   ```

   {% note info %}

   Если StorageClass в исходном кластере и {{ managed-k8s-name }} называются по-разному, создайте ConfigMap с маппингом StorageClass до запуска восстановления:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: change-storage-class-config
     namespace: velero
     labels:
       velero.io/plugin-config: ""
       velero.io/change-storage-class: RestoreItemAction
   data:
     <исходный_storage_class>: <целевой_storage_class>
   ```

   {% endnote %}


1. Проверьте статус и логи восстановления:

   ```bash
   velero restore describe migration-restore --details
   velero restore logs migration-restore
   ```
