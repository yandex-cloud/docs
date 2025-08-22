---
title: Создать подписку в {{ cns-full-name }}
description: Следуя этой инструкции, вы сможете подписать эндпоинт на уведомления в топике.
---

# Управлять подпиской

## Изменить подписку {#subscribe-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Выберите топик, в котором находится подписка.
  1. Слева выберите **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}**.
  1. Выберите подписку и укажите новые параметры.
  1. Нажмите **{{ ui-key.yacloud.common.save-changes }}**.

- AWS CLI {#aws-cli}

  1. Посмотрите список подписок для топика:
     ```bash
     aws sns set-subscription-attributes \
      --subscription-arn <ARN_подписки> <атрибуты>
     ```
  1. Измените подписку:
     ```bash
     aws sns set-subscription-attributes \
      --subscription-arn <ARN_подписки> <атрибуты>
     ```
  1. Посмотрите новые параметры подписки:
     ```bash
     aws sns get-subscription-attributes \
      --subscription-arn <ARN_подписки>
     ```

  Подробнее о командах см. в документации AWS: [set-subscription-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/set-subscription-attributes.html) и [get-subscription-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/get-subscription-attributes.html).

- AWS SDK для Python {#python}

  Чтобы изменить подписку, используйте следующий код:

  ```python
  try:
    response = sns.set_subscription_attributes(
      SubscriptionArn='<subscription_arn>',
      AttributeName='<attribute_name>',
      AttributeValue='<new_value>'
    )
  ```

{% endlist %}

## Удалить подписку {#subscribe-delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится топик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Слева выберите раздел **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}**.
  1. Выберите топик, в котором находится подписка.
  1. Слева выберите **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}**.
  1. Напротив нужной подписки нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- AWS CLI {#aws-cli}

  Выполните команду:

  ```bash
  aws sns unsubscribe --subscription-arn <ARN_подписки>
  ```

  Подробнее о команде `aws sns unsubscribe` см. в [документации AWS](https://docs.aws.amazon.com/cli/latest/reference/sns/unsubscribe.html).

- AWS SDK для Python {#python}

  Используйте следующий код:

  ```python
  try:
    response = sns.unsubscribe(
      SubscriptionArn='<ARN_подписки>'
  ```

{% endlist %}

При удалении подписки связанный с ней эндпоинт сохраняется.