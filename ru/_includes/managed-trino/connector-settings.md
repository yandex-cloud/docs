* **URI** — URI для подключения к кластеру {{ metastore-name }} в формате `thrift://<IP-адрес_кластера>:9083`.

  Чтобы узнать IP-адрес кластера {{ metastore-name }}:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.metastore.label_metastore }}**.

  {% include [metastore version](metastore-version-catalog-create.md) %}

* **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [{{ objstorage-full-name }}](../../storage/quickstart/overview.md) и внешнее хранилище.

    {% include [objstorage-sa-roles](objstorage-sa-roles.md) %}

    Для внешнего хранилища необходимо указать:

    * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
    * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
    * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
    * **Регион** — регион файлового хранилища, например `ru-central1`.
