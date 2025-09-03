---
title: Настройка групп безопасности для инструментов {{ alb-name }} для {{ managed-k8s-name }}
description: Для корректной работы Ingress-контроллера или Gateway API нужно настроить группы безопасности кластера и групп узлов {{ managed-k8s-full-name }} и балансировщика {{ alb-name }}.
---

# Настройка групп безопасности для инструментов {{ alb-name }} для {{ managed-k8s-name }} 

Для корректной работы [Ingress-контроллера](index.md) или [Gateway API](../k8s-gateway-api/index.md) нужно настроить [группы безопасности](../../../vpc/concepts/security-groups.md) [кластера](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [групп узлов {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#node-group) и [балансировщика нагрузки](../../concepts/application-load-balancer.md) {{ alb-name }}.

Для кластера, групп узлов и балансировщика можно использовать разные группы безопасности (рекомендуется) или одну и ту же группу.

В группах безопасности должны быть настроены:
* Все стандартные правила, описанные в соответствующих разделах документации:
  * Для кластера и групп узлов — в разделе [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md) документации {{ managed-k8s-name }}.
  * Для балансировщика — в разделе [{#T}](../../concepts/application-load-balancer.md#security-groups). Последнее правило, для исходящего трафика на виртуальные машины [бэкендов](../../concepts/backend-group.md), должно разрешать соединения в [подсети](../../../vpc/concepts/network.md#subnet) [групп узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера или его группу безопасности.
* Правила для проверок состояния бэкендов, разрешающие:
  * Балансировщику — отправлять трафик узлам кластера по протоколу TCP на порт 10501 (назначение трафика — подсети или группы безопасности групп узлов кластера).
  * Группам узлов — принимать этот трафик (источник трафика — подсети балансировщика или его группа безопасности).

Группы безопасности кластера и групп узлов указываются в их настройках. Подробнее см. инструкции:
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

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.140.0.0/24`[^\[Узл\]^](#example) | Для отправки трафика, в том числе для проверок состояния, на узлы

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | Для получения входящего HTTP-трафика
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | Для получения входящего HTTPS-трафика
    `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | Для проверок состояния узлов балансировщика

  {% endlist %}

* Группа безопасности группы узлов для проверок состояния бэкендов:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `10501` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.128.0.0/24`[^\[Б\]^](#example)<br>`10.129.0.0/24`[^\[Б\]^](#example)<br>`10.130.0.0/24`[^\[Б\]^](#example) | Для проверок состояния бэкендов

  {% endlist %}

* Группа безопасности кластера и группы узлов для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) | Для трафика между [мастером](../../../managed-kubernetes/concepts/index.md#master) и узлами

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — | Для сетевого балансировщика нагрузки
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`) | Для трафика между мастером и узлами
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_ipv6-icmp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.0.0.0/8`<br>`192.168.0.0/16`<br>`172.16.0.0/12` | Для проверки работоспособности узлов из подсетей внутри {{ yandex-cloud }}

  {% endlist %}

* Группа безопасности группы узлов для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | Для доступа к внешним ресурсам

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`) | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`[^\[К\]^](#example)<br>`10.112.0.0/16`[^\[С\]^](#example) | Для трафика между [подами](../../../managed-kubernetes/concepts/index.md#pod) и [сервисами](../../../managed-kubernetes/concepts/index.md#service)

  {% endlist %}

* Группа безопасности кластера для служебного трафика:

  {% list tabs group=traffic %}

  - Исходящий трафик {#outgoing}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `4443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.96.0.0/16`[^\[К\]^](#example) | Для трафика между мастером и [подами](../../../managed-kubernetes/concepts/index.md#pod) `metric-server`

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для доступа к API {{ k8s }}
    `6443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для доступа к API {{ k8s }}

  {% endlist %}

* Группа безопасности группы узлов для подключения к сервисам из интернета:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `30000-32767` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | Для доступа к сервисам из интернета и подсетей {{ yandex-cloud }}

  {% endlist %}

* Группа безопасности группы узлов для подключения к узлам по SSH:

  {% list tabs group=traffic %}

  - Входящий трафик {#incoming}

    {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}
    --- | --- | --- | --- | ---
    `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `203.0.113.0/24`[^\[Упр\]^](#example) | Для подключения к узлам по SSH

  {% endlist %}

Подробнее о группах безопасности для кластера и групп узлов см. в разделе [{#T}](../../../managed-kubernetes/operations/connect/security-groups.md) документации {{ managed-k8s-name }}.

### {{ TF }} {#example-terraform}

{% include [terraform-security-groups-example](../../../_includes/application-load-balancer/tf-security-groups-example.md) %}
