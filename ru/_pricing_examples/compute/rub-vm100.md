> 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|string }} + 2 × {{ sku|RUB|compute.vm.ram.v3|string }}) = {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %}
>
> Итого: {% calc [currency=RUB] 720 × (2 × {{ sku|RUB|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|RUB|compute.vm.ram.v3|number }}) %} — стоимость использования ВМ с 2 × 100% vCPU и 2 ГБ RAM в течение 30 дней.

Где:
* 720 — количество часов в 30 днях.
* 2 — количество ядер 100% vCPU.
* {{ sku|RUB|compute.vm.cpu.c100.v3|string }} — стоимость часа использования 100% vCPU.
* 2 — объем RAM (в гигабайтах).
* {{ sku|RUB|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.