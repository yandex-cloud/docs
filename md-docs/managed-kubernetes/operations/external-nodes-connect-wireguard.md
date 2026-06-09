# Настройка WireGuard-шлюзов для подключения внешних узлов к кластеру

Сервис {{ managed-k8s-full-name }} позволяет подключать в качестве узлов [кластера {{ k8s }}](../concepts/index.md#kubernetes-cluster) серверы, расположенные вне {{ yandex-cloud }}. Для подключения необходимо организовать сетевую связность между удаленной сетью, в которой расположен внешний сервер, и [облачной сетью](../../vpc/concepts/network.md#network), в которой находится кластер {{ managed-k8s-name }}. Это можно сделать с помощью [VPN](../../glossary/vpn.md).

Ниже рассматривается пример организации сетевой связности с помощью протокола [WireGuard](https://www.wireguard.com).

Схема решения:

![external-nodes-connect](../../_assets/tutorials/external-nodes-connect/external-nodes-connect.svg)

На схеме внешний узел кластера {{ k8s }} и VPN клиент расположены в удаленной сети вне {{ yandex-cloud }}.

Для простоты тестирования в приведенном ниже решении в качестве удаленной площадки выступает отдельная [облачная сеть](../../vpc/concepts/network.md#network) {{ vpc-full-name }}, а в качестве VPN клиента — [виртуальная машина](../../compute/concepts/vm.md) {{ compute-full-name }}, расположенная в этой облачной сети.

## Перед началом работы {#before-you-begin}

1. [Создайте](../../vpc/operations/network-create.md) основную облачную сеть с тремя [подсетями](../../vpc/concepts/network.md#subnet) в разных зонах доступности.

1. В основной сети [создайте](kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }} с [высокодоступным](../concepts/index.md#master) типом мастера.

    Для создания внешней группы узлов кластер {{ managed-k8s-name }} должен работать в [туннельном режиме](../concepts/network-policy.md#cilium). Он включается только при создании кластера.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

1. В основной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину {{ compute-name }} с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses) и назовите ее `VM-1`. На этой ВМ будет настроен основной WireGuard-шлюз.

1. [Создайте](../../vpc/operations/network-create.md) дополнительную облачную сеть с одной подсетью.

1. В дополнительной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину {{ compute-name }} с публичным IP-адресом и назовите ее `VM-2`. На этой ВМ будет настроен дополнительный WireGuard-шлюз.

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
      `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `wireguard` | `51821` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-2>/32`
      `VM-2-subnet` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<CIDR_подсети_VM-2>`
      
    {% endlist %}

1. В дополнительной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности и назначьте ее `VM-2`. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила:

    {% list tabs group=traffic %}

    - Исходящий трафик {#outgoing}

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `any` | `{{ port-any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      
    - Входящий трафик {#incoming}
      
      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | --- | ---
      `icmp` | `{{ port-any }}` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `ssh` | `22` | `TCP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
      `wireguard` | `51822` | `UDP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_адрес_VM-1>/32`
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

1. Настройте маршрутизацию для основного WireGuard-шлюза:

   1. В основной сети [создайте таблицу маршрутизации и добавьте в нее статический маршрут](../../vpc/operations/static-route-create.md):

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** — укажите CIDR подсети, где расположена `VM-2`.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** — укажите внутренний IP-адрес `VM-1`.

   1. Привяжите таблицу маршрутизации ко всем подсетям основной сети.

1. Настройте маршрутизацию для дополнительного WireGuard-шлюза:

   1. В дополнительной сети создайте таблицу маршрутизации.

   1. Добавьте для таблицы маршрутизации статический маршрут:

      * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** — укажите CIDR подсети, где расположена `VM-1`.
      * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** — укажите внутренний IP-адрес `VM-2`.

      Повторите этот шаг для каждой подсети основной сети.

   1. Привяжите таблицу маршрутизации к подсети, в которой расположена `VM-2`.

## Настройка WireGuard-шлюзов {#gw}

1. Настройте основной WireGuard-шлюз:

    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к `VM-1` по [SSH](../../glossary/ssh-keygen.md).

    1. Установите WireGuard:

        ```bash
        sudo apt update && sudo apt install wireguard
        ```

    1. Сгенерируйте и сохраните ключи шифрования:

        ```
        wg genkey | sudo tee vm1_private.key | wg pubkey | sudo tee vm1_public.key > /dev/null
        wg genkey | sudo tee vm2_private.key | wg pubkey | sudo tee vm2_public.key > /dev/null
        ```
       В текущей директории будут созданы четыре файла:

          * `vm1_private.key` — содержит закрытый ключ шифрования для `VM-1`.
          * `vm1_public.key` — содержит открытый ключ шифрования для `VM-1`.
          * `vm2_private.key` — содержит закрытый ключ шифрования для `VM-2`.
          * `vm2_public.key` — содержит открытый ключ шифрования для `VM-2`.

    1. Создайте конфигурационный файл `wg0.conf`:

        ```bash
        sudo nano /etc/wireguard/wg0.conf
        ```

    1. Добавьте в него конфигурацию:

        ```text
        [Interface]
        PrivateKey = <содержимое_файла_vm1_private.key>
        Address = 10.0.0.1/32
        ListenPort = 51821

        PreUp = sysctl -w net.ipv4.ip_forward=1

        [Peer]
        PublicKey = <содержимое_файла_vm2_public.key>
        Endpoint = <публичный_адрес_VM-2>:51822
        AllowedIPs = <CIDR_подсети_VM-2>, 10.0.0.2/32
        PersistentKeepalive = 15
        ```
  
       [Подробнее о параметрах конфигурации](https://www.procustodibus.com/blog/2020/12/wireguard-site-to-site-config).

       Сохраните изменения и закройте файл.

    1. Примените конфигурацию:

        ```bash
        sudo systemctl restart wg-quick@wg0
        ```

1. Настройте дополнительный WireGuard-шлюз:

    1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к `VM-2` по [SSH](../../glossary/ssh-keygen.md).

    1. Установите WireGuard:

        ```bash
        sudo apt update && sudo apt install wireguard
        ```

    1. Создайте конфигурационный файл `wg0.conf`:

        ```bash
        sudo nano /etc/wireguard/wg0.conf
        ```

    1. Добавьте в него конфигурацию:

        ```text
        [Interface]
        PrivateKey = <содержимое_файла_vm2_private.key>
        Address = 10.0.0.2/32
        ListenPort = 51822

        PreUp = sysctl -w net.ipv4.ip_forward=1

        [Peer]
        PublicKey = <содержимое_файла_vm1_public.key>
        Endpoint = <публичный_адрес_VM-1>:51821
        AllowedIPs = <CIDR_основной_подсети1>, <CIDR_основной_подсети2>, <CIDR_основной_подсети3>, 10.0.0.1/32
        PersistentKeepalive = 15
        ```

       [Подробнее о параметрах конфигурации](https://www.procustodibus.com/blog/2020/12/wireguard-site-to-site-config).

       Сохраните изменения и закройте файл.

    1. Примените конфигурацию:

        ```bash
        sudo systemctl restart wg-quick@wg0
        ```

1. Проверьте статус соединения на обеих ВМ:

   ```bash
   sudo wg show
   ```

    `latest handshake` в выводе команды означает, что соединение установлено: 

    ```text
    ...
    latest handshake: 3 seconds ago
    ...
    ```

1. Настройте [MTU](../../vpc/concepts/mtu-mss.md) на обеих ВМ:
   
      ```bash
      ETH_NIC=eth0
      sudo iptables -t mangle -A FORWARD -i ${ETH_NIC} -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
      sudo iptables -t mangle -A FORWARD -o ${ETH_NIC} -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
      echo "net.ipv4.ip_no_pmtu_disc = 1" | sudo tee -a /etc/sysctl.conf
      sudo sysctl -p /etc/sysctl.conf
      ``` 
   
     {% note warning %}
   
     Если оставить значение MTU по умолчанию, возможны потери сетевого трафика.
   
     {% endnote %}

1. [Подключите](external-nodes-connect.md) `VM-2` к кластеру {{ managed-k8s-name }} в качестве внешнего узла.

## Решение проблем {#troubleshooting}

### Ошибка при работе с пакетами `docker-ce` и `containerd` на внешнем узле {#docker-containerd}

Чтобы диагностировать и исправить ошибку:

1. Посмотрите список служб, которые работают некорректно:

   ```bash
   sudo systemctl --failed
   ```

   Результат:

   ```text
   UNIT LOAD ACTIVE SUB DESCRIPTION
   docker.socket loaded failed failed Docker Socket for the API
   LOAD = Reflects whether the unit definition was properly loaded.
   ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
   SUB = The low-level unit activation state, values depend on unit type.
   1 loaded units listed.
   ```

1. Проверьте состояние `docker.socket`:

   ```bash
   sudo systemctl status docker.socket
   ```

   Результат:

   ```text
   docker.socket - Docker Socket for the API
   Loaded: loaded (/lib/systemd/system/docker.socket; disabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Tue 2024-02-10 09:53:37 UTC; 6s ago
   Triggers: ● docker.service
   Listen: /run/docker.sock (Stream)
   CPU: 1ms
   Feb 10 09:53:37 ext-node systemd[1]: Starting Docker Socket for the API...
   Feb 10 09:53:37 ext-node systemd[7052]: docker.socket: Failed to resolve group docker: No such process
   Feb 10 09:53:37 ext-node systemd[1]: docker.socket: Control process exited, code=exited, status=216/GROUP
   Feb 10 09:53:37 ext-node systemd[1]: docker.socket: Failed with result 'exit-code'.
   Feb 10 09:53:37 ext-node systemd[1]: Failed to listen on Docker Socket for the API.
   ```

1. Посмотрите ошибки в системных логах:

   ```bash
   sudo journalctl -xe
   ```

   Результат:

   ```bash
   ...
   Feb 10 09:56:40 ext-node maintainer[19298]: E: Sub-process /usr/bin/dpkg returned an error code (1)
   ...
   ```

1. Переустановите пакеты и исправьте ошибки:

   ```bash
   sudo apt install -f
   ```

1. Когда установщик спросит, что делать с файлом `config.toml`, введите `N`, чтобы оставить текущую версию файла.