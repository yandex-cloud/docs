# Creating a new cloud


[At sign-up](../../../billing/quickstart/index.md#create_billing_account), a [cloud](../../concepts/resources-hierarchy.md#cloud) named `cloud-<Yandex_ID>` will be automatically created for you. After you link a billing account, you can create an additional cloud.

To create an additional cloud:



{% list tabs group=instructions %}

- Management console {#console}

  1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure your [billing account](../../../billing/concepts/billing-account.md) is in `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a billing account.

  1. Go to the [management console]({{ link-console-main }}).

  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens:
  
      1. Enter a name for the cloud. The naming requirements are as follows:

          {% include [name-format.md](../../../_includes/name-format.md) %}

      1. If you have multiple organizations, select the one you need.

      1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To activate the cloud, make sure to link it to your billing account. To do this, use the `yandex_billing_cloud_binding` resource indicating the cloud in the `cloud_id` field.

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
        
      * `organization_id`: Organization [ID](../../../organization/operations/organization-get-id.md). {{ TF }} allows you to create a cloud only for an existing organization.
      * `billing_account_id`: Billing account ID.
      * `cloud_id`: [ID](../../../resource-manager/operations/cloud/get-id.md) of the cloud to link to the billing account.

      For more information about the `yandex_resourcemanager_cloud` and `yandex_billing_cloud_binding` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-docs-link }}).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a cloud linked to your billing account in the organization. You can check the new cloud and its parameters in the [management console]({{ link-console-main }}) or using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc resource-manager cloud list
    ```

- API {#api}

  To create a cloud, use the [create](../../api-ref/Cloud/create.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/Create](../../api-ref/grpc/Cloud/create.md) gRPC API call.

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
