If a customer consumes $800.00 worth of resources a month, and the customer also has [CVoS](../../billing/concepts/cvos.md) of $80.00 per month on the payment account from which technical support for his organization is paid, then the cost of support for that customer will be:

> {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} + ($800.00 + $80.00) × 0.05 = {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + (800,00 + 80,00) × 0,05) × 100) / 100 %}
> 
> Total: {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + (800,00 + 80,00) × 0,05) × 100) / 100 %}

Where:
* {{ sku|USD|support.organization.business.fixed_consumption.v1|string }}: Fixed amount per month.
* $44.00: 5% of the cost of paid consumed resources located in the organization, including reserved consumption on the payment account in the organization.

This amount will be charged to a single billing account.