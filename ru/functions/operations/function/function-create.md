---
title: Создать функцию
description: Следуя данной инструкции, вы сможете создать функцию.
---

# Создать функцию

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя и описание функции. Формат имени:

        {% include [name-format](../../../_includes/name-format.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=<имя_функции>
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: python_function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

        ```hcl
        resource "yandex_function" "my-function" {
          name       = "<имя_функции>"
          user_hash  = "<хеш_версии_функции>"
          runtime    = "<среда_выполнения>"
          entrypoint = "<точка_входа>"
          memory     = "<объем_памяти>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
        }
        ```

        Где:

        * `name` — имя функции.
        * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
        * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
        * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
        * `content` — исходный код функции:
            * `zip_filename` — путь к ZIP-архиву, содержащему исходный код функции и необходимые зависимости.

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

    1. Создайте ресурсы:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

        ```bash
        yc serverless function list
        ```

- API {#api}

    Чтобы создать функцию, воспользуйтесь методом REST API [create](../../functions/api-ref/Function/create.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/api-ref/grpc/Function/create.md).


{% endlist %}
