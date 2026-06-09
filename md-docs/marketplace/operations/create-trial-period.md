# Создание пробного периода

1. Авторизуйтесь в [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
1. Перейдите в продукт, для которого вы хотите добавить [пробный период](../concepts/trial-period.md).
1. Перейдите на вкладку **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** и выберите тариф.

    {% note warning %}

    Пробный период можно создать только для тарифа c ценовой политикой `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` для SKU, основанных на параметрах потребления ВМ.

    {% endnote %}
    
1. Нажмите кнопку **{{ ui-key.yacloud_portal.marketplace_v2.tariff.action_create-trial-spec }}**.
1. Укажите длительность пробного периода и нажмите **{{ ui-key.yacloud.common.create }}**.