---
title: Как создать виртуальную машину из публичного образа в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете создать виртуальную машину из публичного образа.
---

# Создать виртуальную машину из публичного образа



Чтобы создать [ВМ](../../concepts/vm.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный [образ](../../concepts/image.md) с программным обеспечением, которое хотите использовать.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../concepts/disk.md):

      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.

  1. {% include [section-storages-secondary-disk](../../../_includes/compute/create/section-storages-secondary-disk.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}

      {% note info %}

      Каждый публичный образ имеет свои минимальные системные требования к ВМ. Например, для образа [{{ GL }}](/marketplace/products/yc/gitlab) из {{ marketplace-full-name }} требуется не меньше 4 виртуальных ядер и 8 ГБ оперативной памяти.

      {% endnote %}

  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}

      {% note info %}

      Собственные SSH-ключи на ВМ с включенным доступом по {{ oslogin }} передавайте через [метаданные](../../concepts/vm-metadata.md#how-to-send-metadata).

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ занимает несколько минут. Когда ВМ перейдет в статус `RUNNING`, переходите к [настройке программного обеспечения](setup.md). Следить за статусами ВМ можно в списке ВМ каталога.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Подготовьте [пару ключей](../../operations/vm-connect/ssh.md#creating-ssh-keys) (открытый и закрытый) для SSH-доступа на ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) {{ marketplace-full-name }}.

     {% include [id-info](../../../_includes/compute/id-info.md) %}

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
     | b0c6n43f9lgh******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.130.0.0/24] |
     | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.129.0.0/24] |
     | e9bnlm18l70a******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
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

      * `--name` — имя ВМ. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует выбранной подсети.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          * `subnet-name` — имя выбранной подсети.
          * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

          {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

      * `--create-boot-disk` — настройки загрузочного диска ВМ:
          * `image-family` — [семейство образов](../../concepts/image.md#family), например, `centos-7`. Эта опция позволит установить последнюю версию ОС из указанного семейства.

      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

          {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

          Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/vm-metadata.md#how-to-send-metadata) данные этих пользователей с помощью параметра `--metadata-from-file`.

  {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

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

     resource "yandex_compute_instance" "linux-vm" {
       name        = "linux-vm"
       platform_id = "standard-v3"
       zone        = "<зона_доступности>"

       resources {
         cores  = "<количество_ядер_vCPU>"
         memory = "<объем_RAM_ГБ>"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet-1.id
         nat       = true
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<зона_доступности>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = yandex_vpc_network.network-1.id
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
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
       * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ. Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata` — в метаданных необходимо передать имя пользователя и [публичный ключ для SSH-доступа](../vm-connect/ssh.md#creating-ssh-keys) на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).

           Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/vm-metadata.md#how-to-send-metadata) данные этих пользователей в файле и передайте в блоке `metadata`.
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

{% endlist %}