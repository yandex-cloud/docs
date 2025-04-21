1. Go to [**{{ billing-name }}**]({{ link-console-billing }}).
1. Select the billing account from the list.

    {% include [account-access-lost](../../_includes/billing/account-access-lost.md) %}

1. In the top-right corner of the **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}**.
1. Confirm and wait until the check is completed.
1. If the account can be deleted, the deletion notification will pop up. At this point, you can still abort the operation by clicking **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-go-pay_button_cancel }}**.
1. If the account cannot be deleted, click **{{ ui-key.yacloud_billing.billing.account.dashboard.card_label_threshold-description }}** to see the reason.
   The list of reasons includes, but is not limited to, the following:
     * The account has linked [resources](../../resource-manager/concepts/resources-hierarchy.md#rm-resources), [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [organizations](../../organization/concepts/organization.md), {{ ml-platform-name }} [communities](../../datasphere/concepts/community.md), or {{ speechsense-name }} [spaces](../../speechsense/concepts/resources-hierarchy.md#space) left. 
     * You still have resources purchased under the [CVoS](../../billing/concepts/cvos.md).
     * You have not disabled the paid [Technical support](../../support/overview.md) service plan.
     * Your billing account has a [partner](../../partner/terms.md#referral-partner) status or you are a [partner's customer](../../partner/terms.md#sub-account).
     * [Payment settlements for the provided services are still pending](../../billing/concepts/act.md).
 
   If you cannot fix the issue preventing the deletion of your account yourself, [contact]({{ link-console-support }}/tickets/create) our technical support.
1. As soon as all the conditions are met, you billing account becomes inactive and can no longer be used to work with {{ yandex-cloud }} resources. To delete your inactive account, write us at [{{ link-support-mail }}](mailto:{{ link-support-mail }}).

{% include [payment-refund](../../_includes/billing/payment-refund.md) %}

{% note warning %}

After you delete your billing account, you cannot recover it, and your agreement with Yandex.Cloud LLC, Cloud Services Kazakhstan LLP, Iron Hive doo Beograd (Serbia), or Direct Cursus Technology LLC. (Dubai) will be terminated.

{% endnote %}
