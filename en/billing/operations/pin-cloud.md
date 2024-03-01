---
title: "How to link a cloud to a billing account"
description: "Follow this guide to link a cloud to a billing account."
---

# Linking a cloud to a billing account

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Requirements for linking a cloud {#bind-roles}

Before linking a cloud, make sure that the billing account has been activated (the `ACTIVE` or `TRIAL_ACTIVE` status) and that the user has the following roles:
* [resource-manager.clouds.owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) in the cloud.
* `billing.accounts.owner` or `editor` in the billing account. To learn more about roles, see [Access management](../security/index.md#roles-list).

## Linking a cloud {#bind-cloud}

To link a cloud or transfer an existing one:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.

  1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).

  1. Select an account from the list.

  1. Go to the **{{ ui-key.yacloud.billing.account.switch_overview }}** page.

  1. Under **{{ ui-key.yacloud.billing.account.dashboard-resources.section_resources }}**, click **{{ ui-key.yacloud.billing.account.dashboard-resources.button_bind-cloud }}**.

  1. Select the cloud from the list.

  1. Click **{{ ui-key.yacloud.billing.account.bind-cloud.button_bind }}** and the added cloud will appear on the list.

  1. If you transferred a cloud, pay any outstanding charges on the old account.

- {{ TF }} {#tf}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To link a cloud, a service account must have the `billing.accounts.owner` or `editor` [role](../security/index.md#set-role) for the billing account.

  1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_billing_cloud_binding" "mycloud" {
        billing_account_id = "<billing_account_ID>"
        cloud_id           = "<cloud_ID>"
      }
      ```

      Where:

      * `billing_account_id`: ID of the billing account to link the cloud to.
      * `cloud_id`: ID of the cloud to link the billing account to.

      For more information about the `yandex_billing_cloud_binding` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/billing_cloud_binding).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   After that, the cloud will be linked to the billing account. You can check that the cloud is linked to the account on the billing account page in the [{{ billing-name }} service]({{ link-console-billing }}).

- API {#api}

   To link a cloud, use the [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) REST API method for the [BillingAccount](../api-ref/BillingAccount/index.md) resource or the [BillingAccountService/BindBillableObject](../api-ref/grpc/billing_account_service.md#BindBillableObject) gRPC API call.

{% endlist %}


If you are migrating a cloud because you want to stop using the old billing account, make sure the free Basic service plan is activated in it. Otherwise, even though it has no linked clouds remaining, you will continue to be charged for the paid service plan.

## Resource management in organizations {#bind-cloud-organization}

1. If your billing account is [added to your organization](../concepts/organization.md), you will be able to connect only those clouds and {{ ml-platform-name }}, {{ tracker-name }}, or {{ datalens-short-name }} instances that are created in your organization.

1. {% include [account_scope.md](../_includes/account-scope.md) %}
