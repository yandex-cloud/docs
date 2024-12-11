> 720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|string }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|string }}) = {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|gitlab.instance.free.cpu|number }} + 8 × {{ sku|RUB|gitlab.instance.free.ram|number }}) %}
  
  Где:

  * 720 — количество часов в 30 днях.
  * 2 — количество vCPU.
  * {{ sku|RUB|gitlab.instance.free.cpu|string }} — стоимость часа использования vCPU.
  * 8 — объем RAM (в гигабайтах).
  * {{ sku|RUB|gitlab.instance.free.ram|string }} — стоимость часа использования 1 ГБ RAM.