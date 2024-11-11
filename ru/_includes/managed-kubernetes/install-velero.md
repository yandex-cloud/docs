Установите приложение Velero:

{% list tabs group=instructions %}

- {{ marketplace-full-name }} {#marketplace}

    Установите приложение Velero согласно [инструкции](../../managed-kubernetes/operations/applications/velero-yc-csi.md). В поле **Имя бакета Object Storage** укажите [созданный ранее](#before-you-begin) бакет.

    {% note warning  %}

    Если имя пространства имен, где установлено приложение Velero, отличается от `velero`, для всех последующих команд дополнительно используйте параметр `--namespace <пространство_имен_приложения_Velero>`.

    {% endnote %}

- Вручную {#manual}

    1. {% include [cli-install](../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Velero.
    1. [Назначьте ему роль](../../iam/concepts/access-control/roles.md) `storage.editor` для доступа к [{{ objstorage-full-name }}](../../storage/).
    1. [Создайте статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

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

    1. Установите серверную часть Velero в кластер {{ managed-k8s-name }}:

        ```bash
        kubectl label volumesnapshotclasses.snapshot.storage.k8s.io yc-csi-snapclass \
        velero.io/csi-volumesnapshot-class="true" && \
        velero install \
          --backup-location-config s3Url=https://{{ s3-storage-host }},region={{ region-id }} \
          --bucket <имя_бакета> \
          --plugins velero/velero-plugin-for-aws:v1.5.2 \
          --provider aws \
          --secret-file <путь_к_файлу_credentials> \
          --features=EnableCSI \
          --use-volume-snapshots=true \
          --snapshot-location-config region={{ region-id }} \
          --uploader-type=restic
        ```

        Где:
        * `--backup-location-config` — параметры хранилища резервных копий. URL-адрес хранилища {{ objstorage-name }} и регион.
        * `--bucket` — имя бакета {{ objstorage-name }} для хранения резервных копий, [созданного ранее](#before-you-begin).
        * `--plugins` — образы плагина для совместимости с AWS API.
        * `--provider` — имя провайдера объектного хранилища.
        * `--secret-file` — полный путь к файлу с данными статического ключа доступа.
        * `--features` — список активных функциональных возможностей.
        * `--snapshot-location-config` — зона доступности, в которой будут размещены снимки дисков.
        * (опционально) `--uploader-type=restic` — включение плагина restic.

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