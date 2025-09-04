---
title: Как настроить группы безопасности кластера {{ k8s }} в {{ managed-k8s-full-name }}
description: Следуя данной инструкции, вы сможете настроить группы безопасности.
---

# Настройка групп безопасности


Для [групп безопасности](../../../vpc/concepts/security-groups.md) действует принцип «весь трафик, который не разрешен, запрещен». Чтобы кластер работал:

1. [Создайте правила](../../../vpc/operations/security-group-add-rule.md) в его группах безопасности, разрешающие нужный трафик для узлов кластера:

    * [Служебный трафик внутри кластера](#rules-internal).

      Эти правила разрешают внутрикластерную коммуникацию и подключение к кластеру через API {{ k8s }}.

    * [Подключение к сервисам из интернета](#rules-nodes).
    * [Подключение к узлам по SSH](#rules-nodes-ssh).

    {% note tip %}

    Поместите каждый из этих наборов правил в отдельную группу безопасности.

    Тогда будет удобно [применять эти группы безопасности](#apply) к кластеру и его группам узлов.

    {% endnote %}

1. (Опционально) Если вы планируете использовать [L7-балансировщик {{ alb-full-name }}](../../../application-load-balancer/concepts/application-load-balancer.md) вместе с кластером, то [добавьте правила для балансировщика](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

1. [Примените группы безопасности с этими правилами](#apply) к кластеру и группам узлов.

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных [подсетях](../../../vpc/concepts/network.md#subnet).

  {% note warning %}

  Для работы некоторых продуктов требуются дополнительные правила в группах безопасности. Подробности приведены в документации соответствующих продуктов.

  {% endnote %}

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будет размещен [кластер](../../concepts/index.md#kubernetes-cluster). От этого зависит работоспособность и доступность кластера и запущенных в нем сервисов.

Перед изменением списка групп безопасности или настроек входящих в них правил убедитесь, что это не нарушит работу кластера и его групп узлов.

{% note alert %}

Не удаляйте группы безопасности, привязанные к работающему кластеру или группе узлов. Это может привести к запрету прохождения сетевого трафика и нарушить работу кластера и его узлов.

{% endnote %}

## Создать правила для служебного трафика {#rules-internal}

{% note warning %}

Настройка правил для служебного трафика — обязательное условие для работоспособности высокодоступного кластера.

{% endnote %}

### Разрешить трафик для кластера и групп узлов {#rules-internal-cluster}

Чтобы кластер работал корректно, создайте правила для входящего и исходящего трафика, и [примените их к кластеру и группам узлов](#apply):

1. Добавьте правила для входящего трафика, которые разрешают:

   * Выполнять проверки состояния сетевого балансировщика нагрузки:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
   * Передавать служебный трафик между [мастером](../../concepts/index.md#master) и [узлами](../../concepts/index.md#node-group):
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
   * Проверять работоспособность узлов с помощью ICMP-запросов из подсетей внутри {{ yandex-cloud }}:
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `ICMP`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазоны адресов подсетей внутри {{ yandex-cloud }}, из которых будет осуществляться проверка работоспособности, например:
       * `10.0.0.0/8`.
       * `192.168.0.0/16`.
       * `172.16.0.0/12`.

1. Добавьте правило для исходящего служебного трафика между мастером и узлами:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

{% note info %}

Если вы используете [высокодоступный тип мастера](../../concepts/index.md#master), разрешите трафик для групп узлов до CIDR подсетей, в которых расположены хосты мастера, или до CIDR кластера. Это нужно для передачи служебного трафика между мастером и узлами.

{% endnote %}

### Разрешить трафик для групп узлов {#rules-internal-nodegroup}

Чтобы группы узлов работали корректно, создайте правила для входящего и исходящего трафика, и [примените их к группам узлов](#apply):

1. Добавьте правило для входящего трафика, которое разрешает передачу трафика между [подами](../../concepts/index.md#pod) и [сервисами](../../concepts/index.md#service):
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — CIDR кластера и CIDR сервисов. Например, `10.96.0.0/16` и `10.112.0.0/16`.

1. Добавьте правило для исходящего трафика, которое разрешает узлам в группе узлов подключаться к внешним ресурсам, например, чтобы скачивать образы с Docker Hub или работать с [{{ objstorage-full-name }}](../../tutorials/kubernetes-backup.md):
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

    {% note info %}

    Если вы используете [высокодоступный тип мастера](../../concepts/index.md#master) и не хотите разрешать узлам подключаться к любым адресам (CIDR — `0.0.0.0/0`), разрешите исходящий трафик до CIDR подсетей, в которых расположены хосты мастера, или до CIDR кластера. Это нужно, чтобы у узлов был доступ к мастеру.

      {% cut "Примеры" %}

      * Доступ к CIDR кластера:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `10.131.0.32/32`.

      * Доступ к CIDR подсетей с хостами мастера:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `10.128.0.0/24`, `10.129.0.0/24`, `10.131.0.0/24`.

      {% endcut %}

    {% endnote %}

### Разрешить трафик для кластера {#rules-master}

Чтобы кластер работал корректно и к нему можно было [подключиться](./index.md), создайте правила для входящего и исходящего трафика и [примените их к кластеру](#apply):

1. Добавьте правила для входящего трафика, которые разрешают подключение к [мастеру](../../concepts/index.md#master) через порты `{{ port-k8s }}` и `{{ port-https }}`. Это позволит получить доступ к API {{ k8s }} и управлять кластером с помощью `kubectl` и других утилит.

    Создайте два правила для входящего трафика, по одному для каждого порта:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`, `{{ port-k8s }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — укажите диапазон адресов подсетей, из которых будете управлять кластером, например:
      * `85.23.23.22/32` — для внешней сети.
      * `192.168.0.0/24` — для внутренней сети.

1. Добавьте правила для исходящего трафика, которые разрешают:
   
   * Передачу трафика между мастером и [подами](../../concepts/index.md#pod) `metric-server`:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `4443`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — укажите CIDR кластера, например `10.96.0.0/16`.
   
   * Подключение мастера к NTP-серверам для синхронизации времени:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `123`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

## Создать правило для подключения к сервисам из интернета {#rules-nodes}

Чтобы запущенные на узлах сервисы были доступны из интернета и подсетей внутри {{ yandex-cloud }}, создайте правило для входящего трафика, и [примените его к группе узлов](#apply):

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `30000-32767`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

## Создать правило для подключения к узлам по SSH {#rules-nodes-ssh}

Чтобы получить доступ к узлам по протоколу [SSH](../../../glossary/ssh-keygen.md), создайте правило для входящего трафика и [примените его к группе узлов](#apply):

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазоны адресов подсетей внутри {{ yandex-cloud }}, а также публичные IP-адреса компьютеров в интернете, например:
    * `10.0.0.0/8`.
    * `192.168.0.0/16`.
    * `172.16.0.0/12`.
    * `85.32.32.22/32`.

## Применить группы безопасности с правилами {#apply}

В зависимости от правил, которые содержатся в группах безопасности, эти группы должны быть [назначены кластеру](../kubernetes-cluster/kubernetes-cluster-update.md#update-cluster) или [группе узлов](../node-group/node-group-update.md#update-settings):

| **Группа безопасности** | **Объект, на который нужно назначить группу** |
| ----------------------- | --------------------------------------------- |
| Группа, [разрешающая трафик для кластера и групп узлов](#rules-internal-cluster) | Кластер и группа узлов |
| Группа, [разрешающая трафик для групп узлов](#rules-internal-nodegroup) | Группа узлов |
| Группа, [разрешающая трафик для кластера](#rules-master) | Кластер |
| Группа, [разрешающая подключение к сервисам из интернета](#rules-nodes) | Группа узлов |
| Группа, [разрешающая подключение к узлам по SSH](#rules-nodes-ssh) | Группа узлов |

## Примеры правил {#examples}

### Группы безопасности для кластера {{ managed-k8s-name }} {#k8s-example}

Пусть планируется создать кластер {{ k8s }}, в котором:

* Используется следующая конфигурация:

    * Высокодоступный мастер, размещенный в зонах доступности `{{ region-id }}-a`, `{{ region-id }}-b` и `{{ region-id }}-d`.
    * Группа узлов `worker-nodes-a`, размещенная в зоне доступности `{{ region-id }}-a`.
    * CIDR кластера — `10.96.0.0/16`, CIDR сервисов — `10.112.0.0/16`.

* Применяются следующие политики по обмену трафиком:

    * [Проверка работоспособности узлов с помощью ICMP-запросов](#rules-internal-cluster) разрешена из следующих подсетей внутри {{ yandex-cloud }}:

        * `10.0.0.0/8`,
        * `172.16.0.0/12`,
        * `192.168.0.0/16`.

    * [Подключение к сервисам из интернета](#rules-nodes) разрешено с любых адресов — `0.0.0.0/0`.
    * [Подключение к узлам по SSH](#rules-nodes-ssh) разрешено только с одного адреса — `85.32.32.22/32`.
    * [Доступ к API {{ k8s }}](#rules-master) разрешен из одной подсети — `203.0.113.0/24`.

Чтобы создать такой кластер:

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте группу безопасности `k8s-cluster-nodegroup-traffic`, разрешающую трафик для кластера и групп узлов:

      ```bash
      yc vpc security-group create \
        --name k8s-cluster-nodegroup-traffic \
        --network-id <идентификатор_облачной_сети> \
        --rule "description=healthchecks,direction=ingress,protocol=tcp,from-port=0,to-port=65535,predefined=loadbalancer_healthchecks" \
        --rule "description=master-nodes,direction=ingress,protocol=any,from-port=0,to-port=65535,predefined=self_security_group" \
        --rule "description=icmp,direction=ingress,protocol=icmp,v4-cidrs=[10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]" \
        --rule "description=master-nodes-outgoing,direction=egress,protocol=any,from-port=0,to-port=65535,predefined=self_security_group"
      ```

  1. Создайте группу безопасности `k8s-nodegroup-traffic`, разрешающую трафик для групп узлов:

      ```bash
      yc vpc security-group create \
        --name k8s-nodegroup-traffic \
        --network-id <идентификатор_облачной_сети> \
        --rule "description=pods-services,direction=ingress,protocol=any,from-port=0,to-port=65535,v4-cidrs=[10.96.0.0/16,10.112.0.0/16]" \
        --rule "description=nodes-external-resources,direction=egress,protocol=any,from-port=0,to-port=65535,v4-cidrs=[0.0.0.0/0]"
      ``` 

  1. Создайте группу безопасности `k8s-cluster-traffic`, разрешающую трафик для кластера:

      ```bash
      yc vpc security-group create \
        --name k8s-cluster-traffic \
        --network-id <идентификатор_облачной_сети> \
        --rule "description=api-443,direction=ingress,protocol=tcp,port=443,v4-cidrs=[203.0.113.0/24]" \
        --rule "description=api-6443,direction=ingress,protocol=tcp,port=6443,v4-cidrs=[203.0.113.0/24]" \
        --rule "description=metric-server,direction=egress,protocol=tcp,port=4443,v4-cidrs=[10.96.0.0/16]" \
        --rule "description=ntp-server,direction=egress,protocol=udp,port=123,v4-cidrs=[0.0.0.0/0]"
      ```

  1. Создайте группу безопасности `k8s-services-access`, разрешающую подключение к сервисам из интернета:

      ```bash
      yc vpc security-group create \
        --name k8s-services-access \
        --network-id <идентификатор_облачной_сети> \
        --rule "description=services-incoming,direction=ingress,protocol=tcp,from-port=30000,to-port=32767,v4-cidrs=[0.0.0.0/0]"
      ```

  1. Создайте группу безопасности `k8s-ssh-access`, разрешающую подключение к узлам по SSH:

      ```bash
      yc vpc security-group create \
        --name k8s-ssh-access \
        --network-id <идентификатор_облачной_сети> \
        --rule "description=ssh-access,direction=ingress,protocol=tcp,port=22,v4-cidrs=[85.32.32.22/32]"
      ```  

  1. Создайте кластер и назначьте ему группы безопасности `k8s-cluster-nodegroup-traffic`, `k8s-cluster-traffic`:

      ```bash
      {{ yc-k8s }} cluster create \
        --name k8s-cluster \
        --network-id <идентификатор_облачной_сети> \
        --service-account-id <идентификатор_сервисного_аккаунта_для_кластера> \
        --node-service-account-id <идентификатор_сервисного_аккаунта_для_группы_узлов> \
        --cluster-ipv4-range 10.96.0.0/16 \
        --service-ipv4-range 10.112.0.0/16 \
        --public-ip \
        --master-location zone={{ region-id }}-a,subnet-id=<идентификатор_облачной_подсети_в_зоне_{{ region-id }}-a> \
        --master-location zone={{ region-id }}-b,subnet-id=<идентификатор_облачной_подсети_в_зоне_{{ region-id }}-b> \
        --master-location zone={{ region-id }}-d,subnet-id=<идентификатор_облачной_подсети_в_зоне_{{ region-id }}-d> \
        --security-group-ids <идентификатор_k8s-cluster-nodegroup-traffic>,<идентификатор_k8s-cluster-traffic>
      ```

      Идентификатор группы безопасности можно [получить](../../../vpc/operations/security-group-get-info.md) вместе с информацией о ней.

  1. Создайте группу узлов и назначьте ей группы безопасности `k8s-cluster-nodegroup-traffic`, `k8s-nodegroup-traffic`, `k8s-services-access`, `k8s-ssh-access`:

      ```bash
      {{ yc-k8s }} node-group create \
        --name worker-nodes-a \
        --cluster-id <идентификатор_кластера> \
        --location zone={{ region-id }}-a \
        --fixed-size 1 \
        --network-interface subnets=<идентификатор_подсети_в_зоне_{{ region-id }}-a>,ipv4-address=nat,security-group-ids=[<идентификатор_k8s-cluster-nodegroup-traffic>,<идентификатор_k8s-nodegroup-traffic>,<идентификатор_k8s-services-access>,<идентификатор_k8s-ssh-access>]
      ```

      Идентификатор группы безопасности можно [получить](../../../vpc/operations/security-group-get-info.md) вместе с информацией о ней.
    
- {{ TF }} {#tf}    

  1. Создайте группы безопасности с необходимыми правилами:

      ```hcl
      resource "yandex_vpc_security_group" "k8s-cluster-nodegroup-traffic" {
        name        = "k8s-cluster-nodegroup-traffic"
        description = "Правила группы разрешают служебный трафик для кластера и групп узлов. Примените ее к кластеру и группам узлов."
        network_id  = "<идентификатор_облачной_сети>"
        ingress {
          description       = "Правило для проверок состояния сетевого балансировщика нагрузки."
          from_port         = 0
          to_port           = 65535
          protocol          = "TCP"
          predefined_target = "loadbalancer_healthchecks"
        }
        ingress {
          description       = "Правило для входящего служебного трафика между мастером и узлами."
          from_port         = 0
          to_port           = 65535
          protocol          = "ANY"
          predefined_target = "self_security_group"
        }
        ingress {
          description    = "Правило для проверки работоспособности узлов с помощью ICMP-запросов из подсетей внутри {{ yandex-cloud }}."
          protocol       = "ICMP"
          v4_cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
        }
        egress {
          description       = "Правило для исходящего служебного трафика между мастером и узлами."
          from_port         = 0
          to_port           = 65535
          protocol          = "ANY"
          predefined_target = "self_security_group"
        }
      }

      resource "yandex_vpc_security_group" "k8s-nodegroup-traffic" {
        name        = "k8s-nodegroup-traffic"
        description = "Правила группы разрешают служебный трафик для групп узлов. Примените ее к группам узлов."
        network_id  = "<идентификатор_облачной_сети>"
        ingress {
          description    = "Правило для входящего трафика, разрешающее передачу трафика между подами и сервисами."
          from_port      = 0
          to_port        = 65535
          protocol       = "ANY"
          v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
        }
        egress {
          description    = "Правило для исходящего трафика, разрешающее узлам в группе узлов подключаться к внешним ресурсам."
          from_port      = 0
          to_port        = 65535
          protocol       = "ANY"
          v4_cidr_blocks = ["0.0.0.0/0"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-services-access" {
        name        = "k8s-services-access"
        description = "Правила группы разрешают подключение к сервисам из интернета. Примените ее к группам узлов."
        network_id  = "<идентификатор_облачной_сети>"
        ingress {
          description    = "Правило для входящего трафика, разрешающее подключение к сервисам."
          from_port      = 30000
          to_port        = 32767
          protocol       = "TCP"
          v4_cidr_blocks = ["0.0.0.0/0"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-ssh-access" {
        name        = "k8s-ssh-access"
        description = "Правила группы разрешают подключение к узлам по SSH. Примените ее к группам узлов."
        network_id  = "<идентификатор_облачной_сети>"
        ingress {
          description    = "Правило для входящего трафика, разрешающее подключение к узлам по SSH."
          port           = 22
          protocol       = "TCP"
          v4_cidr_blocks = ["85.32.32.22/32"]
        }
      }

      resource "yandex_vpc_security_group" "k8s-cluster-traffic" {
        name        = "k8s-cluster-traffic"
        description = "Правила группы разрешают трафик для кластера. Примените ее к кластеру."
        network_id  = "<идентификатор_облачной_сети>"
        ingress {
          description    = "Правило для входящего трафика, разрешающее доступ к API {{ k8s }} (порт 443)."
          port           = 443
          protocol       = "TCP"
          v4_cidr_blocks = ["203.0.113.0/24"]
        }
        ingress {
          description    = "Правило для входящего трафика, разрешающее доступ к API {{ k8s }} (порт 6443)."
          port           = 6443
          protocol       = "TCP"
          v4_cidr_blocks = ["203.0.113.0/24"]
        }
        egress {
          description    = "Правило для исходящего трафика, разрешающее передачу трафика между мастером и подами metric-server."
          port           = 4443
          protocol       = "TCP"
          v4_cidr_blocks = ["10.96.0.0/16"]
        }
        egress {
          description    = "Правило для исходящего трафика, разрешающее подключение мастера к NTP-серверам для синхронизации времени."
          port           = 123
          protocol       = "UDP"
          v4_cidr_blocks = ["0.0.0.0/0"]
        }
      }
      ```

  1. Создайте кластер с группой узлов и примените группы безопасности с правилами следующим образом:

      ```hcl
      resource "yandex_kubernetes_cluster" "k8s-cluster" {
        name = "k8s-cluster"
        service_account_id = "<идентификатор_сервисного_аккаунта_для_кластера>"
        node_service_account_id = "<идентификатор_сервисного_аккаунта_для_групп_узлов>"
        cluster_ipv4_range = "10.96.0.0/16"
        service_ipv4_range = "10.112.0.0/16"
        network_id = "<идентификатор_облачной_сети>"
        master {
          master_location {
            zone      = "{{ region-id }}-a"
            subnet_id = "<идентификатор_облачной_подсети_в_зоне>"
          }
          master_location {
            zone      = "{{ region-id }}-b"
            subnet_id = "<идентификатор_облачной_подсети_в_зоне>"
          }
          master_location {
            zone      = "{{ region-id }}-d"
            subnet_id = "<идентификатор_облачной_подсети_в_зоне>"
          }
          security_group_ids = [
            yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id,
            yandex_vpc_security_group.k8s-cluster-traffic.id
          ]
          public_ip = true
        }
      }

      resource "yandex_kubernetes_node_group" "worker-nodes-a" {
        cluster_id = yandex_kubernetes_cluster.k8s-cluster.id
        name       = "worker-nodes-a"
        allocation_policy {
          location {
            zone = "{{ region-id }}-a"
          }
        }
        scale_policy {
          fixed_scale {
            size = 1
          }
        }
        instance_template {
          network_interface {
            nat                = true
            subnet_ids         = [<идентификатор_облачной_подсети>]
            security_group_ids = [
              yandex_vpc_security_group.k8s-cluster-nodegroup-traffic.id,
              yandex_vpc_security_group.k8s-nodegroup-traffic.id,
              yandex_vpc_security_group.k8s-services-access.id,
              yandex_vpc_security_group.k8s-ssh-access.id
            ]
          }
        }
      }
      ```

{% endlist %}

### Группы безопасности для L7-балансировщика {{ alb-name }} и кластера {{ managed-k8s-name }} {#alb-example}

Пусть необходимо создать правила для следующих условий:

* Требуется развернуть в трех подсетях балансировщик с [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses), принимающий HTTPS-трафик. CIDR подсетей — `10.128.0.0/24`, `10.129.0.0/24` и `10.130.0.0/24`.
* При создании кластера были указаны CIDR кластера `10.96.0.0/16` и CIDR сервисов `10.112.0.0/16`.
* Группа узлов в кластере расположена в подсети, имеющей CIDR `10.140.0.0/24`.
* [Подключаться](../../../managed-kubernetes/operations/node-connect-ssh.md) к узлам по [SSH](../../../glossary/ssh-keygen.md) и управлять кластером через [API](../../../glossary/rest-api.md), `kubectl` и другие утилиты можно только из CIDR `203.0.113.0/24`.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    {% include [terraform-security-groups-example](../../../_includes/application-load-balancer/tf-security-groups-example.md) %}

{% endlist %}
