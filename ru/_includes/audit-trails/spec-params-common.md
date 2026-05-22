* `destination` — настройки выбранного места назначения, куда будут загружаться аудитные логи.

    {% note warning %}

    Настройки мест назначения взаимоисключающие. Использование одних настроек делает невозможным использование других.

    {% endnote %}

    * `object_storage` — загружать логи в [бакет](../../storage/concepts/bucket.md#naming) {{ objstorage-full-name }}:

        * `bucket_id` — [имя](../../storage/concepts/bucket.md#naming) бакета.

            Имя бакета можно запросить со списком бакетов в каталоге (используется каталог по умолчанию):

            ```bash
            yc storage bucket list
            ```
        * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

            {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

    * `cloud_logging` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

        В параметре `log_group_id` укажите идентификатор лог-группы. Идентификатор можно запросить со [списком лог-групп в каталоге](../../logging/operations/list.md).
    * `data_stream` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}:

        * `stream_name` — имя потока данных. Имя можно запросить со [списком потоков данных в каталоге](../../data-streams/operations/manage-streams.md#list-data-streams).
        * `database_id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}. Идентификатор можно запросить со [списком баз данных {{ ydb-short-name }} в каталоге](../../ydb/operations/manage-databases.md#list-db).
* `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.