# Creating a new cloud


[When a user signs up](../../../billing/quickstart/index.md#create_billing_account), the system automatically creates a [cloud](../../concepts/resources-hierarchy.md#cloud) named `cloud-<Yandex ID>`. After you link a billing account, you can create an additional cloud.

To create an additional cloud:



{% list tabs %}

- Management console

      1. [On the billing page]({{ link-console-billing }}), make sure that the [payment account](../../../billing/concepts/billing-account.md) is in `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a billing account.
   1. On the [management console]({{ link-console-main }}) homepage, click ![image](../../../_assets/options.svg) next to your billing account.
   1. Select **Create cloud**.
   1. Enter the name of the cloud. For naming requirements, see below:

      {% include [name-format.md](../../../_includes/name-format.md) %}

   1. Enter the organization you are going to link the cloud to. If you don't have an organization yet, one will be created automatically.
   1. Click **Create**. The `default` folder page in the new cloud opens.

- API

   To create a cloud, use the [create](../../api-ref/Cloud/create.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/Create](../../api-ref/grpc/cloud_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the cloud to create:
      * `name`: Cloud name. For naming requirements, see below:

         {% include [name-format.md](../../../_includes/name-format.md) %}

      * `organization_id`: Organization ID. {{ TF }} only lets you create a cloud for an existing organization. You can get a list of organization IDs using the [CLI](../../../cli/quickstart.md) command: `yc organization-manager organization list`.

      Example of the configuration file structure:

      
      ```hcl
      provider "yandex" {
        token     = "<OAuth>"
        cloud_id  = "<ID of default cloud>"
        folder_id = "<ID of default cloud>"
        zone      = "<default availability zone>"
      }

      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<cloud name>"
        organization_id = "<organization ID>"
      }
      ```



      For more information about the `yandex_resourcemanager_cloud` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/resourcemanager_cloud).
   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` in the terminal and press **Enter**.

      You can verify the created cloud and its parameters in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager cloud list
      ```

{% endlist %}

{% note info %}

When you create a cloud, you are automatically given the [owner](../../concepts/resources-hierarchy.md#owner) role in this cloud.

{% endnote %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)