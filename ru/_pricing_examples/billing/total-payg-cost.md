
> Итого: {% calc [currency=RUB] 20 × (4 × {{ sku|RUB|compute.vm.cpu.c100.v3|number }} + 16 × {{ sku|RUB|compute.vm.ram.v3|number }}) + 720 × 100 × {{ sku|RUB|compute.filesystem.ssd.v1|number }} %} — стоимость использования ВМ с 4 × 100% vCPU и 16 ГБ RAM в течение 20 часов с учетом использования диска.



