> 3 × 5 × 720 × {{ sku|USD|lockbox.storage.v1.active_secrets|string }} = {% calc [currency=USD] 3 × 5 × 720 × {{ sku|USD|lockbox.storage.v1.active_secrets|number }} %}
> 20,000 / 10,000 × {{ sku|USD|lockbox.api.v1.get|string }} = {% calc [currency=USD] 20000 / 10000 × {{ sku|USD|lockbox.api.v1.get|number }} %}

> Total: {% calc [currency=USD] 3 × 5 × 720 × {{ sku|USD|lockbox.storage.v1.active_secrets|number }} %} + {% calc [currency=USD] 20000 / 10000 × {{ sku|USD|lockbox.api.v1.get|number }} %} = {% calc [currency=USD] (3 × 5 × 720 × {{ sku|USD|lockbox.storage.v1.active_secrets|number }}) + (20,000 / 10,000 × {{ sku|USD|lockbox.api.v1.get|number }}) %}, cost of using {{ lockbox-name }} per month, including VAT.

Where:
* 3 × 5: Number of versions of all secrets.
* 720 × {{ sku|USD|lockbox.storage.v1.active_secrets|string }}: Price of storing one secret version per month, without VAT.
* 20,000: Number of `get` operations.
* {{ sku|USD|lockbox.api.v1.get|string }}: Price per 10,000 `get` operations, without VAT.