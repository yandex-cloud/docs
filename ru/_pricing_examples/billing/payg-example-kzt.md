Расчет стоимости ВМ:

> 20 × (4 × {{ sku|KZT|compute.vm.cpu.c100.v3|string }} + 16 × {{ sku|KZT|compute.vm.ram.v3|string }}) = {% calc [currency=KZT] 20 × (4 × {{ sku|KZT|compute.vm.cpu.c100.v3|number }} + 16 × {{ sku|KZT|compute.vm.ram.v3|number }}) %}

Где:
* 20 — время обработки данных (в часах).
* 4 — количество ядер 100% vCPU.
* {{ sku|KZT|compute.vm.cpu.c100.v3|string }} — стоимость часа использования 100% vCPU.
* 16 — объем RAM (в гигабайтах).
* {{ sku|KZT|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.
