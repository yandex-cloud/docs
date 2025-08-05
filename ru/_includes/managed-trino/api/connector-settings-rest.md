* `filesystem` — тип файлового хранилища. Доступные варианты:

    * `s3` — хранилище [{{ objstorage-full-name }}](../../../storage/quickstart/index.md).
    * `externalS3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:

        * `awsAccessKey` — идентификатор AWS-совместимого статического ключа доступа.
        * `awsSecretKey` — секретный ключ AWS-совместимого статического ключа доступа.
        * `awsEndpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
        * `awsRegion` — регион файлового хранилища, например `ru-central1`.

* `metastore.hive.uri` — URI для подключения к кластеру {{ metastore-name }} в формате `thrift://<IP-адрес_кластера>:<порт>`.

    Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** и на панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
