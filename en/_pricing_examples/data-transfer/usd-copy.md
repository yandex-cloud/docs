CPU cost:

> 24 * 2 * {{ sku|USD|datatransfer.compute.cpu.v1|string }} = {% calc [currency=USD] 24 * 2 * {{ sku|USD|datatransfer.compute.cpu.v1|number }} %}

RAM cost:

> 24 * 4 * {{ sku|USD|datatransfer.compute.ram.v1|string }} = {% calc [currency=USD] 24 * 4 * {{ sku|USD|datatransfer.compute.ram.v1|number }} %}

Data transfer cost:

> (500 - 100) * {{ sku|USD|datatransfer.rows.v1|pricingRate.100|string }} = {% calc [currency=USD] (500 - 100) * {{ sku|USD|datatransfer.rows.v1|pricingRate.100|number }} %}

**Total cost**:

> {% calc [currency=USD] 24 * 2 * {{ sku|USD|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=USD] 24 * 4 * {{ sku|USD|datatransfer.compute.ram.v1|number }} %} + {% calc [currency=USD] (500 - 100) * {{ sku|USD|datatransfer.rows.v1|pricingRate.100|number }} %} = {% calc [currency=USD] (24 * 2 * {{ sku|USD|datatransfer.compute.cpu.v1|number }}) + (24 * 4 * {{ sku|USD|datatransfer.compute.ram.v1|number }}) + ((500 - 100) * {{ sku|USD|datatransfer.rows.v1|pricingRate.100|number }}) %}
