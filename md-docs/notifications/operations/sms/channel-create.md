# Создать канал SMS-уведомлений

В {{ cns-name }} сообщения конечным пользователям отправляются через [каналы уведомлений](../../concepts/index.md#channels) с [общим](../../concepts/sms.md#common-sender) или [индивидуальным](../../concepts/sms.md#individual-sender) отправителем.


## Создать канал SMS-уведомлений с общим отправителем {#create-common-channel}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_sms }}** выберите [тип отправителя](../../concepts/sms.md#senders) **{{ ui-key.yacloud.cns.sender_sms-common }}** и нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Создать канал SMS-уведомлений c индивидуальным отправителем {#create-individual-channel}

{% note info %}

Зарегистрировать индивидуальное имя отправителя могут юридические лица или ИП.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать канал уведомлений.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Нажмите **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. На вкладке **{{ ui-key.yacloud.cns.type_sms }}** выберите тип отправителя **{{ ui-key.yacloud.cns.sender_sms-individual }}**.
  1. Укажите желаемое текстовое имя отправителя и нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

После этого будет автоматически сформирована заявка в техническую поддержку на регистрацию текстового имени отправителя.

{% note info %}

Регистрация текстового имени отправителя может занять от 2 до 4 недель.

{% endnote %}

Когда регистрация завершится, вы получите ответ от технической поддержки о предоставлении доступа к каналу с индивидуальным отправителем.

#### См. также {#see-also}

* [{#T}](manage-templates.md)