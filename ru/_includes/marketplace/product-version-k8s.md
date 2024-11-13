1. Загрузите логотип продукта в формате SVG.

1. Выберите категории продукта.

1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или создайте новый.

1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_k8s-manifest }}** вставьте действующую ссылку на манифест, предварительно загруженный в {{ objstorage-full-name }}. Подробнее о манифесте и требованиям к продуктам для {{ managed-k8s-name }} см. [{#T}](../../marketplace/operations/create-container.md).

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. {% include [terms](terms.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

## Тестирование версии {#k8s-test}

{% note warning %}

Запустить версию продукта, чтобы протестировать ее работу, можно только до того, как вы нажмете кнопку **{{ ui-key.yacloud_portal.marketplace_v2.common.page_action_send-to-moderating }}** и отправите версию на модерацию.

{% endnote %}

Чтобы протестировать версию продукта:

1. На вкладке **Версии** выберите ранее созданную версию продукта.
1. В правом верхнем углу нажмите кнопку ![image](../../_assets/console-icons/caret-right.svg) **Запустить**.
