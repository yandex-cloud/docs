CPU cost:

> 30 * 24 * 12 * {{ sku|USD|datatransfer.compute.cpu.v1|string }} = {% calc [currency=USD] 30 * 24 * 12 * {{ sku|USD|datatransfer.compute.cpu.v1|number }} %}

RAM cost:

> 30 * 24 * 24 * {{ sku|USD|datatransfer.compute.ram.v1|string }} = {% calc [currency=USD] 30 * 24 * 24 * {{ sku|USD|datatransfer.compute.ram.v1|number }} %}

Data transfer cost:

50,000,000 rows are free of charge as they are included in the free usage quota.

**Total cost**:

> {% calc [currency=USD] 30 * 24 * 12 * {{ sku|USD|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=USD] 30 * 24 * 24 * {{ sku|USD|datatransfer.compute.ram.v1|number }} %} = {% calc [currency=USD] (30 * 24 * 12 * {{ sku|USD|datatransfer.compute.cpu.v1|number }}) + (30 * 24 * 24 * {{ sku|USD|datatransfer.compute.ram.v1|number }}) %}
