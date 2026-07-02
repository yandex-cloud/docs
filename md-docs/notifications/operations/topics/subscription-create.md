[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Notification Service](../../index.md) > [Пошаговые инструкции](../index.md) > Топики > Создать подписку на топик

# Создать подписку

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится топик.
  1. Перейдите в сервис **Cloud Notification Service**.
  1. Слева выберите раздел **Топики**.
  
     1. Выберите топик.
     1. Слева выберите **Подписки**.
     1. Нажмите кнопку **Создать подписку**.
     1. Выберите тип канала уведомлений:
          
        * **Мобильные push-уведомления**.
        
            Введите ARN эндпоинта в формате: `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Скопировать ARN эндпоинта можно на странице его настроек.
     
        * **Push-уведомления в браузере**.
     
            Введите ARN эндпоинта в формате: `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`.
        
        * **SMS**.
           
            Введите номер телефона в формате [E.164](https://ru.wikipedia.org/wiki/E.164), например `+79991112233`. Телефон не требуется предварительно добавлять в канале уведомлений SMS, при этом сам канал должен быть создан.
     
     1. Нажмите **Создать подписку**.
     
        Таким же образом подпишите на топик другие эндпоинты.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns subscribe \
       --topic-arn <ARN_топика> \
       --protocol <тип_канала> \
       --notification-endpoint <ARN_эндпоинта_или_номер_телефона>
     ```
     
     Где:
       * `topic-arn` — ARN топика.
       * `protocol` — тип канала отправки уведомлений, например, `sms`, `application`.
       * `notification-endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://ru.wikipedia.org/wiki/E.164), например `+79991112233`.
     
     Подробнее о команде `aws sns subscribe` смотрите в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы подписать эндпоинт на уведомления в топике, используйте следующий код:
     
     ```python
     try:
         response = client.subscribe(
             TopicArn = "<ARN_топика>",
             Protocol = "<тип_канала>",
             Endpoint = "<ARN_эндпоинта_или_номер_телефона>"
         )
         print(f"Topic ARN: {response['TopicArn']}")
     except botocore.exceptions.ClientError as error:
         print(f"Error: {error}")
     ```
     
     Где:
     
     * `TopicArn` — ARN топика.
     * `Protocol` — тип канала для отправки уведомлений, например, `sms`, `application`.
     * `Endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://ru.wikipedia.org/wiki/E.164), например `+79991112233`.

{% endlist %}