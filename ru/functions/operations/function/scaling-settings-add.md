# Добавить настройки масштабирования функции

Вы можете задать:

{% include [scaling](../../../_includes/functions/scaling.md) %}

{% include [provisioned-instances-price](../../../_includes/functions/provisioned-instances-price.md) %}

Для разных [версий](../../concepts/function.md#version) функции можно задать свои настройки масштабирования, используя [теги](../../concepts/function.md#tag). Настройки масштабирования будут действовать для той версии функции, которой присвоен указанный тег. Версии функции масштабируются независимо друг от друга.

Настройки масштабирования не могут превышать [квоты](../../concepts/limits.md#functions-quotas).

{% include [provisioned-instances-time](../../../_includes/functions/provisioned-instances-time.md)%}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В блоке **История версий** наведите курсор на тег версии функции (например, ![image](../../../_assets/settings.svg) `$latest`), для которой хотите добавить настройки масштабирования.
    1. Во всплывающем окне нажмите кнопку **Добавить**.
    1. В открывшемся окне укажите:
        * **zone_instances_limit** — количество экземпляров функции в зоне доступности.
        * **zone_requests_limit** — количество одновременно выполняемых вызовов функции в зоне доступности.
        * **provisioned_instances_count** — количество подготовленных экземпляров.
    1. Нажмите кнопку **Сохранить**.

- CLI

    Чтобы добавить настройки масштабирования для функции, выполните команду:

    ```
    yc serverless function set-scaling-policy \
      --id=d4eokpuol55h******** \
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

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

    Чтобы добавить настройки масштабирования: 

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `yandex_function_scaling_policy` — описание настроек масштабирования функции.
         * `function_id` — идентификатор функции.
         * `policy` — настройки масштабирования:
           * `policy.0.tag` — [тег](../../concepts/function.md#tag) версии функции.
           * `policy.0.zone_instances_limit` — количество экземпляров функции.
           * `policy.0.zone_requests_limit` — количество выполняемых вызовов.

        Пример структуры конфигурационного файла:

        {% if product == "yandex-cloud" %}

        ```
        provider "yandex" {
            token     = "<OAuth или статический ключ сервисного аккаунта>"
            folder_id = "<идентификатор каталога>"
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

        {% endif %}

        {% if product == "cloud-il" %}

        ```
        provider "yandex" {
            endpoint  = "{{ api-host }}:443"
            token     = "<статический ключ сервисного аккаунта>"
            folder_id = "<идентификатор каталога>"
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

        {% endif %}

        Более подробную информацию о параметрах ресурса `yandex_function_scaling_policy` см. в [документации провайдера]({{ tf-provider-link }}/yandex_function_scaling_policy).

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
    yc serverless function list-scaling-policies <имя_функции>|<идентификатор_функции>
    ```

- API

    Добавить настройки масштабирования для функции можно с помощью метода API [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md).

- {{ yandex-cloud }} Toolkit

    Добавить настройки масштабирования для функции можно с помощью [плагина {{ yandex-cloud }} Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}