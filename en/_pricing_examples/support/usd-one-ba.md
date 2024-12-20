If a customer consumes $800.00 worth of resources a month, support costs will add up to:

> {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} + $800.00 × 0.05 = {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + 800,00 × 0,05) × 100) / 100 %}
> 
> Total: {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + 800,00 × 0,05) × 100) / 100 %}

Where:
* {{ sku|USD|support.organization.business.fixed_consumption.v1|string }}: Fixed amount per month.
* $40.00: 5% of the cost of consumed paid resources residing in the organization.

This amount will be charged to a single billing account.