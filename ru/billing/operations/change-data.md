# Изменить данные платежного аккаунта

Данные платежного аккаунта может менять только владелец — пользователь с ролью `billing.accounts.owner`. Подробную информацию см. в разделе [Управление доступом](../security/index.md).

Порядок действий пользователя зависит от вида изменений.

## Переименование платежного аккаунта {#change-name}

Изменить имя платежного аккаунта вы можете как на главной странице консоли управления, так и в сервисе {{ billing-name }}:  
1. Откройте [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
1. В левом верхнем углу нажмите значок ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Выберите сервис ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_overview }}**.
1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.billing.account.dashboard.label_rename }}** в верхнем блоке напротив названия аккаунта. 
1. Введите новое имя. 
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-resources.button_action-rename-account }}**.

## Изменение данных плательщика {#change-address}

Через сервис [Яндекс Баланс](https://balance.yandex.ru/) вы можете изменить контакты плательщика (например, почтовый адрес или телефон) или добавить платежные реквизиты (например, расчетный счет):
1. В [консоли управления]({{ link-console-billing }}) нажмите значок ![image](../../_assets/console-icons/dots-9.svg) и выберите сервис **{{ billing-name }}**.
1. Выберите аккаунт на странице **{{ ui-key.yacloud.billing.label_accounts }}**.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.switch_overview }}**.
1. Нажмите ссылку **{{ ui-key.yacloud.billing.account.dashboard-info.company_label_edit_ru }}**. <br/>Вы будете перенаправлены в сервис [Яндекс Баланс](https://balance.yandex.ru/).
1. Воспользуйтесь [инструкцией](https://yandex.ru/support/balance/operations/change-data.html) Яндекс Баланса.

## Изменение любых реквизитов, кроме ИНН {#change-details}

[Напишите запрос](../qa/common.md) в службу поддержки {{ yandex-cloud }}. В запросе укажите список измененных реквизитов и номер [договора](../concepts/contract.md), а также прикрепите копию акта, подтверждающего изменения (с подписью и печатью организации).

## Изменение юридического лица или ИНН {#change-legal-entity}

Изменить юридическое лицо или ИНН в настройках платежного аккаунта невозможно. Поэтому если у вас изменились эти реквизиты:
1. [Создайте](create-new-account.md) платежный аккаунт с новыми реквизитами, выбрав в качестве типа плательщика **Юридическое лицо или ИП**.
1. Дождитесь активации платежного аккаунта, чтобы избежать простоя ресурсов.
1. Перенесите все облака со старого платежного аккаунта на новый. Для этого достаточно [привязать](pin-cloud.md) их к новому платежному аккаунту.

##### См. также

* [Привязать другую карту](pin-card.md)
* [Изменить способ оплаты](change-payment-method.md)
* [Настроить уведомления](budgets.md)