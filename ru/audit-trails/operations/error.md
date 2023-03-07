# Обработка ошибок

Если трейл не может отправить события в [объект назначения](../concepts/trail.md#target), [статус трейла](../concepts/trail.md#status) изменится на `error`. Инструкция содержит рекомендации по восстановлению нормальной работы трейла.

{% note info %}

После устранения причины, трейл изменит статус на `active` через несколько минут.

{% endnote %}


## Объект назначения — {{ objstorage-full-name }} {#storage}

### ACCESS_DENIED {#access-denied}

* Проверьте права сервисного аккаунта: может ли он писать в бакет? Нужна роль `storage.uploader` или выше.
{% if product == "yandex-cloud" %}
* Если бакет [зашифрован](../../storage/tutorials/server-side-encryption.md) ключом {{ kms-full-name }}, убедитесь, что у сервисного аккаунта есть роль `kms.keys.encrypterDecrypter` на ключ.
{% endif %}
* Проверьте [bucket ACL](../../storage/concepts/acl.md) и [bucket policy](../../storage/concepts/policy.md): в них не должно быть правил, которые запрещают сервисному аккаунту писать в бакет.


### BUCKET_QUOTA_EXCEEDED {#bucket-quota-exceeded}

Увеличьте размер бакета или удалите ненужные объекты.

### BUCKET_CLOUD_QUOTA_EXCEEDED {#bucket-cloud-quota-exceeded}

Обратитесь в [поддержку]({{ link-console-support }}) для увеличения квоты {{ objstorage-name }} на облако.

### BUCKET_NOT_FOUND {#bucket-not-found}

* Создайте бакет с таким же именем и выдайте на него роли сервисному аккаунту.
* Так же вы можете отредактировать трейл, указав другой бакет назначения.

{% if product == "yandex-cloud" %}

### BUCKET_INVALID_ENCRYPTION {#bucket-invalid-encryption}

Проверьте, что ключ, которым зашифрован бакет, находится в статусе `active`.

{% endif %}

### UNKNOWN или INTERNAL_ERROR {#internal-error}

Обратитесь в [поддержку]({{ link-console-support }}) за дополнительной информацией и рекомендациями.
