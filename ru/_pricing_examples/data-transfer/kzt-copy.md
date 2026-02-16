Стоимость CPU:

> 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|string }} = {% calc [currency=KZT] 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %}

Стоимость RAM:

> 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|string }} = {% calc [currency=KZT] 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %}

Стоимость передачи данных:

> (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|string }} = {% calc [currency=KZT] (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }} %}

**Общая стоимость**:

> {% calc [currency=KZT] 24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=KZT] 24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }} %} + {% calc [currency=KZT] (500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }} %} = {% calc [currency=KZT] (24 * 2 * {{ sku|KZT|datatransfer.compute.cpu.v1|number }}) + (24 * 4 * {{ sku|KZT|datatransfer.compute.ram.v1|number }}) + ((500 - 100) * {{ sku|KZT|datatransfer.rows.v1|pricingRate.100|number }}) %}
