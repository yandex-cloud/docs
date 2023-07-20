# Link a cloud to a billing account

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

## Requirements for linking a cloud

Before linking a cloud, make sure that the billing account has been activated (the `ACTIVE` or `TRIAL_ACTIVE` status) and that the user has the following roles:
* [resource-manager.clouds.owner](../../iam/concepts/access-control/roles.md#owner) in the cloud.
* `billing.accounts.owner` or `editor` in the billing account. Read more about roles in [Access control](../security/index.md#role-list).

## Linking a cloud {#bind-cloud}

To link a cloud or transfer an existing one:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/main-menu.svg) **All services**.

  1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).

  1. Select an account from the list.

  1. Go to the **Account data** page.

  1. Under **Clouds**, click **Link cloud**.

  1. Select a cloud from the list.

  1. Click **Link** and the added cloud will appear on the list.

  1. If you transferred a cloud, pay any outstanding charges on the old account.

- {{ TF }}

  If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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

   After that, the cloud will be linked to the billing account. You can check that the cloud is linked to the account on the billing account page in [Billing]({{ link-console-billing }}).

{% endlist %}


{% include [account_scope.md](../_includes/account-scope.md) %}

If you are migrating a cloud because you want to stop using the old billing account, make sure the free Basic service plan is activated in it. Otherwise, even though it has no linked clouds remaining, you will continue to be charged for the paid service plan.





