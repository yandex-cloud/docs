# Creating a new cloud


[When a user signs up](../../../billing/quickstart/index.md#create_billing_account), the system automatically creates a [cloud](../../concepts/resources-hierarchy.md#cloud) named `cloud-<Yandex ID>`. After you link a billing account, you can create an additional cloud.

To create an additional cloud:



{% list tabs %}

- Management console

      1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a billing account.
   1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, select a billing account.
   1. Under **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}**, click **{{ ui-key.yacloud.common.create }}**.
   1. Enter the name of the cloud. The naming requirements are as follows:

      {% include [name-format.md](../../../_includes/name-format.md) %}

   1. Enter the organization you are going to link the cloud to.
   1. Click **{{ ui-key.yacloud.common.create }}**. The `default` folder page in the new cloud opens.

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To activate the cloud, make sure to link it to your billing account. To do this, use the `yandex_billing_cloud_binding` resource and specify the cloud in the `cloud_id` field.

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<cloud_name>"
        organization_id = "<organization_ID>"
      }

      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<billing_account_ID>"
        cloud_id           = yandex_resourcemanager_cloud.cloud1.id
      }
      ```

      Where:

      * `name`: Cloud name. The naming requirements are as follows:

         {% include [name-format.md](../../../_includes/name-format.md) %}

      * `organization_id`: Organization ID. {{ TF }} allows you to create a cloud only for an existing organization. You can get a list of organization IDs using the [CLI](../../../cli/quickstart.md) command: `yc organization-manager organization list`.
      * `billing_account_id`: Billing account ID.
      * `cloud_id`: ID of the cloud to link to the billing account.

      For more information about the `yandex_resourcemanager_cloud` and `yandex_billing_cloud_binding` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-docs-link }}).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a cloud linked to your billing account in the organization. You can verify the created cloud and its parameters in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc resource-manager cloud list
      ```

- API

   To create a cloud, use the [create](../../api-ref/Cloud/create.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/Create](../../api-ref/grpc/cloud_service.md#Create) gRPC API call.

{% endlist %}

{% note info %}

When you create a cloud, you are automatically given the [owner](../../concepts/resources-hierarchy.md#owner) role in this cloud.

{% endnote %}

#### See also {#see-also}

* [{#T}](update.md)
* [{#T}](set-access-bindings.md)
* [{#T}](switch-cloud.md)
* [{#T}](../folder/create.md)
* [{#T}](../../../billing/concepts/billing-account.md)
