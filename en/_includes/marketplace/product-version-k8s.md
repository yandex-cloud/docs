1. Upload the product logo in SVG format.

1. Select product categories.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tariff }}** field, select the service plan that you created or create a new one.

1. In the **{{ ui-key.yacloud_portal.marketplace_v2.version.label_k8s-manifest }}** field, insert a valid link to the manifest previously uploaded to {{ objstorage-full-name }}. For more information about the manifest and product requirements for {{ managed-k8s-name }}, see [{#T}](../../marketplace/operations/create-container.md).

1. Fill in the product information in Russian and English:

   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-name }}**: Name of your product.
   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_short-description }}**: Brief description.
   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_image-description }}**: Detailed description of your product, i.e., what problems it addresses, its key characteristics, features, and advantages over similar products. Be specific and avoid advertising cliches.
   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tutorial }}**: Step-by-step guide on how to get started with your product. Specify what to pay attention to when deploying your product and what difficulties users may face.
   * **{{ ui-key.yacloud_portal.portal.support }}**: Your contact details if there are any questions or something goes wrong while using the product.
   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_use-cases }}**: List of examples of how your product can be used. Give links to available use cases (if any).

1. Add useful links in Russian and English.

1. Under **Terms of service**, add links to license agreements.

   For each link, fill in the following fields:
   * **Header (ru)**: Name of the product (or license agreement) in Russian.
   * **Header (en)**: Name of the product (or license agreement) in English.
   * **{{ ui-key.yacloud_portal.marketplace_v2.tariff.tariff-table_type }}**: Type of the license agreement:
      * For the main product: Additional terms of service.
      * For software from other vendors included in the product: Additional terms of service by third parties.
   * **{{ ui-key.yacloud_portal.marketplace_v2.version.label_tos-url }}**: Link to the license agreement.

1. Click **{{ ui-key.yacloud.common.create }}**.