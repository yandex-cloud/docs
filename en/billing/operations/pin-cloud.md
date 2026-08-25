---
title: How to link a cloud to a billing account
description: Follow this guide to link a cloud to a billing account.
---

# Linking a cloud to a billing account

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Requirements for linking a cloud {#bind-roles}

Before linking a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), make sure the following conditions are met:
1. [Billing account](../concepts/billing-account.md) has been successfully activated, i.e., its [status](../concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`.
1. The user holds all these [roles](../../iam/concepts/access-control/roles.md) at once:
   * [resource-manager.clouds.owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the cloud.
   * [billing.accounts.editor](../security/index.md#billing-accounts-editor) and higher for the billing account.

## Linking a cloud {#bind-cloud}

To link or re-link a cloud to a billing account:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
   1. Select the billing account you want to link the cloud to.
   1. Proceed to linking your cloud or service using one of the following methods:

       * Click ![alt text](../../_assets/console-icons/link.svg) **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}** under **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_section-billable }}** in the ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** section.

         {% cut "Steps in the UI" %}

         ![image](../../_assets/billing/pin-cloud-account.png)

         {% endcut %}

       * In the left-hand panel, select ![image](../../_assets/console-icons/cloud.svg) **{{ ui-key.yacloud_org.billing.account.entities.label_title }}**. In the top-right corner of the page, click ![image](../../_assets/console-icons/link.svg) **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**.

         {% cut "Steps in the UI" %}

         ![image](../../_assets/billing/pin-cloud-billable-entities.png)

         {% endcut %}

     1. In the **{{ ui-key.yacloud_org.billing.account.entities.label_type }}** field, pick the entity type you need from the list and select the resource to link to the billing account.
     1. Click **{{ ui-key.yacloud_billing.billing.account.bind-cloud.button_bind }}**; the cloud or service you added will appear in the list.
     1. If you are re-linking the cloud, pay any outstanding charges on the old billing account.

         ![image](../../_assets/billing/pin-cloud-billable-entities-window.png)

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To link a cloud, the [service account](../../iam/concepts/users/service-accounts.md) must have the `billing.accounts.editor` [role](../security/index.md#set-role) or higher for the billing account you are linking your cloud to.

  To link a cloud to a billing account:
  
  1. In the configuration file, specify the properties of the resources you want to create:

     ```hcl
     resource "yandex_billing_cloud_binding" "mycloud" {
       billing_account_id = "<billing_account_ID>"
       cloud_id           = "<cloud_ID>"
     }
     ```

     Where:
     * `billing_account_id`: ID of the billing account to link the cloud to.
     * `cloud_id`: ID of the cloud you want to link to the billing account.

     For more on the properties of the `yandex_billing_cloud_binding` resource in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/billing_cloud_binding).
  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  After that, the cloud will be linked to the billing account.

- API {#api}

  To link a cloud, use the [bindBillableObject](../api-ref/BillingAccount/bindBillableObject.md) REST API method for the [BillingAccount](../api-ref/BillingAccount/index.md) resource or the [BillingAccountService/BindBillableObject](../api-ref/grpc/BillingAccount/bindBillableObject.md) gRPC API call.

{% endlist %}

{% note warning %}

Linking a cloud or another container to a [suspended account](../concepts/billing-account-statuses.md) will stop all your resources.

{% endnote %}

## How to check the cloud's link {#check-binding}

To check the cloud's or service's link to a billing account, use one of these methods:

  {% list tabs %}

  - Via Account

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Select the billing account the new cloud or service was linked to.
  
        Under **{{ ui-key.yacloud_billing.billing.account.dashboard-resources.title_section-billable }}**, you can see the type and number of your linked resources.

    1. For detailed information about the linked resources, click a resource or ![alt text](../../_assets/console-icons/chevron-right.svg) **{{ ui-key.yacloud.common.action_show-all }}**.

      You will see the list of all linked clouds and services.

  - Via Clouds and services

    1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
    1. Select the billing account the new cloud or service was linked to.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/cloud.svg) **{{ ui-key.yacloud_org.billing.account.entities.label_title }}**.

      You will see the list of all linked clouds and services.

  {% endlist %}

## Resource management in organizations {#bind-cloud-organization}

1. {% include [cloud-to-pin.md](../_includes/clouds-to-pin.md) %}
1. {% include [account_scope.md](../_includes/account-scope.md) %}

If you want to stop using the old billing account, make sure it is on the free **Basic** service plan to avoid having your balance further debited. Otherwise, you will continue to be billed for the paid plan even if the account has no linked clouds.
