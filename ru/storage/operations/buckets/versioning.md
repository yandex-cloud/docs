---
title: "Управление версионированием бакета в {{ objstorage-full-name }}"
description: "Версионирование бакета — это возможность хранить историю объекта с помощью версий. Из этой статьи вы узнаете, как управлять версионированием в {{ objstorage-name }}."
---

# Управление версионированием бакета

[Версионирование](../../concepts/versioning.md) бакета — это возможность хранить историю объекта с помощью версий.

{% note info %}

Операция включения необратима: отключить версионирование нельзя, можно только приостановить создание новых версий. После приостановки версионирования новые объекты будут сохранятся с версией `null`.

{% endnote %}

Включить версионирование бакета:

{% list tabs %}

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования ACL бакета:

     ```bash
     yc storage bucket update --help
     ```  

  1. Выполните следующую команду:

     ```bash
     yc storage bucket update <имя_бакета> --versioning versioning-enabled 
     ```  
     
     Результат:

     ```bash
     name: my-bucket
     folder_id: csgeoelk7fl15s66dsvbo
     default_storage_class: STANDARD
     versioning: VERSIONING_ENABLED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- AWS CLI

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните следующую команду:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} \
    s3api put-bucket-versioning \
    --bucket <имя_бакета> \
    --versioning-configuration 'Status=Enabled'
  ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
    Получите [статические ключи доступа](../../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

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

  Где:

  * `bucket` — имя бакета. Обязательный параметр.
  * `access_key` — идентификатор статического ключа доступа.
  * `secret_key` — значение секретного ключа доступа.
  * `acl` — применяемая политика ACL. Значение по умолчанию `private`. Необязательный параметр.
  * `versioning` — управление версионированием бакета:
    * `enabled` — включает версионирование бакета. Необязательный параметр.

{% endlist %}
