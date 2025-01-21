# Посмотреть историю платежей

Всю историю зачислений на [лицевой счет](../concepts/personal-account.md#balance) вы можете отслеживать на странице **{{ ui-key.yacloud_billing.billing.account.switch_history }}** либо в сервисе [Яндекс Баланс](https://yandex.ru/support/balance/operations/find-bill.html). Способ отслеживания зависит от вашего юридического статуса ([типа платежного аккаунта](../concepts/billing-account.md#ba-types)).

{% list tabs group=customers %}
        
- Юридические лица и ИП {#businesses}
  
  Организации и ИП могут отслеживать всю историю зачислений в сервисе Яндекс Баланс на странице [Счета](https://balance.yandex.ru/invoices.xml).
  
- Физические лица {#individuals}
  
  Физические лица могут посмотреть всю историю зачислений на странице **{{ ui-key.yacloud_billing.billing.account.switch_history }}**.

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт.
  1. На панели слева выберите ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **{{ ui-key.yacloud_billing.billing.account.switch_history }}**.

  <br/>Все платежи расположены в хронологическом порядке (самый старый платеж находится в самом низу).
  <br/>Чтобы отфильтровать платежи, задайте необходимый период. Результаты отобразятся в таблице.
  
  
  Название  | Описание
  ----- | -----
  {{ ui-key.yacloud_billing.billing.account.history.column_description }} | Подробная информация о платеже.
  {{ ui-key.yacloud_billing.billing.account.history.column_date }} | Дата зачисления средств на баланс лицевого счета.
  {{ ui-key.yacloud_billing.billing.account.history.column_status }} | Статус платежа.
  {{ ui-key.yacloud_billing.billing.account.history.column_money }} | Фактически зачисленные средства на баланс лицевого счета, в рублях.
  

  
  <br/>История платежей содержит агрегированные данные по всем сервисам. Подробная информация по оказанным услугам доступа на странице [Детализация](../operations/check-charges.md).
  
{% endlist %}
