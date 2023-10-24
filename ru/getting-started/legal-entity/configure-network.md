# Настройте безопасную сетевую конфигурацию

## Зарезервируйте два статических публичных IP-адреса {#reserve-ips}

Для работы интернет-сервиса потребуются два статических публичных IP-адреса: один будет назначен VPN-шлюзу, а другой — сетевому балансировщику.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в каталоге, где требуется зарезервировать IP-адреса.
    1. Откройте вкладку **{{ ui-key.yacloud.vpc.switch_addresses }}**. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
    1. В открывшемся окне выберите зону доступности `{{ region-id }}-b`. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.
    1. Снова нажмите **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
    1. В открывшемся окне выберите зону доступности `{{ region-id }}-a`. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}

## Создайте ВМ для сервиса во всех зонах доступности {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте ваш каталог и нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**. Выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
    1. Укажите имя виртуальной машины: `web-node-a`.
    1. Выберите зону доступности `{{ region-id }}-a`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}** и выберите образ [Drupal](https://cloud.yandex.ru/marketplace/products/f2e90bncf96u25a9cirp).
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите подсеть `subnet-a`. В блоке **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
    1. В поле **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите логин и SSH-ключ для доступа к ВМ.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    1. Повторите операции для ВМ `web-node-b` и `web-node-c`. Создайте их в зонах `{{ region-id }}-b` и `{{ region-id }}-c`, и подключите к подсетям `subnet-b` и `subnet-c` соответственно.

{% endlist %}

## Создайте IPSec-инстанс для удаленного доступа {#create-ipsec-instance}

Для организации защищенного доступа к вашим ресурсам создайте IPSec-инстанс.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте ваш каталог и нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**. Выберите пункт **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
    1. Укажите имя виртуальной машины: `vpc`.
    1. Выберите зону доступности `{{ region-id }}-a`.
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**, нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.image_button_show-all-products }}** и выберите образ [IPSec-инстанс](https://cloud.yandex.ru/marketplace/products/f2e70ohdvsd0jgp2302j).
    1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите подсеть `subnet-a`. В блоке **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите из списка зарезервированный IP-адрес.
    1. В поле **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите логин и SSH-ключ для доступа к ВМ.
    1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
    
{% endlist %}

## Настройте маршрутизацию для VPN {#vpn-routing}

Настройте маршрутизацию между удаленной сетью и IPSec-инстансом. В примере будет использоваться подсеть `192.168.0.0/24`. 

### Создайте таблицу маршрутизации {#create-route-table}

Создайте таблицу маршрутизации и добавьте в нее [статические маршруты](../../vpc/concepts/static-routes.md): 

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в каталоге, где требуется настроить маршрутизацию.
    1. Выберите сеть, в которой требуется создать таблицу маршрутизации.
    1. На панели слева выберите ![image](../../_assets/vpc/route-tables.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Задайте имя таблицы маршрутизации: `vpn-route`.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
    1. В открывшемся окне введите префикс подсети назначения на удаленной площадке, в примере это `192.168.0.0/24`.
    1. В поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** укажите внутренний IP-адрес IPSec-шлюза. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.
    
{% endlist %}

### Привяжите таблицу маршрутизации ко всем подсетям {#associate-route-table}

Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети. Для этого:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в каталоге, где требуется настроить маршрутизацию.
    1. Выберите сеть, в которой находятся подсети, которым нужно назначить таблицу маршрутизации.
    1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
    1. В открывшемся меню выберите пункт **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
    1. В открывшемся окне выберите созданную таблицу в списке.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.
    1. Привяжите таблицу маршрутизации `vpn-route` ко всем трем подсетям.

{% endlist %}

## Создайте и настройте группы безопасности {#create-security-group}

Чтобы разделить трафик между сегментами сети, необходимо создать группы безопасности и настроить в них правила приема и отправки трафика.

### Создайте группу безопасности для VPN {#create-vpn-sg}

Для работы VPN необходимо разрешить прием и передачу трафика на UDP-порты `500` и `4500` из внешней сети — это необходимо для работы IPSec-туннеля. Также необходимо разрешить передачу трафика между подсетями вашей виртуальной сети и сетью на удаленной площадке.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** в каталоге, где требуется создать группу безопасности.
    1. На панели слева выберите ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
    1. Введите имя группы безопасности — `vpn-sg`.
    1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть, к которой будет относиться группа безопасности.
    1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте правила для управления трафиком: 
       1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}**.
       1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
       1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите порт: `500`.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}`.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** укажите публичный адрес удаленного VPN-концентратора с маской `32`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. 
    1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
       1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите порт: `4500`.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_udp }}`.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** укажите публичный адрес удаленного VPN-концентратора с маской `32`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
    1. Настройте правила, разрешающие передачу трафика между веб-серверами и машинами на удаленной площадке. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
       1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
       1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** укажите CIDR внутренней сети — `10.0.0.0/8`. 
       1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}** и укажите CIDR удаленной площадки — `192.168.0.0/24`.
    1. Создайте такие же правила для входящего трафика.

{% endlist %}

### Создайте группу безопасности для ВМ интернет-сервиса {#create-service-sg}

Создайте группу безопасности `web-service-sg` и настройте правила для трафика.

#### Правила для исходящего трафика {#web-service-egress}

Разрешите исходящие соединения к другим машинам из группы безопасности:

* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`;
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`;
* **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

#### Правила для входящего трафика {#web-service-ingress}

Разрешите следующие входящие соединения:

1. HTTP-соединения от нескольких тестовых несуществующих IP-адресов: 
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}**: `1.1.1.1/32`, `85.32.45.45/32`.
1. HTTPS-соединения от нескольких тестовых несуществующих IP-адресов:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}**: `1.1.1.1/32`, `85.32.45.45/32`.
1. TCP-соединения для доступа по SSH:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}**: `0.0.0.0/0`.
1. Соединения от других машин из группы безопасности:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.
1. Проверки состояния от сетевого балансировщика:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}**: `198.18.235.0/24` и `198.18.248.0/24`.

## Назначьте группы безопасности ВМ {#assign-security-groups-vm}

Чтобы правила групп безопасности начали действовать, группы необходимо назначить сетевым интерфейсам ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. Выберите виртуальную машину `vpn`.
    1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** нажмите значок ![options](../../_assets/options.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
    1. В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** выберите группу безопасности `vpn-sg`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
    1. Повторите шаги и назначьте группу безопасности `web-service-sg` виртуальным машинам `web-node-a`, `web-node-b` и `web-node-c`.
    
{% endlist %}

## Создайте сетевой балансировщик {#create-load-balancer}

Сетевой балансировщик будет распределять входящий трафик интернет-сервиса по ВМ, объединенным в целевую группу. 

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    Чтобы создать сетевой балансировщик:
    1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** в каталоге, где требуется создать балансировщик.
    1. Нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.button_create }}**.
    1. Задайте имя балансировщика: `web-service-lb`.
    1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_address-type }}** выберите `{{ ui-key.yacloud.common.label_list }}` и укажите публичный статический адрес.
    1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_listeners }}** нажмите кнопку **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-listener }}**.
    1. В открывшемся окне введите имя обработчика и укажите порт `80` в полях **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-port }}** и **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.field_listener-target-port }}**. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. В блоке **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}** нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
    1. В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** нажмите на список и нажмите **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
    1. В открывшемся окне задайте имя целевой группы: `web-tg`.
    1. Выберите виртуальные машины `web-node-a`, `web-node-b` и `web-node-c`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Выберите созданную целевую группу из списка.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    
{% endlist %}

## Проверьте работоспособность инфраструктуры {#test}

Проверьте работоспособность инфраструктуры и убедитесь, что трафик к ВМ интернет-сервиса поступает только от разрешенных правилами адресов:

1. Выполните на вашем компьютере команду `curl <Публичный IP-адрес сетевого балансировщика>`. Убедитесь, что ответ не поступил.
1. Создайте группу безопасности `web-service-test-sg` без правил и назначьте ее ВМ `web-node-a`, `web-node-b` и `web-node-c`.
1. Создайте в группе безопасности `web-service-test-sg` следующее правило для входящего трафика:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `80`,
   * **{{ ui-key.yacloud.vpc.network.security-groups.label_destination-type-cidr }}**: `<IP-адрес вашего компьютера>/32`.
1. Снова выполните на вашем компьютере команду `curl <Публичный IP-адрес сетевого балансировщика>`. Убедитесь, что в качестве ответа вернулся HTML-код стартовой страницы Drupal.
1. Удалите тестовую группу.

##  Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые ресурсы, удалите созданные [виртуальные машины](../../compute/operations/vm-control/vm-delete.md) и [балансировщик](../../network-load-balancer/operations/load-balancer-delete.md): 
* `vpn`;
* `web-node-a`; 
* `web-node-b`; 
* `web-node-c`;
* `web-service-lb`.

Освободите и [удалите](../../vpc/operations/address-delete.md) зарезервированные статические публичные IP-адреса.