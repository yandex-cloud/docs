{% note warning %}

Должно быть указано только одно место назначения: `storage_destination` , `logging_destination` или `data_stream_destination`.

{% endnote %}

* `logging_destination` — загружать логи в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}.

    * `log_group_id` — [идентификатор лог-группы](../../logging/operations/get-group.md), в которую трейл будет сохранять аудитные логи.
* `storage_destination` — загружать логи в [бакет](../../storage/concepts/bucket.md) {{ objstorage-full-name }}:

    * `bucket_name` — имя бакета, куда трейл будет сохранять аудитные логи.
    * `object_prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

        {% include [note-bucket-prefix](note-bucket-prefix.md) %}

* `data_stream_destination` — загружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}:

    * `stream_name` — имя потока данных, в который трейл будет сохранять аудитные логи.
    * `database_id` — идентификатор базы данных {{ ydb-full-name }}, которая используется потоком данных {{ yds-name }}.