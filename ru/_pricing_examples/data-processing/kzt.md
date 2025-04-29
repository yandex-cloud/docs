> {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|string }} × 20 = {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %}
>
> Итого: {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.

Где:

* {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
* 2 — количество vCPU в хосте-мастере.
* {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
* 16 — объем RAM хоста-мастера (в гигабайтах).
* {{ sku|KZT|compute.filesystem.ssd.v1|string }}  — стоимость часа использования 1 ГБ `network-ssd`.
* 20 — объем хранилища хоста-мастера (в гигабайтах).

> {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|string }} × 100 = {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %}
>
> Итого: {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.

Где:

* {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }} %} — стоимость часа использования 100% vCPU.
* 2 — количество vCPU в хосте для хранения данных.
* {% calc [currency=KZT] {{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }} %} — стоимость часа использования 1 ГБ RAM.
* 8 — объем RAM хоста для хранения данных (в гигабайтах).
* {{ sku|KZT|compute.filesystem.hdd.v1|string }} — стоимость часа использования 1 ГБ `network-hdd`.
* 100 — объем хранилища хоста для хранения данных (в гигабайтах).

> {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} + {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} = {% calc [currency=KZT] (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100) %}
>
> Итого: {% calc [currency=KZT] (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100) %} — стоимость часа использования кластера из двух подкластеров.

Где:

* {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 16 + {{ sku|KZT|compute.filesystem.ssd.v1|number }} × 20 %} — стоимость часа использования первого подкластера.
* {% calc [currency=KZT] ({{ sku|KZT|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|KZT|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|KZT|mdb.dataproc.v2.ram|number }} + {{ sku|KZT|compute.vm.ram.v2|number }}) × 8 + {{ sku|KZT|compute.filesystem.hdd.v1|number }} × 100 %} — стоимость часа использования второго подкластера.