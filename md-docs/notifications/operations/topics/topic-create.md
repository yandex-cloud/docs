# Создать топик

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Notification Service**.
  1. Слева выберите раздел **Топики**.
  1. Нажмите кнопку **Создать топик**.
  1. Введите имя топика. Имя топика должно быть уникальным в Cloud Notification Service.
  1. В разделе **Логирование** включите **Запись логов**.
  1. В списке **Каталог** выберите каталог, в котором будет расположена [лог-группа](../../../logging/concepts/log-group.md).
  1. В поле **Лог-группа** выберите существующую лог-группу или создайте новую.
  1. Нажмите **Создать топик**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns create-topic --name <имя_топика>
     ```
     
     Где `name` — произвольное имя топика, должно быть уникальным в Cloud Notification Service.
     
     Подробнее о команде `aws sns create-topic` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-topic.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы создать топик, используйте следующий код:

     ```python
     response = client.create_topic(
         Name="<имя_топика>"
     )
     
     print (f"Topic ARN:", response['TopicArn'])
     ```
     
     Где:
     
     * `Name` — произвольное имя топика, должно быть уникальным в Cloud Notification Service.

{% endlist %}

После создания топика изменить его имя невозможно. Для добавления в топик эндпоинтов [создайте подписки](subscription-create.md).