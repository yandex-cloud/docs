---
title: Creating a new cloud
description: Follow this guide to create a new cloud.
---

# Creating a new cloud

[After you sign up](../../../billing/quickstart/index.md#create_billing_account) with {{ yandex-cloud }} and create an [organization](../../../organization/concepts/organization.md), you will create your first [cloud](../../concepts/resources-hierarchy.md#cloud). If you need an additional cloud, follow the same guide to create it.

To create a cloud:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure your [billing account](../../../billing/concepts/billing-account.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account, [create one](../../../billing/quickstart/index.md#create_billing_account) or ask your administrator to assign you the `billing.accounts.member` role for a billing account.
  1. Navigate to the [management console]({{ link-console-main }}).
  1. In the upper left corner next to the **{{ ui-key.yacloud.cloud-tree-list.value_search-placeholder }}** field, click ![plus](../../../_assets/console-icons/plus.svg). In the window that opens:
  
      1. Enter a name for the cloud. The naming requirements are as follows:

          {% include [name-format.md](../../../_includes/name-format.md) %}
      1. If you have multiple organizations, select the one you need.
      1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% note info %}

  To create a new cloud using the {{ yandex-cloud }} CLI, [link](../../../cli/operations/profile/manage-properties.md#set) the organization to a [CLI profile](../../../cli/operations/profile/profile-list.md).

  {% endnote %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. View the description of the create cloud command:

      ```bash
      yc resource-manager cloud create --help
      ```

  1. If you do not have a linked organization yet, link the one you want to create the cloud in to the CLI profile.

      ```bash
      yc config set organization-id <organization_ID>
      ```

      Where `<organization_ID>` is the [ID](../../../organization/operations/organization-get-id.md) of the organization to create the cloud in.

  1. To create the cloud, run this command:

      ```bash
      yc resource-manager cloud create \
        --name <cloud_name> \
        --billing-account-id <billing_account_ID>
      ```

      Where:

      * `--name`: Name of the cloud you are creating. The naming requirements are as follows:

          {% include [name-format.md](../../../_includes/name-format.md) %}
      * `--billing-account-id`: ID of the [billing account](../../../billing/concepts/billing-account.md) to link the new cloud to.

          You can get the billing account ID in the [{{ billing-name }} interface]({{ link-console-billing }}) under **{{ ui-key.yacloud_billing.billing.account.dashboard-info.title_main }}** on the billing account page.

      Result:

      ```text
      done (4s)
      id: b1gbi30tq0m9********
      created_at: "2024-12-10T09:25:22Z"
      name: my-new-cloud
      organization_id: bpfaidqca8vd********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% note warning %}

  To activate the cloud, make sure to link it to your billing account. Until then, the new cloud will remain in the `Creating` status. To link the cloud to your billing account, use the `yandex_billing_cloud_binding` resource and specify the cloud ID in the `cloud_id` field.

  {% endnote %}

  1. In the {{ TF }} configuration file, describe the resources you want to create:

      ```hcl
      # Creating a cloud

      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "<cloud_name>"
        organization_id = "<organization_ID>"
      }

      # Linking the cloud to the billing account

      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<billing_account_ID>"
        cloud_id           = yandex_resourcemanager_cloud.cloud1.id
      }
      ```

      Where:

      * `name`: Cloud name. The naming requirements are as follows:
      
        {% include [name-format.md](../../../_includes/name-format.md) %}
        
      * `organization_id`: Organization [ID](../../../organization/operations/organization-get-id.md). {{ TF }} allows you to create a cloud only for an existing organization.
      * `billing_account_id`: ID of the [billing account](../../../billing/concepts/billing-account.md) to link the new cloud to.

          You can get the [billing account ID](../../../billing/concepts/billing-account.md#billing-account-id) in the [{{ billing-name }}]({{ link-console-billing }}) interface under **{{ ui-key.yacloud_billing.billing.account.dashboard-info.title_main }}** on the billing account page.
      * `cloud_id`: [ID](../../../resource-manager/operations/cloud/get-id.md) of the cloud to link to the billing account.

      For more information about the `yandex_resourcemanager_cloud` and `yandex_billing_cloud_binding` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-docs-link }}).

  1. Create the resources:

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
