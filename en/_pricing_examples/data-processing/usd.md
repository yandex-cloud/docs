> {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }} %} × 16 + {{ sku|USD|compute.filesystem.ssd.v1|string }} × 20 = {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20 %}
>
> Total: {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20 %}, cost of using the first subcluster per hour.

Where:

* {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }} %}: Cost of using 100% vCPU per hour.
* 2: Number of vCPUs per master host.
* {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }} %}: Cost of using 1 GB of RAM per hour.
* 16: Amount of RAM per master host (in GB).
* {{ sku|USD|compute.filesystem.ssd.v1|string }}: Cost of using 1 GB of `network-ssd` per hour.
* 20: Master host storage capacity (in GB).

> {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }} %} × 2 + {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }} %} × 8 + {{ sku|USD|compute.filesystem.hdd.v1|string }} × 100 = {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100 %}
>
> Total: {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100 %}, cost of using the second subcluster per hour.

Where:

* {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }} %}: Cost of using 100% vCPU per hour.
* 2: Number of vCPUs per data storage host.
* {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }} %}: Cost of using 1 GB of RAM per hour.
* 8: Amount of RAM per data storage host (in GB).
* {{ sku|USD|compute.filesystem.hdd.v1|string }}: Cost of using 1 GB of `network-hdd` per hour.
* 100: Storage capacity per data storage host (in GB).

> {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20 %} + {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100 %} = {% calc [currency=USD] (({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100) %}
>
> Total: {% calc [currency=USD] (({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20) + (({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100) %}, cost of using a cluster of two subclusters per hour.

Where:

* {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 16 + {{ sku|USD|compute.filesystem.ssd.v1|number }} × 20 %}: Cost of using the first subcluster per hour.
* {% calc [currency=USD] ({{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.vm.cpu.c100.v2|number }}) × 2 + ({{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.vm.ram.v2|number }}) × 8 + {{ sku|USD|compute.filesystem.hdd.v1|number }} × 100 %}: Cost of using the second subcluster per hour.