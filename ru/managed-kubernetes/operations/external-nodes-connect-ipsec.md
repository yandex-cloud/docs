---
title: Как настроить IPSec-шлюзы для подключения внешних узлов к кластеру {{ managed-k8s-name }}
description: Следуя данной инструкции, вы сможете настроить IPSec-шлюзы для подключения внешних узлов к кластеру {{ managed-k8s-name }}
---

# Настройка IPSec-шлюзов для подключения внешних узлов к кластеру

Сервис {{ managed-k8s-full-name }} позволяет подключать в качестве узлов [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) серверы, расположенные вне {{ yandex-cloud }}. Для подключения необходимо организовать сетевую связность между удаленной сетью, в которой расположен внешний сервер, и [облачной сетью](../../vpc/concepts/network.md#network), в которой находится кластер {{ managed-k8s-name }}. Это можно сделать с помощью [VPN](../../glossary/vpn.md).

Ниже рассматривается пример организации сетевой связности с помощью протокола [IPSec](../../glossary/ipsec.md). В роли внешнего сервера выступает виртуальная машина, расположенная в другой облачной сети {{ yandex-cloud }}.

## Перед началом работы {#before-you-begin}

1. [Создайте](../../vpc/operations/network-create.md) основную облачную сеть с тремя [подсетями](../../vpc/concepts/network.md#subnet) в разных зонах доступности.

1. В основной сети [создайте](kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }} с [высокодоступным](../../managed-kubernetes/concepts/index.md#master) типом мастера.

    Для создания внешней группы узлов кластер {{ managed-k8s-name }} должен работать в [туннельном режиме](../concepts/network-policy.md#cilium). Он включается только при создании кластера.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. В основной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину {{ compute-name }} с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses) и назовите ее `VM-1`. На этой ВМ будет настроен основной IPSec-шлюз.

1. [Создайте](../../vpc/operations/network-create.md) дополнительную облачную сеть с одной подсетью.

1. В дополнительной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину {{ compute-name }} с публичным IP-адресом и назовите ее `VM-2`. На этой ВМ будет настроен дополнительный IPSec-шлюз.

## Настройка групп безопасности {#sg}

1. В основной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности и назначьте ее `VM-1`. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила:

    {% list tabs group=traffic %}

    - Исходящий трафик {#outgoing}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `any` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

    - Входящий трафик {#incoming}
      
      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `icmp` | `{{ port-any }}` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ssh` | `22` | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-2>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-2>/32`
      `VM-2-subnet` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_подсети_VM-2>`

    {% endlist %}

1. В дополнительной сети [создайте](../../vpc/operations/security-group-create) группу безопасности и назначьте ее `VM-2`. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила:

    {% list tabs group=traffic %}

    - Исходящий трафик {#outgoing}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `any` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

    - Входящий трафик {#incoming}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | --- 
      `icmp` | `{{ port-any }}` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ssh` | `22`   | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-1>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-1>/32`
      `k8s-VM-1-subnets` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_основной_подсети1>`, `<CIDR_основной_подсети2>`, `<CIDR_основной_подсети3>`
      `cluster&services` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_кластера>`, `<CIDR_сервисов>`

    {% endlist %}

1. В группу безопасности кластера и групп узлов {{ managed-k8s-name }} [добавьте](../../vpc/operations/security-group-add-rule.md) правило:

    {% list tabs group=traffic %}

    - Входящий трафик {#incoming}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `VM-2-subnet` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_подсети_VM-2>` 

    {% endlist %}

## Настройка маршрутизации {#rt}

1. Настройте маршрутизацию для основного IPSec-шлюза:

   1. В основной сети [создайте таблицу маршрутизации и добавьте в нее статический маршрут](../../vpc/operations/static-route-create.md):

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** — укажите CIDR подсети, где расположена `VM-2`.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** — укажите внутренний IP-адрес `VM-1`.

   1. Привяжите таблицу маршрутизации ко всем подсетям основной сети.

1. Настройте маршрутизацию для дополнительного IPSec-шлюза:

   1. В дополнительной сети создайте таблицу маршрутизации.

   1. Добавьте для таблицы маршрутизации статический маршрут:

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** — укажите CIDR подсети, где расположена `VM-1`.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** — укажите внутренний IP-адрес `VM-2`.

      Повторите этот шаг для каждой подсети основной сети.

   1. Привяжите таблицу маршрутизации к подсети, в которой расположена `VM-2`.

## Настройка IPSec-шлюзов {#gw}

1. Настройте основной IPSec-шлюз:

    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к `VM-1` по [SSH](../../glossary/ssh-keygen.md).

    1. Установите strongSwan:

        ```bash
        sudo apt update && sudo apt install strongswan
        ```

    1. Откройте файл конфигурации `ipsec.conf`:

        ```bash
        sudo nano /etc/ipsec.conf
        ```

    1. Замените содержимое файла следующим текстом:

        ```text
        # basic configuration

        config setup
          charondebug="all"
          uniqueids=yes

        conn VM-1
          type=tunnel
          auto=route
          keyexchange=ikev2
          ike=aes256-sha2_256-modp2048!
          esp=aes256-sha2_256!
          authby=secret
          left=<внутренний_адрес_VM-1>
          leftsubnet=<CIDR_основной_подсети1>,<CIDR_основной_подсети2>,<CIDR_основной_подсети3>
          leftsourceip=<внутренний_адрес_VM-1>
          leftid=<публичный_адрес_VM-1>
          right=<публичный_адрес_VM-2>
          rightsubnet=<CIDR_подсети_VM-2>
          aggressive=no
          keyingtries=%forever
          ikelifetime=86400s
        ```

        Подробнее о параметрах см. в [документации strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki/connsection).

    1. Откройте файл `ipsec.secrets`, который используется для аутентификации:

       ```bash
       sudo nano /etc/ipsec.secrets
       ```

    1. Замените содержимое файла следующим текстом:

       ```text
       <публичный_адрес_VM-1> <публичный_адрес_VM-2> : PSK "<пароль>"
       ```

       Подробнее о формате файла `ipsec.secrets` см. в [документации strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki/Ipsecsecrets).

1. Настройте дополнительный IPSec-шлюз:

    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к `VM-2` по [SSH](../../glossary/ssh-keygen.md).

    1. Установите [strongSwan](https://docs.strongswan.org/docs/latest/howtos/introduction.html):

        ```bash
        sudo apt update && sudo apt install strongswan
        ```

    1. Откройте файл конфигурации `ipsec.conf`:

        ```bash
        sudo nano /etc/ipsec.conf
        ```

    1. Замените содержимое файла следующим текстом:

        ```text
        # basic configuration

        config setup
          charondebug="all"

        conn VM-2
          type=tunnel
          auto=route
          keyexchange=ikev2
          ike=aes256-sha2_256-modp2048!
          esp=aes256-sha2_256!
          authby=secret
          left=<внутренний_адрес_VM-2>
          leftid=<публичный_адрес_VM-2>
          leftsubnet=<CIDR_подсети_VM-2>
          right=<публичный_адрес_VM-1>
          rightsubnet=<CIDR_основной_подсети1>,<CIDR_основной_подсети2>,<CIDR_основной_подсети3>
          rightsourceip=<внутренний_адрес_VM-1>
          aggressive=no
          keyingtries=%forever
          ikelifetime=86400s
          lifetime=43200s
          lifebytes=576000000
          dpddelay=30s
        ```

        Подробнее о параметрах см. в [документации strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki/connsection).

    1. Откройте файл `ipsec.secrets`, необходимый для аутентификации:

       ```bash
       sudo nano /etc/ipsec.secrets
       ```

    1. Замените содержимое файла следующим текстом:

       ```text
       <публичный_адрес_VM-2> <публичный_адрес_VM-1> : PSK "<пароль>"
       ```

       Пароли должны быть одинаковыми на обеих ВМ.

       Подробнее о формате файла `ipsec.secrets` см. в [документации strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki/Ipsecsecrets). 

1. Перезапустите strongSwan на обеих ВМ:

   ```bash
   sudo ipsec restart
   ```

1. Проверьте статус соединения на обеих ВМ:

   ```bash
   sudo ipsec statusall
   ```

   `ESTABLISHED` в выводе команды означает, что соединение установлено:

   ```text
   ...
   Security Associations (1 up, 0 connecting):
        VM-1[1]: ESTABLISHED 5 seconds ago, 10.128.*.**[46.21.***.***]...84.201.***.***[84.201.***.***]
   ...
   ```

   Если соединение не установилось, попробуйте запустить его вручную. На `VM-1` выполните команду:

    ```bash
    sudo ipsec up VM-1
    ```

   Эту команду достаточно выполнить только на одной из ВМ.

1. {% include [mtu](../../_includes/managed-kubernetes/ext-nodes-vpn-mtu.md) %}

1. [Подключите](../../managed-kubernetes/operations/external-nodes-connect.md) `VM-2` к кластеру {{ managed-k8s-name }} в качестве внешнего узла.

## Решение проблем {#troubleshooting}

{% include [docker-containerd-error](../../_includes/managed-kubernetes/ext-nodes-vpn-error.md) %}