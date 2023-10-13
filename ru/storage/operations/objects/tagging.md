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

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `tags` во фрагмент с описанием объекта:

      ```hcl
      resource "yandex_storage_object" "test-object" {
        access_key       = "<идентификатор_статического_ключа>"
        secret_key       = "<секретный_ключ>"
        bucket           = "<имя_бакета>"
        key              = "<имя_объекта>"
        source           = "<путь_к_файлу>"
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
      }
      ```

      Где `tags` — массив меток объекта в формате `<ключ> = "<значение>"`.
      
      Более подробную информацию о параметрах ресурса `yandex_storage_object` в Terraform, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_object).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого к объекту будут добавлены метки. Проверить появление меток и настройки объекта можно с помощью [AWS CLI или S3 API](#get-tag).

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

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигураций {{ TF }} и удалите блок `tags` из фрагмента с описанием объекта.

     {% cut "Пример описания тегов объекта в конфигурации {{ TF }}" %}

     ```hcl
      resource "yandex_storage_object" "test-object" {
        ...
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
      }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого у объекта будут удалены метки. Проверить удаление меток и настройки объекта можно с помощью [AWS CLI или S3 API](#get-tag).

- API

  Чтобы удалить метки объекта, воспользуйтесь методом S3 API [deleteObjectTagging](../../s3/api-ref/object/deleteobjecttagging.md).

{% endlist %}
