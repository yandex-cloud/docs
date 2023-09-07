# Контролируйте расходы

С помощью инструкций в этом пункте чек-листа вы активируете платную версию и настроете оплату ресурсов для вашей организации.

## Активируйте платную версию {#pay-activate}

1. В [консоли управления]({{ link-console-billing }}) на странице **{{ ui-key.yacloud.billing.label_accounts }}** выберите платежный аккаунт.
1. На странице **{{ ui-key.yacloud.billing.account.switch_overview }}** нажмите кнопку **{{ ui-key.yacloud.billing.account.button_billing-payment-action }}**.
1. Подтвердите переход, для этого еще раз нажмите кнопку **{{ ui-key.yacloud.billing.account.button_billing-payment-action }}**.

После активации платной версии [баланс лицевого счета](../../billing/concepts/personal-account.md#balance) по умолчанию равен нулю. Мы рекомендуем следить за балансом и [пополнять](../../billing/operations/pay-the-bill.md) его до положительного значения.
<br/>Если вы вовремя не пополните баланс и у вас появится задолженность, то использование сервисов {{ yandex-cloud }} может быть приостановлено. Дополнительную информацию см. в разделе [Цикл оплаты](../../billing/payment/billing-cycle-business.md).

## Пополните лицевой счет {#pay-personal-account}

{% include [personal-account-balance](../../billing/_includes/personal-account-balance.md) %}

Чтобы пополнить лицевой счет:
1. В [консоли управления]({{ link-console-billing }}) на странице **{{ ui-key.yacloud.billing.label_accounts }}** выберите платежный аккаунт.
1. Нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**.
1. Выберите способ оплаты:

  {% list tabs %}

  - Банковская карта

    Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.popup-refill_button_individual-action }}**. Затем введите данные карты и нажмите кнопку **Оплатить**. К оплате принимаются банковские карты Visa, MasterCard и МИР.

    Платеж происходит в режиме реального времени и зачисляется в течение 15 минут.

  - Банковский перевод

    Введите сумму платежа и нажмите кнопку **{{ ui-key.yacloud.billing.account.dashboard-overview.popup-refill_button_company-action }}**.

    Система сформирует счет для оплаты. Распечатайте счет и используйте его для оплаты в отделении банка или через систему клиент-банк.

    Перед проведением оплаты убедитесь, что в платежном поручении корректно указаны:
    * сумма платежа;
    * банковские реквизиты ООО «Яндекс.Облако» (для РФ), ТОО «Яндекс.Облако Казахстан» (для РК), SAG (для нерезидентов РФ и РК);
    * ИНН вашей организации или ИП;
    * [номер лицевого счета](../../billing/concepts/personal-account.md#id) в назначении платежа;
    * [номер договора](../../billing/concepts/contract.md) в назначении платежа.

    Сроки зачисления средств зависят от банка, проводящего платеж.

    {% include [payment-bill-note](../../billing/_includes/payment-bill-note.md) %}

   {% endlist %}
 
## Настройте уведомления {#set-notif}

Для контроля расходов в {{ yandex-cloud }} настройте уведомления с помощью [бюджетов](../../billing/concepts/budget.md).  

Доступные типы бюджета:
* _{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}_ — уведомление отправляется, когда стоимость ресурсов без учета скидок превышает установленный порог потребления.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}_ — уведомление отправляется, когда стоимость ресурсов с учетом скидок и активных промокодов превышает установленный порог потребления.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}_ — уведомление отправляется, когда баланс лицевого счета становится меньше установленного порога.

{% note info %}

Вы можете создать триггер, который будет запускать [функцию](../../functions/concepts/function.md) {{ sf-name }} или [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} при превышении пороговых значений. Подробнее о [триггере для бюджетов](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}

## Создайте бюджет {#create-budget}

1. В [консоли управления]({{ link-console-billing }}) на странице **{{ ui-key.yacloud.billing.label_accounts }}** выберите платежный аккаунт.
1. Перейдите на страницу **{{ ui-key.yacloud.billing.account.budgets.label_budgets }}** и нажмите **{{ ui-key.yacloud.billing.account.budgets.button_create }}**.
   1. Введите имя бюджета.
   1. Выберите **{{ ui-key.yacloud.billing.account.budgets.label_type }}**.
   1. Задайте **Сумму бюджета**:
       * для типов **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** или **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** — сумму расходов на потребление;
       * для типа **{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}** — остаток на лицевом счете.
   1. Для типов **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** и **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** выберите период расчета бюджета:
       * Укажите дату начала действия бюджета, если выбрали **{{ ui-key.yacloud.billing.account.budgets.reset-period_value_custom }}** период. Дата начала — первое число месяца.
       * Задайте дату окончания действия бюджета. Дата окончания устанавливает, когда бюджет перестанет считать потребление или остаток средств и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.
   1. Выберите пользователей, которые получат уведомление.
   1. Для типов **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** и **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** определите область действия бюджета. Вы можете выбрать отдельные облака, каталоги и сервисы, которые будут входить в установленный бюджет. По умолчанию данные собираются со всех облаков, каталогов и сервисов, доступных выбранному платежному аккаунту. 
   1. Установите хотя бы один порог потребления, при котором будут отправлены уведомления. Вы можете указать пороговое значение в процентах или валюте и выбрать пользователей, которые получат уведомления. Бюджет может иметь несколько пороговых значений.
   
   {% note info %}
   
   Пользователи, указанные в блоке **{{ ui-key.yacloud.common.section-base }}**, будут получать уведомления при достижении каждого заданного порога. Пользователи, указанные при задании порога, получат уведомление только при достижении этого порога.
   
   Если при подсчете бюджета были достигнуты одновременно несколько порогов, пользователи получат только одно уведомление.
   
   {% endnote %}

1. После заполнения всех полей нажмите кнопку **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**. Бюджет будет создан.

## Контролируйте историю платежей {#control-pay}

Всю историю зачислений на [лицевой счет](../../billing/concepts/personal-account.md#balance) вы можете отслеживать либо на странице **{{ ui-key.yacloud.billing.account.switch_history }}**, либо в сервисе Яндекс Баланс. Способ отслеживания зависит от вашего юридического статуса ([типа платежного аккаунта](../../billing/concepts/billing-account.md#ba-types)).
  
Организации и ИП могут отслеживать всю историю зачислений в сервисе Яндекс Баланс на странице [Счета](https://balance.yandex.ru/invoices.xml).