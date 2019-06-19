# Billing account

A billing account is used to identify the user paying for resources in Yandex.Cloud.

The billing account can only be linked to one [personal account](personal-account.md) and one cloud. You can use only the payment method which corresponds to the type of billing account and your [agreement](contract.md).

The relationship between the cloud, billing account, personal account, and payment method is shown in the diagram below.

![image](../_assets/cloud-billing-account.png)

> [!NOTE]
>
> The billing account is not used for the management of Yandex.Cloud resources.
>

## Types of billing accounts {#ba-types}

The type of a billing account determines the Yandex.Cloud resource [payment method](../payment/payment-methods.md).

---

**[!TAB Individual account]**

- Intended for residents of Russia.
- You pay for resources using a bank card.
- Funds for the resources consumed are debited automatically. For more information, see the section [Billing cycle for individuals](../payment/billing-cycle-individual.md).
- Once the funds are debited from your bank card, a [payment receipt](individual-bill.md) is sent to your email address.

**[!TAB Business account]**

- Intended for residents of Russia.
- Resource usage is paid for via bank transfer from a business's bank account or a corporate bank card.
- Payments for the resources consumed are made based on the [agreement](../concepts/contract.md) and [payment invoice](bill.md), or the amount is debited automatically from the linked bank card. For more information, see the section [Billing cycle for businesses](../payment/billing-cycle-business.md).
- A report for services rendered and an invoice are sent to your email address at the beginning of the next reporting period. For more information, see the section [Financial documents](../payment/documents.md).

---

## Validity period {#dates}

The billing account has no validity period.

However, if the use of Yandex.Cloud services is suspended due to arrears and you fail to pay the outstanding amount within 30 days of suspension, all your data, including the billing account, will be permanently blocked and deleted.

## Number of billing accounts {#restrictions}

Each customer is allowed to create only one billing account.

