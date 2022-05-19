# Creating a new cloud

[When a user signs up](../../../billing/quickstart/index.md#create_billing_account), the system automatically creates a [cloud](../../concepts/resources-hierarchy.md#cloud) named `cloud-<Yandex ID>`. After you link a billing account, you can create an additional cloud.

To create an additional cloud:

{% list tabs %}

- Management console

   1. [On the billing page]({{ link-console-billing }}), make sure that the [payment account](../../../billing/concepts/billing-account.md) is in `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a billing account.
   1. On the [management console]({{ link-console-main }}) homepage, click ![image](../../../_assets/options.svg) next to your billing account.
   1. Select **Create cloud**.
   1. Enter the name of the cloud. Naming requirements:

      {% include [name-format.md](../../../_includes/name-format.md) %}

   1. Enter the organization you are going to link the cloud to. If you don't have an organization yet, one will be created automatically.
   1. Click **Create**. The `default` folder page in the new cloud opens.

- Terraform

   If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the cloud to create:
      * `name`: Cloud name. Naming requirements:

         {% include [name-format.md](../../../_includes/name-format.md) %}

      * `organization_id`: Organization ID. Terraform allows you to create a cloud only for an existing organization. You can get a list of organization IDs using the [CLI](../../../cli/quickstart.md) command: `yc organization-manager organization list`.

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

      For more detailed information about the `yandex_resourcemanager_cloud` resource parameters in Terraform, see the [provider documentation](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_cloud).
   1. In the command line, go to the directory where you created the configuration file.
   1. Make sure the configuration file is correct using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal displays a list of resources to be created and their parameters. No changes are made at this step. If there are errors in the configuration, Terraform points them out.
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

#### For details, see also {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)