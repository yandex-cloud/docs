# Unexpected receipt for an amount missing from the payment history arrived at the email linked to the billing account



## Issue description {#issue-description}

* You got an electronic receipt at the email linked to the billing account. However, you cannot find information about a deduction for the specified amount in the payment history.
* The electronic receipt received by email has the "Income" type.
* The electronic receipt received by email has the "credit transfer" or "full settlement" payment method.

## Solution {#issue-resolution}

Yandex Cloud uses a postpaid model: the client first consumes resources and then pays for actual usage.

The document you received is a receipt for actual usage, which is similar to a reconciliation report for a legal entity for the reporting period. It does not indicate a fact of deduction, but a fact of past usage.
