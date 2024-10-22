1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** field, select the service plan you created or [create](../../marketplace/operations/create-tariff.md) a new one.

1. In the **Docker compose** field, describe the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec) in YAML format.

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. Under **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:

    * Set the VM configuration requirements for your software to run:

        1. Click the ![image](../../_assets/console-icons/plus.svg) icon on the right.

        1. Select an option for:

            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
            * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`

            {% include [version-remove-param](../../_includes/marketplace/version-remove-param.md) %}

    * {% include [version-non-numeric-params](../../_includes/marketplace/version-non-numeric-params.md) %}
    * {% include [version-numeric-params](../../_includes/marketplace/version-numeric-params.md) %}

1. {% include [terms](terms.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.