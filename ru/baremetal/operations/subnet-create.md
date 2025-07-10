---
title: Как создать приватную подсеть в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете создать приватную подсеть, к которой подключите ваши серверы в {{ baremetal-full-name }}.
---

# Создать приватную подсеть

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [приватную подсеть](../concepts/network.md#private-subnet).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.baremetal.label_subnetworks }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет арендован сервер.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-pool }}** выберите [пул](../concepts/servers.md#server-pools), из которого будет арендован сервер.
  1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** укажите имя подсети. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** подсети.
  1. (Опционально) Добавьте метки.
  1. (Опционально) Настройте маршрутизацию для взаимодействия с серверами из других [пулов](../concepts/servers.md#server-pools):

     1. Включите опцию **{{ ui-key.yacloud.baremetal.title_routing-settings }}**.
     1. В поле **{{ ui-key.yacloud.baremetal.field_network-id }}** выберите имеющийся [VRF](../concepts/network.md#vrf-segment) или создайте новый.
     1. В поле **{{ ui-key.yacloud.baremetal.field_CIDR }}** задайте [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.
     1. В поле **{{ ui-key.yacloud.baremetal.field_gateway }}** задайте IP-адрес шлюза, через который трафик из подсети будет идти в другие подсети, подключенные к VRF.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

     1. (Опционально) Включите опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, чтобы подключенные к приватной подсети сетевые интерфейсы серверов получали IP-адреса по DHCP.
     1. Если вы включили опцию **{{ ui-key.yacloud.baremetal.field_dhcp-settings }}**, задайте диапазон адресов, из которого сетевым интерфейсам серверов могут назначаться IP-адреса.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для создания [приватной подсети](../concepts/network.md#private-subnet):

     ```bash
     yc baremetal private-subnet create --help
     ```
  
  1. Создайте подсеть:
     
     ```bash
     yc baremetal private-subnet create \
       --hardware-pool-id <пул> \
       --name <имя_приватной_подсети> \
       --description "<описание_приватной_подсети>" \
       --labels <ключ>=<значение> \
       --vrf-options "vrf-id=<идентификатор_VRF>,vrf-name=<имя_VRF>,cidr=<CIDR>,gateway-ip=<IP-адрес_шлюза>,dhcp=[start-ip=<начало_диапазона_IP-адресов>,end-ip=<конец_диапазона_IP-адресов>]"
     ```

     Где:
     * `--hardware-pool-id` — [пул](../concepts/servers.md#server-pools), из которого будет арендован сервер.
     * `--name` — имя подсети. Требования к имени:
       
       {% include [name-format](../../_includes/name-format.md) %}
       
     * `--description` — описание подсети. Необязательный параметр.
     * `--labels` — метки подсети. Необязательный параметр.
     * `--vrf-options` — настройки маршрутизации для взаимодействия с серверами из других пулов. Необязательный параметр. Возможные настройки:
       * `vrf-id` — идентификатор [виртуального сегмента сети (VRF)](../concepts/network.md#vrf-segment).
       * `vrf-name` — имя VRF.
       * `cidr` — [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.
       * `gateway-ip` — IP-адрес шлюза, через который трафик из подсети будет идти в другие подсети, подключенные к VRF. Необязательный параметр.
     
         {% include [default-gateaway](../../_includes/baremetal/instruction-steps/default-gateaway.md) %}

       * `dhcp` — диапазон адресов, из которого сетевым интерфейсам серверов могут назначаться IP-адреса по DHCP. Необязательный параметр.
     
         {% include [default-dhcp](../../_includes/baremetal/instruction-steps/default-dhcp.md) %}

{% endlist %}

## Пример {#examples}

Создайте приватную подсеть с VRF, CIDR, шлюзом по умолчанию и диапазоном IP-адресов:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal private-subnet create \
    --hardware-pool-id ru-central1-m3 \
    --name demo-private-subnet \
    --description "My first private subnet" \
    --labels env=test \
    --hardware-pool-id ru-central1-m3 \
    --vrf-options "vrf-id=ly5j5qluq32z********,cidr=10.0.0.0/8,gateway-ip=10.0.0.1,dhcp=[start-ip=10.0.1.2,end-ip=10.0.1.10]"
  ```

  Результат:  
  
  ```text
  id: ly5p3zynykcg********
  cloud_id: b1gia87mbaom********
  folder_id: b1gcqo0asnc1********
  name: demo-private-subnet
  description: My first private subnet
  status: READY
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m3
  vrf_options:
    vrf_id: ly5j5qluq32z********
    cidr: 10.0.0.0/8
    dhcp_options:
      start_ip: 10.0.1.2
      end_ip: 10.0.1.10
    gateway_ip: 10.0.0.1
  created_at: "2025-06-26T13:28:29.348159Z"
  labels:
    env: test
  ```

{% endlist %}