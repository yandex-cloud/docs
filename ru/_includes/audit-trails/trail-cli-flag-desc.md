* `--description` — описание трейла. Необязательный параметр.
* `--labels` — список [меток](../../resource-manager/concepts/labels.md). Необязательный параметр. Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.
* `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта.
* `--destination-bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета {{ objstorage-full-name }}, в который будут загружаться аудитные логи.

    С этим параметром нельзя использовать параметры `--destination-log-group-id` и `--destination-yds-stream`.
* `--destination-bucket-object-prefix` — [префикс](../../storage/concepts/object.md#folder), который будет присвоен объектам с аудитными логами в бакете. Необязательный параметр, участвует в [полном имени](../../audit-trails/concepts/format.md#log-file-name) файла аудитного лога.

    {% include [note-bucket-prefix](./note-bucket-prefix.md) %}

* `--destination-log-group-id` — идентификатор [лог-группы](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, в которую будут загружаться аудитные логи.

    С этим параметром нельзя использовать параметры `--destination-bucket` и `--destination-yds-stream`.
* `--destination-yds-stream` — имя [потока данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}, в который будут загружаться аудитные логи.

    С этим параметром нельзя использовать параметры `--destination-bucket` и `--destination-log-group-id`.
* `--destination-yds-database-id` — идентификатор базы данных {{ ydb-short-name }}, которая используется потоком данных {{ yds-name }}.
* `--filter-all-folder-id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
* `--filter-all-cloud-id` — [идентификатор](../../resource-manager/operations/cloud/get-id.md) облака, для всех ресурсов которого будут регистрироваться события уровня конфигурации.
* `--filter-all-organisation-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, для всех ресурсов которой будут регистрироваться события уровня конфигурации.
* `--filter-some-folder-ids` — список идентификаторов каталогов, для всех ресурсов которых будут регистрироваться события уровня конфигурации в облаке, заданном в поле `--filter-from-cloud-id`.

    Параметр используется только в паре с параметром `--filter-from-cloud-id`.
* `--filter-from-cloud-id` — идентификатор облака, в котором находятся каталоги, заданные в параметре `--filter-some-folder-ids`.

    Параметр используется только в паре с параметром `--filter-some-folder-ids`.
* `--filter-some-cloud-ids` — список идентификаторов облаков, для всех ресурсов которых будут регистрироваться события уровня конфигурации в организации, заданной в поле `--filter-from-organisation-id`.

    Параметр используется только в паре с параметром `--filter-from-organisation-id`.
* `--filter-from-organisation-id` — идентификатор организации, в которой находятся облака, заданные в параметре `--filter-some-folder-ids`.

    Параметр используется только в паре с параметром `--filter-some-cloud-ids`.