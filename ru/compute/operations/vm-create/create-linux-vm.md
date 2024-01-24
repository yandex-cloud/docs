---
title: "Как создать виртуальную машину Linux на базе публичного образа"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину с операционной системой Linux."
---

# Создать виртуальную машину из публичного образа Linux


{% list tabs group=instructions %}

- Консоль управления {#console}

  
  @[youtube](https://www.youtube.com/watch?v=PN3b26KXb78)


  {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) {{ marketplace-full-name }} на базе ОС Linux (например, [CentOS 7](/marketplace/products/yc/centos-7)).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Выберите [подсеть](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
     | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
     | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      Где:
      * `name` — имя ВМ.

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `subnet-name` — имя выбранной подсети.
      * `image-family` — [семейство образов](../../concepts/image.md#family), например, `centos-7`. Эта опция позволит установить последнюю версию ОС из указанного семейства.
      * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адрес, исключите параметр.
      * `ssh-key` — путь до публичного SSH-ключа. Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.


  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "<зона_доступности>"
       size     = "<размер_диска>"
       image_id = "<идентификатор_образа>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "linux-vm"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = "<количество ядер vCPU>"
         memory = "<объем_RAM_в_ГБ>"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<зона_доступности>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:

     * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):
       * `name` — имя диска.
       * `type` — тип создаваемого диска.
       * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
       * `size` — размер диска в ГБ.
       * `image_id` — идентификатор образа для ВМ. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска. 
       * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый SSH-ключ для доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- API {#api}

  Создайте ВМ с помощью метода REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/):
  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.
  1. Получите [{{ iam-full-name }}-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:

     
     * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.


     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
     * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
  1. [Получите идентификатор](../../../resource-manager/operations/folder/get-id.md) [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Получите информацию об [образе](../../concepts/image.md), из которого надо создать ВМ (идентификатор образа и минимальный размер [диска](../../concepts/disk.md)):
     * Если вы знаете [семейство образа](../../concepts/image.md#family), получите информации о последнем образе в этом семействе:

       ```bash
       export IAM_TOKEN=CggaATEVAgA...
       export FAMILY=ubuntu-1804
       curl -H "Authorization: Bearer ${IAM_TOKEN}" \
         "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
       ```

     * Вы можете получить информацию об образе из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
  1. Получите идентификатор [подсети](../../../vpc/concepts/network.md#subnet) и идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md). В запросе укажите идентификатор каталога, в котором создана подсеть:

     ```bash
     export IAM_TOKEN=CggaATEVAgA...
     export FOLDER_ID=b1gvmob95yysaplct532
     curl -H "Authorization: Bearer ${IAM_TOKEN}" \
       "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
     {
       "subnets": [
        {
          "v4CidrBlocks": [
            "10.130.0.0/24"
          ],
          "id": "b0c6n43ftldh30l0vfg2",
          "folderId": "b1gvmob95yysaplct532",
          "createdAt": "2018-09-23T12:15:00Z",
          "name": "default-{{ region-id }}-a",
          "description": "Auto-created default subnet for zone {{ region-id }}-a",
          "networkId": "enpe3m3fagludao8aslg",
          "zoneId": "{{ region-id }}-a"
        },
        ...
       ]
     }
     ```

  1. Создайте файл с телом запроса на создание ВМ, например, `body.json`:

     ```json
     {
       "folderId": "b1gvmob95yysaplct532",
       "name": "instance-demo-no-pwauth",
       "zoneId": "{{ region-id }}-a",
       "platformId": "standard-v3",
       "resourcesSpec": {
         "memory": "2147483648",
         "cores": "2"
       },
       "metadata": {
         "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
       },
       "bootDiskSpec": {
         "diskSpec": {
           "size": "2621440000",
           "imageId": "fd8rc75pn12fe3u2dnmb"
         }
       },
       "networkInterfaceSpecs": [
         {
           "subnetId": "b0c6n43ftldh30l0vfg2",
           "primaryV4AddressSpec": {
             "oneToOneNatSpec": {
               "ipVersion": "IPV4"
             }
           }
         }
       ]
     }
     ```

     Где:
     * `folderId` — идентификатор каталога.
     * `name` — имя, которое будет присвоено ВМ при создании.
     * `zoneId` — зона доступности, которая соответствует выбранной подсети.
     * `platformId` — [платформа](../../concepts/vm-platforms.md).
     * `resourceSpec` — ресурсы, доступные ВМ. Значения должны соответствовать выбранной платформе.
     * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `bootDiskSpec` — настройки загрузочного диска. Укажите идентификатор выбранного образа и размер диска.

       {% include [id-info](../../../_includes/compute/id-info.md) %}

       Размер диска должен быть не меньше минимального размера диска, указанного в информации об образе.
     * `networkInterfaceSpecs` — настройки [сети](../../../vpc/concepts/network.md#network).
       * `subnetId` — идентификатор выбранной подсети.
       * `primaryV4AddressSpec` — IP-адрес, который будет присвоен ВМ. Чтобы добавить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ, укажите:

         ```json
         "primaryV4AddressSpec": {
           "oneToOneNatSpec": {
             "ipVersion": "IPV4"
           }
         }
         ```

     Подробнее про формат тела запроса в [справочнике API](../../api-ref/Instance/create.md).
  1. Создайте ВМ:

     ```bash
     export IAM_TOKEN=CggaATEVAgA...
     curl -X POST \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -d '@body.json' \
       https://compute.{{ api-host }}/compute/v1/instances
     ```

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../vm-connect/ssh.md).