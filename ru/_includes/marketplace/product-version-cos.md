1. Загрузите логотип продукта в формате SVG.

1. Выберите категории продукта.

1. В поле **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** выберите созданный тариф или [создайте](../../marketplace/operations/create-tariff.md) новый.

1. В поле **Docker compose** опишите [Docker Compose-спецификацию](../../cos/concepts/coi-specifications.md#compose-spec) в формате YAML.

1. {% include [product-info](product-info.md) %}

1. {% include [links](links.md) %}

1. В блоке **{{ ui-key.yacloud_portal.marketplace_v2.version.section_title_resource-spec }}**:

    * Задайте требования к конфигурации ВМ, необходимой для работы вашего программного продукта:

        1. Нажмите справа на значок ![image](../../_assets/console-icons/plus.svg).

        1. Выберите параметр:

            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
            * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
            * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`

            {% include [version-remove-param](../../_includes/marketplace/version-remove-param.md) %}

    * {% include [version-non-numeric-params](../../_includes/marketplace/version-non-numeric-params.md) %}
    * {% include [version-numeric-params](../../_includes/marketplace/version-numeric-params.md) %}

1. {% include [terms](terms.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.