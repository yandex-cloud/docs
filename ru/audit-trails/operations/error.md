# Обработка ошибок


Если трейл не может отправить аудитные логи в [объект назначения](../concepts/trail.md#target), [статус трейла](../concepts/trail.md#status) изменится на `Error`. Инструкция содержит рекомендации по восстановлению нормальной работы трейла.

{% note info %}

Через несколько минут после устранения причины ошибки, трейл изменит статус на `Active`. Все аудитные логи будут загружены в объект назначения.

{% endnote %}


Объекты назначения:
* [Бакет {{ objstorage-name }}](#storage).
* [Поток данных {{ yds-name }}](#data-streams).
* [Лог-группа {{ cloud-logging-name }}](#cloud-logging).


## Бакет {{ objstorage-name }} {#storage}

### ACCESS_DENIED {#bucket-access-denied}

* Проверьте, что сервисному аккаунту, от имени которого трейл загружает аудитные логи в бакет, назначена [роль](../../storage/security/index.md#storage-uploader) `storage.uploader` или выше.
* Если бакет [зашифрован](../../storage/tutorials/server-side-encryption.md) ключом {{ kms-full-name }}, убедитесь, что у сервисного аккаунта, от имени которого трейл загружает аудитные логи в бакет, есть [роль](../../kms/security/index.md#kms-keys-decrypter) `kms.keys.decrypter` на ключ.
* Если трейл поставляет события в зашифрованный бакет, проверьте существование ключа {{ kms-name }} данного бакета.
* Проверьте [список управления доступом (ACL)](../../storage/concepts/acl.md) и [политики доступа (bucket policy)](../../storage/concepts/policy.md): в них не должно быть правил, которые запрещают сервисному аккаунту запись в бакет.

### BUCKET_QUOTA_EXCEEDED {#bucket-quota-exceeded}

[Увеличьте](../../storage/operations/buckets/limit-max-volume.md) размер бакета или [удалите](../../storage/operations/objects/delete.md) ненужные объекты.

### BUCKET_CLOUD_QUOTA_EXCEEDED {#bucket-cloud-quota-exceeded}

Обратитесь в [поддержку]({{ link-console-support }}) для увеличения [квоты](../../storage/concepts/limits.md#storage-quotas) {{ objstorage-name }} на облако.

### BUCKET_NOT_FOUND {#bucket-not-found}

Проверьте бакет, который указан в [настройках трейла](../concepts/trail.md#trail-settings). Если бакет был удален:
1. [Создайте](../../storage/operations/buckets/create.md) новый бакет с тем же именем, которое было указано в настройках трейла.

    Также вы можете изменить настройки трейла, указав в блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** другой бакет.
1. Если бакет [зашифрован](../../storage/tutorials/server-side-encryption.md) ключом {{ kms-full-name }}, выдайте сервисному аккаунту, от имени которого трейл загружает аудитные логи в бакет, [роль](../../kms/security/index.md#kms-keys-decrypter) `kms.keys.decrypter` на ключ.


### BUCKET_INVALID_ENCRYPTION {#bucket-invalid-encryption}

Проверьте, что ключ {{ kms-full-name }}, которым [зашифрован](../../storage/tutorials/server-side-encryption.md) бакет, находится в статусе `Active`.


### UNKNOWN или INTERNAL_ERROR {#bucket-internal-error}

Обратитесь в [поддержку]({{ link-console-support }}) за дополнительной информацией и рекомендациями.


## Поток данных {{ yds-name }} {#data-streams}

### ACCESS_DENIED {#stream-access-denied}

Проверьте, что сервисному аккаунту, от имени которого трейл загружает аудитные логи в поток данных, назначена [роль](../../data-streams/security/#yds-editor) `yds.writer` или выше.

### STREAM_NOT_FOUND {#stream-not-found}

Проверьте поток данных, который указан в [настройках трейла](../concepts/trail.md#trail-settings). Если поток данных или его база данных {{ ydb-short-name }} были удалены:
1. [Создайте](../../data-streams/operations/manage-streams.md#create-data-stream) новый поток данных.
1. Измените настройки трейла, указав в блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** новый поток данных.

###  DATABASE_INACTIVE {#database-inactive}

[Убедитесь](../../ydb/operations/manage-databases.md#list-db), что база данных {{ ydb-short-name }} находится в статусе `Running`. При необходимости запустите БД, например, с помощью [консоли управления]({{ link-console-main }}):
1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Справа от имени нужной БД нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

###  DATABASE_NOT_FOUND {#database-not-found}

[Убедитесь](../../ydb/operations/manage-databases.md#list-db), что база данных {{ ydb-short-name }} находится в статусе `Running`, а привязанный к ней [поток данных](../../data-streams/operations/manage-streams.md#list-data-streams) — в статусе `Active`. Если поток данных или его БД {{ ydb-short-name }} были удалены, создайте [новый поток](../../data-streams/operations/manage-streams.md#create-data-stream) данных или [новую БД](../../ydb/operations/manage-databases.md#serverless).

### UNKNOWN или INTERNAL_ERROR {#database-internal-error}

Обратитесь в [поддержку]({{ link-console-support }}) за дополнительной информацией и рекомендациями.

## Лог-группа {{ cloud-logging-name }} {#cloud-logging}

### ACCESS_DENIED {#logging-access-denied}

Проверьте, что сервисному аккаунту, от имени которого трейл загружает аудитные логи в лог-группу, назначена [роль](../../logging/security/index.md#logging-writer) `logging.writer` или выше.

### LOG_GROUP_NOT_FOUND {#log-group-not-found}

Проверьте лог-группу, которая указана в [настройках трейла](../concepts/trail.md#trail-settings). Если лог-группа была удалена:
1. [Создайте](../../logging/operations/create-group.md) новую лог-группу.
1. Измените настройки трейла, указав в блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** новую лог-группу.

### UNKNOWN или INTERNAL_ERROR {#logging-internal-error}

Обратитесь в [поддержку]({{ link-console-support }}) за дополнительной информацией и рекомендациями.


## См. также

* [{#T}](../../iam/operations/sa/assign-role-for-sa.md)
