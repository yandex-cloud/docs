If a customer consumes $800.00 worth of resources per month and also has reserved a [committed volume of services](../../billing/concepts/cvos.md) in the amount of $80.00 per month on the billing account used to pay for their organization’s technical support, the support costs will add up to:

> {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} + ($800.00 + $80.00) × 0.05 = {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + (800.00 + 80.00) × 0.05) × 100) / 100 %}
> 
> Total: {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + (800.00 + 80.00) × 0.05) × 100) / 100 %}

Where:
* {{ sku|USD|support.organization.business.fixed_consumption.v1|string }}: Fixed amount per month.
* $44.00: 5% of the cost of consumed paid resources residing in the organization.

This amount will be charged to a single billing account.