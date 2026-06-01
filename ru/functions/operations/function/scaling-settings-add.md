---
title: Как задать настройки масштабирования функции в {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете задать настройки масштабирования функции.
---

# Добавить настройки масштабирования функции

Вы можете задать:

{% include [scaling](../../../_includes/functions/scaling.md) %}

{% include [provisioned-instances-price](../../../_includes/functions/provisioned-instances-price.md) %}

Для разных [версий](../../concepts/function.md#version) функции можно задать свои настройки масштабирования, используя [теги](../../concepts/function.md#tag). Настройки масштабирования будут действовать для той версии функции, которой присвоен указанный тег. Версии функции масштабируются независимо друг от друга.

Настройки масштабирования не могут превышать [квоты](../../concepts/limits.md#functions-quotas).

{% note info %}

{% include [provisioned-instances-time](../../../_includes/functions/provisioned-instances-time.md)%}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** наведите курсор на тег версии функции (например, ![image](../../../_assets/console-icons/gear.svg) `$latest`), для которой хотите добавить настройки масштабирования.
    1. Во всплывающем окне нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. В открывшемся окне укажите:
        * **zone_instances_limit** — количество экземпляров функции в зоне доступности.
        * **zone_requests_limit** — количество одновременно выполняемых вызовов функции в зоне доступности.
        * **provisioned_instances_count** — количество подготовленных экземпляров.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    Чтобы задать настройки масштабирования, выполните команду:

    ```bash
    yc serverless function set-scaling-policy \
      --id=<идентификатор_функции> \
      --tag=\$latest \
      --zone-instances-limit=1 \
      --zone-requests-limit=2 \
      --provisioned-instances-count=3
    ```

    Где:

    * `--id` — идентификатор функции. Чтобы узнать его, [получите](./function-list.md) список функций.
    * `--tag` —  [тег](../../concepts/function.md#tag) версии функции.
    * `--zone-instances-limit` — количество экземпляров функции.
    * `--zone-requests-limit` — количество выполняемых вызовов.
    * `--provisioned-instances-count` — количество подготовленных экземпляров.

    Результат:

    ```bash
    function_id: d4eokpuol55h********
    tag: $latest
    zone_instances_limit: "1"
    zone_requests_limit: "2"
    provisioned_instances_count: "3"
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}  

    Чтобы добавить настройки масштабирования:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `yandex_function` — описание создаваемой функции и ее исходный код.
         * `name` — имя функции.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
         * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
         * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
         * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
         * `execution_timeout` — максимальное время выполнения функции до таймаута.
         * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
         * `content` — исходный код функции.
           * `content.0.zip_filename` — имя ZIP-архива, содержащего исходный код функции.
       * `yandex_function_scaling_policy` — описание настроек масштабирования функции.
         * `function_id` — идентификатор функции.
         * `policy` — настройки масштабирования:
           * `policy.0.tag` — [тег](../../concepts/function.md#tag) версии функции.
           * `policy.0.zone_instances_limit` — количество экземпляров функции.
           * `policy.0.zone_requests_limit` — количество выполняемых вызовов.

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_function" "test-function" {
          name               = "<имя_функции>"
          user_hash          = "<хеш>"
          runtime            = "<среда_выполнения>"
          entrypoint         = "<точка_входа>"
          memory             = "128"
          execution_timeout  = "10"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
        }

        resource "yandex_function_scaling_policy" "my_scaling_policy" {
          function_id = "<идентификатор_функции>"
          policy {
            tag = "$latest"
            zone_instances_limit = 2
            zone_requests_limit  = 1
          }
        }
        ```

        Подробнее о параметрах ресурсов см. [yandex_function_scaling_policy]({{ tf-provider-resources-link }}/function_scaling_policy).

    1. Проверьте конфигурацию командой:
        
       ```bash
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```text
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```
       terraform plan
       ```

       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

    1. Примените изменения конфигурации:

       ```bash
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

    Проверить добавление настроек масштабирования можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
    
    ```bash
    yc serverless function list-scaling-policies <имя_или_идентификатор_функции>
    ```

- API {#api}

    Чтобы задать настройки масштабирования, воспользуйтесь методом REST API [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetScalingPolicy](../../functions/api-ref/grpc/Function/setScalingPolicy.md).



{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}
