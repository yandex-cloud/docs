# Управление метками объекта

[Метки объектов](../../concepts/tags.md) — это пары ключ-значение для логической маркировки объектов.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Добавить или изменить метки {#add-edit-tag}

{% list tabs %}

- AWS CLI

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду, которая перезаписывает все имеющиеся у объекта метки:

  ```bash
  aws s3api put-object-tagging \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --tagging 'TagSet=[{Key=<ключ_метки>,Value=<значение_метки>},{Key=<ключ_метки>,Value=<значение_метки>}]' \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--tagging` — массив меток объекта, где:
    * `Key` — ключ метки, тип: `string`.
    * `Value` — значение метки, тип: `string`.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- API

  Чтобы добавить или изменить метки объекта, воспользуйтесь методом S3 API [putObjectTagging](../../s3/api-ref/object/putobjecttagging.md).

{% endlist %}

## Посмотреть метки {#get-tag}

{% list tabs %}

- AWS CLI

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api get-object-tagging \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

  Результат:

  ```json
  {
      "TagSet": [
          {
              "Key": "test-key-1",
              "Value": "test-value-1"
          },
          {
              "Key": "test-key-2",
              "Value": "test-value-2"
          }
      ]
  }
  ```  

- API

  Чтобы посмотреть метки объекта, воспользуйтесь методом S3 API [getObjectTagging](../../s3/api-ref/object/getobjecttagging.md).

{% endlist %}

## Удалить метки {#delete-tag}

{% list tabs %}

- AWS CLI

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api delete-object-tagging \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
  * `--endpoint-url` — эндпоинт {{ objstorage-name }}.

- API

  Чтобы удалить метки объекта, воспользуйтесь методом S3 API [deleteObjectTagging](../../s3/api-ref/object/deleteobjecttagging.md).

{% endlist %}
