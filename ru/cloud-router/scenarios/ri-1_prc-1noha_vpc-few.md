# On-Prem без резервирования и несколько VPC

Нерезервируемое подключение On-Prem через одно [приватное соединение](../../interconnect/concepts/priv-con.md) {{ interconnect-name }} к одному `RI` с двумя (и более) [облачными сетями](../../vpc/concepts/network.md) без сетевой связности между ними.

![ri-topology-2](../../_assets/cloud-router/ri-topology-2.svg)

На схеме выше представлена сетевая топология в следующей конфигурации:

* `On-Prem` клиента с двумя локальными подсетями — `subnet-c1` и `subnet-c2`.
* Сетевое оборудование On-Prem подключается через сервис [{{ interconnect-name }}](../../interconnect/concepts/index.md) к сетевому оборудованию {{ yandex-cloud }}.
* [Приватное соединение](../../interconnect/concepts/priv-con.md) `prc-m9`, организованное через [точку присутствия](../../interconnect/concepts/pops.md) `M9`, подключается к `RI` в {{ yandex-cloud }}.
* Со стороны {{ yandex-cloud }} к `RI` подключаются две виртуальные сети:
  * виртуальная сеть `Net-1` в составе трех подсетей — `subnet-a1`, `subnet-b1` и `subnet-d1`.
  * виртуальная сеть `Net-2` в составе трех подсетей — `subnet-a2`, `subnet-b2` и `subnet-d2`.

Данная топология обеспечивает сетевую связность между:

* Подсетями в `On-Prem` и подсетями `subnet-a1`, `subnet-b1` и `subnet-d1` в VPC `Net-1`.
* Подсетями в `On-Prem` и подсетями `subnet-a2`, `subnet-b2` и `subnet-d2` в VPC `Net-2`.

Данная топология не обеспечивает сетевую связность между подсетями виртуальных сетей `Net-1` и `Net-2`.

