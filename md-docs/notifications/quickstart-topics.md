# Как начать работать с топиками в {{ cns-full-name }}

{% note info %}

Сервис находится на [стадии Preview](../overview/concepts/launch-stages.md).

{% endnote %}

Чтобы включить {{ cns-name }}, запросите доступ к сервису у вашего аккаунт-менеджера или в [технической поддержке]({{ link-console-support }}).

{{ cns-name }} ({{ cns-short-name }}) — сервис для мультиканальной отправки уведомлений пользователям. HTTP API сервиса совместим с [Amazon SNS API](https://docs.aws.amazon.com/sns/latest/api/welcome.html).

Чтобы отправлять сообщения в разные эндпоинты одновременно, используйте топики. _Топик_ позволяет отправлять уведомления сразу всем подписанным на него эндпоинтам.

Чтобы начать работать с топиками:

1. [Подготовьте облако к работе](#before-you-begin)
1. Создайте каналы для уведомлений и эндпоинты: 
   
   * [Мобильные push-уведомления](quickstart-push.md)
   * [Push-уведомления в браузере](quickstart-browser.md)
   * [SMS](quickstart-sms.md) 
      Для SMS можно не добавлять телефонные номера в канале, а добавить их сразу в топике.

1. [Создайте топик](#create-topic)
1. [Подпишите эндпоинты на топик](#subscribe-endpoints)
1. [Отправьте уведомление в топик](#send-message)

# Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Создайте топик {#create-topic}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.local.action_create-topic_qywb9 }}**.
  1. Введите имя топика. Имя топика должно быть уникальным в {{ cns-name }}.
  1. В разделе **{{ ui-key.yacloud.cns.section_logging }}** включите **{{ ui-key.yacloud.cns.field_logging }}**.
  1. В списке **{{ ui-key.yacloud.cns.field_logging-folder }}** выберите каталог, в котором будет расположена [лог-группа](../logging/concepts/log-group.md).
  1. В поле **{{ ui-key.yacloud.cns.field_log-group }}** выберите существующую лог-группу или создайте новую.
  1. Нажмите **{{ ui-key.yacloud.cns.Topics.button_create_r6PZn }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns create-topic --name <имя_топика>
     ```
     
     Где `name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.
     
     Подробнее о команде `aws sns create-topic` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-topic.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](tools/sdk-python.md#aws-sdk).
  1. Чтобы создать канал push-уведомлений, используйте следующий код:

     ```python
     response = client.create_topic(
         Name="<имя_топика>"
     )
     
     print (f"Topic ARN:", response['TopicArn'])
     ```
     
     Где:
     
     * `Name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.

{% endlist %}

## Подпишите эндпоинты на топик {#subscribe-endpoints}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите топик.
  1. Слева выберите **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}**.
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

   Выполните команду:

   ```bash
   aws sns subscribe \
     --topic-arn <ARN_топика> \
     --protocol <тип_канала> \
     --notification-endpoint <ARN_эндпоинта_или_номер_телефона>
   ```
   
   Где:
     * `topic-arn` — ARN топика.
     * `protocol` — тип канала отправки уведомлений, например, `sms`, `application`.
     * `notification-endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164), например `+79991112233`.
   
   Подробнее о команде `aws sns subscribe` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-subscribe-endpoint-to-topic.html).

- AWS SDK для Python {#python}

  Используйте следующий код:

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
  * `Endpoint` — ARN эндпоинта, который подписывается на топик, в формате `arn:aws:sns::<cloud_id>:endpoint/<platform>/<channel_name>/<endpoint_unique_id>`. Для SMS — номер телефона в формате [E.164](https://{{ lang }}.wikipedia.org/wiki/E.164), например `+79991112233`.

{% endlist %}

## Отправьте уведомление в топик {#send-message}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите топик.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_send-message }}**.
  1. Выберите вид уведомлений: 
       
      * **Одинаковые** — во все типы каналов будет отправлено одно и то же уведомление.
      * **Различные** — можно ввести разные тексты для разных типов каналов.
  
  1. Введите единый текст для всех каналов или разные тексты для разных типов каналов в формате JSON. Если канал не указан, будет отправлен текст по умолчанию из поля `default`.
     
      Формат уведомления в JSON:
      
      ```json
      {
        "default": "<Текст_по_умолчанию>",
        "sms": "<Текст_уведомления_для_sms>",
        "WEB": "<Текст_уведомления_для_браузера>",
        "APNS": {
          "aps": {
            "alert": {
              "title": "Заголовок_уведомления",
              "body": "Текст_уведомления"
            }
          }
        },
        "GCM": {
          "notification": {
            "title": "Заголовок_уведомления",
            "body": "Текст_уведомления"
          }
        },
        "HMS": {
          "notification": {
            "title": "Заголовок_уведомления",
            "body": "<Текст_уведомления>"
          }
        },
        "RUSTORE": {
          "notification": {
            "title": "Заголовок_уведомления",
            "body": "<Текст_уведомления>"
          }
        }
      }
      ```
  
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.action_send-msg }}**.

- AWS CLI {#aws-cli}

  Выполните команду:

  Для отправки уведомления:
  
  ```bash
  aws sns publish \
  --topic-arn <ARN_топика> \
  --message-structure json \
  --message '{"default": "<текст_уведомления>","APNS": {"aps":{"alert":"<текст_уведомления>"}},"GCM": {"notification":{"body":"<текст_уведомления>"}},"HMS": {"notification":{"body":"<текст_уведомления>"}},"RUSTORE": {"notification":{"body":"<текст_уведомления>"}},"WEB": "<текст_уведомления>","sms": "<текст_уведомления>"}'
  ```
  
  Где:
    * `topic-arn` — ARN топика.
    * `message-structure` — формат сообщения `json`.
    * `message` — текст уведомления или путь к файлу с уведомлением. Для отправки разных уведомлений в зависимости от типа канала укажите канал и текст уведомления. Если какой-либо канал не указан, будет отправлено сообщение по умолчанию.
  
  Подробнее о команде `aws sns publish` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-publish-to-topic.html).

- AWS SDK для Python {#python}

  Используйте следующий код:

  ```python
  try:
      response = client.publish(
          TopicArn="<ARN_топика>",
          Message=json.dumps({
              "default": "<текст_уведомления>",
              "APNS": {"aps":{"alert":"<текст_уведомления>"}},
              "GCM": {"notification":{"body":"<текст_уведомления>"}},
              "HMS": {"notification":{"body":"<текст_уведомления>"}},
              "RUSTORE": {"notification":{"body":"<текст_уведомления>"}},
              "WEB": "<текст_уведомления>",
              "sms": "<текст_уведомления>"
          }),
          MessageStructure="json"
      )
      print(f"Message ID: {response["MessageId"]}")
  except botocore.exceptions.ClientError as error:
      print(f"Error: {error}")
  ```
  
  Где:
  
  * `TopicArn` — ARN топика.
  * `Message` — текст уведомления. Можно указать единый текст для всех типов каналов или разные тексты для каждого типа канала. Если какой-либо канал не указан, будет отправлено сообщение по умолчанию из поля `default`.
  * `MessageStructure` — формат сообщения (`json`).

{% endlist %}