---
title: Управление метками объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете управлять метками объекта в бакете в {{ objstorage-name }}.
---

# Управление метками объекта

[Метки объектов](../../concepts/tags.md) — это пары ключ-значение для логической маркировки объектов.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Добавить или изменить метки {#add-edit-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на имя нужного объекта.
  1. Нажмите на кнопку **Добавить метку**.
  1. Через двоеточие введите ключ и значение метки (ключ:значение).

  Если вы хотите изменить метку:
  
  1. Нажмите на кнопку **Добавить метку**.
  1. Введите ключ метки, которую вы хотите изменить, и новое значение.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения меток объекта в бакете:

      ```bash
      yc storage s3api put-object-tagging --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE    | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | my-bucket        | b1g5dk66rc1u******** | 53687091200 | STANDARD              | 2024-12-17 07:17:04 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. В терминале выполните команду, которая перезаписывает все имеющиеся у объекта метки:

      ```bash
      yc storage s3api put-object-tagging \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии> \
        --tagging TagSet=[{Key=<ключ_метки>,Value=<значение_метки>},{Key=<ключ_метки>,Value=<значение_метки>}]
      ```

      Где:
      * `--bucket` — имя бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
      * `--version-id` — [версия](../../concepts/versioning.md) объекта. Необязательный параметр.
      * `--tagging` — массив меток объекта, где:
        * `Key` — ключ метки, тип: `string`.
        * `Value` — значение метки, тип: `string`.

      Результат:

      ```text
      request_id: ac9066e5********
      ```

- AWS CLI {#aws-cli}

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

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

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

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого к объекту будут добавлены метки. Проверить появление меток и настройки объекта можно с помощью [AWS CLI или S3 API](#get-tag).

- API {#api}

  Чтобы добавить или изменить метки объекта, воспользуйтесь методом S3 API [putObjectTagging](../../s3/api-ref/object/putobjecttagging.md).

{% endlist %}

## Посмотреть метки {#get-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Вы можете посмотреть метки в списке объектов бакета и на странице отдельного объекта.

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на имя нужного объекта.


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра меток объекта в бакете:

      ```bash
      yc storage s3api get-object-tagging --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE    | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | my-bucket        | b1g5dk66rc1u******** | 53687091200 | STANDARD              | 2024-12-17 07:17:04 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Получите информацию о метках объекта:

      ```bash
      yc storage s3api get-object-tagging \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии>
      ```

      Где:
      * `--bucket` — имя бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
      * `--version-id` — [версия](../../concepts/versioning.md) объекта. Необязательный параметр.

      Результат:

      ```text
      request_id: 2defc7b2********
      tag_set:
        - key: key-for-my-object-2
          value: second-value
        - key: key-for-my-object-1
          value: first-value
      ```

- AWS CLI {#aws-cli}

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

- API {#api}

  Чтобы посмотреть метки объекта, воспользуйтесь методом S3 API [getObjectTagging](../../s3/api-ref/object/getobjecttagging.md).

{% endlist %}

## Удалить метки {#delete-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на имя нужного объекта.
  1. Нажмите на крестик рядом с меткой, которую вы хотите удалить.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления меток объекта в бакете:

      ```bash
      yc storage s3api delete-object-tagging --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE    | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | my-bucket        | b1g5dk66rc1u******** | 53687091200 | STANDARD              | 2024-12-17 07:17:04 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Удалите метки объекта в бакете:

      ```bash
      yc storage s3api delete-object-tagging \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        --version-id <идентификатор_версии>
      ```

      Где:
      * `--bucket` — имя бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта в бакете.
      * `--version-id` — [версия](../../concepts/versioning.md) объекта. Необязательный параметр.

      Результат:

      ```text
      request_id: 1131dfc4********
      ```

- AWS CLI {#aws-cli}

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

- {{ TF }} {#tf}

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

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого у объекта будут удалены метки. Проверить удаление меток и настройки объекта можно с помощью [AWS CLI или S3 API](#get-tag).

- API {#api}

  Чтобы удалить метки объекта, воспользуйтесь методом S3 API [deleteObjectTagging](../../s3/api-ref/object/deleteobjecttagging.md).

{% endlist %}
