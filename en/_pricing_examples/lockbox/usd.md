> 3 × 5 × {{ sku|USD|lockbox.storage.v1.active_secrets|month|string }} = {% calc [currency=USD] 3 × 5 × {{ sku|USD|lockbox.storage.v1.active_secrets|month|number }} %}
> 20,000 / 10,000 × {{ sku|USD|lockbox.api.v1.get|string }} = {% calc [currency=USD] 20000 / 10000 × {{ sku|USD|lockbox.api.v1.get|number }} %}

> Total: {% calc [currency=USD] 3 × 5 × {{ sku|USD|lockbox.storage.v1.active_secrets|month|number }} %} + {% calc [currency=USD] 20000 / 10000 × {{ sku|USD|lockbox.api.v1.get|number }} %} = {% calc [currency=USD] (3 × 5 × {{ sku|USD|lockbox.storage.v1.active_secrets|month|number }}) + (20000 / 10000 × {{ sku|USD|lockbox.api.v1.get|number }}) %}, representing the cost of using {{ lockbox-name }} for one month, incl. VAT.

Where:
* 3 × 5: Number of versions of all secrets.
* {{ sku|USD|lockbox.storage.v1.active_secrets|month|string }}: Price of storing one secret version per month, incl. VAT.
* 20,000: Number of `get` operations.
* {{ sku|USD|lockbox.api.v1.get|string }}: Price per 10,000 `get` operations, incl. VAT.