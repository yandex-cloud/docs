# Отправить тестовое SMS-уведомление

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. Перейдите в сервис **Cloud Notification Service**.
  1. Выберите нужный канал SMS-уведомлений.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/handset-arrow-in.svg) **Тестовые номера**.
  1. Напротив нужного тестового номера нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/comment.svg) **Отправить**.
  1. В открывшемся окне введите текст сообщения и нажмите **Отправить**.

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