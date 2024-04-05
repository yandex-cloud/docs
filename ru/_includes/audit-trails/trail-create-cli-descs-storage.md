
* `--destination-bucket` — [имя бакета](../../storage/concepts/bucket.md#naming), в который будут загружаться аудитные логи.
    Чтобы получить список бакетов в каталоге по умолчанию, выполните команду CLI `yc storage bucket list`.

* `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

    {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}