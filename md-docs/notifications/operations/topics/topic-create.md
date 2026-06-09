# Создать топик

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cns.local.action_create-topic_qywb9 }}**.
  1. Введите имя топика. Имя топика должно быть уникальным в {{ cns-name }}.
  1. В разделе **{{ ui-key.yacloud.cns.section_logging }}** включите **{{ ui-key.yacloud.cns.field_logging }}**.
  1. В списке **{{ ui-key.yacloud.cns.field_logging-folder }}** выберите каталог, в котором будет расположена [лог-группа](../../../logging/concepts/log-group.md).
  1. В поле **{{ ui-key.yacloud.cns.field_log-group }}** выберите существующую лог-группу или создайте новую.
  1. Нажмите **{{ ui-key.yacloud.cns.Topics.button_create_r6PZn }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  1. Выполните команду:

     ```bash
     aws sns create-topic --name <имя_топика>
     ```
     
     Где `name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.
     
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
     
     * `Name` — произвольное имя топика, должно быть уникальным в {{ cns-name }}.

{% endlist %}

После создания топика изменить его имя невозможно. Для добавления в топик эндпоинтов [создайте подписки](subscription-create.md).