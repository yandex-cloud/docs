---
title: Управлять топиком в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете обновить или удалить топик.
---

# Управлять топиком

## Обновить топик {#topic-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Выберите топик.
  1. Справа вверху нажмите кнопку ![image](../../../_assets/edit.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя топика. Имя топика должно быть уникальным в {{ cns-name }}.
  1. В разделе **{{ ui-key.yacloud.cns.section_logging }}** включите или отключите **{{ ui-key.yacloud.cns.field_logging }}**.
  1. Измените лог-группу или создайте новую.
  1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

- AWS CLI {#aws-cli}

  1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../storage/tools/aws-cli.md).
  
  1. Выполните команду:

     ```bash
     aws sns set-topic-attributes \
      --topic-arn <ARN_топика> <атрибуты>
     ```
  1. Посмотрите новые параметры топика:

     ```bash
     aws sns get-topic-attributes \
      --topic-arn <ARN_топика>
     ```
     
  Подробнее о командах см. в документации AWS: [set-topic-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/set-topic-attributes.html) и [get-topic-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/get-topic-attributes.html).

- AWS SDK для Python {#python}

  1. Если у вас еще нет AWS SDK для Python (boto3), [установите и настройте его](../../tools/sdk-python.md#aws-sdk).
  1. Чтобы изменить топик, используйте следующий код:

     ```python
     try:
       response = client.set_topic_attributes(
          TopicArn = "<ARN_топика>",
          AttributeName='<имя_атрибута>',
          AttributeValue='<значение_атрибута>'
       )
     print("Response metadata:", response['ResponseMetadata'])
     ```

{% endlist %}

## Удалить топик {#topic-delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Напротив нужного топика нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- AWS CLI {#aws-cli}

  Выполните команду:

  ```bash
  aws sns delete-topic --topic-arn <ARN_топика>
  ```

  Подробнее о команде `aws sns delete-topic` см. в [документации AWS](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-delete-subscription-topic.html).

- AWS SDK для Python {#python}

  Используйте следующий код:

  ```python
  @staticmethod
    def delete_topic(topic):

        try:
            topic.delete()
            logger.info("Deleted topic %s.", topic.arn)
        except ClientError:
            logger.exception("Couldn't delete topic %s.", topic.arn)
            raise
  ```

{% endlist %}

При удалении топика удаляются все его подписки. Связанные с подписками эндпоинты сохраняются. Удаление топика занимает некоторое время. Пока топик удаляется, не получится создать новый топик с тем же именем.