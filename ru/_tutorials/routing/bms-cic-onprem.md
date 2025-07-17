# Организация сетевой связности между подсетями {{ baremetal-full-name }} и on-premises с помощью {{ interconnect-name }}

В данном руководстве вы установите сетевую связность между [сервером](../../baremetal/concepts/servers.md) {{ baremetal-name }}, расположенным в [приватной подсети](../../baremetal/concepts/network.md#private-network) {{ baremetal-full-name }}, и ресурсами, которые развернуты on-premises. Сетевая связность будет организована с помощью сервисов [{{ interconnect-name }}](../../interconnect/index.yaml) и [{{ cr-name }}](../../cloud-router/index.yaml).

Схема решения:

![bms-cic-onprem](../../_assets/tutorials/bms-cic-onprem.svg)

На схеме выше показана организация сетевого взаимодействия между ресурсами в сегменте {{ baremetal-full-name }} и удаленными ресурсами на площадке клиента, которая подключена к {{ yandex-cloud }} с помощью сервиса {{ interconnect-name }}.

Для организации сетевого взаимодействия между такими ресурсами и виртуальной сетью нужно добавить соответствующие IP-префиксы подсетей {{ vpc-name }} в Routing Instance. Подробнее с организацией такого вида сетевого взаимодействия можно ознакомиться [в документации](../../cloud-router/tutorials/bm-vrf-and-vpc-interconnect.md). 

{% note info %}

Предполагается, что сетевое взаимодействие между on-premises и виртуальной сетью {{ vpc-short-name }} с помощью сервиса {{ interconnect-name }} уже организовано и работает. 

{% endnote %}

Чтобы настроить сетевую связность между приватными подсетями {{ baremetal-name }} и on-premise-ресурсами с помощью {{ interconnect-name }} необходимо:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную инфраструктуру](#setup-infrastructure).
1. [Создайте Routing Instance](#create-routing-instance).
1. [Создайте приватное соединение](#create-private-connection).
1. [Проверьте сетевую связность](#check-connectivity).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для организации сетевой связности между подсетями {{ baremetal-name }} и {{ vpc-short-name }} входят:

* плата за использование [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) виртуальной машины (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за вычислительные ресурсы и диски [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за аренду сервера {{ baremetal-name }} (см. [тарифы {{ baremetal-full-name }}](../../baremetal/pricing.md)).


## Создайте облачную инфраструктуру {#setup-infrastructure}

Создайте необходимую инфраструктуру {{ yandex-cloud }}, в которой вы будете настраивать сетевую связность.

Для настройки {{ interconnect-name }} в сервисе {{ baremetal-name }} понадобятся приватная маршрутизируемая [подсеть](../../baremetal/concepts/network.md#private-subnet) и [VRF](../../baremetal/concepts/network.md#vrf-segment) в {{ baremetal-name }}, [облачная сеть](../../vpc/concepts/network.md#network) с одной или более [подсетями](../../vpc/concepts/network.md#subnet) {{ vpc-name }}, а также Routing Instance, в составе которого будут [анонсированы](../../interconnect/concepts/priv-con.md#prc-announce) один или несколько префиксов приватных подсетей {{ vpc-short-name }}.

Для проверки сетевой связности понадобятся сервер {{ baremetal-name }} и виртуальная машина {{ compute-name }}.

### Создайте VRF и приватную подсеть {{ baremetal-name }} {#setup-vrf}

Создайте виртуальный сегмент сети (VRF) и приватную подсеть в [пуле серверов](../../baremetal/concepts/servers.md#server-pools) `{{ region-id }}-m3`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Создайте виртуальный сегмент сети:
        1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя VRF: `my-vrf`.
        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-network }}**.
  1. Создайте приватную подсеть:
        1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}** и нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_server-pool }}** выберите пул серверов `{{ region-id }}-m3`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя подсети: `subnet-m3`.
        1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
        1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите созданный ранее сегмент `my-vrf`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR }}** укажите `192.168.1.0/24`.
        1. В поле **{{ ui-key.yacloud.baremetal.field_gateway }}** оставьте значение по умолчанию `192.168.1.1`.
        1. Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}** и в появившемся поле **{{ ui-key.yacloud.baremetal.field_dhcp-ip-range }}** оставьте значения по умолчанию: `192.168.1.1` — `192.168.1.254`.
        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

{% endlist %}


### Арендуйте сервер {{ baremetal-name }} {#rent-bms}

{% list tabs group=instructions %}

- Консоль управления {#console}


  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}** нажмите фильтр `{{ ui-key.yacloud.baremetal.servers.ConfigurationField.poolFilter_frWLA }}` и выберите пул серверов `{{ region-id }}-m3`.
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите образ. Например: `Ubuntu 24.04`.
  1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}** в поле **{{ ui-key.yacloud.baremetal.field_subnet-id }}** выберите созданную ранее подсеть `subnet-m3`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}** в поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите `{{ ui-key.yacloud.baremetal.label_public-ip-no }}`.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}** в поле **{{ ui-key.yacloud.baremetal.field_name }}** задайте имя сервера: `server-m3`.
  1. {% include [server-lease-step13](../../_includes/baremetal/instruction-steps/server-lease-step13.md) %}

{% endlist %}

{% note info %}

Подготовка сервера и установка на него операционной системы может занять до 45 минут — в это время сервер будет находиться в статусе `Provisioning`. После завершения установки ОС сервер перейдет в статус `Ready`.

{% endnote %}

## Создайте Routing Instance {#create-routing-instance}

Для организации сетевой связности между подсетями {{ baremetal-name }} и on-premise-подсетями необходимо создать ресурс `Routing Instance`. `Routing Instance` можно создать через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.

Если в вашем каталоге уже есть настроенная сетевая связность с использованием [{{ interconnect-name }}](../../interconnect/index.yaml) (VPC-to-On-Prem), то вы можете как использовать уже существующий `Routing Instance`, так и запросить создание нового, дополнительного `Routing Instance` для организации обособленной сетевой связности.

### Проверьте наличие Routing Instance в вашем каталоге {#check-for-ri}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [check-for-routing-instance](../../_includes/baremetal/check-for-routing-instance.md) %}

1. Если у вас уже есть Routing Instance, вы можете пропустить следующий шаг и [переходить](#create-private-connection) к созданию приватного соединения.

    Если у вас нет Routing Instance или вы хотите построить дополнительную, обособленную сетевую связность, запросите создание нового Routing Instance.

### Запросите создание Routing Instance {#request-ri}

{% include [request-routing-instance](../../_includes/baremetal/request-routing-instance.md) %}

## Создайте приватное соединение {#create-private-connection}

После того как в вашем каталоге будет создан необходимый Routing Instance, создайте [приватное соединение](../../baremetal/concepts/network.md#private-connection-to-vpc) {{ interconnect-name }} в сервисе {{ baremetal-name }}:

{% include [create-private-connection](../../_includes/baremetal/create-private-connection.md) %}

## Проверьте сетевую связность {#check-connectivity}

После того как статус созданного приватного соединения изменится на `Ready`, сетевая связность между подсетями {{ baremetal-name }} и {{ vpc-short-name }} будет установлена и вы сможете приступить к ее проверке.

Проверка сетевой связности предполагает, что:
* процесс настройки приватного соединения с облачными подсетями успешно завершен (статус соединения отображается как `Ready`);
* локальный сервис Firewall на сервере {{ baremetal-name }} разрешает прохождение трафика [ICMP](https://ru.wikipedia.org/wiki/ICMP);
* маршрутная таблица в операционной системе сервера {{ baremetal-name }} содержит маршрут до CIDR подсети с виртуальной машиной;
* [группа безопасности](../../vpc/concepts/security-groups.md), которая назначена [сетевому интерфейсу](../../compute/concepts/network.md) виртуальной машины, разрешает прохождение ICMP-трафика.

### Проверьте сетевую связность из приватной подсети {{ baremetal-name }} к on-premise-ресурсам {#check-bms-to-onprem}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с сервером `server-m3` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.label_kvm-console }}**.
  
      Откроется окно с терминалом KVM-консоли, в котором вы увидите строку аутентификации:
      
      ```
      server-m3 login:
      ```

      Если вы не видите этой строки, попробуйте [перезапустить](../../baremetal/operations/servers/server-stop-and-start.md#restart) сервер.

  1. В терминале KVM-консоли введите имя пользователя `root` и нажмите **ENTER**.
  1. В строке для ввода пароля вставьте сгенерированный при аренде сервера пароль и нажмите **ENTER**. Обратите внимание, что при наборе или вставке пароля в ОС Linux введенные символы не отображаются на экране.

      {% include [kvm-paste-tip](../../_includes/baremetal/kvm-paste-tip.md) %}

      Результат:

      ```text
      Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-53-generic x86_64)
      ...
      root@server-m3:~# _
      ```

      Если вы не сохранили пароль администратора к серверу, вы можете создать новый пароль по [инструкции](../../baremetal/operations/servers/reset-password.md) или [переустановить](../../baremetal/operations/servers/reinstall-os-from-marketplace.md) на сервере операционную систему.
  1. В терминале KVM-консоли выполните команду `ping`, чтобы убедиться в доступности виртуальной машины `sample-vm` по ее [внутреннему](../../compute/concepts/network.md#internal-ip) IP-адресу:

      ```bash
      ping <внутренний_IP-адрес_ВМ> -c 5
      ```

      Узнать внутренний IP-адрес ВМ вы можете в [консоли управления]({{ link-console-main }}) в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** на странице с информацией о ВМ.

      Результат:

      ```text
      PING 192.168.11.2 (192.168.11.2) 56(84) bytes of data.
      64 bytes from 192.168.11.2: icmp_seq=1 ttl=64 time=3.90 ms
      64 bytes from 192.168.11.2: icmp_seq=2 ttl=64 time=0.235 ms
      64 bytes from 192.168.11.2: icmp_seq=3 ttl=64 time=0.222 ms
      64 bytes from 192.168.11.2: icmp_seq=4 ttl=64 time=0.231 ms
      64 bytes from 192.168.11.2: icmp_seq=5 ttl=64 time=0.235 ms

      --- 192.168.11.2 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4086ms
      rtt min/avg/max/mdev = 0.222/0.964/3.899/1.467 ms
      ```

      Сетевая связность между сервером {{ baremetal-name }} и виртуальной машиной установлена, пакеты проходят без потерь.

{% endlist %}

### Проверьте сетевую связность от on-premise-ресурса с приватной подсетью {{ baremetal-name }} {#check-onprem-to-bms}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к виртуальной машине по SSH.
1. В терминале выполните команду `ping`, чтобы убедиться в доступности сервера `server-m3` по его приватному IP-адресу:

      ```bash
      ping <приватный_IP-адрес_сервера> -c 5
      ```

      Узнать приватный IP-адрес сервера {{ baremetal-name }} вы можете в [консоли управления]({{ link-console-main }}) в блоке **Сетевые настройки** на странице с информацией о сервере.

      Результат:

      ```text
      PING 192.168.1.3 (192.168.1.3) 56(84) bytes of data.
      64 bytes from 192.168.1.3: icmp_seq=1 ttl=64 time=0.271 ms
      64 bytes from 192.168.1.3: icmp_seq=2 ttl=64 time=0.215 ms
      64 bytes from 192.168.1.3: icmp_seq=3 ttl=64 time=0.262 ms
      64 bytes from 192.168.1.3: icmp_seq=4 ttl=64 time=0.223 ms
      64 bytes from 192.168.1.3: icmp_seq=5 ttl=64 time=0.208 ms

      --- 192.168.1.3 ping statistics ---
      5 packets transmitted, 5 received, 0% packet loss, time 4106ms
      rtt min/avg/max/mdev = 0.208/0.235/0.271/0.025 ms
      ```

      Сетевая связность между виртуальной машиной и сервером {{ baremetal-name }} установлена, пакеты проходят без потерь.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. Удалить сервер {{ baremetal-name }} нельзя. Вместо этого [откажитесь](../../baremetal/operations/servers/server-lease-cancel.md) от продления аренды сервера.
1. При необходимости удалите приватное соединение:

    {% list tabs group=instructions %}

    - Консоль управления {#console} 
    
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создали инфраструктуру.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
      1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и выберите виртуальный сегмент сети `my-vrf`.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![CircleXmark](../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud.baremetal.action_delete-external-connection }}**.
      1. В открывшемся окне подтвердите удаление.

      В результате статус соединения сменится на `Deleting`. После того как все связи будут удалены, соединение пропадет из списка.

    {% endlist %}
