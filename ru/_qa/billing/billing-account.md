# Вопросы о платежном аккаунте

#### Как узнать идентификатор платежного аккаунта? {#account-id}

Чтобы узнать идентификатор платежного аккаунта:

{% include [billing-account-id](../../_includes/billing/billing-account-id.md) %}

#### Какое количество платежных аккаунтов я могу создать? {#account-amount}

{% include [billing-account-amounts](../../billing/_includes/billing-account-amounts.md) %}

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### Какое количество облаков я могу привязать к платежному аккаунту? {#clouds-amount}

{% include [pin-cloud-note](../../billing/_includes/pin-cloud-note.md) %}

#### Как перенести облако на другой платежный аккаунт? {#cloud-transfer}

Чтобы перенести облако на другой платежный аккаунт, достаточно [привязать](../../billing/operations/pin-cloud.md) его к этому аккаунту. При этом облако автоматически потеряет привязку к своему текущему аккаунту. Чтобы избежать задолженности, не забудьте пополнить лицевой счет в платежном аккаунте, с которого перенесли облако.

#### Я создал новый платежный аккаунт, а он заблокирован. Почему? {#blocked-account}

Скорее всего, ранее вы уже создавали платежный аккаунт, для которого был активирован пробный период. В рамках пробного периода вашему платежному аккаунту выдается стартовый грант. Так как стартовый грант может быть выдан только на один платежный аккаунт, то при повторной регистрации вы не можете использовать пробный период и новый платежный аккаунт создается в статусе `SUSPENDED`.
Чтобы разблокировать новый платежный аккаунт, [активируйте платную версию](../../billing/operations/activate-commercial.md) и [пополните баланс лицевого счета](../../billing/operations/pay-the-bill.md) на минимальную сумму (минимальная сумма указана в окне **{{ ui-key.yacloud.billing.account.dashboard.button_refill }}**).

#### Как изменить тип платежного аккаунта? {#account-type}

После создания платежного аккаунта вы не можете изменить его тип, однако можете [создать новый](../../billing/operations/create-new-account.md).

#### Как подключить порог оплаты?  {#credit}

[Порог оплаты](../../billing/concepts/billing-threshold.md) подключается автоматически после [активации платной версии](../../billing/operations/activate-commercial.md) и завершения первого отчетного периода.


{% include [change-payment-method](../../billing/_includes/change-payment-method.md) %}


#### Как изменить платежные реквизиты или адрес доставки документов?  {#change-email}

{% include [change-address](../../billing/_includes/change-address.md) %}


#### Почему после создания платежного аккаунта со способом оплаты "{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_invoice }}" я не получил письмо с описанием дальнейших действий?  {#account-notification}

Активация платежного аккаунта может занять до трех рабочих дней.
Если в течение этого времени вы так и не получили письмо, отправьте запрос на электронную почту [cloud_docs@support.yandex.ru](mailto:cloud_docs@support.yandex.ru).

{% include [change-payment-docs](../../billing/_includes/change-payment-docs.md) %}


#### Я отвязал карту от аккаунта на Яндексе, и мой платежный аккаунт заблокировали. Что делать?  {#account-card}


Платежный аккаунт был переведен в статус `SUSPENDED` согласно [условиям договора (п. 6.11.4.)](https://yandex.ru/legal/cloud_oferta/).
После блокировки на вашу почту, указанную в аккаунте Яндекса или Яндекс 360, было отправлено письмо с подробными инструкциями по восстановлению доступа.




#### Не могу привязать банковскую карту при создании платежного аккаунта. Что делать?  {#cant-create}

Скорее всего, платежная система вашей карты не поддерживается нашим сервисом.

Для решения проблемы попробуйте привязать другую карту или, если вы являетесь юридическим лицом, создайте платежный аккаунт с типом **{{ ui-key.yacloud.billing.account.create-new.account-type_label_company }}** и способом оплаты **{{ ui-key.yacloud.billing.account.create-new.payment-type_label_invoice }}**.

#### Почему при создании платежного аккаунта появляется ошибка «Недоступная страна для плательщика»?  {#account-error}

Скорее всего, вы авторизованы на Яндексе под аккаунтом, к которому уже привязан плательщик с другим резидентством. 

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

Чтобы создать платежный аккаунт, в котором плательщиком будет являться резидент другой страны, войдите с другим Яндекс ID или авторизуйтесь под другим аккаунтом Яндекс 360. 

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### Как сменить владельца платежного аккаунта? {#account-owner}

Владельца платежного аккаунта сменить невозможно. Если возникла такая необходимость, новый владелец может [создать платежный аккаунт](../../billing/operations/create-new-account.md) и [привязать](../../billing/operations/pin-cloud.md) к нему облака со всеми ресурсами.
