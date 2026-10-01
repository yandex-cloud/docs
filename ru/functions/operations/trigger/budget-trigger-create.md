# Создать триггер для бюджетов, который вызывает функцию {{ sf-name }}

Создайте [триггер для бюджетов](../../concepts/trigger/budget-trigger.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} при превышении пороговых значений.

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* Бюджет, при превышении порога которого триггер будет запускаться. Если у вас нет бюджета, [создайте его](../../../billing/operations/budgets.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. [Перейдите]({{ link-console-main }}/link/functions) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.

        * {% include [triggers-labels-step](../../../_includes/functions/triggers-labels-step.md) %}

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}** выберите платежный аккаунт и бюджет. Можно выбрать **{{ ui-key.yacloud.serverless-functions.triggers.form.label_any-budget }}**.

    1. В блоке **Приёмники**:

        1. В поле **Тип приёмника** выберите `Функция`.

        1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

            {% include [function-settings](../../../_includes/functions/function-settings.md) %}

        1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

            {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

        1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

        1. {% include [trigger-console-filter](../../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../../_includes/functions/trigger-console-template.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать триггер, который вызывает функцию, выполните команду:

    ```bash
    yc serverless trigger create billing-budget \
      --name <имя_триггера> \
      --billing-account-id <идентификатор_платежного_аккаунта> \
      --budget-id <идентификатор_бюджета> \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts 1 \
      --retry-interval 10s \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--billing-account-id` — идентификатор платежного аккаунта.
    * `--budget-id` — идентификатор бюджета.
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Результат:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: budget-trigger
    rule:
      billing-budget:
        billing-account-id: dn2char50j**********
        budget-id: dn2jnshmdlc1********
        invoke_function:
          function_id: d4eofc7n0m03********
          function_tag: $latest
          service_account_id: aje3932acd0c********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
            service-account-id: aje3932acd0c********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    Чтобы создать триггер для бюджетов, который вызывает функцию:

    1. Опишите в конфигурационном файле параметры триггера:

       ```hcl
       resource "yandex_serverless_triggers" "my_trigger" {
         name = "<имя_триггера>"
         source {
           billing_budget {
             billing_account_id = "<идентификатор_платежного_аккаунта>"
             budget_id          = "<идентификатор_бюджета>"
           }
         }
         action {
           invoke_function {
             function_id        = "<идентификатор_функции>"
             service_account_id = "<идентификатор_сервисного_аккаунта>"
           }
           retry_policy {
             retry_attempts = "<количество_повторных_отправок>"
             interval       = "<интервал_между_повторными_отправками>"
           }
           dead_letter {
             dead_letter_queue {
               queue_arn          = "<ARN_очереди_Dead_Letter_Queue>"
               service_account_id = "<идентификатор_сервисного_аккаунта>"
             }
           }
         }
       }
       ```

       Где:

       {% include [tf-triggers-common-params](../../../_includes/tf-triggers-common-params.md) %}

       * `source` — параметры источника событий:

         * `billing_budget` — параметры бюджета:

           * `billing_account_id` — идентификатор платежного аккаунта.
           * `budget_id` — идентификатор бюджета. Необязательный параметр. Если параметр не указан, триггер срабатывает для любого бюджета платежного аккаунта.

       {% include [tf-triggers-action-function](../../../_includes/functions/tf-triggers-action-function.md) %}

       Подробнее о параметрах ресурса `yandex_serverless_triggers` в [документации провайдера]({{ tf-provider-resources-link }}/serverless_triggers).

    1. Создайте ресурсы:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

        ```bash
        yc serverless trigger list
        ```

- API {#api}

  Чтобы создать триггер для бюджетов, воспользуйтесь методом REST API [create](../../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../../serverless-containers/operations/budget-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/budget-trigger-create.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
