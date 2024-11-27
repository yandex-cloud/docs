1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** field, select the service plan you created or create a new one.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_k8s-manifest }}** field, insert a valid link to the manifest previously uploaded to {{ objstorage-full-name }}. For more information about the manifest and product requirements for {{ managed-k8s-name }}, see [{#T}](../../marketplace/operations/create-container.md).

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. {% include [terms](terms.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.

## Version testing {#k8s-test}

{% note warning %}

Once you click **{{ ui-key.yacloud_portal.marketplace_v2.common.page_action_send-to-moderating }}** and submit a product version for moderation, you will not be able to run it and test its performance.

{% endnote %}

To test a product version:

1. On the **Versions** tab, select the product version created earlier.
1. In the top-right corner, click ![image](../../_assets/console-icons/caret-right.svg) **Start**.
