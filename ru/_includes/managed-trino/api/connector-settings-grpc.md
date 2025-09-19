* `filesystem` — тип файлового хранилища. Доступные варианты:

    * `s3` — хранилище [{{ objstorage-full-name }}](../../../storage/quickstart/index.md).
    * `external_s3` — внешнее хранилище. Для него необходимо указать дополнительные параметры:

        * `aws_access_key` — идентификатор AWS-совместимого статического ключа доступа.
        * `aws_secret_key` — секретный ключ AWS-совместимого статического ключа доступа.
        * `aws_endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
        * `aws_region` — регион файлового хранилища, например `ru-central1`.

* `metastore.hive.uri` — URI для подключения к кластеру {{ metastore-name }} в формате `thrift://<IP-адрес_кластера>:9083`.

    Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** и на панели слева выберите ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
