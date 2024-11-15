---
title: Создать группу виртуальных машин с фиксированными IP-адресами
description: Следуя данной инструкции, вы сможете создать группу виртуальных машин с фиксированными IP-адресами.
---

# Создать группу виртуальных машин с фиксированными IP-адресами


Вы можете использовать [теги](../../concepts/instance-groups/policies/allocation-policy.md#tags) и [переменные](../../concepts/instance-groups/variables-in-the-template.md), чтобы создать группу ВМ с заранее заданными [внутренними](../../../vpc/concepts/address.md#internal-addresses) и [публичными](../../../vpc/concepts/address.md#public-addresses) IP-адресами.

Чтобы создать группу ВМ с фиксированными IP-адресами:

{% list tabs group=instructions %}

- CLI {#cli}

  1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
  1. Создайте облачную [сеть](../../../vpc/operations/network-create.md) и [подсети](../../../vpc/operations/subnet-create.md), например в двух [зонах доступности](../../../overview/concepts/geo-scope.md), если у вас их нет.
  1. Если вы хотите, чтобы ВМ из группы были доступны из интернета, [зарезервируйте](../../../vpc/operations/get-static-ip.md) необходимое количество статических публичных IP-адресов. Для примера, приведенного ниже, вам будет достаточно четырех IP-адресов.
  1. {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания группы ВМ:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Выберите один из публичных образов {{ marketplace-full-name }}, например [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Подготовьте файл с [YAML-спецификацией](../../concepts/instance-groups/specification.md) группы ВМ с произвольным именем, например `specification.yaml`.

      Чтобы назначить ВМ группы фиксированные IP-адреса, добавьте в спецификацию:

      * В поле `allocation_policy` — вложенное поле `zones` с парными параметрами `zone_id` и `instance_tags_pool` для каждой из [зон доступности](../../../overview/concepts/geo-scope.md), в которых будут создаваться ВМ. Например, если ВМ группы будут расположены в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b`, поле `allocation_policy` будет выглядеть так:

          ```yml
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
                instance_tags_pool:
                - <тег1_зоны_{{ region-id }}-a>
                - <тег2_зоны_{{ region-id }}-a>
              - zone_id: {{ region-id }}-b
                instance_tags_pool:
                - <тег1_зоны_{{ region-id }}-b>
                - <тег2_зоны_{{ region-id }}-b>
          ```

          Где:

          * `zone_id` — идентификатор зоны доступности.
          * `instance_tags_pool` — список уникальных [тегов](../../concepts/instance-groups/policies/allocation-policy.md#tags) для привязки IP-адресов к ВМ группы. Значение тега участвует в формировании имен ВМ, а также в формировании переменных, содержащих IP-адреса ВМ. Количество тегов для каждой зоны доступности должно соответствовать количеству ВМ, создаваемых в этой зоне. Примеры возможных значений тегов: `ru1-a1`, `ru1-b2` и т.п.
          
      * Поле `variables`, содержащее набор переменных, через которые с помощью шаблонов в группу ВМ передаются IP-адреса создаваемых ВМ:

          ```yml
          variables:
            - key: ip_<тег1_зоны_{{ region-id }}-a>
              value: <внутренний_IP-адрес1>
            - key: external_ip_<тег1_зоны_{{ region-id }}-a>
              value: <публичный_IP-адрес1>
            ...
            - key: ip_<тег2_зоны_{{ region-id }}-b>
              value: <внутренний_IP-адрес_4>
            - key: external_ip_<тег2_зоны_{{ region-id }}-b>
              value: <публичный_IP-адрес_4>
          ```

          Где:

          * `key` — имя переменной, в формате `<префикс>_<тег>`:
              * `<префикс>` определяет тип IP-адреса. Например, для внутренних адресов можно использовать префикс `ip`, а для публичных IP-адресов — `external_ip`.

              * `<тег>` должен быть идентичен значению соответствующего тега, заданного для данной ВМ в поле `allocation_policy`, например `ru1-a1`.

          * `value` — значение переменной: внутренний или публичный IP-адрес создаваемой ВМ.

              Внутренние IP-адреса должны принадлежать диапазону IP-адресов, выделенному для указанной подсети в соответствующей зоне доступности.

              Если виртуальные машины группы будут создаваться без привязанных публичных IP-адресов, не задавайте переменные с префиксом `external_ip`.

          Подробнее об использовании переменных в шаблоне ВМ см. в разделе [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

      * В поле `instance_template.name` — имя виртуальной машины, содержащее шаблон тега. Например: `sample-vm-{instance.tag}`. После подстановки значений тегов в этот шаблон имена ВМ будут выглядеть как `sample-vm-ru1-a1`, `sample-vm-ru1-b2` и т.д.

      * В поле `instance_template.network_interface_specs` — идентификаторы подсетей и шаблоны IP-адресов:

          ```yml
          instance_template:
            ...
            network_interface_specs:
              - subnet_ids:
                  - <идентификатор_подсети_в_{{ region-id }}-a>
                  - <идентификатор_подсети_в_{{ region-id }}-b>
                primary_v4_address_spec:
                  address: "{ip_{instance.tag}}"
                  one_to_one_nat_spec:
                    ip_version: IPV4
                    address: "{<external_ip_{instance.tag}}"
          ```

          Где:
          * `subnet_ids` — список идентификаторов [подсетей](../../../vpc/concepts/network.md#subnet), в которых должны располагаться ВМ. Требуется указать одну подсеть в каждой из зон доступности, в которых будут созданы ВМ группы.
          * `primary_v4_address_spec.address` — шаблон внутренних IP-адресов. В шаблон будет подставлено значение из переменной, заданной для данной ВМ в поле `variables`.
          * `primary_v4_address_spec.one_to_one_nat_spec.address` — шаблон для публичных IP-адресов. В шаблон будет подставлено значение из переменной, заданной для данной ВМ в поле `variables`.

          Если виртуальные машины группы будут создаваться без привязанных публичных IP-адресов, не добавляйте в спецификацию поле `primary_v4_address_spec.one_to_one_nat_spec`.

      Пример YAML-спецификации:

      ```yml
      service_account_id: ajegtlf2q28a********
      name: my-vm-group-with-fixed-ips
      description: Example of using tags for managing ips. Created with CLI
      scale_policy:
        fixed_scale:
          size: 4
      deploy_policy:
        max_unavailable: 2
      allocation_policy:
        zones:
          - zone_id: {{ region-id }}-a
            instance_tags_pool:
            - ru1-a1
            - ru1-a2
          - zone_id: {{ region-id }}-b
            instance_tags_pool:
            - ru1-b1
            - ru1-b2
      variables:
        - key: ip_ru1-a1
          value: 192.168.2.5
        - key: external_ip_ru1-a1
          value: 84.201.***.**
        - key: ip_ru1-a2
          value: 192.168.2.15
        - key: external_ip_ru1-a2
          value: 130.193.**.**
        - key: ip_ru1-b1
          value: 192.168.1.5
        - key: external_ip_ru1-b1
          value: 84.201.***.**
        - key: ip_ru1-b2
          value: 192.168.1.15
        - key: external_ip_ru1-b2
          value: 84.201.***.*
      instance_template:
        name: sample-vm-{instance.tag}
        platform_id: standard-v2
        resources_spec:
          memory: 2G
          cores: 2
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            image_id: fd8dlvgiatiqd8tt2qke
            type_id: network-hdd
            size: 20g
        network_interface_specs:
          - subnet_ids:
              - e2l3qffk0h6t********
              - e9bijtoprmcu********
            primary_v4_address_spec:
              address: "{ip_{instance.tag}}"
              one_to_one_nat_spec:
                address: "{external_ip_{instance.tag}}"
      ```

      В данном примере приведена спецификация для [создания группы ВМ фиксированного размера](./create-fixed-group.md) с фиксированными внутренними и публичными IP-адресами.

      Подробнее о параметрах спецификации группы ВМ см. в разделе [{#T}](../../concepts/instance-groups/specification.md).

  1. Создайте группу ВМ в каталоге по умолчанию:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      Данная команда создаст группу ВМ со следующими характеристиками:
      * С именем `my-vm-group-with-fixed-ips`.
      * С OC `Ubuntu 22.04 LTS`.
      * С четырьмя ВМ — по две в зонах доступности `{{ region-id }}-a` и `{{ region-id }}-b`.
      * С двумя vCPU и двумя ГБ RAM.
      * С сетевым [HDD-диском](../../concepts/disk.md#disks-types) объемом 20 ГБ.
      * К каждой ВМ группы будут привязаны фиксированные внутренний и публичный [IP-адреса](../../../vpc/concepts/address.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые вы хотите создать:

      ```hcl
      resource "yandex_compute_instance_group" "ig-1" {
        name                = "fixed-ig"
        folder_id           = "<идентификатор_каталога>"
        service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
        deletion_protection = false
        depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
        instance_template {
          name = "sample-vm-{instance.tag}"
          platform_id = "standard-v3"
          resources {
            memory = 2
            cores  = 2
          }

          boot_disk {
            mode = "READ_WRITE"
            initialize_params {
              image_id = "fd8dlvgiatiqd8tt2qke"
            }
          }

          network_interface {
            network_id         = "${yandex_vpc_network.ig-network.id}"
            subnet_ids         = ["${yandex_vpc_subnet.ig-subnet-a.id}", "${yandex_vpc_subnet.ig-subnet-b.id}"]
            nat                = true
            ip_address         = "{ip_{instance.tag}}"
            nat_ip_address     = "{external_ip_{instance.tag}}"
          }

          metadata = {
            user-data = "#cloud-config\n      datasource:\n       Ec2:\n        strict_id: false\n      ssh_pwauth: no\n      users:\n      - name: <имя_пользователя_ВМ>\n        sudo: ALL=(ALL) NOPASSWD:ALL\n        shell: /bin/bash\n        ssh_authorized_keys:\n        - <публичный_SSH-ключ>\n      runcmd: []"
          }
        }

        variables = {
          ip_ru1-a1 = "192.168.2.5"
          external_ip_ru1-a1 = "${yandex_vpc_address.external-address-a1.external_ipv4_address[0].address}"
          ip_ru1-a2 = "192.168.2.15"
          external_ip_ru1-a2 = "${yandex_vpc_address.external-address-a2.external_ipv4_address[0].address}"
          ip_ru1-b1 = "192.168.1.5"
          external_ip_ru1-b1 = "${yandex_vpc_address.external-address-b1.external_ipv4_address[0].address}"
          ip_ru1-b2 = "192.168.1.15"
          external_ip_ru1-b2 = "${yandex_vpc_address.external-address-b2.external_ipv4_address[0].address}"
        }

        scale_policy {
          fixed_scale {
            size = 4
          }
        }

        allocation_policy {
          zones = ["{{ region-id }}-a","{{ region-id }}-b"]
          instance_tags_pool {
            zone = "{{ region-id }}-a"
            tags = ["ru1-a1","ru1-a2"]
          }
          instance_tags_pool {
            zone = "{{ region-id }}-b"
            tags = ["ru1-b1","ru1-b2"]
          }
        }

        deploy_policy {
          max_unavailable = 1
          max_expansion   = 0
        }
      }

      resource "yandex_iam_service_account" "ig-sa" {
        name        = "instance-group-sa"
        description = "Сервисный аккаунт для управления группой ВМ."
      }

      resource "yandex_resourcemanager_folder_iam_member" "editor" {
        folder_id  = "<идентификатор_каталога>"
        role       = "editor"
        member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
        depends_on = [
          yandex_iam_service_account.ig-sa,
        ]
      }

      resource "yandex_vpc_network" "ig-network" {
        name = "ig-network"
      }

      resource "yandex_vpc_subnet" "ig-subnet-a" {
        name           = "ig-subnet-a"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.ig-network.id}"
        v4_cidr_blocks = ["192.168.2.0/24"]
      }

      resource "yandex_vpc_subnet" "ig-subnet-b" {
        name           = "ig-subnet-b"
        zone           = "{{ region-id }}-b"
        network_id     = "${yandex_vpc_network.ig-network.id}"
        v4_cidr_blocks = ["192.168.1.0/24"]
      }

      resource "yandex_vpc_address" "external-address-a1" {
        name = "external-address-a1"

        external_ipv4_address {
          zone_id = "{{ region-id }}-a"
        }
      }

      resource "yandex_vpc_address" "external-address-a2" {
        name = "external-address-a2"

        external_ipv4_address {
          zone_id = "{{ region-id }}-a"
        }
      }

      resource "yandex_vpc_address" "external-address-b1" {
        name = "external-address-b1"

        external_ipv4_address {
          zone_id = "{{ region-id }}-b"
        }
      }

      resource "yandex_vpc_address" "external-address-b2" {
        name = "external-address-b2"

        external_ipv4_address {
          zone_id = "{{ region-id }}-b"
        }
      }
      ```

      Где:
      * `yandex_compute_instance_group` — описание группы ВМ:
        * Общая информация о группе ВМ:
          * `name` — имя группы ВМ.
          * `folder_id` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).
          * `service_account_id` — идентификатор [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
          * `deletion_protection` — защита группы ВМ от удаления: `true` или `false`. Пока опция включена, группу ВМ удалить невозможно. Значение по умолчанию `false`.
        * `instance_template` — [шаблон ВМ](../../concepts/instance-groups/instance-template.md):
          * `name` — имя виртуальной машины, содержащее шаблон [тега](../../concepts/instance-groups/policies/allocation-policy.md#tags), например `sample-vm-{instance.tag}`. После подстановки значений тегов в этот шаблон имена ВМ будут выглядеть как `sample-vm-ru1-a1`, `sample-vm-ru1-b2` и т.д.
          * `platform_id` — [платформа](../../concepts/vm-platforms.md).
          * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
          * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md):
            * `mode` — режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
            * `image_id` — идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
          * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network):
            * `subnet_ids` — список идентификаторов [подсетей](../../../vpc/concepts/network.md#subnet), в которых должны располагаться ВМ. Требуется указать одну подсеть в каждой из зон доступности, в которых будут созданы ВМ группы.
            * `nat` — параметр, задающий привязку публичного IP-адреса к ВМ. Возможные значения `true` и `false`.
            * `ip_address` — внутренний IP-адрес ВМ. В качестве значения используется шаблон, в который будет подставлено значение из переменной, заданной для данной ВМ в блоке `variables`.
            * `nat_ip_address` — публичный IP-адрес ВМ. В качестве значения используется шаблон, в который будет подставлено значение из переменной, заданной для данной ВМ в поле `variables`.
          * `metadata` — в [метаданных](../../concepts/vm-metadata.md) передайте имя пользователя ВМ и открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) этого пользователя на ВМ.

            Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md).

        * `variables` — [переменные](../../concepts/instance-groups/variables-in-the-template.md), назначаемые группе ВМ. Блок содержит список переменных в формате `<имя> = <значение>`. Через переменные с помощью шаблонов в группу ВМ передаются IP-адреса создаваемых ВМ:
          * имя переменной: должно быть в формате `<префикс>_<тег>`:

            * `<префикс>` определяет тип IP-адреса. Например, для внутренних IP-адресов можно использовать префикс `ip`, а для публичных IP-адресов — `external_ip`.

            * `<тег>` должен быть идентичен значению соответствующего тега, заданного для данной ВМ в поле `allocation_policy`, например `ru1-a1`.

          * значение переменной: внутренний или публичный IP-адрес создаваемой ВМ.

              Внутренние IP-адреса должны принадлежать диапазону IP-адресов, выделенному для указанной подсети в соответствующей зоне доступности.

              Если виртуальные машины группы будут создаваться без привязанных публичных IP-адресов, не задавайте переменные с префиксом `external_ip`.

          Подробнее об использовании переменных в шаблоне ВМ см. в разделе [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

        * [Политики](../../concepts/instance-groups/policies/index.md):
          * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
          * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
          * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md) и регионам:
            * `zones` — массив, содержащий идентификаторы зон доступности, в которых будут создаваться ВМ группы.
            * `instance_tags_pool` — список уникальных тегов, необходимых для привязки IP-адресов к ВМ группы. Задается отдельно для каждой зоны доступности, в которых будут создаваться ВМ группы.

              Значение тегов, заданных в массиве `tags`, участвует в формировании имен ВМ, а также в формировании переменных, содержащих IP-адреса ВМ. Количество тегов в массиве `tags` для каждой зоны доступности должно соответствовать количеству ВМ, создаваемых в этой зоне. Примеры возможных значений тегов: `ru1-a1`, `ru1-b2` и т.п.

      * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

        {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * `yandex_resourcemanager_folder_iam_member` — описание прав доступа к [каталогу](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`.
      * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet` — описание [подсетей](../../../vpc/concepts/network.md#subnet), к которым будут подключены ВМ группы.
      * `yandex_vpc_address` — описание зарезервированного статического [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses).

        {% note info %}

        Если у вас уже есть подходящие ресурсы (сервисный аккаунт, облачная сеть и подсети, зарезервированные статические IP-адреса), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

        {% endnote %}

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../../instancegroup/api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md).

{% endlist %}