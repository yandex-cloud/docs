# Agreements and accounts

#### How is the relationship between partners and {{ yandex-cloud }} regulated? {#offer}

The relationship between a partner and {{ yandex-cloud }} is regulated by the [Partner Agreement](https://yandex.ru/legal/cloud_partnership/?lang=ru) that you sign when applying to participate in the [partner program](/partners/service#join). The Partner Agreement is a separate agreement that supplements the {{ yandex-cloud }} Offer Agreement in terms of participation in the partner program.

You enter into an agreement with a customer yourself.

#### Where can I get sample agreements? {#examples-of-contracts}

You can use your own agreement template or the examples we provided to you in the [Partner Kit](../../partner/program/var-tools.md#kit):

Types of our partners' agreements that you can find in the Partner Kit:

* Simple agreements for providing services without an agent fee. These agreements let you include the cost of using {{ yandex-cloud }} services and of support and maintenance services from a partner company.
* Commission agreements which, as some experts believe, are more consistent with the subject of agreements for "services to provide access to cloud resources" in terms of their wording for taxation purposes.

#### What is an agent's tax base: the entire amount paid by a customer under the payment invoice issued or only a partner bonus? {#tax-base}

If you use the Simplified Tax System (USN) and work under an agency agreement, you must specify an agent fee in a separate line in the agreement with the customer. In this case, you only pay taxes on the amount of the agent fee.

#### How is VAT refunded if I use the Simplified Tax System (USN)? {#VAT}

If your customer pays VAT, you can re-issue them invoices from your organization. However, you still have to maintain and submit to the tax service the balance sheet and the invoice journal.

#### What service payment system is used in {{ yandex-cloud }} for partners? What happens if there is no money in the account? {#payments}

{{ yandex-cloud }} uses a postpaid billing system. To get started, you should switch to paid consumption mode. Your account or [subaccounts](../../partner/terms.md#sub-account) may start consumption without any top-up immediately after activation. The sum for consumption across all subaccounts linked to the partner account is debited from the partner personal account.

At the end of each month, we will send a service certificate to your email address indicating the amount minus the partner bonus for the past (reporting) month.

At the end of the reporting month, starting from the second month of paid consumption, you have 15 days to settle the payment invoice received. During this period, until the account is topped up, your [credit limit](../../billing/concepts/billing-threshold.md) is activated. The credit limit is calculated automatically based on the average monthly consumption over the past few months.

If you do not settle the payment before the end of the current month or the credit limit is exceeded, we will contact you to clarify the reasons for the delay in payment and agree on the deadline for transferring the funds. If we fail to receive your response after several attempts to contact you, your resources may be suspended until the issue is resolved. For more information about suspending and restoring service usage, see **Billing cycle** in the {{ billing-name }} documentation:

* [Individuals](../../billing/payment/billing-cycle-individual.md)
* [Businesses and individual entrepreneurs](../../billing/payment/billing-cycle-business.md)

#### At what point does a partner invoice a customer for cloud consumption? {#client-invoice}

Partners can issue payment invoices to their customers at any time. We only monitor the settlement of payment invoices [between {{ yandex-cloud }} and partners](#payments). By accepting the offer, a partner commits to and accepts the rules for settling payment invoices under their account and subaccounts connected to it.

#### How to download reporting documents in the management console? {#docs}

See the {{ billing-name }} [documentation](../../billing/operations/download-reporting-docs.md).

#### How to invoice? {#bill}

To invoice your organization:

1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/dots-9.svg) **All services**.
1. Select ![image](../../_assets/console-icons/credit-card.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
1. Select a billing account.
1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
1. Enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.popup-refill_button_company-action }}**.
1. The document will open in a new browser tab and get saved in `.pdf` format.

#### How to connect to EDM? {#edm}

Electronic document management is used for the electronic exchange of documents that are signed with a qualified electronic signature (advanced e-signature). Electronic documents carry the same weight as their paper versions and are accepted by tax and judicial authorities over the internet.

{{ yandex-cloud }} sends unilateral reports using electronic document management.

For more information on how to connect to EDM, see the {{ billing-name }} [documentation](../../billing/operations/edo.md).
