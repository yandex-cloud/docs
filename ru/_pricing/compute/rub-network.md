| Программное ускорение сети | Цена за 1 час, вкл. НДС |
| --- | --- |
| **Intel Broadwell** |
| Для ВМ с числом ядер меньше 18 | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v1|number }} × 2 %} |
| Для ВМ с 18 ядрами и больше | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v1|number }} × 4 %} |
| **Intel Cascade Lake** |
| Для ВМ с числом ядер меньше 20 | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v2|number }} × 2 %} |
| Для ВМ с 20 ядрами и больше | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v2|number }} × 4 %} |
| **Intel Ice Lake** |
| Для ВМ с числом ядер меньше 36 | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v3|number }} × 2 %} |
| Для ВМ с 36 ядрами и больше | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.v3|number }} × 4 %} |
| **Intel Ice Lake (Compute Optimized)** |
| Для ВМ с числом ядер меньше 16 | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.highfreq-v3|number }} × 2 %} |
| Для ВМ с 16 ядрами и больше | {% calc [currency=RUB] {{ sku|RUB|compute.vm.software_accelerated_network.cores.highfreq-v3|number }} × 4 %} |
| **AMD Zen 3**^*^ |
| Для ВМ с числом ядер меньше 96 | 4,6224 ₽ |
| Для ВМ с 96 ядрами и больше | 9,2448 ₽ |

^*^ Доступ предоставляется по запросу, при наличии технической возможности.


