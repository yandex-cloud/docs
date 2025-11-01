An organization with an active Business service plan pays for resources from different billing accounts:

* Account 1: Consumes $400.00 worth of resources a month.
* Account 2: Consumes $80.00 worth of resources a month.

The fixed amount will only be paid by one of the accounts, e.g., Account 1.

The support cost will be:

> {{ sku|USD|support.organization.business.fixed_consumption.v1|string }} + $400.00 × 0.05 = {% calc [currency=USD] round(({{ sku|USD|support.organization.business.fixed_consumption.v1|number }} + 400,00 × 0,05) × 100) / 100 %} for Account 1.
> 
> $80.00 × 0.05 = $4.00 for Account 2.