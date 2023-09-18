1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте облачную площадку](#cloud-setup).
1. [Настройте удаленную площадку](#remote-setup).
1. [Проверьте работу IPsec-соединения и связность между удаленными и облачными ресурсами](#ipsec-test).

Если инфраструктура вам больше не нужна, [удалите](#clear-out) созданные ресурсы.

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры для данного решения на базе IPsec-шлюзов входят:

* Плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md)).
* Плата за использование статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).


### Создайте пару ключей SSH {#create-ssh-keys}

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

## Настройте облачную площадку {#cloud-setup}

На этом этапе вы зарезервируете два статических IP-адреса для IPsec-шлюзов, а также создадите и настроите инфраструктуру облачной площадки {{ yandex-cloud }}. В нее войдут IPsec-шлюз, две виртуальные машины, сеть и две подсети.

### Создайте и настройте облачную сеть {#setup-cloud-net}

#### Зарезервируйте публичные IP-адреса для шлюзов {#reserve-public-ip}

[Зарезервируйте](../../../vpc/operations/get-static-ip.md) два статических [публичных IP-адреса](../../../vpc/concepts/address.md#public-addresses) в зоне доступности `{{ region-id }}-b`:

* Для основного IPsec-шлюза `cloud-gw`. В дальнейшем этот адрес будет обозначаться как `<x1.x1.x1.x1>`.
* Для удаленного IPsec-шлюза `remote-gw`. В дальнейшем этот адрес будет обозначаться как `<x2.x2.x2.x2>`.

#### Создайте сеть и подсети на облачной площадке {#cloud-net}

1. [Создайте сеть](../../../vpc/operations/network-create.md) с именем `cloud-net`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
1. В сети `cloud-net` [создайте подсети](../../../vpc/operations/subnet-create.md) со следующими параметрами:

    1. Для подключения основного IPsec-шлюза `cloud-gw`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `ipsec-subnet`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `172.16.0.0/24`.

    1. Для подключения виртуальной машины `vm-a`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `172.16.1.0/24`.

    1. Для подключения виртуальной машины `vm-b`:
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `172.16.2.0/24`.

#### Создайте и настройте группу безопасности для основного IPsec-шлюза {#cloud-sg}

1. В сети `cloud-net` [создайте группу безопасности](../../../vpc/operations/security-group-create.md) с именем `cloud-net-sg`.
1. В группе безопасности `cloud-net-sg` [создайте правила](../../../vpc/operations/security-group-add-rule.md) в соответствии с таблицей:

    | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
    | --- | --- | --- | --- | --- | --- |
    | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `icmp`           | `Весь` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `ipsec-udp-500`  | `500`  | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
    | Входящий | `ipsec-udp-4500` | `4500` | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x2.x2.x2.x2>/32` |
    | Входящий | `subnet-a`       | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.1.0/24` |
    | Входящий | `subnet-b`       | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `172.16.2.0/24` |

#### Настройте статическую маршрутизацию для основного IPsec-шлюза {#cloud-static}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создана сеть `cloud-net`.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Выберите сеть `cloud-net`.
1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.network.switch_route-table }}** и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** укажите `cloud-net-rt`.
1. В блоке **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}** нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

    1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** укажите `10.10.0.0/16`.
    1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** укажите внутренний IP-адрес основного IPsec-шлюза — `172.16.0.10`.
    1. Нажмите **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Нажмите **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Привяжите таблицу маршрутизации `cloud-net-rt` к подсетям `subnet-a` и `subnet-b`:

    1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.network.switch_overview }}**.
    1. В строке подсети `subnet-a` нажмите значок ![image](../../../_assets/options.svg) и выберите **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. В открывшемся окне выберите таблицу маршрутизации `cloud-net-rt` и нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
    1. Повторите два предыдущих шага для подсети `subnet-b`, чтобы привязать к ней таблицу маршрутизации `cloud-net-rt`.

### Создайте и настройте виртуальные машины на облачной площадке {#setup-cloud-vms}

#### Создайте ВМ с основным IPsec-шлюзом на облачной площадке {#create-cloud-gw}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать основной IPsec-шлюз.
1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт ![image](../../../_assets/create-resource-vm.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** укажите `cloud-gw`.
1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите `{{ region-id }}-b` — зону доступности, где находится подсеть, к которой будет подключен основной IPsec-шлюз.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}** и выберите образ [IPSec-инстанс](/marketplace/products/yc/ipsec-instance-ubuntu).
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите `ipsec-subnet`. 
    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
    1. В открывшемся поле **{{ ui-key.yacloud.component.compute.network-select.field_address }}** выберите публичный IP-адрес `<x1.x1.x1.x1>`, который вы ранее [зарезервировали](#reserve-public-ip).

        Чтобы адрес не изменился после перезагрузки, [сделайте](../../../vpc/operations/set-static-ip.md) его статическим.

    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` и в открывшемся поле укажите `172.16.0.10`.
    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите [ранее созданную](#cloud-sg) группу безопасности `cloud-net-sg`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите `ipsec`.
    * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** введите [созданный ранее](#create-ssh-keys) публичный SSH-ключ для доступа к ВМ.

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Дождитесь, когда ВМ перейдет в статус `Running`.

#### Настройте основной IPsec-шлюз {#config-cloud-gw}

Для настройки шлюза используйте IP-адреса, имя пользователя и ключ SSH, которые вы указывали при создании виртуальной машины `cloud-gw`.

{% note warning %}

Для настройки strongSwan [рекомендуется использовать](https://docs.strongswan.org/docs/5.9/howtos/introduction.html#_configuration_files) формат конфигурационного файла [swanctl.conf](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html). Инструкция для настройки шлюза в устаревшем формате конфигурации представлена на вкладке `ipsec.conf`.

{% endnote %}

{% list tabs %}

- swanctl.conf

  1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

  1. Задайте параметры даты и времени для ВМ:

      ```bash
      sudo timedatectl set-timezone Europe/Moscow
      sudo timedatectl set-ntp True
      timedatectl
      ```

  1. Для оптимальной работы протокола ICMP отключите функциональность `ICMP Redirects` на IPsec-шлюзе:

      ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
      ```

      Подробнее об этом читайте в [документации strongSwan](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

  1. Создайте резервную копию файла конфигурации `swanctl.conf`:

      ```bash
      sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
      ```

  1. Создайте конфигурацию для основного IPsec-шлюза в файле `/etc/swanctl/swanctl.conf`:
  
      ```bash
      sudo nano /etc/swanctl/swanctl.conf
      ```
  
      В открывшемся файле укажите:

      ```bash
      connections {
        cloud-ipsec {
          local_addrs = 172.16.0.10
          remote_addrs = <x2.x2.x2.x2>
          local {
            auth = psk
          }
          remote {
            auth = psk
          }
          version = 2 # IKEv2
          mobike = no
          proposals = aes128gcm16-prfsha256-ecp256, default
          dpd_delay = 10s
          children {
            cloud-ipsec {
              # List of local IPv4 subnets
              local_ts = 172.16.1.0/24, 172.16.2.0/24

              # List of remote IPv4 subnets
              remote_ts = 10.10.0.0/16

              start_action = trap
              esp_proposals = aes128gcm16
              dpd_action = clear
            }
          }
        }
      }

      # Pre-shared key (PSK) for IPsec connection
      secrets {
        ike-cloud-ipsec {
          secret = <пароль_ipsec>
        }
      }
      ```
  
      Где:

      * `cloud-ipsec` — имя IPsec-соединения.
      * `remote_addrs` — публичный IP-адрес `<x2.x2.x2.x2>` удаленного IPsec-шлюза.
      * `proposals` — [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). Список шифров (ciphers), которые могут использоваться для шифрования канала управления IPsec-соединением.
      * `esp_proposals` — [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). Список шифров (ciphers), которые могут использоваться для шифрования передаваемых данных.
      * `secret` — [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). Ключ (пароль) `<пароль_ipsec>`, который будет использоваться для установки IPsec-соединения.

      {% note info %}

      В файле конфигурации `swanctl.conf` вы можете указать дополнительные параметры в соответствии с [документацией strongSwan](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

      Например, для увеличения скорости передачи данных через IPsec-соединение используйте [оптимизированные алгоритмы шифрования](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) в режиме [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2). Поддержка этих алгоритмов должна быть реализована на платформе удаленного IPsec-шлюза, если это не strongSwan.

      {% endnote %}

  1. Загрузите конфигурацию в strongSwan:

      ```bash
      sudo swanctl --load-all
      ```

  1. Перезапустите strongSwan:

      ```bash
      sudo systemctl restart strongswan
      ```

  1. Проверьте состояние strongSwan:

      ```bash
      sudo swanctl -L
      ```

  1. (Опционально) Посмотрите логи strongSwan:

      ```bash
      sudo journalctl -u strongswan --no-pager
      sudo journalctl -u strongswan -n 20
      sudo journalctl -u strongswan -f
      ```

  1. Закройте соединение с `cloud-gw`:

      ```bash
      exit
      ```

- ipsec.conf

  1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):
  
      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

  1. Создайте конфигурацию для основного IPsec-шлюза в файле `/etc/swanctl/ipsec.conf`:

      ```bash
      sudo nano /etc/ipsec.conf
      ```

     В открывшемся файле конфигурации `/etc/ipsec.conf` задайте нужные параметры для настройки основного IPsec-шлюза:

      ```bash
      config setup
        charondebug="all"
        uniqueids=yes
        strictcrlpolicy=no

      conn cloud-to-remote-site
        authby=secret
        left=%defaultroute
        leftid=<x1.x1.x1.x1>
        leftsubnet=172.16.1.0/24
        right=<x2.x2.x2.x2>
        rightsubnet=10.10.0.0/16
        ike=aes256-sha2_256-modp1024!
        esp=aes256-sha2_256!
        keyingtries=0
        ikelifetime=1h
        lifetime=8h
        dpddelay=30
        dpdtimeout=120
        dpdaction=restart
        auto=start
      ```
  
      Где:

      * `conn` — название подключения к удаленному IPsec-шлюзу.
      * `leftid` — публичный IP-адрес `<x1.x1.x1.x1>` основного IPsec-шлюза со стороны {{ yandex-cloud }}.
      * `leftsubnet` — список префиксов подсетей, которые находятся за IPsec-шлюзом со стороны {{ yandex-cloud }}.
      * `right` — публичный IP-адрес `<x2.x2.x2.x2>` удаленного IPsec-шлюза.
      * `rightsubnet` — список префиксов подсетей, расположенных за удаленным IPsec-шлюзом.
      * `ike`, `esp` — алгоритмы шифрования, которые будут использоваться для организации IPsec-соединения между IPsec шлюзами. Список допустимых алгоритмов шифрования для режима [IKEv2](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html) и режима [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) приведен в документации strongSwan. Режим `IKEv1` признан устаревшим и не рекомендуется к использованию.

  1. Создайте конфигурацию для основного IPsec-шлюза в файле `/etc/swanctl/ipsec.secrets`:
  
      ```bash
      sudo nano /etc/ipsec.secrets
      ```

     В открывшемся файле конфигурации `/etc/ipsec.secrets` укажите IP-адреса ваших IPsec-шлюзов и задайте пароль (Pre-Shared Key) для IPsec-соединения с удаленным шлюзом:
  
      ```bash
      <x1.x1.x1.x1> <x2.x2.x2.x2> : PSK "<пароль_ipsec>"
      ```

      Где:

      * `<пароль_ipsec>` — ключ/пароль, используемый шлюзами для установки IPsec-соединения.
      * `<x1.x1.x1.x1>` — публичный IP-адрес основного IPsec-шлюза со стороны {{ yandex-cloud }}.
      * `<x2.x2.x2.x2>` — публичный IP-адрес удаленного IPsec-шлюза.

      В файле конфигурации вы можете указать дополнительные параметры в соответствии с [документацией strongSwan](https://wiki.strongswan.org/projects/strongswan/wiki).

      {% cut "Если вам нужно развернуть IPsec-шлюз и ресурсы за ним в одной подсети" %}

        Добавьте в конфигурационный файл IPsec-шлюза исключающие правила для IP-адреса шлюза по умолчанию и собственного (приватного) IP-адреса IPsec-шлюза:

        ```bash
        conn passthrough-1
          left=%defaultroute
          leftsubnet=<IP-адрес_шлюза_подсети_по_умолчанию>
          rightsubnet=10.10.0.0/8
          type=passthrough
          auto=route
        conn passthrough-2
          left=%defaultroute
          leftsubnet=<внутренний_IP-адрес_IPsec-инстанса>
          rightsubnet=10.0.0.0/8
          type=passthrough
          auto=route
        ```

        Где:

        * `<IP-адрес_шлюза_подсети_по_умолчанию>` — префикс подсети в котором находятся IPsec-шлюз и ресурсы за ним.
        * `<внутренний_ip-адрес_IPsec-инстанса>` — собственный IP-адрес IPsec-шлюза.

        IPsec-шлюз будет доступен для диагностики и будет отвечать по протоколу [ICMP](https://ru.wikipedia.org/wiki/ICMP).

      {% endcut %}


  1. Перезапустите strongSwan:

      ```bash
      sudo systemctl restart strongswan-starter
      ```

  1. Закройте соединение с `cloud-gw`:

      ```bash
      exit
      ```

{% endlist %}

#### Разверните тестовые ВМ на облачной площадке {#cloud-test-vm}

1. [Cоздайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) `vm-a` со следующими параметрами:

    * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** — `vm-a`.
    * **{{ ui-key.yacloud.compute.instances.create.field_zone }}** — `{{ region-id }}-a`.
    * **Операционная система** — [Ubuntu 22.04 LTS](/marketplace/products/yc/ipsec-instance-ubuntu).
    * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `subnet-a`.
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
    * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** — `172.16.1.5`.
    * **{{ ui-key.yacloud.compute.instances.create.field_user }}** — `ipsec`.
    * **{{ ui-key.yacloud.compute.instances.create.field_key }}** — публичный SSH-ключ для доступа к ВМ.

1. [Cоздайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) `vm-b` со следующими параметрами:

    * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** — `vm-b`.
    * **{{ ui-key.yacloud.compute.instances.create.field_zone }}** — `{{ region-id }}-b`.
    * **Операционная система** — `Ubuntu 22.04 LTS`.
    * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `subnet-b`.
    * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
    * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** — `172.16.2.5`.
    * **{{ ui-key.yacloud.compute.instances.create.field_user }}** — `ipsec`.
    * **{{ ui-key.yacloud.compute.instances.create.field_key }}** — публичный SSH-ключ для доступа к ВМ.

## Настройте удаленную площадку {#remote-setup}

На этом этапе вы создадите и настроите инфраструктуру удаленной площадки условного корпоративного ЦОД. В нее войдут IPsec-шлюз, виртуальная машина, сеть и  подсеть.

### Создайте и настройте удаленную сеть {#setup-remote-net}

#### Создайте сеть и подсеть на удаленной площадке {#remote-net}

1. [Создайте сеть](../../../vpc/operations/network-create.md) с именем `remote-net`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
1. В сети `remote-net` [создайте подсеть](../../../vpc/operations/subnet-create.md) для подключения удаленного IPsec-шлюза `remote-gw` и виртуальной машины `vm-1` со следующими параметрами:

    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-1`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `10.10.0.0/16`.

#### Создайте и настройте группу безопасности для удаленного IPsec-шлюза {#remote-sg}

1. В сети `remote-net` [создайте группу безопасности](../../../vpc/operations/security-group-create.md) с именем `remote-net-sg`.
1. В группе безопасности `remote-net-sg` [создайте правила](../../../vpc/operations/security-group-add-rule.md) в соответствии с таблицей:

    | Направление<br/>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
    | --- | --- | --- | --- | --- | --- |
    | Исходящий | `any`           | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `icmp`           | `Весь` | `ICMP` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `ssh`            | `22`   | `TCP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
    | Входящий | `ipsec-udp-500`  | `500`  | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
    | Входящий | `ipsec-udp-4500` | `4500` | `UDP`  | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<x1.x1.x1.x1>/32` |
    | Входящий | `subnet-1`       | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `10.10.0.0/16` |

#### Настройте статическую маршрутизацию для удаленного IPsec-шлюза {#remote-static}

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создана сеть `remote-net`.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
1. Выберите сеть `remote-net`.
1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.network.switch_route-table }}** и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** укажите `remote-net-rt`.
1. В блоке **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}** нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.

    1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** укажите `172.16.1.0/24`.
    1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** укажите внутренний IP-адрес основного IPsec-шлюза — `10.10.20.20`.
    1. Нажмите **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.

1. Повторите предыдущий шаг, чтобы добавить второе правило с параметрами:

    * **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** — `172.16.2.0/24`.
    * **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** — `10.10.20.20`.

1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
1. Привяжите таблицу маршрутизации `remote-net-rt` к подсети `subnet-1`:

    1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.network.switch_overview }}**.
    1. В строке подсети `subnet-1` нажмите значок ![image](../../../_assets/options.svg) и выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. В открывшемся окне выберите таблицу `remote-net-rt` и нажмите кнопку **ui-key.yacloud.vpc.subnet.add-route-table.button_add**.

### Создайте и настройте виртуальные машины на удаленной площадке {#setup-remote-vms}

#### Создайте ВМ с удаленным IPsec-шлюзом {#create-remote-gw}

Создайте ВМ, которая будет выступать в роли удаленного IPsec-шлюза. 

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать удаленный IPsec-шлюз.
1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите пункт ![image](../../../_assets/create-resource-vm.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
1. В поле **{{ ui-key.yacloud.compute.instances.create.field_name }}** укажите `remote-gw`.
1. В поле **{{ ui-key.yacloud.compute.instances.create.field_zone }}** выберите `{{ region-id }}-b` — зону доступности, где находится подсеть, к которой будет подключен удаленный IPsec-шлюз.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}** и выберите образ `IPSec-инстанс`.
1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите `subnet-1`.
    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
    1. В открывшемся поле **{{ ui-key.yacloud.component.compute.network-select.field_address }}** выберите публичный IP-адрес `<x2.x2.x2.x2>`, который был [зарезервирован ранее](#reserve-public-ip).

        Чтобы адрес не изменился после перезагрузки, [сделайте](../../../vpc/operations/set-static-ip.md) его статическим.

    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_manual }}` и в открывшемся поле укажите `10.10.20.20`.
    1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите [ранее созданную](#cloud-sg) группу безопасности `remote-net-sg`.

1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

    * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** укажите `ipsec`.
    * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** введите [созданный ранее](#create-ssh-keys) публичный SSH-ключ для доступа к ВМ.

1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

Дождитесь, когда ВМ перейдет в статус `Running`.

#### Настройте удаленный IPsec-шлюз {#config-remote-gw}

Для настройки шлюза используйте IP-адреса, имя пользователя и ключ SSH, которые вы указывали при создании ВМ `remote-gw`.

{% note warning %}

Для настройки strongSwan [рекомендуется использовать](https://docs.strongswan.org/docs/5.9/howtos/introduction.html#_configuration_files) формат конфигурационного файла [swanctl.conf](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html). Инструкция для настройки шлюза в устаревшем формате конфигурации представлена на вкладке `ipsec.conf`.

{% endnote %}

{% list tabs %}

- swanctl.conf
  
  1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

  1. Задайте параметры даты и времени для ВМ:

      ```bash
      sudo timedatectl set-timezone Europe/Moscow
      sudo timedatectl set-ntp True
      timedatectl
      ```

  1. Для оптимальной работы протокола ICMP отключите функциональность `ICMP Redirects` на IPsec-шлюзе:

      ```bash
	  sudo su -c "echo 'net.ipv4.conf.eth0.send_redirects=0' >> /etc/sysctl.conf"
	  sudo su -c "echo 'net.ipv4.conf.default.send_redirects=0' >> /etc/sysctl.conf"
      ```

      Подробнее об этом читайте в [документации strongSwan](https://docs.strongswan.org/docs/5.9/howtos/forwarding.html#_hosts_on_the_lan).

  1. Создайте резервную копию файла конфигурации `swanctl.conf`:
  
      ```bash
      sudo mv /etc/swanctl/swanctl.conf /etc/swanctl/swanctl.orig
      ```

  1. Создайте конфигурацию для удаленного IPsec-шлюза в файле `/etc/swanctl/swanctl.conf`:

      ```bash
      sudo nano /etc/swanctl/swanctl.conf
      ```

      В открывшемся файле укажите:

      ```bash
      connections {
        cloud-ipsec {
          local_addrs = 10.10.20.20
          remote_addrs = <x1.x1.x1.x1>
          local {
            auth = psk
          }
          remote {
            auth = psk
          }
          version = 2 # IKEv2
          mobike = no
          proposals = aes128gcm16-prfsha256-ecp256, default
          dpd_delay = 10s
          children {
            cloud-ipsec {
              # List of local IPv4 subnets
              local_ts = 10.10.0.0/16

              # List of remote IPv4 subnets
              remote_ts = 172.16.1.0/24, 172.16.2.0/24

              start_action = trap
              esp_proposals = aes128gcm16
              dpd_action = clear
            }
          }
        }
      }

      # Pre-shared key (PSK) for IPsec connection
      secrets {
        ike-cloud-ipsec {
          secret = <пароль_ipsec>
        }
      }
      ```

      Где:

      * `cloud-ipsec` — имя IPsec-соединения.
      * `remote_addrs` — публичный IP-адрес `<x1.x1.x1.x1>` основного IPsec-шлюза.
      * `proposals` — [Internet Key Exchange Version 2 (IKEv2)](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_internet_key_exchange_version_2_ikev2). Список шифров (ciphers), которые могут использоваться для шифрования канала управления IPsec-соединением.
      * `esp_proposals` — [Encapsulating Security Payload](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_encapsulating_security_payload_esp). Список шифров (ciphers), которые могут использоваться для шифрования передаваемых данных.
      * `secret` — [Pre-Shared Key](https://docs.strongswan.org/docs/5.9/howtos/ipsecProtocol.html#_psk_based_authentication). Ключ (пароль) `<пароль_ipsec>`, который будет использоваться для установки IPsec-соединения.

      {% note info %}

      В файле конфигурации `swanctl.conf` вы можете указать дополнительные параметры в соответствии с [документацией strongSwan](https://docs.strongswan.org/docs/5.9/swanctl/swanctlConf.html).

      Например, для увеличения скорости передачи данных через IPsec-соединение используйте [оптимизированные алгоритмы шифрования](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html#_authenticated_encryption_aead_algorithms) в режиме [IKEv2](https://docs.strongswan.org/docs/5.9/features/ietf.html#_ikev2). Поддержка этих алгоритмов должна быть реализована на платформе удаленного IPsec-шлюза, если это не strongSwan.

      {% endnote %}

  1. Загрузите конфигурацию в strongSwan:

      ```bash
      sudo swanctl --load-all
      ```

  1. Перезапустите strongSwan:

      ```bash
      sudo systemctl restart strongswan
      ```

  1. Проверьте состояние strongSwan:

      ```bash
      sudo swanctl -L
      ```

  1. (Опционально) Посмотрите логи strongSwan:

      ```bash
      sudo journalctl -u strongswan --no-pager
      sudo journalctl -u strongswan -n 20
      sudo journalctl -u strongswan -f
      ```

  1. Закройте соединение с `remote-gw`:

      ```bash
      exit
      ```

- ipsec.conf

  1. Подключитесь к виртуальной машине по [SSH](../../../glossary/ssh-keygen.md):

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

  1. Создайте конфигурацию для удаленного IPsec-шлюза в файле `/etc/swanctl/ipsec.conf`:

      ```bash
      sudo nano /etc/ipsec.conf
      ```

     В открывшемся файле конфигурации `/etc/ipsec.conf` задайте нужные параметры для настройки удаленного IPsec-шлюза. Значения параметров будут зеркальным отображением значений параметров основного IPsec-шлюза.

      ```bash
      config setup
        charondebug="all"
        uniqueids=yes
        strictcrlpolicy=no

      conn remote-site-to-cloud
        authby=secret
        left=%defaultroute
        leftid=<x2.x2.x2.x2>
        leftsubnet=10.10.0.0/16
        right=<x1.x1.x1.x1>
        rightsubnet=172.16.1.0/24
        ike=aes256-sha2_256-modp1024!
        esp=aes256-sha2_256!
        keyingtries=0
        ikelifetime=1h
        lifetime=8h
        dpddelay=30
        dpdtimeout=120
        dpdaction=restart
        auto=start
      ```

      Где:

      * `conn` — название подключения к IPsec-шлюзу со стороны {{ yandex-cloud }}.
      * `leftid` — публичный IP-адрес `<x2.x2.x2.x2>` удаленного IPsec-шлюза.
      * `leftsubnet` — список префиксов подсетей, которые находятся за удаленным IPsec-шлюзом.
      * `right` — публичный IP-адрес `<x1.x1.x1.x1>` IPsec-шлюза со стороны {{ yandex-cloud }}.
      * `rightsubnet` — список префиксов подсетей, расположенных за IPsec-шлюзом со стороны {{ yandex-cloud }}.
      * `ike`, `esp` — алгоритмы шифрования, которые будут использоваться для организации IPsec-соединения между IPsec шлюзами. Список допустимых алгоритмов шифрования для режима [IKEv2](https://docs.strongswan.org/docs/5.9/config/IKEv2CipherSuites.html) и режима [IKEv1](https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites) приведен в документации strongSwan. Режим `IKEv1` признан устаревшим и не рекомендуется к использованию.

  1. Создайте конфигурацию для основного IPsec-шлюза в файле `/etc/swanctl/ipsec.secrets`:
  
      ```bash
      sudo nano /etc/ipsec.secrets
      ```

     В открывшемся файле конфигурации `/etc/ipsec.secrets` укажите IP-адреса ваших IPsec-шлюзов и задайте пароль (Pre-Shared Key) для IPsec-соединения с основным шлюзом:

      ```bash
      <x2.x2.x2.x2> <x1.x1.x1.x1> : PSK "<пароль_ipsec>"
      ```

      Где:

      * `<пароль_ipsec>` — ключ/пароль, используемый шлюзами для установки IPsec-соединения.
      * `<x1.x1.x1.x1>` — публичный IP-адрес основного IPsec-шлюза со стороны {{ yandex-cloud }}.
      * `<x2.x2.x2.x2>` — публичный IP-адрес удаленного IPsec-шлюза.

  1. Перезапустите strongSwan:

      ```bash
      sudo systemctl restart strongswan-starter
      ```

  1. Закройте соединение с `cloud-gw`:

      ```bash
      exit
      ```

{% endlist %}

#### Разверните тестовую ВМ на удаленной площадке {#remote-test-vm}

[Cоздайте тестовую ВМ](../../../compute/operations/vm-create/create-linux-vm.md) со следующими параметрами:

  * **{{ ui-key.yacloud.compute.instances.create.field_coi-name }}** — `vm-1`.
  * **{{ ui-key.yacloud.compute.instances.create.field_zone }}** — `{{ region-id }}-b`.
  * **Операционная система** — `Ubuntu 22.04 LTS`.
  * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** — `subnet-1`.
  * **{{ ui-key.yacloud.component.compute.network-select.field_external }}** — `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
  * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** — `10.10.10.10`.
  * **{{ ui-key.yacloud.compute.instances.create.field_user }}** — `ipsec`.
  * **{{ ui-key.yacloud.compute.instances.create.field_key }}** — публичный SSH-ключ для доступа к ВМ.

## Проверьте работу IPsec-соединения и связность между удаленными и облачными ресурсами {#ipsec-test}

### Установите IPsec-соединение между шлюзами и проверьте его работу {#ipsec-bringup}

IPsec-шлюзы на основной и удаленной площадках настроены на установление IPsec-соединения между собой при получении любым из них трафика, предназначенного для подсети на другой стороне IPsec-соединения (за другим шлюзом).

{% note info %}

На создание туннеля между шлюзами может потребоваться время. Если при активации IPsec-соединения команда `ping` не выдает нужного результата, подождите несколько минут, затем попробуйте выполнить команду снова.

{% endnote %}

Для активации IPsec-соединения между шлюзами:

1. Отправьте несколько пакетов ICMP со стороны удаленной площадки, например, от ВМ `vm-1` к ВМ `vm-a` с помощью команды `ping`:

    ```bash
    ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10 ping -c4 172.16.1.5
    ```

    Результат:

    ```bash
    PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
    64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
    64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
    64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
    64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

    --- 172.16.1.5 ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3005ms
    rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
    ```

1. Активируйте IPsec-соединение со стороны облачной площадки — отправьте пакеты ICMP от ВМ `vm-b` к ВМ `vm-1`:

    ```bash
    ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5 ping -c4 10.10.10.10
    ```

    Результат:

    ```bash
    PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
    64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
    64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
    64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
    64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

    --- 10.10.10.10 ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3005ms
    rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
    ```

### Проверьте связность между ВМ {#ipsec-test-vm}

{% note warning %}

Набор команд для проверки IPsec-соединения будет отличаться в зависимости от использованного формата конфигурационного файла strongSwan.

{% endnote %}

{% list tabs %}

- swanctl.conf

  1. Подключитесь к основному IPsec-шлюзу `cloud-gw`:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

      1. Проверьте состояние strongSwan:

          ```bash
          sudo swanctl -L
          ```

          Результат:

          ```bash
          cloud-to-remote-site: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
            local:  %any
            remote: <x2.x2.x2.x2>
            local pre-shared key authentication:
              id: <x1.x1.x1.x1>
            remote pre-shared key authentication:
              id: <x2.x2.x2.x2>
            cloud-to-remote-site: TUNNEL, rekeying every 28260s, dpd action is restart
              local:  172.16.1.0/24
              remote: 10.10.0.0/16
          cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
            local:  172.16.0.10
            remote: <x2.x2.x2.x2>
            local pre-shared key authentication:
            remote pre-shared key authentication:
            cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
              local:  172.16.1.0/24 172.16.2.0/24
              remote: 10.10.0.0/16
          ```

      1. Проверьте активные IPsec-соединения:

          ```bash
          sudo swanctl -l
          ```

          Результат:

          ```bash
          cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i* 9f63a85191df1e48_r
            local  '172.16.0.10' @ 172.16.0.10[4500]
            remote '10.10.20.20' @ <x2.x2.x2.x2>[4500]
            AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
            established 9716s ago, rekeying in 4107s
            cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
              installed 682s ago, rekeying in 2735s, expires in 3278s
              in  cf9668bb,      0 bytes,     0 packets
              out c3a00b2c,      0 bytes,     0 packets
              local  172.16.1.0/24 172.16.2.0/24
              remote 10.10.0.0/16
          ```

          Состояние соединения `ESTABLISHED` означает, что IPsec-соединение установилось и работает.

      1. Закройте соединение с `cloud-gw`:

          ```bash
          exit
          ```

  1. Подключитесь к удаленному IPsec-шлюзу `remote-gw`:

      ```bash
      ssh ipsec@<x2.x2.x2.x2>
      ```

      1. Проверьте состояние strongSwan:

          ```bash
          sudo swanctl -L
          ```

          Результат:

          ```bash
          remote-site-to-cloud: IKEv1/2, reauthentication every 3060s, no rekeying, dpd delay 30s
            local:  %any
            remote: <x1.x1.x1.x1>
            local pre-shared key authentication:
              id: <x2.x2.x2.x2>
            remote pre-shared key authentication:
              id: <x1.x1.x1.x1>
            remote-site-to-cloud: TUNNEL, rekeying every 28260s, dpd action is restart
              local:  10.10.0.0/16
              remote: 172.16.1.0/24
          cloud-ipsec: IKEv2, no reauthentication, rekeying every 14400s, dpd delay 10s
            local:  10.10.20.20
            remote: <x1.x1.x1.x1>
            local pre-shared key authentication:
            remote pre-shared key authentication:
            cloud-ipsec: TUNNEL, rekeying every 3600s, dpd action is clear
              local:  10.10.0.0/16
              remote: 172.16.1.0/24 172.16.2.0/24
          ```

      1. Проверьте активные IPsec-соединения:
      
          ```bash
          sudo swanctl -l
          ```

          Результат:

          ```bash
          cloud-ipsec: #6, ESTABLISHED, IKEv2, 80e6fa659b4f6307_i 9f63a85191df1e48_r*
            local  '10.10.20.20' @ 10.10.20.20[4500]
            remote '172.16.0.10' @ <x1.x1.x1.x1>[4500]
            AES_GCM_16-128/PRF_HMAC_SHA2_256/ECP_256
            established 9833s ago, rekeying in 3346s
            cloud-ipsec: #19, reqid 1, INSTALLED, TUNNEL-in-UDP, ESP:AES_GCM_16-128
              installed 799s ago, rekeying in 2620s, expires in 3161s
              in  c3a00b2c,      0 bytes,     0 packets
              out cf9668bb,      0 bytes,     0 packets
              local  10.10.0.0/16
              remote 172.16.1.0/24 172.16.2.0/24
          ```

          Состояние соединения `ESTABLISHED` означает, что IPsec-соединение установилось и работает.

      1. Закройте соединение с `remote-gw`:

          ```bash
          exit
          ```

  1. Подключитесь к ВМ `vm-a`:

      ```bash
      ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.1.5
      ```

      1. Задайте параметры даты и времени для ВМ:

          ```bash
          sudo timedatectl set-timezone Europe/Moscow
          sudo timedatectl set-ntp True
          timedatectl
          ```

      1. Проверьте IP-связность между `vm-a` и `vm-1`:

          ```bash
          ping -c4 10.10.10.10
          ```

          Результат:

          ```bash
          PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
          64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
          64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
          64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
          64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

          --- 10.10.10.10 ping statistics ---
          4 packets transmitted, 4 received, 0% packet loss, time 3005ms
          rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
          ```

      1. Закройте соединение с `vm-a`:

          ```bash
          exit
          ```

  1. Подключитесь к ВМ `vm-b`:

      ```bash
      ssh -J ipsec@<x1.x1.x1.x1> ipsec@172.16.2.5
      ```

      1. Задайте параметры даты и времени для ВМ:

          ```bash
          sudo timedatectl set-timezone Europe/Moscow
          sudo timedatectl set-ntp True
          timedatectl
          ```

      1. Проверьте IP-связность между `vm-b` и `vm-1`:

          ```bash
          ping -c4 10.10.10.10
          ```

          Результат:

          ```bash
          PING 10.10.10.10 (10.10.10.10) 56(84) bytes of data.
          64 bytes from 10.10.10.10: icmp_seq=1 ttl=58 time=4.92 ms
          64 bytes from 10.10.10.10: icmp_seq=2 ttl=58 time=4.33 ms
          64 bytes from 10.10.10.10: icmp_seq=3 ttl=58 time=4.31 ms
          64 bytes from 10.10.10.10: icmp_seq=4 ttl=58 time=4.38 ms

          --- 10.10.10.10 ping statistics ---
          4 packets transmitted, 4 received, 0% packet loss, time 3005ms
          rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
          ```

      1. Закройте соединение с `vm-b`:

          ```bash
          exit
          ```

  1. Подключитесь к ВМ `vm-1`:

      ```bash
      ssh -J ipsec@<x2.x2.x2.x2> ipsec@10.10.10.10
      ```

      1. Задайте параметры даты и времени для ВМ:

          ```bash
          sudo timedatectl set-timezone Europe/Moscow
          sudo timedatectl set-ntp True
          timedatectl
          ```

      1. Проверьте IP-связность между `vm-1` и `vm-a`:

          ```bash
          ping -c4 172.16.1.5
          ```

          Результат:

          ```bash
          PING 172.16.1.5 (172.16.1.5) 56(84) bytes of data.
          64 bytes from 172.16.1.5: icmp_seq=1 ttl=58 time=4.92 ms
          64 bytes from 172.16.1.5: icmp_seq=2 ttl=58 time=4.33 ms
          64 bytes from 172.16.1.5: icmp_seq=3 ttl=58 time=4.31 ms
          64 bytes from 172.16.1.5: icmp_seq=4 ttl=58 time=4.38 ms

          --- 172.16.1.5 ping statistics ---
          4 packets transmitted, 4 received, 0% packet loss, time 3005ms
          rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
          ```

      1. Проверьте IP-связность между `vm-1` и `vm-b`:

          ```bash
          ping -c4 172.16.2.5
          ```

          Результат:

          ```bash
          PING 172.16.2.5 (172.16.2.5) 56(84) bytes of data.
          64 bytes from 172.16.2.5: icmp_seq=1 ttl=58 time=4.92 ms
          64 bytes from 172.16.2.5: icmp_seq=2 ttl=58 time=4.33 ms
          64 bytes from 172.16.2.5: icmp_seq=3 ttl=58 time=4.31 ms
          64 bytes from 172.16.2.5: icmp_seq=4 ttl=58 time=4.38 ms

          --- 172.16.2.5 ping statistics ---
          4 packets transmitted, 4 received, 0% packet loss, time 3005ms
          rtt min/avg/max/mdev = 4.306/4.483/4.916/0.251 ms
          ```
      
      1. Закройте соединение с `vm-1`:

          ```bash
          exit
          ```

- ipsec.conf

  1. Подключитесь к основному IPsec-шлюзу `cloud-gw`:

      ```bash
      ssh ipsec@<x1.x1.x1.x1>
      ```

  1. Убедитесь, что соединение между шлюзами установлено:

      ```bash
      sudo ipsec status
      ```

      Результат:

      ```bash
      Routed Connections:
      cloud-ipsec{2}:  ROUTED, TUNNEL, reqid 1
      cloud-ipsec{2}:   172.16.1.0/24 172.16.2.0/24 === 10.10.0.0/16
      Security Associations (1 up, 0 connecting):
      cloud-ipsec[6]: ESTABLISHED 2 hours ago, 172.16.0.10[172.16.0.10]...<x2.x2.x2.x2>[10.10.20.20]
      cloud-ipsec{19}:  INSTALLED, TUNNEL, reqid 1, ESP in UDP SPIs: cf9668bb_i c3a00b2c_o
      cloud-ipsec{19}:   172.16.1.0/24 172.16.2.0/24 === 10.10.0.0/16
      ```

      Статус `ESTABLISHED` означает, что туннель между шлюзами создан.

  1. Проверьте состояние демона strongSwan:

      ```bash
      systemctl status strongswan-starter
      ```

      Результат:

      ```bash
      ● strongswan-starter.service - strongSwan IPsec IKEv1/IKEv2 daemon using ipsec.conf
          Loaded: loaded (/lib/systemd/system/strongswan-starter.service; enabled; vendor preset: enabled)
          Active: active (running) since Sun 2023-05-28 21:54:02 MSK; 1h ago
        Main PID: 738 (starter)
            Tasks: 18 (limit: 1028)
          Memory: 8.1M
              CPU: 8.246s
          CGroup: /system.slice/strongswan-starter.service
                  ├─738 /usr/lib/ipsec/starter --daemon charon --nofork
                  └─798 /usr/lib/ipsec/charon
      ```

  1. Дополнительно вы можете посмотреть подробную информацию о IPsec-соединениях и работе strongSwan:

      ```bash
      journalctl -u strongswan-starter
      ```

  1. Закройте соединение с основным IPsec-шлюзом `cloud-gw`:

      ```bash
      exit
      ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [{#T}](../../../compute/operations/vm-control/vm-delete.md)
* [{#T}](../../../vpc/operations/address-delete.md)
* [{#T}](../../../vpc/operations/subnet-delete.md)
* [{#T}](../../../vpc/operations/network-delete.md)