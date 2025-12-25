  * **URI** — URI для подключения к кластеру {{ metastore-name }} в формате `thrift://<IP-адрес_кластера>:9083`.

    Чтобы узнать IP-адрес кластера {{ metastore-name }}:
      1. Перейдите на страницу [каталога ресурсов]({{ link-console-main }}).
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.

    {% include [metastore version](metastore-version-catalog-create.md) %}

  * **Файловое хранилище** — тип файлового хранилища. Доступные варианты: [{{ objstorage-full-name }}](../../storage/quickstart/index.md) и внешнее хранилище.

    Для внешнего хранилища необходимо указать:

      * **Идентификатор ключа доступа** — идентификатор AWS-совместимого статического ключа доступа.
      * **Секретный ключ** — секретный ключ AWS-совместимого статического ключа доступа.
      * **Эндпоинт** — эндпоинт файлового хранилища, например `storage.yandexcloud.net`.
      * **Регион** — регион файлового хранилища, например `ru-central1`.
