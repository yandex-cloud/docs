1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу безопасности](#create-security-groups).
1. [Создайте тестовую ВМ](#create-vm).
1. [Создайте NAT-инстанс](#create-nat-instance).
1. [Настройте статическую маршрутизацию в облачной сети](#configure-static-route).
1. [Проверьте работу NAT-инстанса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/nat-instance/paid-resources.md) %}


### Подготовьте инфраструктуру {#deploy-infrastructure}

1. [Создайте облачную сеть](../../vpc/operations/network-create.md), например `my-vpc`.
1. В облачной [сети](../../vpc/concepts/network.md#network) [создайте подсети](../../vpc/operations/subnet-create.md), например:

    * `public-subnet`, в которой будет размещен NAT-инстанс.
    * `private-subnet`, в которой будет размещена тестовая ВМ.


## Создайте группу безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают обращаться к ВМ по SSH. В сценарии будет создана группа безопасности `nat-instance-sg`.

Чтобы создать группу безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Откройте вкладку ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности:

      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите имя группы: `nat-instance-sg`.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите сеть `my-vpc`.
      1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

          Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
          --- | --- | --- | --- | --- | ---
          Исходящий | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Входящий | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Входящий | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
          Входящий | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

      1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик. Чтобы открыть все порты, нажмите **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}**, чтобы разрешить передачу трафика по всем протоколам.
      1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите `0.0.0.0/0`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Создайте тестовую виртуальную машину {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../compute/concepts/image.md) и версию операционной системы на базе Linux.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), где находится подсеть `private-subnet`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть для тестовой ВМ, например `private-subnet`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу `nat-instance-sg`.
      * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например, `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `test-vm`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Сохраните имя пользователя, закрытый SSH-ключ и внутренний IP-адрес тестовой ВМ.

{% endlist %}


## Создайте NAT-инстанс {#create-nat-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и выберите образ [NAT-инстанс](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), где находится подсеть `public-subnet`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть для NAT-инстанса, например `public-subnet`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите созданную ранее группу `nat-instance-sg`.
      * Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например, `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `nat-instance`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Сохраните имя пользователя, закрытый SSH-ключ, внутренний и публичный IP-адреса NAT-инстанса.

{% endlist %}


## Настройте статическую маршрутизацию {#configure-static-route}

{% note info %}

При создании NAT-инстанса автоматически настраивается только один сетевой интерфейс. Остальные интерфейсы можно включить вручную. Назначьте каждому новому интерфейсу IP-адрес и пропишите для него маршрут в таблице маршрутизации. В каждой подсети корректным шлюзом будет первый IP-адрес. Например, для подсети `192.168.0.128/25` первым адресом в подсети будет — `192.168.0.129`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте таблицу маршрутизации и добавьте в нее статический маршрут:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать статический маршрут.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![route-tables](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.vpc.network.switch_route-table }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
      1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_name }}** задайте имя таблицы маршрутизации, например `nat-instance-route`. Требования к имени:

          {% include [name-format](../../_includes/name-format.md) %}

      1. В поле **{{ ui-key.yacloud.vpc.route-table-form.field_network-id }}** выберите сеть, например `my-vpc`.
      1. В блоке **{{ ui-key.yacloud.vpc.route-table-form.section_static-routes }}** нажмите **{{ ui-key.yacloud.vpc.route-table-form.label_add-static-route }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.add-static-route.field_destination-prefix }}** введите `0.0.0.0/0`.
      1. В поле **{{ ui-key.yacloud.vpc.add-static-route.field_next-hop-address }}** выберите `{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}`.
      1. В поле **{{ ui-key.yacloud.vpc.add-static-route.value_ip-address }}** укажите внутренний IP-адрес NAT-инстанса. Нажмите кнопку **{{ ui-key.yacloud.vpc.add-static-route.button_add }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.route-table.create.button_create }}**.

  1. Привяжите таблицу маршрутизации к подсети, где находится тестовая ВМ, например `private-subnet`:

      1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
      1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке подсети с тестовой ВМ и выберите **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}**.
      1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.subnet.add-route-table.label_title }}** выберите таблицу `nat-instance-route` и нажмите **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

{% endlist %}

Созданный маршрут можно применять и к другим подсетям в той же сети, кроме подсети, где находится NAT-инстанс.

{% note warning %}

Не привязывайте таблицу маршрутизации к подсети, в которой находится NAT-инстанс. В противном случае будут возникать маршрутные петли, при которых NAT-инстанс будет направлять пакеты не в локальную сеть, а сам себе.

{% endnote %}


## Проверьте работу NAT-инстанса {#test}

{% include [test](../_tutorials_includes/nat-instance/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../compute/operations/vm-control/vm-delete.md) тестовую ВМ и NAT-инстанс.
1. [Удалите](../../vpc/operations/security-group-delete.md) группу безопасности.
1. [Удалите](../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.