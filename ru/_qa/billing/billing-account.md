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

#### Как сменить привязку облака с одного платежного аккаунта на другой? {#cloud-transfer}

Чтобы сменить привязку облака, достаточно просто [привязать](../../billing/operations/pin-cloud.md) его к другому аккаунту. При этом облако автоматически потеряет привязку к своему текущему аккаунту. Чтобы избежать задолженности, не забудьте пополнить лицевой счет в платежном аккаунте, к которому было привязано облако.

#### Почему я не могу привязать облако к платежному аккаунту? {#cannot-pin-cloud}

Если ваш платежный аккаунт добавлен в организацию, вы можете привязать к нему только ресурсы, находящиеся в этой же организации. Возможно, у вас нет [прав на работу](../../billing/operations/pin-cloud.md#bind-roles) с этим облаком или платежным аккаунтом. Обратитесь к администратору вашей [организации](../../billing/concepts/organization.md) для [назначения необходимых ролей](../../billing/security/index.md#set-role).
Роли могут быть выданы как непосредственно на платежный аккаунт и облако, так и на организацию, где они находятся.

#### Я создал новый платежный бизнес-аккаунт, а он заблокирован. Почему? {#blocked-account}

Скорее всего, ранее вы уже создавали платежный бизнес-аккаунт, для которого был активирован пробный период. В рамках пробного периода вашему платежному аккаунту выдается стартовый грант. Так как стартовый грант может быть выдан только на один платежный аккаунт, то при повторной регистрации вы не можете использовать пробный период и новый платежный аккаунт создается в статусе `SUSPENDED`.
Чтобы разблокировать новый платежный аккаунт, [активируйте платную версию](../../billing/operations/activate-commercial.md) и [пополните баланс лицевого счета](../../billing/operations/pay-the-bill.md) на минимальную сумму (минимальная сумма указана в окне **{{ ui-key.yacloud_billing.billing.account.dashboard.button_refill }}**).

#### Как изменить тип платежного аккаунта? {#account-type}

После создания платежного аккаунта вы не можете изменить его тип, однако можете [создать новый](../../billing/operations/create-new-account.md).

#### Как подключить порог оплаты? {#credit}

[Порог оплаты](../../billing/concepts/billing-threshold.md) подключается автоматически после [активации платной версии](../../billing/operations/activate-commercial.md) и завершения первого отчетного периода.

{% include [change-payment-method](../../billing/_includes/change-payment-method.md) %}

#### Как изменить платежные реквизиты или адрес доставки документов? {#change-email}

{% include [change-address](../../billing/_includes/change-address.md) %}

#### Почему после создания платежного аккаунта со способом оплаты "{{ ui-key.yacloud_billing_account.cloud-billing-account.payment-type_label_invoice }}" я не получил письмо с описанием дальнейших действий? {#account-notification}

Для активации платежного аккаунта происходит проверка документов и данных. После этого ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.
Если вы так и не получили письмо, отправьте запрос на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}).

{% include [change-payment-docs](../../billing/_includes/change-payment-docs.md) %}


#### Я отвязал карту от аккаунта на Яндексе, и мой платежный аккаунт заблокировали. Что делать? {#account-card}


Платежный аккаунт был переведен в статус `SUSPENDED` согласно [условиям договора (п. 6.11.4.)]({{ billing-oferta-url }}).
После блокировки на вашу почту, указанную в аккаунте Яндекса или Яндекс 360, было отправлено письмо с подробными инструкциями по восстановлению доступа.




#### Не могу привязать банковскую карту при создании платежного аккаунта. Что делать? {#cant-create}

Скорее всего, платежная система вашей карты не поддерживается нашим сервисом.

Для решения проблемы попробуйте привязать другую карту или, если вы являетесь юридическим лицом, создайте платежный аккаунт с типом **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}** и способом оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}**.

#### Почему при создании платежного аккаунта появляется ошибка «Недоступная страна для плательщика»? {#account-error}

Скорее всего, вы авторизованы на Яндексе под аккаунтом, к которому уже привязан плательщик с другим резидентством. 

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

Чтобы создать платежный аккаунт, в котором плательщиком будет являться резидент другой страны, войдите с другим Яндекс ID или авторизуйтесь под другим аккаунтом Яндекс 360. 

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### Как сменить владельца платежного аккаунта? {#account-owner}

Владельца платежного аккаунта сменить невозможно. Если возникла такая необходимость, новый владелец может [создать платежный аккаунт](../../billing/operations/create-new-account.md) и [привязать](../../billing/operations/pin-cloud.md) к нему облака со всеми ресурсами.

#### Где я могу добавить расчетный счет? {#checking-account}

Чтобы указать расчетный счет для платежного аккаунта:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
   1. Выберите платежный аккаунт.
   1. Перейдите на страницу **{{ ui-key.yacloud_billing.billing.account.switch_overview }}**.
   1. Нажмите ссылку **{{ ui-key.yacloud_billing.billing.account.dashboard-info.company_label_edit_ru }}**. 
      Вы будете перенаправлены в сервис [Яндекс Баланс](https://balance.yandex.ru/).
   1. Выберите плательщика и нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
   1. В разделе **Платежные реквизиты** заполните поле **{{ ui-key.yacloud_billing.billing.account.overview.company_label_rs }}**.

{% endlist %}

#### Как узнать, управляется ли мой аккаунт через организацию {{ yandex-cloud }}? {#check-ba-org}

{% include [account-in-organization](../../_includes/billing/check-account-organization.md) %}

#### Могу ли я оплачивать ресурсы сервисов, находящихся в другой организации {{ yandex-cloud }}? {#pay-org}

Да, можете.

{% include [account-in-organization](../../_includes/billing/pay-resouces-of-another-organization.md) %}

См. [Особенности управления платежным аккаунтом в организации](../../billing/concepts/organization.md).

#### Как перестать пользоваться платформой и удалить платежный аккаунт? {#delete-account}


Удалите все [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder) и ресурсы в них, погасите существующую задолженность и выберите **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}** на странице платежного аккаунта в сервисе [**{{ billing-name }}**]({{ link-console-billing }}). Подробнее см. в разделе [{#T}](../../billing/operations/delete-account.md).


