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

      1. Click the plus sign icon on the right.

      1. Select an option for:
         * `CPU share`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_gpu }}`
         * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`
         * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`
           To remove a parameter, click ![image](../../_assets/console-icons/xmark.svg) next to its name. The `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_cpu }}`, `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_memory }}`, and `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_disk-size }}` parameters are required and cannot be removed.

   * For the parameters:
      * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_platforms }}`: Select all the platforms on which the VM can be deployed.
      * `{{ ui-key.yacloud.common.resource-acl.label_bindings }}`: Select the required roles. If you specify the service account role, the user will be prompted to link a service account with this role to the VM when it is deployed.
      * `{{ ui-key.yacloud_portal.marketplace_v2.version.label_resource-spec_network }}`: Specify the maximum available number of network interfaces for VMs based on your product. By default, one network interface is available.
   * For the other parameters in the **{{ ui-key.yacloud_portal.common.min }}** field, specify the value that guarantees your software will run on the deployed VM. The user cannot start a VM with the parameters below those specified. If necessary, fill in the fields:
      * **{{ ui-key.yacloud_portal.common.max }}**: Maximum parameter value. The user cannot start a VM with parameters higher than those specified.
      * **{{ ui-key.yacloud_portal.common.recommended }}**: Optimal value for your software to run on the VM.

1. {% include [terms](terms.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.
