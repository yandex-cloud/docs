---
title: Копирование объектов в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете скопировать объект из бакета в {{ objstorage-name }}.
---

# Копирование объектов

В {{ objstorage-name }} поддерживается копирование объектов на стороне сервера (_Server Side Copy_). 

Если в [бакете](../../concepts/bucket.md) отключено [шифрование](../../concepts/encryption.md), то [объекты](../../concepts/object.md) будут копироваться в бакеты на стороне сервера. Хост, на котором выполняется команда копирования, и {{ objstorage-name }} обмениваются только [ключами](../../concepts/object.md#key) объектов. Плата за трафик при копировании в таком случае не взимается, поскольку он является внутренним для объектного хранилища. При этом сами запросы на копирование [тарифицируются](../../pricing.md#prices-operations).

Если объекты в бакете зашифрованы, то сначала они будут скопированы на хост, выполняющий команду, и после загружены в бакет-приемник.

Большие объекты, загруженные с помощью [составной загрузки](../../concepts/multipart.md), хранятся в бакете частями. Копирование таких объектов происходит путем вызова [copyPart](../../s3/api-ref/multipart/copypart.md) для каждой его части. Таким образом, расходы при копировании составных объектов выше, чем при копировании обычных.

Вы можете скопировать как [все содержимое бакета](#copy-from-bucket-to-bucket), так и [отдельный его объект](#copy-single-object).


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


## Копирование одного объекта {#copy-single-object}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для загрузки объекта в бакет:

      ```bash
      yc storage s3api copy-object --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Выполните команду:

      ```bash
      yc storage s3api copy-object \
        --copy-source <бакет_источник>/<ключ_объекта> \
        --bucket <бакет_приемник> \
        --key <ключ_объекта>
      ```

      Где:

      * `--copy-source` — имя бакета-источника и [ключ](../../concepts/object.md#key) объекта, который нужно скопировать.
      * `--bucket` — имя бакета, в который нужно скопировать объект.
      * `--key` — ключ, по которому объект будет храниться в бакете.

      Результат:

      ```bash
      copy_object_result:
        etag: '"d41d8cd98f00b204e9800998********"'
        last_modified_at: "2024-10-08T14:21:41.628Z"
      request_id: 61523025********
      copy_source_version_id: "null"
      ```

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp s3://<бакет_источник>/<ключ_объекта> s3://<бакет_приемник>/<ключ_объекта>
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 cp` — команда для копирования объектов.

      Результат:

      ```text
      copy: s3://<бакет_источник>/<ключ_объекта> to s3://<бакет_приемник>/<ключ_объекта>
      ```

      Подробнее о команде `aws s3 cp` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

{% endlist %}

## Копирование всех объектов бакета в другой бакет {#copy-from-bucket-to-bucket}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
  1. Выполните команду:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp --recursive s3:<бакет_источник>/ s3:<бакет_приемник>/
      ```

      Где:

      * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
      * `s3 cp` — команда для копирования объектов.
      * `--recursive` — параметр для копирования всех объектов бакета-источника.

      Подробнее о команде `aws s3 cp` см. в документации [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

  Все объекты будут скопированы из бакета-источника в бакет-приемник.

  {% note info %}

  Вы можете скопировать объекты между бакетами, как в рамках одного облака, так и между разными облаками. Для этого убедитесь, что у используемого [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) есть права на запись в оба бакета.

  {% endnote %}


{% endlist %}

