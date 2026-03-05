# Активировать платную версию

Юридические лица могут активировать платную версию в течение шестидесяти дней с момента окончания срока действия [пробного периода](../concepts/trial-period.md). В противном случае все ресурсы будут автоматически удалены. Если за время пробного периода вы не израсходовали [стартовый грант](../concepts/bonus-account.md), то оставшуюся сумму можно будет использовать в будущем для оплаты потребленных ресурсов.

{% note info %}

Активировать платную версию может пользователь, которому назначена [роль](../security/index.md#billing-accounts-owner) `billing.accounts.owner`.

{% endnote %}

Чтобы перейти к использованию платной версии:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}
  
  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите платежный аккаунт.
  1. На странице ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.button_billing-payment-action }}**.
  1. Подтвердите переход, для этого еще раз нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.button_billing-payment-action }}**.

{% endlist %}

После активации платной версии [баланс лицевого счета](../concepts/personal-account.md#balance) по умолчанию равен нулю. Мы рекомендуем следить за балансом и [пополнять](../operations/pay-the-bill.md) его до положительного значения.
<br/>Если вы вовремя не пополните баланс и у вас появится задолженность, то использование сервисов {{ yandex-cloud }} может быть приостановлено. Дополнительную информацию см. в разделе [Цикл оплаты для организаций и ИП](../payment/billing-cycle-business.md)