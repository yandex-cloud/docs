`network-interfaces` — список сетевых интерфейсов в объекте `--server`. В поле `interface` каждого элемента укажите один из вариантов:

* `private-interface` — приватный интерфейс. В параметре `native-subnet-id` укажите идентификатор [приватной подсети](../../../baremetal/concepts/private-network.md#private-subnet).
* `public-interface` — публичный интерфейс. В настройке `native-subnet` укажите идентификатор [выделенной публичной подсети](../../../baremetal/concepts/public-network.md#public-subnet) в параметре `subnet-id`. Необязательная настройка.
