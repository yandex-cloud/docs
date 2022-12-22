Если у вас есть собственные корпоративные сети, связанные с внутренними сетями в вашем облаке {{ yandex-cloud }} (например, с помощью [сервиса {{ interconnect-name }}](../../interconnect/concepts/index.md)), то можно интегрировать сервис {{ dns-name }} с корпоративным DNS. Это позволит обращаться к ресурсам и сервисам по имени независимо от их расположения: в корпоративной или облачной сетях.

Делегировать управление DNS-записями во [внутренних зонах](../../dns/concepts/dns-zone.md#private-zones) {{ yandex-cloud }} вашим DNS-серверам в корпоративной сети не получится, т. к. NS-записи для внутренней зоны игнорируются. Для того, чтобы распознавание имен сервисов и ресурсов в облачных сетях выполнялось при использовании внутренних зон, настройте отдельные DNS-форвардеры в облачных подсетях. _DNS-форвардеры_ — серверы DNS, которые по-разному перенаправляют запросы в зависимости от имени, указанного в запросе.

{% note info %}

Далее в качестве примера таких серверов взяты широко известные [CoreDNS](https://coredns.io/) и [unbound](https://www.nlnetlabs.nl/projects/unbound/). Вы можете использовать любой другой DNS-форвардер.

{% endnote %}

Чтобы настроить распознавание имен корпоративных сервисов и ресурсов в облачных сетях {{ yandex-cloud }}:

* [Ознакомьтесь с описанием примера интеграции](#network-desc).
* [Настройте DNS в облаке](#setup-cloud-dns).
* [Настройте корпоративные серверы DNS](#setup-on-prem-dns).
* [Проверьте работу сервиса](#check-dns-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Пример интеграции {#network-desc}

![DNS integration example](../../_assets/dns/dns-integration.svg "DNS integration example")

1. Корпоративная сеть состоит из двух подсетей: `172.16.1.0/24` и `172.16.2.0/24`.

1. В этих подсетях размещено по одному DNS-серверу:

    * `172.16.1.5`: ns1.corp.example.net
    * `172.16.2.5`: ns2.corp.example.net
   
    Эти серверы обслуживают зону corp.example.net.

1. Облачная сеть {{ yandex-cloud }} также состоит из двух подсетей:

   * `172.16.3.0/24`: subnet3, зона доступности `{{ region-id }}-a`
   * `172.16.4.0/24`: subnet4, зона доступности `{{ region-id }}-b`

    В этих подсетях размещены DNS-серверы {{ yandex-cloud }}: `172.16.3.2` и `172.16.4.2`.

    Эти серверы обслуживают [внутренние зоны DNS в облачной сети](../../dns/concepts/dns-zone.md).

1. Корпоративная и облачная сети связаны между собой так, что все подсети одной сети доступны из подсетей другой сети и наоборот.

Далее будут настроены два DNS-форвардера в облачной сети:

* `172.16.3.5`: forwarder1.internal
* `172.16.4.5`: forwarder2.internal

Они будут перенаправлять DNS-запросы следующим образом:

* Запросы к зоне `corp.example.net` — через корпоративные DNS-серверы `172.16.1.5` и `172.16.2.5`.
* Все прочие запросы (к зоне `.`) — через внутренние DNS-серверы {{ yandex-cloud }}, соответствующим подсетям: `172.16.3.2` и `172.16.4.2`.

Для обеспечения отказоустойчивости работы DNS-форвардеров, они будут размещены за [внутренним сетевым балансировщиком](../../network-load-balancer/concepts/index.md) {{ network-load-balancer-full-name }}. Все запросы к DNS-форвардерам (как из облачной сети, так и из корпоративной сети) будут выполняться через этот балансировщик.

## Перед началом работы {#before-you-begin}

1. Для установки DNS-форвардеров в каждой из облачных подсетей `subnet3` и `subnet4` [создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа Ubuntu 20.04 с параметрами:

    * **Имя**:
        * `forwarder1` — для ВМ в подсети `subnet3`;
        * `forwarder2` — для ВМ в подсети `subnet4`.
    * В блоке **Сетевые настройки**:
      * **Публичный адрес**: без адреса.
      * **Внутренний адрес**: выберите **Вручную** и укажите:
        * 172.16.3.5 — для ВМ `forwarder1`;
        * 172.16.4.5 — для ВМ `forwarder2`.

1. Для подключения из интернета и проверки сервиса в подсети `subnet4` создайте еще одну ВМ из публичного образа Ubuntu 20.04 с параметрами:

    * **Имя**: `test1`.
    * В блоке **Сетевые настройки**:
      * **Публичный адрес**: Автоматически.
      * **Внутренний адрес**: Автоматически.

1. Для установки ПО из интернета в подсетях `subnet3` и `subnet4` [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

## Настройте DNS в облаке {#setup-cloud-dns}

1. [Установите DNS-форвардеры](#setup-dns-forwarders).
1. [Настройте сетевой балансировщик](#setup-cloud-balancer).
1. [Настройте сервис DHCP](#setup-cloud-dhcp).

### Установите DNS-форвардеры {#setup-dns-forwarders}

{% list tabs %}

* CoreDNS

  1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh) для установки DNS-форвардера через промежуточную ВМ `test1`.

  1. Скачайте актуальную версию `CoreDNS` со [страницы производителя](https://github.com/coredns/coredns/releases/latest) и установите ее:

      ```bash
      cd /var/tmp && wget <URL пакета> -O - | tar -zxvf
      sudo mv coredns /usr/local/sbin
      ```

  1. Создайте файл конфигурации `CoreDNS`:

      ```bash
      sudo mkdir /etc/coredns
      sudo tee /etc/coredns/Corefile
      <скопируйте блок Corefile>
      ```

      `Corefile для forwarder1`

      ```text
      corp.example.net {
        forward . 172.16.1.5 172.16.2.5
      }
      . {
        forward . 172.16.3.2
        health
      }
      ```

      `Corefile для forwarder2`

      ```text
      corp.example.net {
        forward . 172.16.1.5 172.16.2.5
      }
      . {
        forward . 172.16.4.2
        health
      }
      ```

      {% endcut %}

  1. Настройте автоматический запуск `CoreDNS`:

      ```bash
      sudo tee /etc/systemd/system/coredns.service
      <скопируйте блок coredns.service>
      sudo systemctl enable --now coredns
      ```

      {% cut "coredns.service" %}

      ```text
      [Unit]
      Description=CoreDNS
      After=network.target

      [Service]
      User=root
      ExecStart=/usr/local/sbin/coredns -conf /etc/coredns/Corefile
      StandardOutput=append:/var/log/coredns.log
      StandardError=append:/var/log/coredns.log
      RestartSec=5
      Restart=always

      [Install]
      WantedBy=multi-user.target
      ```

      {% endcut %}

  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. В Ubuntu 20.04 это можно сделать командами:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

* unbound
    
  1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh) DNS-форвардера через промежуточную ВМ `test1`.
  1. Установите пакет `unbound`:

      ```bash
      sudo apt update && sudo apt install --yes unbound
      ```

  1. Настройте и перезапустите DNS-форвардер:

      ```bash
      sudo tee --append /etc/unbound/unbound.conf
      <скопируйте блок unbound.conf>
      sudo systemctl restart unbound
      ```

      {% cut "unbound.conf для forwarder1" %}

      ```text
      server:
        module-config: "iterator"
        interface: 0.0.0.0
        access-control: 127.0.0.0/8   allow
        access-control: 172.16.0.0/21 allow

      forward-zone:
        name: "corp.example.net"
        forward-addr: 172.16.1.5
        forward-addr: 172.16.2.5

      forward-zone:
        name: "."
        forward-addr: 172.16.3.2
      ```

      {% endcut %}

      {% cut "unbound.conf для forwarder2" %}

      ```text
      server:
        module-config: "iterator"
        interface: 0.0.0.0
        access-control: 127.0.0.0/8   allow
        access-control: 172.16.0.0/21 allow

      forward-zone:
        name: "corp.example.net"
        forward-addr: 172.16.1.5
        forward-addr: 172.16.2.5

      forward-zone:
        name: "."
        forward-addr: 172.16.4.2
      ```

      {% endcut %}

  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. В Ubuntu 20.04 это можно сделать командами:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

{% endlist %}

### Настройте сетевой балансировщик {#setup-cloud-balancer}

Создайте [сетевой балансировщик](../../network-load-balancer/operations/internal-lb-create.md) с параметрами:

* **Тип**: **Внутренний**.

* В блоке **Обработчики**:
  * **Подсеть**: выберите `subnet3` из списка.
  * **Протокол**: **UDP**.
  * **Порт**: `53`.
  * **Целевой порт**: `53`.

* В блоке **Целевые группы**:
  * Создайте группу, состоящую из хостов `forwarder1` и `forwarder2`.
  * В блоке **Проверка состояния** укажите параметры:

    {% list tabs %}

    * CoreDNS
      * Тип: `HTTP`.
      * Путь: `/health`.
      * Порт: `8080`.

    * unbound
      * Тип: `TCP`.
      * Порт: `53`.

    {% endlist %}

При создании балансировщика ему будет автоматически назначен IP-адрес из подсети `subnet3`.

{% note info %}

Внутренний сетевой балансировщик не будет отвечать на DNS-запросы от форвардеров, из которых состоит его целевая группа: `forwarder1` и `forwarder2`. Это связано с особенностями реализации, подробнее см. в разделе [{#T}](../../network-load-balancer/concepts/internal-load-balancer.md).

{% endnote %}

### Настройте сервис DHCP {#setup-cloud-dhcp}

Чтобы хосты в облачной сети автоматически использовали корпоративный сервис DNS, в [настройках DHCP](../../vpc/concepts/dhcp-options.md) для подсетей `subnet3` и `subnet4` укажите:

1. **Адрес DNS-сервера**: IP-адрес, который был [назначен балансировщику](#setup-cloud-balancer).
1. (Опционально) **Доменное имя**: `corp.example.net`.

Чтобы обновить сетевые настройки на хостах `forwarder1`, `forwarder2` и `test1`, выполните команду:

```bash
sudo netplan apply
```

После обновления сетевых настроек хосты в облачной сети будут использовать балансировщик вместо сервера DNS {{ yandex-cloud }}.

## Настройте корпоративные серверы DNS {#setup-on-prem-dns}

Настройте корпоративные серверы так, чтобы DNS-запросы к [внутренним зонам {{ yandex-cloud }}](../../dns/concepts/dns-zone#private-zones) направлялись на IP-адрес, который был [назначен балансировщику](#setup-cloud-balancer).

## Проверьте работу сервиса {#check-dns-service}

1. Проверьте, что на облачных хостах `forwarder1`, `forwarder2` и `test1` выполняется распознавание имен во внутренней зоне `corp.example.net`:

    ```bash
    host ns1.corp.example.net
    ns1.corp.example.net has address 172.16.1.5
    ```

1. Проверьте, что на облачных хостах `forwarder1`, `forwarder2` и `test1` выполняется распознавание имен в публичных зонах, например:

    ```bash
    host cisco.com
    cisco.com has address 72.163.4.185
    ...
    ```
1. Проверьте, что на корпоративных DNS-серверах `ns1` и `ns2` выполняется распознавание внутренних имен {{ yandex-cloud }}, например:

    ```bash
    host ns.internal
    ns.internal has address 10.130.0.2
    ```

1. Чтобы убедиться, что сервисы запускаются автоматически, перезапустите ВМ `forwarder1`, `forwarder2` и `test1` и повторите проверки.

## Удалите неиспользуемые ресурсы {#clear-out}

* Если какие-либо из созданных ВМ вам больше не нужны, [удалите их](../../compute/operations/vm-control/vm-delete). 
* Удалите [целевые группы](../../network-load-balancer/operations/target-group-delete.md), [обработчики](../../network-load-balancer/operations/listener-remove.md) и [сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md).
