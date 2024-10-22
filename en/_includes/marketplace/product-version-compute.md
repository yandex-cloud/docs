1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** field, select the service plan that you created or create a new one.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_compute-image }}** field, click **{{ ui-key.yacloud.common.add }}**. In the window that opens, find your folder and select the image.

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. If necessary, specify the OS name and version. This section is filled out automatically based on the parameters of the basic image of the operating system.

1. Under **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_packages }}**, list the software and versions included in the product.

1. Under **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:

   * Set the VM configuration requirements for your software to run:

      1. Click the ![image](../../_assets/console-icons/plus.svg) icon on the right.

      1. Select an option for:
         * `CPU share`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
         * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`

           {% include [version-remove-param](../../_includes/marketplace/version-remove-param.md) %}

   * {% include [version-non-numeric-params](../../_includes/marketplace/version-non-numeric-params.md) %}
   * {% include [version-numeric-params](../../_includes/marketplace/version-numeric-params.md) %}

1. {% include [terms](terms.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.