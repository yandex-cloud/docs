---
title: How to link a cloud to a billing account
description: Follow this guide to link a cloud to a billing account.
---

# Linking a cloud to a billing account

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Requirements for linking a cloud {#bind-roles}

Before linking a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), make sure that the [billing account](../concepts/billing-account.md) has been activated (has the `ACTIVE` or `TRIAL_ACTIVE` [status](../concepts/billing-account-statuses.md) and the user has all of the following [roles](../../iam/concepts/access-control/roles.md):
* [resource-manager.clouds.owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the cloud.
* `billing.accounts.owner` or `editor` for the billing account. To learn more about roles, see [Access management](../security/index.md#roles-list).

## Linking a cloud {#bind-cloud}

To link a cloud to a billing account or change the billing account a cloud is linked to:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select the billing account you want to link the cloud to.
  1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page.
  1. Under **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_clouds }}**, click **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.button_bind-cloud }}**.
  1. Select the cloud from the list.
  1. Click **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}** and the added cloud will appear on the list.
  1. If you are changing the cloud's billing account, pay any outstanding charges on the old billing account.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To link a cloud, a [service account](../../iam/concepts/users/service-accounts.md) must have the `billing.accounts.owner` `editor` [role](../security/index.md#set-role) for the billing account.
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

     For more information about the `yandex_billing_cloud_binding` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/billing_cloud_binding).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  After that, the cloud will be linked to the billing account. You can check that the cloud is linked to the account on the billing account page in [{{ billing-name }}]({{ link-console-billing }}).

- API {#api}

  To link a cloud, use the [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) REST API method for the [BillingAccount](../api-ref/BillingAccount/index.md) resource or the [BillingAccountService/BindBillableObject](../api-ref/grpc/BillingAccount/bindBillableObject.md) gRPC API call.

{% endlist %}

If you are migrating a cloud because you want to stop using the old billing account, make sure the free **Basic** service plan is activated in it. Otherwise, even though it has no linked clouds remaining, you will continue to be charged for the paid service plan.

{% note warning %}

Note that linking a cloud (or another container) to the [blocked account](../concepts/billing-account-statuses.md) will stop all your resources.

{% endnote %}

## Resource management in organizations {#bind-cloud-organization}

1. {% include [cloud-to-pin.md](../_includes/clouds-to-pin.md) %}
1. {% include [account_scope.md](../_includes/account-scope.md) %}