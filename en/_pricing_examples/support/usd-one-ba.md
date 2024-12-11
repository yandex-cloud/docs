If a customer consumes $800.00 worth of resources a month, the support charge will be calculated as follows:

> {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} + $800.00 × 0.05 = {% calc [currency=USD] {{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + 800,00 × 0,05 %}

This amount will be charged to a single billing account.