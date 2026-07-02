[Документация Yandex Cloud](../../index.md) > [Yandex Virtual Private Cloud](../index.md) > [Концепции](index.md) > Группы безопасности

# Группы безопасности

Группы безопасности служат основным механизмом разграничения сетевого доступа в Yandex Cloud.

{% note info %}

В настоящее время в сетях Yandex Cloud можно использовать только протокол IPv4. Протокол IPv6 не поддерживается, поэтому группы безопасности работают только с трафиком протокола IPv4.

{% endnote %}

*Группа безопасности* (Security Group, SG) — это ресурс, который создается на уровне [облачной сети](network.md#network). После создания группа безопасности может использоваться в сервисах Yandex Cloud для разграничения сетевого доступа объекта, к которому она применяется.

Группы безопасности можно комбинировать — на один объект можно назначить до пяти групп.

{% note alert %}

Группы безопасности не предназначены для защиты от DDoS атак.

Для фильтрации больших объемов нежелательного сетевого трафика используйте сервис [Yandex DDoS Protection](../ddos-protection/index.md).

{% endnote %}

## Группа безопасности по умолчанию {#default-security-group}

*Группа безопасности по умолчанию* (Default Security Group, DSG) создается автоматически при создании [новой облачной сети](network.md#network) и действует в отношении сетевого трафика лишь тех объектов, которым явно не назначена пользовательская группа безопасности.

Группа безопасности по умолчанию разрешает:

* любой исходящий (`egress`) сетевой трафик;
* любой входящий (`ingress`) сетевой трафик от объектов, к которым применяется эта же группа безопасности ([правило self](#self-rule));
* любой входящий сетевой трафик по протоколу `ICMP`;
* входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `22` (`SSH`);
* входящий сетевой трафик по протоколам `TCP` и `UDP` на порт `3389` (`RDP`).

Весь остальной трафик в группе безопасности по умолчанию запрещен.

Группу безопасности по умолчанию невозможно удалить, она автоматически удаляется при удалении соответствующей сети.

## Где можно использовать группы безопасности {#security-groups-apply}

Список объектов в сервисах Yandex Cloud, где можно использовать группы безопасности:

| Название сервиса                                    | Объекты сервиса                                                                                                                                 |
|-----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| [Compute Cloud](../../compute/index.md)          | [интерфейс ВМ](../../compute/concepts/network.md), [шаблон групп ВМ](../../compute/concepts/instance-groups/instance-template.md#network)       |
| [Managed Service for Kubernetes](../../managed-kubernetes/index.md) | [кластер](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [группа узлов](../../managed-kubernetes/concepts/index.md#node-group) |
| [Application Load Balancer](../../application-load-balancer/index.md)  | [балансировщик](../../application-load-balancer/concepts/application-load-balancer.md#security-groups)                                          |
| [Managed Service for PostgreSQL](../../managed-postgresql/index.md)         | [кластер](../../managed-postgresql/concepts/network.md#security-groups)                                                                         |
| [Managed Service for ClickHouse®](../../managed-clickhouse/index.md)         | [кластер](../../managed-clickhouse/concepts/network.md#security-groups)                                                                         |
| [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/index.md)          | [кластер](../../managed-greenplum/concepts/network.md#security-groups)                                                                          |
| [Managed Service for MySQL®](../../managed-mysql/index.md)              | [кластер](../../managed-mysql/concepts/network.md#security-groups)                                                                              |
| [Yandex Managed Service for Valkey™](../../managed-valkey/index.md)             | [кластер](../../managed-valkey/concepts/network.md#security-groups)                                                                             |
| [Yandex StoreDoc](../../storedoc/index.md)                    | [кластер](../../storedoc/concepts/network.md#security-groups)                                                                                   |
| [Managed Service for Apache Kafka®](../../managed-kafka/index.md)              | [кластер](../../managed-kafka/concepts/network.md#security-groups)                                                                              |
| [Managed Service for OpenSearch](../../managed-opensearch/index.md)         | [кластер](../../managed-opensearch/concepts/network.md#security-groups)                                                                         |
| [Managed Service for Trino](../../managed-trino/index.md)              | [кластер](../../managed-trino/concepts/network.md#security-groups)                                                                              |
| [Yandex Data Processing](../../data-proc/index.md)             | [кластер](../../data-proc/concepts/network.md#security-groups)                                                                                  |
| [Data Transfer](../../data-transfer/index.md)    | [эндпоинт](../../data-transfer/concepts/network.md#security-groups)                                                                             |
| [Managed Service for GitLab](../../managed-gitlab/index.md)             | [инстанс](../../managed-gitlab/operations/configure-security-group.md)                                                                          |

{% note info %}

Подробную информацию об использовании групп безопасности в конкретном сервисе Yandex Cloud смотрите в документации нужного сервиса.

{% endnote %}

## Структура групп безопасности {#security-groups-structure}

Группы безопасности состоят из списка правил (`rules`). Группа безопасности без правил блокирует весь сетевой трафик между объектами, к которым применяется. Это происходит потому, что в конце списка правил группы безопасности всегда неявно присутствует правило «запретить все».

Правила в группах безопасности задаются отдельно для входящего (`ingress`) и исходящего (`egress`) трафика. В одной группе может быть до [50 правил](limits.md#vpc-limits), суммарно для входящего и исходящего трафика.

Новое правило всегда добавляется в конец списка. Добавить новое правило в определенное место в списке между уже существующими правилами нельзя.

### Описание правил групп безопасности {#security-groups-rules}

Каждое правило в группе безопасности состоит из фиксированного набора полей:

| Параметр | Описание |
| --- | --- |
| **Описание** | Краткое описание правила. В этом поле также можно описать метаданные.
| **Протокол** | Какой [сетевой протокол](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1) будет использоваться для данного правила.<br> Для правил в группах безопасности можно использовать следующие протоколы:<ul><li>`TCP`</li><li>`UDP`</li><li>`ICMP`</li><li>`AH` (для организации IPsec-соединений)</li><li>`ESP` (для организации IPsec-соединений)</li><li>`GRE` (для организации туннельных соединений)</li><li>`Любой` (Any) — [любой сетевой протокол](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1).</li></ul>
| **Диапазон портов** | Диапазон портов для выбранного в правиле сетевого протокола.<br> Можно указать только непрерывный диапазон портов. Перечислить список произвольных портов через запятую нельзя.
| **Источник** <br>Только для входящего трафика | IP-адреса источников трафика.<br>Можно использовать следующие варианты указания IP-адресов источников трафика:<ul><li>`CIDR` — список IPv4-префиксов источников трафика. Можно указать [до 50 CIDR](limits.md#vpc-limits) в одном правиле.</li><li>`Группа безопасности` — имя уже существующей группы безопасности.</li><li>`Проверки состояния балансировщика` — специальное правило, которое определяет взаимодействие с [узлами проверки состояния Network Load Balancer](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>
| **Назначение** <br>Только для исходящего трафика | IP-адреса получателей трафика.<br>Можно использовать следующие варианты указания IP-адресов получателей трафика:<ul><li>`CIDR` — список IPv4-префиксов получателей трафика. Можно указать [до 50 CIDR](limits.md#vpc-limits) в одном правиле.</li><li>`Группа безопасности` — имя уже существующей SG.</li><li>`Проверки состояния балансировщика` — специальное правило, которое определяет взаимодействие с [узлами проверки состояния Network Load Balancer](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>

### Правило Self {#self-rule}

В качестве источника или получателя трафика в правиле группы безопасности может выступать специальная группа безопасности, которая называется `Self`. В такую группу входят все IP-адреса объектов, к которым эта группа безопасности будет применена.

Например, можно создать группу безопасности `vm_group_sg`, описав ее в Terraform следующим образом:

```hcl
resource yandex_vpc_security_group vm_group_sg {
  ...  
  ingress {
      protocol          = "ANY"
      description       = "Allow incoming traffic from members of the same security group"
      from_port         = 0
      to_port           = 65535
      predefined_target = "self_security_group"
  }

  egress {
      protocol          = "ANY"
      description       = "Allow outgoing traffic to members of the same security group"
      from_port         = 0
      to_port           = 65535
      predefined_target = "self_security_group"
    }
}
```

Теперь, если применить группу `vm_group_sg` к сетевым интерфейсам двух ВМ, подключенных к одной сети, эти две ВМ смогут обмениваться трафиком между собой без ограничений по портам. Если применить эту же группу к сетевому интерфейсу третьей ВМ в той же сети — все три ВМ смогут обмениваться трафиком между собой.

{% note alert %}

Следует помнить, что правило `Self` действует только на трафик, проходящий непосредственно через сетевой интерфейс ВМ, к которому применена группа безопасности.

На ВМ с публичным IP-адресом трафик в интернет, проходящий через этот сетевой интерфейс в направлении [one-to-one NAT](address.md#public-addresses), не попадет под действие правила `Self`.

{% endnote %}

### Правило со ссылкой на группу безопасности {#reference-rule} 

Правила в группах безопасности дают возможность использовать другие группы безопасности в полях **Источник** или **Назначение**.

В таком правиле будет разрешено сетевое взаимодействие с IP-адресами ресурсов (интерфейсов ВМ) к которым эта группа безопасности уже применена.

Таким образом в правилах можно ссылаться на объекты различного типа, например:

* Рабочие узлы кластера Managed Service for Kubernetes.
* Хосты кластера управляемой базы данных.
* ВМ в группах виртуальных машин.

Использование ссылочных правил в группах безопасности позволяет сохранять консистентность сетевых правил доступа при автомасштабировании облачных ресурсов.

Рассмотрим пример сервиса, состоящего из двух компонентов:

* [группы виртуальных машин](../../compute/concepts/instance-groups/index.md) с веб-серверами за балансировщиком нагрузки;
* кластера [Managed Service for PostgreSQL](../../managed-postgresql/index.md).

Необходимо обеспечить доступ из кластера СУБД к группе веб-серверов, количество которых может меняться в зависимости от нагрузки.

Для решения этой задачи нужно создать две группы безопасности:

* `web-sg` — для группы веб-серверов.
* `db-sg` — для кластера Managed Service for PostgreSQL.

```hcl
resource "yandex_vpc_security_group" "web_sg" {
  name                = "web-sg"
  ...
  ingress {
    description       = "Allow HTTPS"
    protocol          = "TCP"
    port              = 443
  }

  ingress {
    description       = "Allow HTTP"
    protocol          = "TCP"
    port              = 80
  }

  egress {
    description       = "Permit ANY"
    protocol          = "ANY"
    v4_cidr_blocks    = ["0.0.0.0/0"]
  }
  ...
}

resource "yandex_vpc_security_group" "db_sg" {
  name                = "db-sg"
  ...
  ingress {
    description       = "Permit DB access to Web VM's"
    protocol          = "TCP"
    port              = 6432
    security_group_id = [ yandex_vpc_security_group.web_sg.id ]
  }
}
```

При добавлении новых серверов в группу, правила групп безопасности будут автоматически распространяться и на них.

## Особенности работы групп безопасности {#security-groups-notes}

#### Направление трафика {#traffic-destination}

Правила в группах безопасности отдельно описывают входящий и исходящий трафик.

#### Stateful-соединения {#stateful}

В группах безопасности состояние сетевых соединений отслеживается. Если сетевой трафик уже разрешен правилами в одну сторону, то обратный трафик разрешать уже не нужно.

#### Время жизни соединения {#ttl}

Группы безопасности автоматически завершают TCP-соединения в статусе idle через 180 секунд. Не рекомендуется использовать в приложениях таймауты сессии больше этого времени. Подробнее о [лимитах](limits.md#vpc-limits).

#### Использование групп безопасности в правилах {#security-groups-in-rules}

В правилах могут использоваться уже существующие группы безопасности в качестве источников или получателей трафика.

#### Применение нескольких групп безопасности {#multiple-security-groups}

При применении нескольких групп одновременно к одному объекту, правила из этих групп будут складываться в единый список. Сетевой трафик будет разрешен, если он совпадет с правилом хотя бы в одной из групп. Если трафик не совпадет ни с одним правилом ни в одной из групп, то он будет запрещен.

#### Группы безопасности и Network Load Balancer {#security-groups-and-network-load-balancer}

Следует помнить, что группы безопасности нельзя применять к [обработчику трафика](../../network-load-balancer/concepts/listener.md) сетевого балансировщика нагрузки. Для ВМ в [целевых группах](../../network-load-balancer/concepts/target-resources.md), размещенных за балансировщиком нагрузки, группы безопасности могут применяться к сетевым интерфейсам этих ВМ. В группах безопасности таких ВМ обязательно должно быть правило `Health Сhecks` для разрешения трафика [проверок доступности](../../network-load-balancer/concepts/health-check.md#target-statuses) со стороны балансировщика.


#### Группы безопасности и сервисы DNS и метаданных ВМ {#security-groups-and-metadata-dns}

Для надежной и предсказуемой работы сетевых сервисов необходимо явно разрешать в исходящих правилах групп безопасности следующий сетевой трафик:

* Запросы в [службу метаданных ВМ](../../compute/concepts/vm-metadata.md) по IP-адресу `169.254.169.254` по протоколу HTTP `(tcp/80)`.
* Запросы в службу DNS — в направлении второго IP-адреса [в подсети](network.md#subnet) по протоколу DNS `(udp/53)`.

#### Группы безопасности и Managed Service for Kubernetes {#security-groups-and-k8s}

Во избежание проблем с сетевой связностью при развертывании и эксплуатации кластеров Managed Service for Kubernetes, внимательно следуйте [инструкции](../../managed-kubernetes/operations/connect/security-groups.md).

#### Группы безопасности и инструменты Application Load Balancer для Managed Service for Kubernetes {#security-groups-and-alb-for-k8s}

Для корректной работы [Ingress-контроллера](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) или [Gateway API](https://github.com/kubernetes-sigs/gateway-api) настройте группы безопасности [кластера](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [групп узлов](../../managed-kubernetes/concepts/index.md#node-group) Managed Service for Kubernetes, а также [L7-балансировщика нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) Application Load Balancer. Подробнее в [инструкции](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

{% note alert %}

В Yandex Cloud реализована автоматическая [фильтрация исходящего SMTP трафика](limits.md#vpc-egress-traffic-filter).

{% endnote %}

## Примеры описания правил групп безопасности {#security-groups-examples}

### Виртуальная машина с веб-сервером {#security-group-vm-web}

```hcl
resource yandex_vpc_security_group vm_group_sg {
...
  ingress {
    description    = "Allow HTTP protocol from local subnets"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description    = "Allow HTTPS protocol from local subnets"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### Виртуальная машина за сетевым балансировщиком {#security-group-vm-nlb}

```hcl
resource yandex_vpc_security_group vm_group_sg {
...
  ingress {
    description    = "Allow HTTP protocol from local subnets"
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description    = "Allow HTTPS protocol from local subnets"
    protocol       = "TCP"
    port           = "443"
    v4_cidr_blocks = ["192.168.10.0/24", "192.168.20.0/24"]
  }

  ingress {
    description = "Health checks from NLB"
    protocol = "TCP"
    predefined_target = "loadbalancer_healthchecks" # [198.18.235.0/24, 198.18.248.0/24]
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Инструменты для управления группами безопасности {#security-groups-tools}

В Yandex Cloud с группами безопасности можно работать через:

* [Консоль управления](https://console.yandex.cloud/folders/{folder-id}/vpc/security-groups/)
* [Интерфейс командной строки (CLI)](../../cli/cli-ref/vpc/cli-ref/security-group/index.md)
* Terraform:
  * [Security Group](../../terraform/resources/vpc_security_group.md)
  * [Security Group Rule](../../terraform/resources/vpc_security_group_rule.md)
  * [Default Security Group](../../terraform/resources/vpc_default_security_group.md)

## Пошаговые инструкции по работе с группами безопасности {#security-group-howto}

[Примеры работы с группами безопасности](../operations/index.md#security-groups) в Yandex Cloud.


## Примеры использования {#examples}

* [Архитектура и защита базового интернет-сервиса](../tutorials/web-service.md)
* [Соединение с облачной сетью при помощи OpenVPN](../tutorials/openvpn.md)
* [Создание и настройка шлюза UserGate в режиме прокси-сервера](../tutorials/usergate-proxy.md)
* [Создание бастионного хоста](../tutorials/bastion.md)
* [Настройка сети для Yandex Data Processing](../tutorials/data-processing-nat-instance.md)
* [Реализация защищенной высокодоступной сетевой инфраструктуры с выделением DMZ на основе Check Point NGFW](../tutorials/high-accessible-dmz.md)

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._