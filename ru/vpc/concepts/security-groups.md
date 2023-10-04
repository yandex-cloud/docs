---
title: "Группы безопасности в {{ vpc-full-name }}"
description: "Группы безопасности позволяют контролировать сетевые взаимодействия облачных ресурсов."
---

# Группы безопасности

Группы безопасности служат основным механизмом разграничения сетевого доступа в {{ yandex-cloud }}.

{% note info %}

В настоящее время в сетях {{ yandex-cloud }} можно использовать только протокол IPv4. Протокол IPv6 не поддерживается, поэтому группы безопасности работают только с трафиком протокола IPv4.

{% endnote %}

*Группа безопасности* (Security Group, SG) — это ресурс, который создается на уровне [облачной сети](./network.md#network). После создания группа безопасности может использоваться в сервисах {{ yandex-cloud }} для разграничения сетевого доступа объекта, к которому она применяется.

*Группа безопасности по умолчанию* (Default Security Group, DSG) создается автоматически при создании [новой облачной сети](./network.md#network). Группа безопасности по умолчанию обладает следующими свойствами:

* В новой сети будет разрешать весь сетевой трафик в обоих направлениях — исходящий (egress) и входящий (ingress).
* Действует для трафика, проходящего через все подсети в сети, где она создана. 
* Работает лишь в том случае, если на объект еще явно не назначена группа безопасности.
* Ее невозможно удалить, она автоматически удаляется вместе с удалением сети.

Группы безопасности можно комбинировать — на один объект можно назначить до пяти групп.

{% note alert %}

Группы безопасности не предназначены для защиты от DDoS атак.

Для фильтрации больших объемов нежелательного сетевого трафика используйте сервис [ {{ ddos-protection-full-name }}](../ddos-protection/index.md).

{% endnote %}

## Где можно использовать группы безопасности {#security-groups-apply}

Список объектов в сервисах {{ yandex-cloud }}, где можно использовать группы безопасности:

| Название сервиса | Объекты сервиса | 
| --- | --- |
| [{{ compute-short-name }}](../../compute/) | [интерфейс ВМ](../../compute/concepts/network.md), [шаблон групп ВМ](../../compute/concepts/instance-groups/instance-template.md#network) |
| [{{ managed-k8s-name }}](../../managed-kubernetes/) | [кластер](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), [группа узлов](../../managed-kubernetes/concepts/index.md#node-group) |
| [{{ alb-name }}](../../application-load-balancer/ ) | [балансировщик](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) |
| [{{ mpg-name }}](../../managed-postgresql/) | [кластер](../../managed-postgresql/concepts/network.md#security-groups) |
| [{{ mch-name }}](../../managed-clickhouse/) | [кластер](../../managed-clickhouse/concepts/network.md#security-groups) |
| [{{ mgp-name }}](../../managed-greenplum/) | [кластер](../../managed-greenplum/concepts/network.md#security-groups) |
| [{{ mmy-name }}](../../managed-mysql/) | [кластер](../../managed-mysql/concepts/network.md#security-groups) |
| [{{ mrd-name }}](../../managed-redis/) | [кластер](../../managed-redis/concepts/network.md#security-groups) |
| [{{ mmg-name }}](../../managed-mongodb) | [кластер](../../managed-mongodb/concepts/network.md#security-groups) |
| [{{ mkf-name }}](../../managed-kafka/) | [кластер](../../managed-kafka/concepts/network.md#security-groups) |
| [{{ mos-name }}](../../managed-opensearch/) | [кластер](../../managed-opensearch/concepts/network.md#security-groups) |
| [{{ dataproc-name }}](../../data-proc/) | [кластер](../../data-proc/concepts/network.md#security-groups) |
| [{{ data-transfer-name }}](../../data-transfer/) | [эндпоинт](../../data-transfer/concepts/network.md#security-groups) |
| [{{ load-testing-name }}](../../load-testing/) | [агент тестирования](../../load-testing/concepts/agent.md) |
| [{{ mgl-name }}](../../managed-gitlab/) | [инстанс](../../managed-gitlab/operations/connect.md) |

{% note info %}

Подробную информацию об использовании групп безопасности в конкретном сервисе {{ yandex-cloud }} смотрите в документации нужного сервиса.

{% endnote %} 

## Структура групп безопасности {#security-groups-structure}

Группы безопасности состоят из списка правил (`rules`). Группа безопасности без правил блокирует весь сетевой трафик между объектами, к которым применяется. Это происходит потому, что в конце списка правил группы безопасности всегда неявно присутствует правило «запретить все».

Правила в группах безопасности задаются отдельно для входящего (`ingress`) и исходящего (`egress`) трафика. В одной группе может быть до [50 правил](./limits.md#vpc-limits), суммарно для входящего и исходящего трафика.

Новое правило всегда добавляется в конец списка. Добавить новое правило в определенное место в списке между уже существующими правилами нельзя.

### Описание правил групп безопасности {#security-groups-rules}

Каждое правило в группе безопасности состоит из фиксированного набора полей:

| Параметр | Описание | 
| --- | --- |
| **Описание** | Краткое описание правила. В этом поле также можно описать метаданные.
| **Протокол** | Какой [сетевой протокол](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1) будет использоваться для данного правила.<br> Для правил в группах безопасности можно использовать следующие протоколы:<ul><li>`TCP`</li><li>`UDP`</li><li>`ICMP`</li><li>`AH` (для организации IPsec-соединений)</li><li>`ESP` (для организации IPsec-соединений)</li><li>`GRE` (для организации туннельных соединений)</li><li>`Любой` (Any) — [любой сетевой протокол](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml#protocol-numbers-1).</li></ul>
| **Диапазон портов** | Диапазон портов для выбранного в правиле сетевого протокола.<br> Можно указать только непрерывный диапазон портов. Перечислить список произвольных портов через запятую нельзя.
| **Источник** <br>Только для входящего трафика | IP-адреса источников трафика.<br>Можно использовать следующие варианты указания IP-адресов источников трафика:<ul><li>`CIDR` — список IPv4-префиксов источников трафика. Можно указать [до 50 CIDR](./limits.md#vpc-limits) в одном правиле.</li><li>`Группа безопасности` — имя уже существующей группы безопасности.</li><li>`Проверки состояния балансировщика` — специальное правило, которое определяет взаимодействие с [узлами проверки состояния {{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>
| **Назначение** <br>Только для исходящего трафика | IP-адреса получателей трафика.<br>Можно использовать следующие варианты указания IP-адресов получателей трафика:<ul><li>`CIDR` — список IPv4-префиксов получателей трафика. Можно указать [до 50 CIDR](./limits.md#vpc-limits) в одном правиле.</li><li>`Группа безопасности` — имя уже существующей SG.</li><li>`Проверки состояния балансировщика` — специальное правило, которое определяет взаимодействие с [узлами проверки состояния {{ network-load-balancer-name }}](../../network-load-balancer/concepts/health-check.md#target-statuses).</li></ul>

### Правило Self {#self-rule}

В качестве источника или получателя трафика в правиле группы безопасности может выступать специальная группа безопасности, которая называется `Self`. В такую группу входят все IP-адреса объектов, к которым эта группа безопасности будет применена. 

Например, можно создать группу безопасности `vm_group_sg`, описав ее в {{ TF }} следующим образом:

```
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

На ВМ с публичным IP-адресом трафик в интернет, проходящий через этот сетевой интерфейс в направлении [one-to-one NAT](./address.md#public-addresses), не попадет под действие правила `Self`.

{% endnote %}

### Правило со ссылкой на группу безопасности {#reference-rule} 

Правила в группах безопасности дают возможность использовать другие группы безопасности в полях **Источник** или **Назначение**.

В таком правиле будет разрешено сетевое взаимодействие с IP-адресами ресурсов (интерфейсов ВМ) к которым эта группа безопасности уже применена.

Таким образом в правилах можно ссылаться на объекты различного типа, например:

* Рабочие узлы кластера {{ managed-k8s-name }}.
* Хосты кластера управляемой базы данных.
* ВМ в группах виртуальных машин.

Использование ссылочных правил в группах безопасности позволяет сохранять консистентность сетевых правил доступа при автомасштабировании облачных ресурсов.

Рассмотрим пример сервиса состоящего из двух компонентов:

* [группы виртуальных машин](../../compute/concepts/instance-groups/) с веб-серверами за балансировщиком нагрузки;
* кластера [{{ mpg-name }}](../../managed-postgresql/).

Необходимо обеспечить доступ из кластера СУБД к группе веб-серверов, количество которых может меняться в зависимости от нагрузки.

Для решения этой задачи нужно создать две группы безопасности:

* `web-sg` — для группы веб-серверов.
* `db-sg` — для кластера {{ mpg-name }}.

```
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

Группы безопасности автоматически завершают TCP-соединения в статусе idle через 180 секунд. Не рекомендуется использовать в приложениях таймауты сессии больше этого времени. Подробнее о [лимитах](./limits.md#vpc-limits).

#### Использование групп безопасности в правилах {#security-groups-in-rules}

В правилах могут использоваться уже существующие группы безопасности в качестве источников или получателей трафика.

#### Применение нескольких групп безопасности {#multiple-security-groups}

При применении нескольких групп одновременно к одному объекту, правила из этих групп будут складываться в единый список. Сетевой трафик будет разрешен, если он совпадет с правилом хотя бы в одной из групп. Если трафик не совпадет ни с одним правилом ни в одной из групп, то он будет запрещен.

#### Группы безопасности и {{ network-load-balancer-name }} {#security-groups-and-network-load-balancer}

Следует помнить, что группы безопасности нельзя применять к [обработчику трафика](../../network-load-balancer/concepts/listener.md) сетевого балансировщика нагрузки. Для ВМ в [целевых группах](../../network-load-balancer/concepts/target-resources.md), размещенных за балансировщиком нагрузки, группы безопасности могут применяться к сетевым интерфейсам этих ВМ. В группах безопасности таких ВМ обязательно должно быть правило `Health Сhecks` для разрешения трафика [проверок доступности](../../network-load-balancer/concepts/health-check.md#target-statuses) со стороны балансировщика.

#### Группы безопасности и {{ managed-k8s-name }} {#security-groups-and-k8s}

Во избежание проблем с сетевой связностью при развертывании и эксплуатации кластеров {{ managed-k8s-name }}, внимательно следуйте [инструкции](../../managed-kubernetes/operations/connect/security-groups.md). 

{% note alert %}

В {{ yandex-cloud }} реализована автоматическая [фильтрация исходящего SMTP трафика](./limits.md#vpc-egress-traffic-filter).

{% endnote %}

## Примеры описания правил групп безопасности {#security-groups-examples}

### Виртуальная машина с веб-сервером {#security-group-vm-web}

```
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

```
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

В {{ yandex-cloud }} с группами безопасности можно работать через:

* [Консоль управления](https://console.cloud.yandex.ru/folders/{folder-id}/vpc/security-groups/)
* [Интерфейс командной строки (CLI)](https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/vpc/security-group/)
* {{ TF }}:
  * [Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group)
  * [Security Group Rule](https://terraform-provider.yandexcloud.net/Resources/vpc_security_group_rule)
  * [Default Security Group](https://terraform-provider.yandexcloud.net/Resources/vpc_default_security_group)  

## Пошаговые инструкции по работе с группами безопасности {#security-group-howto}

[Примеры работы с группами безопасности](../../vpc/operations/index.md#security-groups) в {{ yandex-cloud }}.
