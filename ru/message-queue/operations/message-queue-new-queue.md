---
title: "Как создать очередь сообщений в {{ message-queue-full-name }}"
description: "Следуя данной инструкции, вы сможете создать очередь сообщений." 
---

# Создание новой очереди сообщений

Очереди сообщений {{ message-queue-name }} позволяют передавать [сообщения](../concepts/message.md) между компонентами распределенных приложений. Передавать сообщения в очереди можно с помощью [API](../api-ref/index.md) или других поддерживаемых [инструментов](../instruments/index.md).

Чтобы создать новую очередь сообщений:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана очередь.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.ymq.queue.form.section_base }}** заполните поля:
      * **{{ ui-key.yacloud.common.name }}** — укажите имя очереди.
  
        {% include [name](../../_includes/message-queue/ymq-name.md) %}
  
      * **{{ ui-key.yacloud.ymq.queue.form.switch_fifo-queue }}** — выберите тип очереди `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}` или `{{ ui-key.yacloud.ymq.queue.form.type_switch_fifo }}`.
      * **{{ ui-key.yacloud.ymq.queue.form.field_visibility-timeout }}** — укажите стандартный таймаут видимости, который будет применяться к сообщениям в очереди после чтения получателем.
      * **{{ ui-key.yacloud.ymq.queue.form.field_keeping-time }}** — укажите максимальный срок хранения сообщений в очереди.
      * **{{ ui-key.yacloud.ymq.queue.form.field_max-size }}** — укажите максимальный размер сообщения.
      * **{{ ui-key.yacloud.ymq.queue.form.field_sending-delay }}** — укажите время, в течение которого новое сообщение нельзя получить из очереди.
      * **{{ ui-key.yacloud.ymq.queue.form.field_receiving-delay }}** — укажите время ожидания при получении сообщения.
  1. Чтобы перенаправлять недоставленные сообщения в [очередь недоставленных сообщений (DLQ)](../concepts/dlq.md), в блоке **{{ ui-key.yacloud.ymq.queue.form.section_message-settings }}**:
      * Включите опцию **{{ ui-key.yacloud.ymq.queue.form.switch_redirect-messages }}**.
      * Укажите **{{ ui-key.yacloud.ymq.queue.form.field_messages-queue }}**.
      * Задайте **{{ ui-key.yacloud.ymq.queue.form.field_max-read-tries }}**.
  1.  Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#cli}

  1. [Установите и настройте](configuring-aws-cli.md) AWS CLI.

  1. Выполните в терминале команду:
  
     ```bash
     aws sqs create-queue \
       --queue-name <имя_очереди> \
       --endpoint <эндпоинт>
     ```

     Где:

     * `--queue-name` — имя создаваемой очереди, например `sample-queue`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
      
     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

- {{ TF }} {#tf}

  {% include [ymq-terraform](../_includes_service/mq-terraform.md) %}

{% endlist %}


При достижении лимита на максимальное количество очередей, возникает ошибка `Cannot create queue: Too many queues`. Для увеличения лимита обратитесь в [техническую поддержку]({{ link-console-support }}).