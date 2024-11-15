Стоимость CPU:

> 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|string }} = {% calc [currency=RUB] 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %}

Стоимость RAM:

> 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|string }} = {% calc [currency=RUB] 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %}

Стоимость передачи данных:

50 000 000 строк входят в объем бесплатного потребления и не тарифицируются.

**Общая стоимость**:

> {% calc [currency=RUB] 30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }} %} + {% calc [currency=RUB] 30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }} %} = {% calc [currency=RUB] (30 * 24 * 12 * {{ sku|RUB|datatransfer.compute.cpu.v1|number }}) + (30 * 24 * 24 * {{ sku|RUB|datatransfer.compute.ram.v1|number }}) %}
