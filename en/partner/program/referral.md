# Referral program

A _referral program_ is a program for acquisition of new {{ yandex-cloud }} customers through distribution of referral links. The links are unique and allow for partner identification. A partner who has acquired a customer gets a [commission](#sum) for the customer's paid resource consumption.

Program participants:

* Referrer: Partner company that refers customers to {{ yandex-cloud }}. Only a legal entity or individual entrepreneur that is a resident of the Russian Federation can be a referrer.
* Referral: Acquired customer. This can be either a business or an individual.

## Participating in the referral program {#desc}

To participate in the referral program:

1. [Get a partner status](../quickstart.md).
1. Generate a referral link:

   1. Log in to the [partner portal]({{ link-cloud-partners }}).
   1. At the top of the screen, switch to the referral program.
   1. Create a referral link:

      1. Go to the **Referral links** tab.
      1. Click ![image](../../_assets/plus-sign.svg) **Create link**.
      1. Enter a link name and click **Create**.

1. Share the link with the customer:

   1. Click **Invite** next to your link.
   1. Enter the customer's email address and click **Send**.

When the customer signs up using your link, meeting the [terms and conditions](#condition), you will get a [commission](#premium) based on the amount of resources consumed by the customer.

### Partner portal {#portal}

You can manage referral links and withdraw commissions for referrals on the [partner portal]({{ link-cloud-partners }}) in the **Referral program** section. To go to this section, switch to the referral program at the top of the screen.

In this section, you will find the following information:

* Referral bonus amount available for withdrawal.
* Statistics for the whole period of your participation in the referral program: number of registrations and created billing accounts, bonus total.
* Referrer company data.
* **Referral links** tab. List of referral links with current statuses and relevant statistics. Here, you can create new links and edit existing ones.
* **Referrals** tab. List of your customers who have used the referral link, registered in {{ yandex-cloud }}, and created a billing account.
* **Bonus** tab. Commission accrual history.
* **Payments** tab. Commission withdrawal history.

## Referral sign-up conditions {#condition}

The following are eligible for the referral program:

* New users. A user is considered new if they have not previously signed up for {{ yandex-cloud }}.
* Users inactive for over 32 days. A user is considered inactive if their account status was `Suspended` and they did not consume any resources of the services for over 32 days.

A referrer will get a commission provided that a referral:

1. Follows the referral link, signs up for {{ yandex-cloud }}, and creates a billing account.

   When using a referral link for sign-up:

   * If the user closes the browser and then re-opens the same link, the sign-up will be accepted. However, if the user opens the URL without using the referral link, the sign-up will not be accepted.
   * If the user lacks some information at sign-up (phone number or Yandex email address), the registration will be accepted only after the user has supplied the missing information and resumed signing up for {{ yandex-cloud }}.
   * If the user closes the tab and opens the console without using the referral link, e.g., {{ link-console-main }}, the sign-up will not be accepted.

1. Consents to sharing their consumption information with the referrer for a period of 12 months. The referrer will only see the referral's total consumption figures. This is necessary to ensure the transparency of commissions.

The referrer and referral do not sign any additional agreements for providing {{ yandex-cloud }} services.

If the conditions above are not met, the customer is not considered a referral program participant. In this case, you will not get a commission for this customer.

## Acquired referral commission {#premium}

### Commission amount {#sum}

A partner commission amounts to 10% of sales to referrals, including VAT, but no more than ₽100,000 per customer per month. You can track the consumption figures of your referral customers in your [partner portal]({{ link-cloud-partners }}) profile.

### Commission payment period per referral {#duration}

A commission for a referral is paid within 12 months of their sign-up via the referral link.

### Commission accrual {#pay-period}

A commission is accrued once a month when {{ yandex-cloud }} receives payment for the resources consumed by the referral. If a customer did not consume or pay for {{ yandex-cloud }} resources, no commission will be paid.

### How to withdraw your commission {#money}

The minimum withdrawable commission is ₽500. There are two ways to withdraw your commission:

1. The commission amounts to 10% of sales to referrals, including VAT.

   If you apply the general tax system, the commission will include 20% VAT. You will get an invoice and a report with VAT stated separately to enable you to pay VAT to the budget.
   If you apply the simplified tax system, the commission is not subject to VAT.

1. Transfer the commission amount to a [grant](../../billing/concepts/bonus-account.md) and use it to pay for {{ yandex-cloud }} services.

You can withdraw your commissions credited as rebates through the partner portal:

1. Log in to the [partner portal]({{ link-cloud-partners }}).
1. At the top of the screen, switch to the referral program.
1. Click **Withdraw**.
1. Specify the amount to withdraw.
1. Select the destination for the withdrawal:

   * **Grant**. The funds will be credited as a grant to the cloud billing account.
   * **Bank account**. The funds will be transferred to the bank account specified in the partner agreement.

1. Click **Transfer**.
