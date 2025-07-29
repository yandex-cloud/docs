* `--cluster-id` — идентификатор кластера, в котором создается каталог {{ TR }}. Идентификатор кластера можно запросить со [списком кластеров](../../managed-trino/operations/cluster-list.md#list-clusters).
* `--metastore-hive-uri` — URI для подключения к кластеру {{ metastore-name }} в формате `thrift://<IP-адрес_кластера>:<порт>`.

  Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

* `--filesystem-native-s3` — хранилище [{{ objstorage-full-name }}](../../storage/quickstart/index.md).
* `--filesystem-external-s3-aws-access-key` — идентификатор AWS-совместимого статического ключа доступа.
* `--filesystem-external-s3-aws-secret-key` — секретный ключ AWS-совместимого статического ключа доступа.
* `--filesystem-external-s3-aws-endpoint` — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
* `--filesystem-external-s3-aws-region` — регион файлового хранилища, например `ru-central1`.

  {% note info %}

  Укажите либо флаг `--filesystem-native-s3`, чтобы использовать хранилище {{ objstorage-name }}, либо флаги группы `--filesystem-external-s3-aws`, чтобы использовать внешнее хранилище.

  {% endnote %}