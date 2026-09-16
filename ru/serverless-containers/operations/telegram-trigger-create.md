# Создать триггер для Telegram, который вызывает контейнер {{ serverless-containers-name }}

Создайте [триггер для Telegram](../concepts/trigger/telegram-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }}, когда Telegram-бот получает новое обновление.

## Перед началом работы {#before-you-begin}

Для создания триггера вам понадобятся:

* Telegram-бот и его токен. Если у вас нет бота, создайте его через [@BotFather](https://core.telegram.org/bots/features#botfather) и скопируйте выданный токен.

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](../../serverless-containers/operations/create.md).
    * [Создайте ревизию контейнера](../../serverless-containers/operations/manage-revision.md#create).

* (Опционально) Очередь [Dead Letter Queue](../../serverless-containers/concepts/dlq.md), куда будут перенаправляться сообщения, которые не смог обработать контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов контейнера;
    * (опционально) на запись в очередь Dead Letter Queue.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}


- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы создать триггер для Telegram, который вызывает контейнер:

    1. Опишите в конфигурационном файле параметры триггера:

       ```hcl
       resource "yandex_serverless_triggers" "my_trigger" {
         name = "<имя_триггера>"
         source {
           telegram_message {
             bot_token       = "<токен_Telegram-бота>"
             allowed_updates = [ "<тип_обновления>", "<тип_обновления>" ]
             force           = true
           }
         }
         action {
           invoke_container {
             container_id       = "<идентификатор_контейнера>"
             path               = "<HTTP-путь>"
             service_account_id = "<идентификатор_сервисного_аккаунта>"
           }
           filter {
             jq = ".message.text | startswith(\"/\")"
           }
           transformer {
             jq = ".message"
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

       {% include [tf-triggers-common-params](../../_includes/tf-triggers-common-params.md) %}

       * `source` — параметры источника событий:

         * `telegram_message` — параметры Telegram-бота:

           * `bot_token` — токен Telegram-бота, полученный от [@BotFather](https://core.telegram.org/bots/features#botfather). Значение передается только при создании и изменении триггера и не возвращается в выводе {{ TF }}. При изменении токена вебхук регистрируется заново.
           * `allowed_updates` — список типов [обновлений Telegram](https://core.telegram.org/bots/api#update), на которые подписывается бот. Необязательный параметр, значение по умолчанию — `[ "message" ]`.
           * `force` — переустановка вебхука, если для бота уже настроен вебхук на другой URL. Без этого параметра создание триггера завершится ошибкой. Если вебхук уже указывает на этот триггер, параметр ничего не меняет. Необязательный параметр.

       {% include [tf-triggers-action-container](../../_includes/serverless-containers/tf-triggers-action-container.md) %}

       Подробнее о параметрах ресурса `yandex_serverless_triggers` в [документации провайдера]({{ tf-provider-resources-link }}/serverless_triggers).

    1. Создайте ресурсы:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

        ```bash
        yc serverless trigger list
        ```

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../functions/operations/trigger/telegram-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/telegram-trigger-create.md)
