{% include [change-plan-roles](../../_includes/support/pricing-roles.md) %}

Чтобы изменить тарифный план технической поддержки {{ yandex-cloud }}:

1. На [главной странице поддержки]({{ link-console-support }}) в {{ support-center-name }} на панели слева выберите раздел **{{ ui-key.support-center.common.plans }}**.
1. В окне **{{ ui-key.support-center.common.plans }}** будет указан платежный аккаунт, с которого будут списываться средства платных тарифов технической поддержки.
1. Смените тариф:
    * Чтобы перейти на **{{ ui-key.support-center.tariff-plans.tariff-card.title_free }}** тариф, нажмите кнопку **{{ ui-key.support-center.tariff-plans.info.action_go }}**.
    * Чтобы перейти на **{{ ui-key.support-center.tariff-plans.tariff-card.title_business }}** тариф, нажмите кнопку **{{ ui-key.support-center.tariff-plans.info.action_go }}**.
    * Чтобы перейти на **{{ ui-key.support-center.tariff-plans.tariff-card.title_premium }}** тариф, нажмите кнопку **{{ ui-key.support-center.tariff-plans.info.action_leave-request }}**.

Если в одной организации с включенным тарифом поддержки есть ресурсы, оплачивающиеся разными платежными аккаунтами, то процентная часть тарифа будет взиматься с каждого платежного аккаунта в зависимости от стоимости потребления ресурсов, а фиксированную часть платит только один аккаунт, который был указан для этого при выборе тарифа **{{ ui-key.support-center.tariff-plans.tariff-card.title_business }}**. При смене тарифа вы можете выбрать, с какого платежного аккаунта будет списываться фиксированная часть. Это может делать только владелец организации. Чтобы изменить платежный аккаунт:

1. В окне **{{ ui-key.support-center.common.plans }}** для выбора другого аккаунта нажмите кнопку **{{ ui-key.support-center.billing-account.common.action_edit }}**.
1. В окне **{{ ui-key.support-center.billing-account.common.title_billing-account }}** укажите альтернативный аккаунт одним из способов:
    * Выберите аккаунт из списка.
    * Создайте новый аккаунт.

Повышение тарифного плана происходит сразу, понижение — первого числа следующего месяца. Действующие тарифные планы и примеры расчета вы можете посмотреть в разделе [Правила тарификации](../../support/pricing.md).