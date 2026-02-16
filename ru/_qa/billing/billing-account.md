# Вопросы о платежном аккаунте

#### Как узнать идентификатор платежного аккаунта? {#account-id}

Чтобы узнать идентификатор платежного аккаунта:

{% include [billing-account-id](../../_includes/billing/billing-account-id.md) %}

#### Какое количество платежных аккаунтов я могу создать? {#account-amount}

{% include [billing-account-amounts](../../billing/_includes/billing-account-amounts.md) %}

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### Я создал личный платежный аккаунт. Могу ли я изменить его на бизнес-аккаунт? {#account-type}

После создания платежного аккаунта вы не можете изменить его [тип](../../billing/concepts/billing-account.md#ba-types), однако можете [создать новый аккаунт](../../billing/operations/create-new-account.md) с нужным типом.

#### Я создал новый платежный бизнес-аккаунт, а он заблокирован. Почему? {#blocked-account}

Скорее всего, ранее вы уже создавали платежный бизнес-аккаунт, для которого был активирован пробный период. В рамках пробного периода вашему платежному аккаунту выдается стартовый грант. Так как стартовый грант может быть выдан только на один платежный аккаунт, то при повторной регистрации вы не можете использовать пробный период и новый платежный аккаунт создается в статусе `SUSPENDED`.
Чтобы разблокировать новый платежный аккаунт, [активируйте платную версию](../../billing/operations/activate-commercial.md) и [пополните баланс лицевого счета](../../billing/operations/pay-the-bill.md) на минимальную сумму (минимальная сумма указана в окне **{{ ui-key.yacloud_billing.billing.account.dashboard.button_refill }}**).

#### Почему после создания платежного аккаунта я не получил письмо с описанием дальнейших действий? {#account-notification}

Если вы выбрали способ оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}** или если плательщик — нерезидент РФ и РК, вы получите письмо с описанием дальнейших действий на почту, указанную в аккаунте Яндекса или Яндекс 360. Вы также можете получить такое письмо в случае выбора способа оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_card }}**, если после создания платежного аккаунта потребуется его верификация. После проверки документов и данных ваш платежный аккаунт может быть активирован, и вы сможете начать пользоваться {{ yandex-cloud }}.
Если вы так и не получили письмо, отправьте запрос на электронную почту [{{ billing-docs-email }}](mailto:{{ billing-docs-email }}).

{% include [change-payment-docs](../../billing/_includes/change-payment-docs.md) %}

#### Почему при создании платежного аккаунта появляется ошибка «Недоступная страна для плательщика»? {#account-error}

Скорее всего, вы авторизованы на Яндексе под аккаунтом, к которому уже привязан плательщик с другим резидентством. 

{% include [billing-account-payers](../../billing/_includes/billing-account-payers.md) %}

Чтобы создать платежный аккаунт, в котором плательщиком будет являться резидент другой страны, войдите с другим Яндекс ID или авторизуйтесь под другим аккаунтом Яндекс 360. 

{% include [billing-account-payers-example](../../billing/_includes/billing-account-payers-example.md) %}

#### Не могу привязать банковскую карту при создании платежного аккаунта. Что делать? {#cant-create}

Скорее всего, платежная система вашей карты не поддерживается нашим сервисом.

Для решения проблемы попробуйте привязать другую карту или, если вы являетесь юридическим лицом, создайте платежный аккаунт с типом **{{ ui-key.yacloud_billing.billing.account.create-new.account-type_label_company }}** и способом оплаты **{{ ui-key.yacloud_billing.billing.account.create-new.payment-type_label_invoice }}**.

#### Что произойдет, если не привязать банковскую карту при создании платежного аккаунта? {#no-linked-card}

{% include [initail-payment-amout](../../_includes/billing/initial-payment-amount.md) %}

{% note warning %}

Если при создании аккаунта вы не привязали карту, то не сможете получить [стартовый грант](../../billing/concepts/bonus-account.md), даже если привяжете карту потом.

{% endnote %}

#### Какое количество облаков я могу привязать к платежному аккаунту? {#clouds-amount}

{% include [pin-cloud-note](../../billing/_includes/pin-cloud-note.md) %}

#### Как сменить привязку облака с одного платежного аккаунта на другой? {#cloud-transfer}

Чтобы сменить привязку облака, достаточно просто [привязать](../../billing/operations/pin-cloud.md) его к другому аккаунту. При этом облако автоматически потеряет привязку к своему текущему аккаунту. Чтобы избежать задолженности, не забудьте пополнить [лицевой счет](../../billing/concepts/personal-account.md) в платежном аккаунте, к которому было привязано облако.

#### Почему я не могу привязать облако к платежному аккаунту? {#cannot-pin-cloud}

Если ваш платежный аккаунт добавлен в организацию, вы можете привязать к нему только ресурсы, находящиеся в этой же организации. Возможно, у вас нет [прав на работу](../../billing/operations/pin-cloud.md#bind-roles) с этим облаком или платежным аккаунтом. Обратитесь к администратору вашей [организации](../../billing/concepts/organization.md) для [назначения необходимых ролей](../../billing/security/index.md#set-role).
Роли могут быть выданы как непосредственно на платежный аккаунт и облако, так и на организацию, где они находятся.

#### Случайно удалил облако. Почему не получается его восстановить? {#cloud-delete-cancel}

Нельзя отменить удаление облака, привязанного к заблокированному платежному аккаунту в статусе `SUSPENDED`.

См. [Отмена удаления облака](../../resource-manager/operations/cloud/delete-cancel.md).

#### Как подключить порог оплаты? {#credit}

[Порог оплаты](../../billing/concepts/billing-threshold.md) подключается автоматически после [активации платной версии](../../billing/operations/activate-commercial.md) и завершения первого отчетного периода.

{% include [change-payment-method](../../billing/_includes/change-payment-method.md) %}

#### Как изменить платежные реквизиты или адрес доставки документов? {#change-email}

{% include [change-address](../../billing/_includes/change-address.md) %}


#### Я отвязал карту от аккаунта на Яндексе, и мой платежный аккаунт заблокировали. Что делать? {#account-card}


Платежный аккаунт был переведен в статус `SUSPENDED` согласно [условиям договора (п. 6.11.4.)]({{ billing-oferta-url }}).
После блокировки на вашу почту, указанную в аккаунте Яндекса или Яндекс 360, было отправлено письмо с подробными инструкциями по восстановлению доступа.




#### Как сменить владельца платежного аккаунта? {#account-owner}

Любой пользователь с ролью `billing.accounts.owner` может удалить эту роль у создателя платежного аккаунта и изменить владельца. Подробнее в разделе [Управление доступом](../../billing/security/index.md).

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


