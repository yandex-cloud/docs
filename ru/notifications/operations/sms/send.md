---
title: Отправить тестовое SMS-уведомление в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете отправить тестовое SMS-уведомление.
---

# Отправить тестовое SMS-уведомление

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Выберите нужный канал SMS-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/handset-arrow-in.svg) **{{ ui-key.yacloud.cns.label_phone-numbers }}**.
  1. Напротив нужного тестового номера нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/comment.svg) **{{ ui-key.yacloud.cns.action_send-msg }}**.
  1. В открывшемся окне введите текст сообщения и нажмите **{{ ui-key.yacloud.cns.action_send-msg }}**.

- AWS SDK для PHP {#php}

  1. Если у вас еще нет AWS SDK для PHP, [установите и настройте его](../../tools/sdk-php.md#aws-sdk).
  1. Чтобы отправить SMS-уведомление, используйте следующий код:

      ```php
      $response = $client->publish(
        [
            'Message' => '<сообщение>',
            'PhoneNumber' => '<номер_телефона>',
        ]
      );

      print($response->get('MessageId'));
      ```

{% endlist %}