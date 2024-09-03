---
title: "Как назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения {{ vpc-full-name }}"
description: "Следуя данной инструкции, вы сможете назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения." 
---

# Назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


[Политики доступа (bucket policy)](../../storage/concepts/policy.md) устанавливают права на действия с [бакетами](../../storage/concepts/bucket.md), [объектами](../../storage/concepts/object.md) и группами объектов.

Минимально необходимая роль для применения или изменения политики доступа — `storage.configurer`. См. [описание роли](../../storage/security/index.md#storage-configurer).

Чтобы назначить политику доступа в {{ objstorage-short-name }} для сервисного подключения:

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  {% note info %}

  Для управления политикой доступа с помощью AWS CLI сервисному аккаунту должна быть назначена [роль](../../storage/security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON:
  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": [
        "arn:aws:s3:::<bucket-name>/*",
        "arn:aws:s3:::<bucket-name>>"
      ],
      "Condition": {
        "StringEquals": {
          "yc:private-endpoint-id": "<pe-id>"
        }
      }
    }
  }
  ```
  где,
  * `<bucket-name>` — имя бакета в Object Storage к которому будем применять политику доступа, например, `my-s3-bucket`.
  * `<pe-id>` — идентификатор созданного ранее сервисного подключения (Private Endpoint), например, `enpd7***************`.

  1. Сохраните готовую конфигурацию в файле `policy.json`.

  1. Выполните команду:
  ```bash
  aws s3api put-bucket-policy \
    --endpoint https://{{ s3-storage-host }} \
    --bucket <bucket-name> \
    --policy file://policy.json
  ```

  После успешного применения политики доступа, подключение к бакету будет возможно только из VPC в котором было создано соответствующее сервисное подключение (Private Endpoint).

  Дополнительную информацию о работе с {{ objstorage-short-name }} с помощью инструмента `AWS CLI` можно получить в документе [управление политикой доступа](../../storage/operations/buckets/policy.md#aws-cli_1).

{% endlist %}

