# Настройка IPSec-шлюзов для подключения внешних узлов к кластеру

Сервис Yandex Managed Service for Kubernetes позволяет подключать в качестве узлов [кластера Kubernetes](../concepts/index.md#kubernetes-cluster) серверы, расположенные вне Yandex Cloud. Для подключения необходимо организовать сетевую связность между удаленной сетью, в которой расположен внешний сервер, и [облачной сетью](../../vpc/concepts/network.md#network), в которой находится кластер Managed Service for Kubernetes. Это можно сделать с помощью [VPN](../../glossary/vpn.md).

Ниже рассматривается пример организации сетевой связности с помощью протокола [IPSec](../../glossary/ipsec.md).

Схема решения:

![external-nodes-connect](../../_assets/tutorials/external-nodes-connect/external-nodes-connect.svg)

На схеме внешний узел кластера Kubernetes и VPN клиент расположены в удаленной сети вне Yandex Cloud.

Для простоты тестирования в приведенном ниже решении в качестве удаленной площадки выступает отдельная [облачная сеть](../../vpc/concepts/network.md#network) Yandex Virtual Private Cloud, а в качестве VPN клиента — [виртуальная машина](../../compute/concepts/vm.md) Yandex Compute Cloud, расположенная в этой облачной сети.

## Перед началом работы {#before-you-begin}

1. [Создайте](../../vpc/operations/network-create.md) основную облачную сеть с тремя [подсетями](../../vpc/concepts/network.md#subnet) в разных зонах доступности.

    {% note warning %}
    
    Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
    
    {% endnote %}

1. В основной сети [создайте](kubernetes-cluster/kubernetes-cluster-create.md) кластер Managed Service for Kubernetes с [высокодоступным](../concepts/index.md#master) типом мастера.

    Для создания внешней группы узлов кластер Managed Service for Kubernetes должен работать в [туннельном режиме](../concepts/network-policy.md#cilium). Он включается только при создании кластера.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

1. В основной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину Compute Cloud с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses) и назовите ее `VM-1`. На этой ВМ будет настроен основной IPSec-шлюз.

1. [Создайте](../../vpc/operations/network-create.md) дополнительную облачную сеть с одной подсетью.

1. В дополнительной сети [создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину Compute Cloud с публичным IP-адресом и назовите ее `VM-2`. На этой ВМ будет настроен дополнительный IPSec-шлюз.

## Настройка групп безопасности {#sg}

1. В основной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности и назначьте ее `VM-1`. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила:

    {% list tabs group=traffic %}

    - Исходящий трафик {#outgoing}

      Описание | Диапазон портов | Протокол | Назначение | CIDR блоки
      --- | --- | --- | --- | ---
      `any` | `0-65535` | `Любой` | `CIDR` | `0.0.0.0/0`

    - Входящий трафик {#incoming}
      
      Описание | Диапазон портов | Протокол | Источник | CIDR блоки
      --- | --- | --- | --- | ---
      `icmp` | `0-65535` | `ICMP` | `CIDR` | `0.0.0.0/0`
      `ssh` | `22` | `TCP`  | `CIDR` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `CIDR` | `<публичный_адрес_VM-2>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `CIDR` | `<публичный_адрес_VM-2>/32`
      `VM-2-subnet` | `0-65535` | `Любой` | `CIDR` | `<CIDR_подсети_VM-2>`

    {% endlist %}

1. В дополнительной сети [создайте](../../vpc/operations/security-group-create.md) группу безопасности и назначьте ее `VM-2`. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу правила:

    {% list tabs group=traffic %}

    - Исходящий трафик {#outgoing}

      Описание | Диапазон портов | Протокол | Назначение | CIDR блоки
      --- | --- | --- | --- | ---
      `any` | `0-65535` | `Любой` | `CIDR` | `0.0.0.0/0`

    - Входящий трафик {#incoming}

      Описание | Диапазон портов | Протокол | Источник | CIDR блоки
      --- | --- | --- | --- | --- 
      `icmp` | `0-65535` | `ICMP` | `CIDR` | `0.0.0.0/0`
      `ssh` | `22`   | `TCP` | `CIDR` | `0.0.0.0/0`
      `ipsec-udp-500` | `500` | `UDP` | `CIDR` | `<публичный_адрес_VM-1>/32`
      `ipsec-udp-4500` | `4500` | `UDP` | `CIDR` | `<публичный_адрес_VM-1>/32`
      `k8s-VM-1-subnets` | `0-65535` | `Любой` | `CIDR` | `<CIDR_основной_подсети1>`, `<CIDR_основной_подсети2>`, `<CIDR_основной_подсети3>`
      `cluster&services` | `0-65535` | `Любой` | `CIDR` | `<CIDR_кластера>`, `<CIDR_сервисов>`

    {% endlist %}

1. В группу безопасности кластера и групп узлов Managed Service for Kubernetes [добавьте](../../vpc/operations/security-group-add-rule.md) правило:

    {% list tabs group=traffic %}

    - Входящий трафик {#incoming}

      Описание | Диапазон портов | Протокол | Источник | CIDR блоки
      --- | --- | --- | --- | ---
      `VM-2-subnet` | `0-65535` | `Любой` | `CIDR` | `<CIDR_подсети_VM-2>` 

    {% endlist %}

## Настройка маршрутизации {#rt}

1. Настройте маршрутизацию для основного IPSec-шлюза:

   1. В основной сети [создайте таблицу маршрутизации и добавьте в нее статический маршрут](../../vpc/operations/static-route-create.md):

      * **Префикс назначения** — укажите CIDR подсети, где расположена `VM-2`.
      * **IP-адрес** — укажите внутренний IP-адрес `VM-1`.

   1. Привяжите таблицу маршрутизации ко всем подсетям основной сети.

1. Настройте маршрутизацию для дополнительного IPSec-шлюза:

   1. В дополнительной сети создайте таблицу маршрутизации.

   1. Добавьте для таблицы маршрутизации статический маршрут:

      * **Префикс назначения** — укажите CIDR подсети, где расположена `VM-1`.
      * **IP-адрес** — укажите внутренний IP-адрес `VM-2`.

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

1. [Подключите](external-nodes-connect.md) `VM-2` к кластеру Managed Service for Kubernetes в качестве внешнего узла.

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