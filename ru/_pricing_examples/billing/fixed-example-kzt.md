Расчет стоимости ВМ при фиксированной оплате:

> 720 × (4 × {{ sku|KZT|compute.vm.cpu.c100.v3|string }} + 16 × {{ sku|KZT|compute.vm.ram.v3|string }}) = {% calc [currency=KZT] 720 × (4 × {{ sku|KZT|compute.vm.cpu.c100.v3|number }} + 16 × {{ sku|KZT|compute.vm.ram.v3|number }}) %}

Где:
* 720 — количество часов в 30 днях.
* 4 — количество ядер 100% vCPU.
* {{ sku|KZT|compute.vm.cpu.c100.v3|string }} — стоимость часа использования 100% vCPU.
* 16 — объем RAM (в гигабайтах).
* {{ sku|KZT|compute.vm.ram.v3|string }} — стоимость часа использования 1 ГБ RAM.

{% include [disk-example-kzt](../../_pricing_examples/billing/disk-example-kzt.md) %}

> Итого: {% calc [currency=KZT] 720 × (4 × {{ sku|KZT|compute.vm.cpu.c100.v3|number }} + 16 × {{ sku|KZT|compute.vm.ram.v3|number }}) + 720 × 100 × {{ sku|KZT|compute.filesystem.ssd.v1|number }} %} — стоимость использования ВМ с 4 × 100% vCPU и 16 ГБ RAM в течение 30 дней с учетом использования диска.