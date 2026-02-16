Стоимость CPU:

> 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|string }} = {% calc [currency=RUB] 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %}

Стоимость RAM:

> 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|string }} = {% calc [currency=RUB] 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %}

Стоимость передачи данных:

> (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|string }} = {% calc [currency=RUB] (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }} %}

**Общая стоимость**:

> {% calc [currency=RUB] 24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=RUB] 24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %} + {% calc [currency=RUB] (500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }} %} = {% calc [currency=RUB] (24 * 2 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }}) + (24 * 4 * {{ sku|RUB|datatransfer.compute.ram.v1|number }}) + ((500 - 100) * {{ sku|RUB|datatransfer.rows.v1|pricingRate.100|number }}) %}
