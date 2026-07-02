[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Практические руководства](index.md) > Интеграция с корпоративным сервисом DNS

# Интеграция Cloud DNS и корпоративного сервиса DNS

Если у вас есть собственные корпоративные сети, связанные с внутренними [сетями](../../vpc/concepts/network.md#network) в вашем [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) Yandex Cloud с помощью сервиса [Yandex Cloud Interconnect](../../interconnect/index.md), то можно интегрировать корпоративный DNS с [Cloud DNS](../index.md). Это позволит обращаться к ресурсам и сервисам по имени независимо от их расположения: в корпоративной или облачной сетях.

Делегировать управление DNS-записями во [внутренних зонах](../concepts/dns-zone.md#private-zones) Yandex Cloud вашим DNS-серверам в корпоративной сети не получится, так как NS-записи для внутренней DNS-зоны игнорируются. Чтобы распознавание имен сервисов и ресурсов в облачных сетях выполнялось при использовании внутренних зон, настройте отдельные DNS-форвардеры в облачных подсетях. _DNS-форвардеры_ — серверы DNS, которые по-разному перенаправляют запросы в зависимости от имени, указанного в запросе. Рекомендуем использовать [CoreDNS](https://coredns.io/) или [Unbound](https://www.nlnetlabs.nl/projects/unbound/).

{% note warning %}

Некоторые DNS-форвардеры сверяют расположение зон в Cloud DNS со своими настройками при валидации ответа. В этом случае необходимо указать в настройках только зоны, существующие в Cloud DNS. Например, если записи размещены в общей зоне `.`, настройте переадресацию для нее.

{% endnote %}

Чтобы настроить распознавание имен корпоративных сервисов и ресурсов в облачных сетях Yandex Cloud:

1. [Ознакомьтесь с описанием примера интеграции](#network-desc).
1. [Настройте DNS в облаке](#setup-cloud-dns).
1. [Настройте корпоративные серверы DNS](#setup-on-prem-dns).
1. [Проверьте работу сервиса](#check-dns-service).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Пример интеграции {#network-desc}

![DNS integration example](../../_assets/dns/dns-integration.svg "DNS integration example")

1. Корпоративная сеть состоит из двух [подсетей](../../vpc/concepts/network.md#subnet): `172.16.1.0/24` и `172.16.2.0/24`.

1. В этих подсетях размещено по одному DNS-серверу:

    * `172.16.1.5`: ns1.corp.example.net
    * `172.16.2.5`: ns2.corp.example.net
   
    Эти серверы обслуживают DNS-зону `corp.example.net`.

1. Облачная сеть Yandex Cloud также состоит из двух подсетей:

   * `172.16.3.0/24`: subnet3, [зона доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
   * `172.16.4.0/24`: subnet4, зона доступности `ru-central1-b`.

    В этих подсетях размещены DNS-серверы Yandex Cloud: `172.16.3.2` и `172.16.4.2`.

    Эти серверы обслуживают [внутренние DNS-зоны](../concepts/dns-zone.md#private-zones) в облачной сети.

1. Корпоративная и облачная сети связаны между собой так, что все подсети одной сети доступны из подсетей другой сети и наоборот.

Далее будут настроены два DNS-форвардера в облачной сети:

* `172.16.3.5`: forwarder1.internal
* `172.16.4.5`: forwarder2.internal

Они будут перенаправлять DNS-запросы следующим образом:

* Запросы к зоне `corp.example.net` — через корпоративные DNS-серверы `172.16.1.5` и `172.16.2.5`.
* Все прочие запросы (к зоне `.`) — через внутренние DNS-серверы Yandex Cloud, соответствующим подсетям: `172.16.3.2` и `172.16.4.2`.

Для обеспечения отказоустойчивости работы DNS-форвардеров, они будут размещены за [внутренним сетевым балансировщиком](../../network-load-balancer/concepts/nlb-types.md) Yandex Network Load Balancer. Все запросы к DNS-форвардерам (как из облачной сети, так и из корпоративной сети) будут выполняться через этот балансировщик.

## Перед началом работы {#before-you-begin}

1. Для установки DNS-форвардеров в каждой из облачных подсетей `subnet3` и `subnet4` [создайте виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) с параметрами:

    * **Имя**:
        * `forwarder1` — для ВМ в подсети `subnet3`;
        * `forwarder2` — для ВМ в подсети `subnet4`.
    * В блоке **Сетевые настройки**:
      * **Публичный IP-адрес**: `Без адреса`.
      * **Внутренний IPv4-адрес**: выберите `Вручную` и укажите:
        * 172.16.3.5 — для ВМ `forwarder1`;
        * 172.16.4.5 — для ВМ `forwarder2`.

1. Для подключения из интернета и проверки сервиса в подсети `subnet4` создайте еще одну ВМ из публичного образа [Ubuntu 20.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-20-04-lts) с параметрами:

    * **Имя**: `test1`.
    * В блоке **Сетевые настройки**:
      * **Публичный IP-адрес**: `Автоматически`.
      * **Внутренний IPv4-адрес**: `Автоматически`.
  
1. Для установки ПО из интернета в подсетях `subnet3` и `subnet4` [настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за постоянно запущенную виртуальную машину ([тарифы Yandex Compute Cloud](../../compute/pricing.md));
* плата за использование динамического или статического внешнего IP-адреса ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* плата за использование сетевого балансировщика ([тарифы Yandex Network Load Balancer](../../network-load-balancer/pricing.md)).

## Настройте DNS в облаке {#setup-cloud-dns}

1. [Установите DNS-форвардеры](#setup-dns-forwarders).
1. [Настройте сетевой балансировщик](#setup-cloud-balancer).
1. [Настройте сервис DHCP](#setup-cloud-dhcp).

### Установите DNS-форвардеры {#setup-dns-forwarders}

{% list tabs %}

- CoreDNS

  1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md) для установки DNS-форвардера через промежуточную ВМ `test1`.

  1. Скачайте актуальную версию `CoreDNS` со [страницы производителя](https://github.com/coredns/coredns/releases/latest) и установите ее:

      ```bash
      cd /var/tmp && wget <URL_пакета> -O - | tar -zxvf
      sudo mv coredns /usr/local/sbin
      ```

  1. Создайте файл конфигурации `CoreDNS`: 
     
     * `forwarder1`:

         ```bash
         sudo mkdir /etc/coredns
         sudo tee >> /etc/coredns/Corefile <<EOF
         corp.example.net {
           forward . 172.16.1.5 172.16.2.5
         }
         . {
           forward . 172.16.3.2
           health
         }
         EOF
         ```

     * `forwarder2`:

         ```bash
         sudo mkdir /etc/coredns
         sudo tee >> /etc/coredns/Corefile <<EOF
         corp.example.net {
           forward . 172.16.1.5 172.16.2.5
         }
         . {
           forward . 172.16.4.2
           health
         }
         EOF
         ```

  1. Настройте автоматический запуск `CoreDNS`:

      ```bash
      sudo tee >> /etc/systemd/system/coredns.service <<EOF
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
      EOF
      sudo systemctl enable --now coredns
      ```

  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. В Ubuntu 20.04 это можно сделать командами:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

- Unbound

  1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md) DNS-форвардера через промежуточную ВМ `test1`.
  1. Установите пакет `unbound`:

      ```bash
      sudo apt update && sudo apt install --yes unbound
      ```

  1. Настройте и перезапустите DNS-форвардер:

      {% cut "unbound.conf для forwarder1" %}
    
      ```bash
      sudo tee -a /etc/unbound/unbound.conf <<EOF
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
      EOF
      ``` 
      {% endcut %}

      {% cut "unbound.conf для forwarder2" %}

      ```bash
      sudo tee -a /etc/unbound/unbound.conf <<EOF
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
      EOF
      ```
      {% endcut %}

  1. Перезапустите Unbound:

      ```bash
      sudo systemctl restart unbound
      ```

  1. Отключите системную службу распознавания имен DNS, чтобы ее функции выполнял локальный DNS-форвардер. В Ubuntu 20.04 это можно сделать командами:

      ```bash
      sudo systemctl disable --now systemd-resolved
      rm /etc/resolv.conf
      echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf
      ```

{% endlist %}

### Настройте сетевой балансировщик Network Load Balancer {#setup-cloud-balancer}

Создайте [внутренний сетевой балансировщик](../../network-load-balancer/operations/internal-lb-create.md) с параметрами:

{% note info %}

Обработка UDP-трафика для сетевого балансировщика по умолчанию выключена. Чтобы включить обработку UDP-трафика на сетевом балансировщике, обратитесь в [техническую поддержку](../../support/overview.md). Подробнее можно прочитать [здесь](../../network-load-balancer/concepts/specifics.md#nlb-udp).

{% endnote %}

* **Тип**: `Внутренний`.

* В блоке **Обработчики**:
  * **Подсеть**: выберите `subnet3` из списка.
  * **Протокол**: `UDP`.
  * **Порт**: `53`.
  * **Целевой порт**: `53`.

* В блоке **Целевые группы**:
  * Создайте группу, состоящую из хостов `forwarder1` и `forwarder2`.
  * В блоке **Проверка состояния** укажите параметры:

    {% list tabs %}

    * CoreDNS
      * **Тип**: `HTTP`.
      * **Путь**: `/health`.
      * **Порт**: `8080`.

    * Unbound
      * **Тип**: `TCP`.
      * **Порт**: `53`.

    {% endlist %}

При создании балансировщика ему будет автоматически назначен IP-адрес из подсети `subnet3`.

{% note info %}

Внутренний сетевой балансировщик не будет отвечать на DNS-запросы от форвардеров, из которых состоит его целевая группа: `forwarder1` и `forwarder2`. Это связано с особенностями реализации, подробнее в разделе [Типы сетевых балансировщиков](../../network-load-balancer/concepts/nlb-types.md).

{% endnote %}

### Настройте сервис DHCP {#setup-cloud-dhcp}

Чтобы хосты в облачной сети автоматически использовали корпоративный сервис DNS, в [настройках DHCP](../../vpc/concepts/dhcp-options.md) для подсетей `subnet3` и `subnet4` укажите:

1. **Серверы доменных имен**: IP-адрес, который был [назначен балансировщику](#setup-cloud-balancer).
1. (Опционально) **Доменное имя**: `corp.example.net`.

Чтобы обновить сетевые настройки на хостах `forwarder1`, `forwarder2` и `test1`, выполните команду:

```bash
sudo netplan apply
```

После обновления сетевых настроек хосты в облачной сети будут использовать балансировщик вместо сервера DNS Yandex Cloud.

## Настройте корпоративные серверы DNS {#setup-on-prem-dns}

Настройте корпоративные серверы так, чтобы DNS-запросы к [внутренним зонам Yandex Cloud](../concepts/dns-zone.md#private-zones) направлялись на IP-адрес, который был [назначен балансировщику](#setup-cloud-balancer).

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
1. Проверьте, что на корпоративных DNS-серверах `ns1` и `ns2` выполняется распознавание внутренних имен Yandex Cloud, например:

    ```bash
    host ns.internal
    ns.internal has address 10.130.0.2
    ```

1. Чтобы убедиться, что сервисы запускаются автоматически, перезапустите ВМ `forwarder1`, `forwarder2` и `test1` и повторите проверки.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы:

* [удалите ВМ](../../compute/operations/vm-control/vm-delete.md);
* [удалите статические публичные IP-адреса](../../vpc/operations/address-delete.md), если вы зарезервировали их специально для своих ВМ;
* [удалите целевые группы](../../network-load-balancer/operations/target-group-delete.md);
* [удалите обработчики](../../network-load-balancer/operations/listener-remove.md);
* [удалите сетевой балансировщик](../../network-load-balancer/operations/load-balancer-delete.md);
* [удалите подсети](../../vpc/operations/subnet-delete.md);
* [удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md);
* [удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md);
* [удалите сети](../../vpc/operations/network-delete.md).