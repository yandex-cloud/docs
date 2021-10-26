## Управление версионированием бакета

[Версионирование](../../concepts/versioning.md) бакета — это возможность хранить историю объекта с помощью версий.

{% note info %}

Операция включения необратима: отключить версионирование нельзя, можно только приостановить создание новых версий. После приостановки версионирования новые объекты будут сохранятся с версией `null`.

{% endnote %}

Включить версионирование бакета:

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint https://{{ s3-storage-host }} \
    s3api put-bucket-versioning \
    --bucket your-bucket-name \
    --versioning-configuration 'Status=Enabled'
  ```

- Terraform

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
    Получите [статические ключи доступа](../../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
  * `bucket` — имя бакета. Обязательный параметр.
  * `access_key` — идентификатор статического ключа доступа.
  * `secret_key` — значение секретного ключа доступа.
  * `acl` — применяемая политика ACL. Значение по умолчанию `private`. Необязательный параметр.
  * `versioning` — управление версионированием бакета:
    * `enabled` — включает версионирование бакета. Необязательный параметр.

  ```hcl
  resource "yandex_storage_bucket" "b" {
    bucket = "<имя бакета>"
    access_key = "<идентификатор ключа>"
    secret_key = "<секретный ключ>"
    acl    = "private"

    versioning {
      enabled = true
    }
  }
  ```

{% endlist %}