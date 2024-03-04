---
title: "Как задать настройки масштабирования функции в {{ sf-full-name }}"
description: "Следуя данной инструкции, вы сможете задать настройки масштабирования функции." 
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
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** наведите курсор на тег версии функции (например, ![image](../../../_assets/console-icons/gear.svg) `$latest`), для которой хотите добавить настройки масштабирования.
    1. Во всплывающем окне нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. В открывшемся окне укажите:
        * **zone_instances_limit** — количество экземпляров функции в зоне доступности.
        * **zone_requests_limit** — количество одновременно выполняемых вызовов функции в зоне доступности.
        * **provisioned_instances_count** — количество подготовленных экземпляров.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    Чтобы добавить настройки масштабирования для функции, выполните команду:

    
    ```
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

    
    ```
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

       * `yandex_function_scaling_policy` — описание настроек масштабирования функции.
         * `function_id` — идентификатор функции.
         * `policy` — настройки масштабирования:
           * `policy.0.tag` — [тег](../../concepts/function.md#tag) версии функции.
           * `policy.0.zone_instances_limit` — количество экземпляров функции.
           * `policy.0.zone_requests_limit` — количество выполняемых вызовов.

        Пример структуры конфигурационного файла:

        
        ```
        provider "yandex" {
            token     = "<OAuth-токен_или_статический_ключ_сервисного_аккаунта>"
            folder_id = "<идентификатор_каталога>"
            zone      = "{{ region-id }}-a"
        }

        resource "yandex_function_scaling_policy" "my_scaling_policy" {
            function_id = "are1samplefu********"
            policy {
                tag = "$latest"
                zone_instances_limit = 2
                zone_requests_limit  = 1
            }
        }
        ```


        Более подробную информацию о параметрах ресурса `yandex_function_scaling_policy` см. в [документации провайдера]({{ tf-provider-resources-link }}/yandex_function_scaling_policy).

    1. Проверьте конфигурацию командой:
        
       ```
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```
       terraform plan
       ```

       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

    Проверить удаление настроек масштабирования можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
    
    ```
    yc serverless function list-scaling-policies <имя_или_идентификатор_функции>
    ```

- API {#api}

    Чтобы добавить настройки масштабирования для функции, воспользуйтесь методом REST API [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/SetScalingPolicy](../../functions/api-ref/grpc/function_service.md#SetScalingPolicy).


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    Добавить настройки масштабирования для функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}