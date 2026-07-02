[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Инструменты для Managed Service for Kubernetes](../index.md) > Настройка групп безопасности

# Настройка групп безопасности для инструментов Application Load Balancer для Managed Service for Kubernetes 

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../gwin/index.md).

{% endnote %}

Для корректной работы [Ingress-контроллера](index.md) или [Gateway API](../k8s-gateway-api/index.md) нужно настроить [группы безопасности](../../../vpc/concepts/security-groups.md) [кластера](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [групп узлов Yandex Managed Service for Kubernetes](../../../managed-kubernetes/concepts/index.md#node-group) и [балансировщика нагрузки](../../concepts/application-load-balancer.md) Application Load Balancer.

Для кластера, групп узлов и балансировщика можно использовать разные группы безопасности (рекомендуется) или одну и ту же группу.

В группах безопасности должны быть настроены:
* Все стандартные правила, описанные в соответствующих разделах документации:
  * Для кластера и групп узлов — в разделе [Настройка групп безопасности](../../../managed-kubernetes/operations/connect/security-groups.md) документации Managed Service for Kubernetes.
  * Для балансировщика — в разделе [Группы безопасности](../../concepts/application-load-balancer.md#security-groups). Последнее правило, для исходящего трафика на виртуальные машины [бэкендов](../../concepts/backend-group.md), должно разрешать соединения в [подсети](../../../vpc/concepts/network.md#subnet) [групп узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера или его группу безопасности.
* Правила для проверок состояния бэкендов, разрешающие:
  * Балансировщику — отправлять трафик узлам кластера по протоколу TCP на порт 10501 (назначение трафика — подсети или группы безопасности групп узлов кластера).
  * Группам узлов — принимать этот трафик (источник трафика — подсети балансировщика или его группа безопасности).

Группы безопасности кластера и групп узлов указываются в их настройках. Подробнее в инструкциях:
* По [созданию](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [изменению](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) кластера.
* По [созданию](../../../managed-kubernetes/operations/node-group/node-group-create.md) и [изменению](../../../managed-kubernetes/operations/node-group/node-group-update.md) группы узлов.

Идентификаторы групп безопасности балансировщика указываются:
* В ресурсе `Ingress` — в аннотации `ingress.alb.yc.io/security-groups`. Если балансировщик создается по нескольким `Ingress`, ему назначаются все указанные в этих `Ingress` группы безопасности.
* В ресурсе `Gateway` — в аннотации `gateway.alb.yc.io/security-groups`.

## Пример настройки {#example}

Пусть необходимо создать правила для следующих условий:

* Требуется развернуть балансировщик с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses), принимающий HTTPS-трафик, в трех подсетях, имеющих CIDR `10.128.0.0/24`, `10.129.0.0/24` и `10.130.0.0/24`, — далее они помечаются \[Б\].
* При создании кластера были указаны CIDR кластера `10.96.0.0/16` \[К\] и CIDR сервисов `10.112.0.0/16` \[С\].
* Группа узлов в кластере расположена в подсети, имеющей CIDR `10.140.0.0/24` \[Узл\].
* [Подключаться](../../../managed-kubernetes/operations/node-connect-ssh.md) к узлам по [SSH](../../../glossary/ssh-keygen.md) и управлять кластером через [API](../../../glossary/rest-api.md), `kubectl` и другие утилиты можно только из CIDR `203.0.113.0/24` \[Упр\].

### Консоль управления {#example-console}

Создайте следующие группы безопасности и правила:

* [Группа безопасности балансировщика](../../concepts/application-load-balancer.md#security-groups):

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    Диапазон портов | Протокол | Назначение | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `0-65535` | `TCP` | `CIDR` | `10.140.0.0/24`[^\[Узл\]^](#example) | Для отправки трафика, в том числе для проверок состояния, на узлы

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `80` | `TCP` | `CIDR` | `0.0.0.0/0` | Для получения входящего HTTP-трафика
    `443` | `TCP` | `CIDR` | `0.0.0.0/0` | Для получения входящего HTTPS-трафика
    `30080` | `TCP` | `Проверки состояния балансировщика` | — | Для проверок состояния узлов балансировщика

  {% endlist %}

* Группа безопасности группы узлов для проверок состояния бэкендов:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `10501` | `TCP` | `CIDR` | `10.128.0.0/24`[^\[Б\]^](#example)<br>`10.129.0.0/24`[^\[Б\]^](#example)<br>`10.130.0.0/24`[^\[Б\]^](#example) | Для проверок состояния бэкендов

  {% endlist %}

* Группа безопасности кластера и группы узлов для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    Диапазон портов | Протокол | Назначение | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `0-65535` | `Любой` (`Any`) | `Группа безопасности` | `Текущая` (`Self`) | Для трафика между [мастером](../../../managed-kubernetes/concepts/index.md#master) и узлами

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `0-65535` | `TCP` | `Проверки состояния балансировщика` | — | Для сетевого балансировщика нагрузки
    `0-65535` | `Любой` (`Any`) | `Группа безопасности` | `Текущая` (`Self`) | Для трафика между мастером и узлами
    `0-65535` | `ICMPv6` | `CIDR` | `10.0.0.0/8`<br>`192.168.0.0/16`<br>`172.16.0.0/12` | Для проверки работоспособности узлов из подсетей внутри Yandex Cloud

  {% endlist %}

* Группа безопасности группы узлов для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    Диапазон портов | Протокол | Назначение | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `0-65535` | `Любой` (`Any`) | `CIDR` | `0.0.0.0/0` | Для доступа к внешним ресурсам

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `0-65535` | `Любой` (`Any`) | `CIDR` | `10.96.0.0/16`[^\[К\]^](#example)<br>`10.112.0.0/16`[^\[С\]^](#example) | Для трафика между [подами](../../../managed-kubernetes/concepts/index.md#pod) и [сервисами](../../../managed-kubernetes/concepts/index.md#service)

  {% endlist %}

* Группа безопасности кластера для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    Диапазон портов | Протокол | Назначение | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `4443` | `TCP` | `CIDR` | `10.96.0.0/16`[^\[К\]^](#example) | Для трафика между мастером и [подами](../../../managed-kubernetes/concepts/index.md#pod) `metric-server`

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Назначение | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `443` | `TCP` | `CIDR` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для доступа к API Kubernetes
    `6443` | `TCP` | `CIDR` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для доступа к API Kubernetes

  {% endlist %}

* Группа безопасности группы узлов для подключения к сервисам из интернета:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `30000-32767` | `TCP` | `CIDR` | `0.0.0.0/0` | Для доступа к сервисам из интернета и подсетей Yandex Cloud

  {% endlist %}

* Группа безопасности группы узлов для подключения к узлам по SSH:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    Диапазон портов | Протокол | Источник | CIDR блоки | Описание
    --- | --- | --- | --- | ---
    `22` | `TCP` | `CIDR` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для подключения к узлам по SSH

  {% endlist %}

Группы безопасности для кластера и групп узлов описаны в разделе [Настройка групп безопасности](../../../managed-kubernetes/operations/connect/security-groups.md).

### Terraform {#example-terraform}

Создайте следующие группы безопасности и правила:

```hcl
locals {
  network-id = "<идентификатор_облачной_сети>"
}

resource "yandex_vpc_security_group" "alb" {
  description = "Группа безопасности балансировщика"
  name        = "alb"
  network_id  = local.network-id
  ingress {
    description    = "Правило для получения входящего HTTP-трафика"
    port           = 80
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "Правило для получения входящего HTTPS-трафика"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description       = "Правило для проверок состояния узлов балансировщика"
    port              = 30080
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  egress {
    description    = "Правило для отправки трафика на узлы, в том числе для проверок состояния"
    from_port      = 0
    to_port        = 65535
    protocol       = "TCP"
    v4_cidr_blocks = ["10.140.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-backend" {
  description = "Группа безопасности группы узлов для проверок состояния бэкендов"
  name        = "nodegroup-backend"
  network_id  = local.network-id
  ingress {
    description    = "Правило для проверок состояния бэкендов"
    port           = 10501
    protocol       = "TCP"
    v4_cidr_blocks = ["10.128.0.0/24", "10.129.0.0/24", "10.130.0.0/24"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-nodegroup-traffic" {
  description = "Группа безопасности кластера и группы узлов для служебного трафика"
  name        = "k8s-cluster-nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description       = "Правило для сетевого балансировщика нагрузки"
    from_port         = 0
    to_port           = 65535
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  ingress {
    description       = "Правило для трафика между мастером и узлами"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
  ingress {
    description    = "Правило для проверки работоспособности узлов из подсетей внутри Yandex Cloud"
    from_port      = 0
    to_port        = 65535
    protocol       = "IPV6_ICMP"
    v4_cidr_blocks = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
  }
  egress {
    description       = "Правило для трафика между мастером и узлами"
    from_port         = 0
    to_port           = 65535
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }
}

resource "yandex_vpc_security_group" "nodegroup-traffic" {
  description = "Группа безопасности группы узлов для служебного трафика"
  name        = "nodegroup-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Правило для трафика между подами и сервисами"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
  }
  egress {
    description    = "Правило для доступа к внешним ресурсам"
    from_port      = 0
    to_port        = 65535
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "k8s-cluster-traffic" {
  description = "Группа безопасности кластера для служебного трафика"
  name        = "k8s-cluster-traffic"
  network_id  = local.network-id
  ingress {
    description    = "Правило для доступа к API Kubernetes"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  ingress {
    description    = "Правило для доступа к API Kubernetes"
    port           = 6443
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
  egress {
    description    = "Правило для трафика между мастером и подами metric-server"
    port           = 4443
    protocol       = "TCP"
    v4_cidr_blocks = ["10.96.0.0/16"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-services-access" {
  description = "Группа безопасности группы узлов для подключения к сервисам из интернета"
  name        = "nodegroup-services-access"
  network_id  = local.network-id
  ingress {
    description    = "Правило для доступа к сервисам из интернета и подсетей Yandex Cloud"
    from_port      = 30000
    to_port        = 32767
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "nodegroup-ssh" {
  description = "Группа безопасности группы узлов для подключения к узлам по SSH"
  name        = "nodegroup-ssh"
  network_id  = local.network-id
  ingress {
    description    = "Правило для подключения к узлам по SSH"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = ["203.0.113.0/24"]
  }
}
```