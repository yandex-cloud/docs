# Архитектура и защита базового интернет-сервиса


В этом руководстве вы развернете и настроите инфраструктуру базового интернет-сервиса с несколькими виртуальными машинами. Подключение к инфраструктуре будет выполняться с удаленной площадки. Доступ к ВМ будет ограничен с помощью [групп безопасности](../../vpc/concepts/security-groups.md). Нагрузка по серверам с веб-приложениями будет распределяться [сетевым балансировщиком](../../network-load-balancer/concepts/index.md). 

Схема организации сетевого взаимодействия удаленной площадки и базового интернет-сервиса:

![image](../../_assets/tutorials/web-service.svg)

Удаленная площадка:

* Сеть `remote-net` с подсетью `subnet-1` (`10.129.0.0/24`).
* Тестовая ВМ — `vm-1` на базе Linux Ubuntu в подсети `subnet-1`. С помощью этой ВМ проверяется работоспособность инфраструктуры облачной площадки.

{% note info %}

В качестве удаленной площадки вы также можете использовать свой персональный компьютер. Для этого вам необходимо знать CIDR подсети локального компьютера и внешний IP-адрес, который он использует для выхода в интернет.

{% endnote %}

Облачная площадка:

* Сеть `network` с подсетями `subnet-a` (`192.168.5.0/24`), `subnet-b` (`192.168.15.0/24`) и `subnet-d` (`192.168.25.0/24`).
* IPsec-инстанс (шлюз) `vpn` в подсети `subnet-a`. Основная задача IPsec-шлюза — организация IPsec-соединения с удаленной площадкой и обеспечение сетевого взаимодействия между облачными ВМ.
* Таблица маршрутизации со статическим маршрутом `vpn-route` обеспечивает передачу трафика из подсети `subnet-1` удаленной площадки к ВМ облачной площадки через основной IPsec-шлюз.
* ВМ базового интернет-сервиса `web-node-a`, `web-node-b` и `web-node-d` на базе Drupal в подсетях `subnet-a`, `subnet-b` и `subnet-d` соответственно.
* Группа безопасности `vpn-sg` используется на ВМ `vpn` для управления трафиком IPSec-туннеля. Группа безопасности `web-service-sg` обеспечивает передачу трафика между ВМ `web-node-a`, `web-node-b` и `web-node-d`. 
* Сетевой балансировщик `web-service-lb` распределяет входящий трафик между ВМ `web-node-a`, `web-node-b` и `web-node-d`.

Чтобы создать инфраструктуру для интернет-сервиса:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте удаленную площадку](#remote-setup).
1. [Настройте облачную площадку](#cloud-setup).
1. [Проверьте работоспособность инфраструктуры](#test).

Если инфраструктура вам больше не нужна, [удалите](#clear-out) созданные ресурсы.

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичных статических IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* плата за использование сетевого балансировщика (см. [тарифы {{ network-load-balancer-full-name }}](../../network-load-balancer/pricing.md)).

## Настройте удаленную площадку {#remote-setup}

На этом этапе вы создадите и настроите инфраструктуру удаленной площадки. В нее войдут сеть, подсеть и виртуальная машина, с которой будет осуществляться доступ к инфраструктуре базового интернет-сервиса.

{% note info %}

В качестве удаленной площадки вы можете использовать свой персональный компьютер. Для этого узнайте CIDR подсети этого компьютера и внешний IP-адрес, который он использует для выхода в интернет.

Если в качестве удаленной площадки вы будете использовать свой персональный компьютер, пропустите этот раздел и переходите к разделу [Настройте облачную площадку](#cloud-setup).

{% endnote %}

### Создайте сеть и подсеть {#remote-net}

1. [Создайте сеть](../../vpc/operations/network-create.md) `remote-net`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
1. [Создайте подсеть](../../vpc/operations/subnet-create.md) для тестовой ВМ на удаленной площадке со следующими параметрами:

    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-1`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** — `remote-net`.
    * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `10.129.0.0/24`.

### Создайте тестовую ВМ {#remote-test-vm}

Создайте ВМ, которая будет использоваться для подключения извне к инфраструктуре базового интернет-сервиса.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
    1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите образ операционной системы [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin).
    1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть `subnet-1`. 
        * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**, чтобы [подключаться](../../compute/operations/vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [{{ oslogin }}](../../organization/concepts/os-login.md) в {{ org-full-name }}.

        Используя {{ oslogin }}, вы сможете подключаться к ВМ по SSH-ключам и SSH-сертификатам с помощью стандартного SSH-клиента или [CLI](../../cli/quickstart.md). {{ oslogin }} позволяет ротировать SSH-ключи, используемые для доступа к ВМ, и является наиболее [безопасным](../../security/domains/iaas-checklist.md#vm-security) вариантом доступа.

    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ — `vm-1`.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Получите публичный IP-адрес созданной ВМ:

        1. Дождитесь, когда созданная ВМ `vm-1` перейдет в статус `Running` и нажмите на строку с этой ВМ.
        1. Скопируйте значение поля **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** на открывшейся странице обзора ВМ.

            Публичный IP-адрес удаленной ВМ потребуется позднее при [создании группы безопасности](#create-vpn-sg).

{% endlist %}

## Настройте облачную площадку {#cloud-setup}

### Создайте и настройте облачную сеть {#setup-cloud-net}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет развернута инфраструктура.
  1. В списке сервисов выберите **{{ vpc-name }}**.
  1. [Создайте облачную сеть](../../vpc/operations/network-create.md) `network`. При создании сети отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. В сети `network` [создайте подсети](../../vpc/operations/subnet-create.md) со следующими параметрами:
  
      1. Для подключения виртуальной машины `web-node-a` и IPsec-инстанса `vpn`:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-a`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-a`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** — `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.5.0/24`.
  
      1. Для подключения виртуальной машины `web-node-b`:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-b`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-b`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** — `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.15.0/24`.
  
      1. Для подключения виртуальной машины `web-node-d`:
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** — `subnet-d`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** — `{{ region-id }}-d`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** — `network`.
          * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** — `192.168.25.0/24`.

{% endlist %}

### Зарезервируйте два статических публичных IP-адреса {#reserve-ips}

Для работы интернет-сервиса потребуются два статических публичных IP-адреса: один будет назначен VPN-шлюзу, а другой — сетевому балансировщику.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будут зарезервированы IP-адреса.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
    1. В открывшемся окне выберите зону доступности `{{ region-id }}-a` и нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
    1. Повторите шаги 4-5 и зарезервируйте статический публичный IP-адрес в зоне доступности `{{ region-id }}-b`.

{% endlist %}

### Создайте и настройте группы безопасности {#create-security-group}

Чтобы разделить трафик между сегментами сети, необходимо создать группы безопасности и настроить в них правила приема и отправки трафика.

#### Создайте группу безопасности для VPN-шлюза {#create-vpn-sg}

Для работы [VPN](../../glossary/vpn.md) необходимо разрешить прием и передачу трафика на UDP-порты `500` и `4500` из внешней сети — это необходимо для работы IPSec-туннеля. Также необходимо разрешить передачу трафика между подсетями вашей виртуальной сети и сетью на удаленной площадке.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет создана группа безопасности. 
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
    1. Введите имя группы безопасности — `vpn-sg`.
    1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `network`, созданную ранее.
    1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) правила в соответствии с таблицей:

       #|
       || **Направление<br/>трафика** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
       || Входящий | `udp500` | `500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
       || Входящий | `udp4500` | `4500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
       || Входящий | `internal` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | 
         * `192.168.5.0/24`
         * `192.168.15.0/24`
         * `192.168.25.0/24`
         * `10.129.0.0/24` ^1^ ||
       || Исходящий | `udp500` | `500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
       || Исходящий | `udp4500` | `4500` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
       || Исходящий | `intersubnet` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | 
         * `192.168.5.0/24`
         * `192.168.15.0/24`
         * `192.168.25.0/24`
         * `10.129.0.0/24` ^1^ ||
       |#

       ^1^ Если в качестве тестовой ВМ вы будете использовать локальный компьютер, укажите здесь CIDR подсети, в которой этот компьютер находится.

    1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

#### Создайте группу безопасности для виртуальных машин интернет-сервиса {#create-service-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет создана группа безопасности. 
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
    1. Введите имя группы безопасности — `web-service-sg`.
    1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `network`, созданную ранее.
    1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** [создайте](../../vpc/operations/security-group-add-rule.md) правила в соответствии с таблицей:
   
       #|
       || **Направление<br/>трафика** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** /<br/>**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** ||
       || Входящий | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` ||
       || Входящий | `anyself` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` ||
       || Входящий | `healthchecks` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — ||
       || Исходящий | `self` | `0-65535` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` ||
       |#

    1. Нажмите **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте и настройте виртуальные машины на облачной площадке {#setup-cloud-vms}

#### Создайте ВМ для сервиса во всех зонах доступности {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будут созданы ВМ.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
    1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [Drupal 10](/marketplace/products/yc/drupal-8).
    1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите зону доступности `{{ region-id }}-a`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       * Выберите подсеть `subnet-a`. 
       * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
       * Выберите группу безопасности `web-service-sg`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}**:

        * Выберите вариант подключения **SSH-ключ**.
        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** задайте имя пользователя.

            {% note alert %}

            Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

            {% endnote %}

        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}
       
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ — `web-node-a`.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Повторите шаги 4-10 для создания ВМ `web-node-b` и `web-node-d`. Создайте их в зонах `{{ region-id }}-b` и `{{ region-id }}-d`, и подключите к подсетям `subnet-b` и `subnet-d` соответственно.

{% endlist %}

#### Создайте IPSec-инстанс для удаленного доступа {#create-ipsec-instance}

Для организации защищенного доступа к вашим ресурсам создайте IPSec-инстанс.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет создана ВМ.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
    1. Выберите вариант **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [IPSec-инстанс](/marketplace/products/yc/ipsec-instance-ubuntu).
    1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите зону доступности `{{ region-id }}-a`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * Выберите подсеть `subnet-a`.
        * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`. В открывшемся списке выберите зарезервированный IP-адрес.
        * Выберите группу безопасности `vpn-sg`.

    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

        * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ — `vpn`.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Дождитесь, когда созданная ВМ `vpn` перейдет в статус `Running`, и скопируйте значение поля **{{ ui-key.yacloud.compute.instances.column_internal-ip }}** в строке, относящейся этой ВМ.
    
        Внутренний адрес шлюза понадобится при настройке статического маршрута.

{% endlist %}

### Настройте маршрутизацию для VPN {#vpn-routing}

Настройте маршрутизацию между подсетью на удаленной площадке и IPSec-инстансом.

#### Создайте таблицу маршрутизации {#create-route-table}

Создайте [таблицу маршрутизации](../../vpc/concepts/routing.md#rt-vpc) и добавьте в нее [статические маршруты](../../vpc/concepts/routing.md#static):

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет настроена маршрутизация.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. Выберите сеть `network`, созданную ранее.
    1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.overview.button_create_route-table }}**.
    1. Укажите имя таблицы маршрутизации: `vpn-route`.
    1. В блоке **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}** нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
    1. В открывшемся окне:
       * В поле **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** введите `10.129.0.0/24`.

           Если в качестве тестовой ВМ вы будете использовать локальный компьютер, укажите CIDR его подсети.
       * В поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** укажите внутренний IP-адрес IPSec-шлюза.
       * Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

{% endlist %}

#### Привяжите таблицу маршрутизации ко всем подсетям {#associate-route-table}

Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации ко всем подсетям в сети `network` на облачной площадке.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется настроить маршрутизацию.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
    1. В строке с подсетью `subnet-a` нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.subnet.add-route-table.field_route-table-id }}** выберите созданную ранее таблицу `vpn-route`.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
    1. Повторите шаги 4-6 для привязки таблицы маршрутизации `vpn-route` к подсетям `subnet-b` и `subnet-d`.

{% endlist %}

### Создайте сетевой балансировщик {#create-load-balancer}

Сетевой балансировщик будет распределять входящий трафик интернет-сервиса между ВМ, объединенными в целевую группу. 

Чтобы создать сетевой балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать балансировщик.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
  1. Задайте имя балансировщика — `web-service-lb`.
  1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** выберите `{{ ui-key.yacloud.common.label_list }}` и укажите публичный статический адрес.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**. В открывшемся окне:

      1. Введите имя обработчика `web-service-lb-listener`.
      1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** укажите `80`.
      1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}** укажите `80`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.

      1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** выберите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**. В открывшемся окне:

          1. Задайте имя целевой группы: `web-tg`.
          1. Выберите виртуальные машины `web-node-a`, `web-node-b` и `web-node-d`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. Выберите созданную целевую группу `web-tg`.
  1. В блоке с созданной целевой группой:

      1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_edit-health-check }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** выберите `{{ ui-key.yacloud.common.label_tcp }}` и нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Проверьте работоспособность инфраструктуры {#test}

Проверьте работоспособность инфраструктуры и убедитесь, что трафик к ВМ интернет-сервиса не поступает извне:

1. На удаленном компьютере выполните команду:

    ```bash
    curl <публичный_IP-адрес_сетевого_балансировщика>
    ```
    
    Убедитесь, что ответ от сервера не поступил. Это означает, что сетевой трафик к серверам Drupal запрещен.
1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности `web-service-sg` два новых правила для входящего трафика:

   #|
   || **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
   || http-external-vm | 80 | TCP | CIDR | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
   || https-external-vm | 443 | TCP | CIDR | `<публичный_IP-адрес_удаленной_ВМ>/32` ||
   |#

   Добавленные правила разрешают доступ с публичного адреса ВМ на удаленной площадке к ВМ целевой группы сетевого балансировщика.

1. Снова выполните на удаленном компьютере команду:

    ```bash
    curl <публичный_IP-адрес_сетевого_балансировщика>
    ```

    Убедитесь, что в качестве ответа вернулся HTML-код стартовой страницы Drupal. Это означает, что добавленные в группу безопасности правила разрешили сетевой доступ к виртуальным машинам Drupal с IP-адреса удаленного компьютера.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые ресурсы:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. [Удалите](../../network-load-balancer/operations/load-balancer-delete.md) сетевой балансировщик.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированные статические публичные IP-адреса.
1. При необходимости удалите [таблицу маршрутизации](../../vpc/operations/delete-route-table.md), [группы безопасности](../../vpc/operations/security-group-delete.md), [подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).