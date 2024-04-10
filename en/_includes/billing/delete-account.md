1. Go to [**{{ billing-name }}**](https://billing.yandex.cloud/accounts/).
1. Select the billing account from the list.
1. In the top-right corner of the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}**.
1. Confirm and wait until the service checks whether your billing account can be deleted.
1. If the account can be deleted, the deletion notification will pop up. At this point, you can still abort the operation by clicking **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-go-pay_button_cancel }}**.
1. If the account cannot be deleted, click **{{ ui-key.yacloud_billing.billing.account.dashboard.card_label_threshold-description }}** to see the reason.
   The list of reasons includes, but is not limited to, the following:
   * The account has linked [resources](../../resource-manager/concepts/resources-hierarchy.md#rm-resources), [clouds](../../organization/concepts/manage-services.md#cloud), [organizations](../../organization/concepts/membership.md), {{ ml-platform-name }} [communities](../../datasphere/concepts/community.md), or {{ speechsense-name }} [spaces](../../speechsense/concepts/resources-hierarchy.md#space) left.
   * You still have resources purchased under the [CVoS](../../billing/concepts/cvos.md).
   * You have not disabled the paid [Technical support](../../support/overview.md) service plan.
   * Your billing account has a [partner](../../partner/terms.md#referral-partner) status or you are a [partner's customer](../../partner/terms.md#subaccount).
   * [Payment settlements for the provided services are still pending](../../billing/concepts/act.md).

   If you cannot solve the issue preventing the deletion of your account on your own, please [contact]({{ link-console-support }}/create-ticket) our technical support.

Please note that once your account is deleted, you will not be able to restore it.