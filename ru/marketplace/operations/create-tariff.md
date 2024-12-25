---
title: Создание тарифа
description: Следуя данной инструкции, вы сможете создать тариф.
---

# Создание тарифа

1. Авторизуйтесь в [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
1. Перейдите в продукт, для которого вы хотите добавить новый [тариф](../concepts/tariff.md).
1. На вкладке **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** нажмите кнопку **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**. Если вы не видите кнопку **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**, значит, ваша заявка на продукт еще не одобрена. Подробности и сроки вы можете уточнить в разделе **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.
1. В открывшемся окне введите название тарифа и выберите ценовую политику. Для разных типов продуктов доступны разные политики.

   {% include [types](../../_includes/marketplace/types-of-charge.md) %}

1. Укажите цену за выбранную единицу измерения.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

## Создать сложный тариф {#complex-tariff}

1. Авторизуйтесь в [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
1. Перейдите в продукт, для которого вы хотите добавить сложный [тариф](../concepts/tariff.md).
1. На вкладке **{{ ui-key.yacloud_portal.marketplace_v2.product.tab_tariffs }}** нажмите кнопку **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**. Если вы не видите кнопку **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_action_create }}**, значит, ваша заявка на продукт еще не одобрена. Подробности и сроки вы можете уточнить в разделе **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.
1. Введите название тарифа.
1. Выберите тип `{{ ui-key.yacloud_components.marketplace.product-pricing-type_payg }}` ⟶ **Другая схема тарификации**.
1. В поле **Описание тарифа** опишите создаваемый тариф:
    * Опишите тариф, который хотите создать, и мы поможем реализовать его, если это возможно.
    * Самостоятельно создайте тариф: укажите метрику, на основании которой будет учтено потребление продукта пользователями, и цену использования одной единицы измерения.

    Подробнее см. [{#T}](../concepts/api-usage.md).

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

Тариф будет отправлен на проверку для утверждения. После утверждения SKU вы получите `skuId`, соответствующий созданному тарифу. `skuId` используется в API для работы с [записями о потреблении приложения](../api-ref/).
