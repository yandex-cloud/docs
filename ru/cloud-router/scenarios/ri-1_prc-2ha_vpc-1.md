# On-Prem с резервированием и 1 VPC

Резервируемое подключение On-Prem через два [приватных соединения](../../interconnect/concepts/priv-con.md) {{ interconnect-name }} к одному `RI` с одной [облачной сетью](../../vpc/concepts/network.md).

![ri-topology-3](../../_assets/cloud-router/ri-topology-3.svg)

На схеме выше представлена сетевая топология в следующей конфигурации:

* `On-Prem` клиента с двумя локальными подсетями — `subnet-c1` и `subnet-c2`.
* Сетевое оборудование On-Prem подключается через сервис [Cloud Interconnect](../../interconnect/concepts/index.md) к сетевому оборудованию {{ yandex-cloud }}.
* Два [приватных соединения](../../interconnect/concepts/priv-con.md) `prc-m9` и `prc-nord`, организованные через две [точки присутствия](../../interconnect/concepts/pops.md) `M9` и `NORD`, подключаются к `RI` в {{ yandex-cloud }}.
* Со стороны {{ yandex-cloud }} к `RI` подключается виртуальная сеть `Net-1` в составе трех подсетей — `subnet-a1`, `subnet-b1` и `subnet-d1`.

Данная топология обеспечивает сетевую связность между подсетями в `On-Prem` и подсетями в VPC `Net-1`.

Для приоритезации трафика между [приватными соединениями](../../interconnect/concepts/priv-con.md) нужно использовать соответствующие [инструменты маршрутизации](prc-ha-with-active-standby.md) {{ interconnect-name }}.

В случае выхода из строя любого из вышеуказанных приватных соединений весь сетевой трафик будет автоматически перемаршрутизирован на оставшееся в работе приватное соединение.

