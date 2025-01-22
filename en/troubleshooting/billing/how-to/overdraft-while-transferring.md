# Limit on negative balance for bank payments



## Scenario description {#case-description}

You need to find out if there is a limit to the negative balance when paying by bank transfer.

## Solution {#case-resolution}

When paying via bank transfer, no negative balance limit is set. Services are suspended only if the outstanding amounts [have not been repaid within the terms specified by the contract](https://yandex.ru/legal/cloud_oferta/):

> 6.9. The Customer pays the Arrears arisen as a result of consuming Services during the Reporting period, monthly within 14 (fourteen) calendar days from the end of the applicable Reporting period (excluding non-working holidays), unless a different payment procedure for individual Services is provided by Special terms. When determining the Arrears amount, the amounts of Grants provided to the Client are taken into account.

This means that with the **Bank transfer** payment type, services will be suspended only if both conditions are met:
1. At the end of the previous month, you had a negative balance on your account.
2. The arrears are not repaid within the first 14 days of the current month.

The procedure for calculations is described in Article 6 of the [Offer Agreement](https://yandex.ru/legal/cloud_oferta/) and in our [documentation](../../../billing/payment/billing-cycle-business).

