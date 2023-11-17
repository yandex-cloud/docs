---
title: "Как создать виртуальную машину из пользовательского образа"
description: "Следуя данной инструкции, вы сможете создать виртуальную машину из пользовательского образа."
---

# Создать виртуальную машину из пользовательского образа

## Перед началом работы {#before-you-begin}

[Подготовьте и загрузите](../image-create/upload.md) [образ](../../concepts/image.md), из которого будет создаваться [ВМ](../../concepts/vm.md).

Убедитесь, что загруженный образ находится в состоянии `READY`.

## Создайте ВМ из подготовленного образа {#create-vm-from-image}

{% list tabs %}

- Консоль управления

  
  @[youtube](https://www.youtube.com/watch?v=M9KoXX4ueAI&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=9&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Введите имя и описание ВМ. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из образов:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom }}** и нажмите **{{ ui-key.yacloud.compute.instances.create.button_choose }}**.
      * В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}**.
      * Выберите образ из списка и нажмите **{{ ui-key.yacloud.common.apply }}**. 

  
  1. {% include [encryption-section-boot](../../../_includes/compute/encryption-section-boot.md) %}


  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** [добавьте диск](create-from-disks.md):

      * Нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * Введите имя диска.
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Укажите нужный размер блока.
      * Укажите нужный размер диска.

      
      * {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}


      * (Опционально) Включите опцию **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
      * Выберите наполнение `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}`.
      * Выберите нужный образ.
      * Нажмите **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.

  
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}** подключите [файловое хранилище](../../concepts/filesystem.md):

     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
     * В открывшемся окне выберите файловое хранилище.
     * Укажите имя устройства.
     * Нажмите **{{ ui-key.yacloud.compute.nfs.button_attach-filesystem-to-the-instance }}**.
 

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости сделайте ВМ [прерываемой](../../concepts/preemptible-vm.md).
     * (Опционально) Включите [программно-ускоренную сеть](../../concepts/software-accelerated-network.md).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

     {% include [network-settings](../../../_includes/compute/network-settings.md) %}

  
  1. {% include [backup-info](../../../_includes/compute/backup-info.md) %}


  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

     * (Опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
     * (Опционально) [Включите доступ к ВМ через OS Login](../vm-connect/os-login.md). Опция доступна только для образов Linux.

       {% note info %}

       {% include [preview](../../../_includes/preview-pp.md) %}

       {% endnote %}

     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

       {% note alert %}

       Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

       {% endnote %}

     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../operations/vm-connect/ssh.md#creating-ssh-keys).
     * Если требуется, разрешите доступ к [серийной консоли](../../operations/serial-console/index.md).

     {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_placement }}** выберите [группу размещения](../../concepts/placement-groups.md) ВМ.
  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Получите список образов в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute image list
     ```

     Результат:

     ```text
     +----------------------+-----------------+--------+-------------+--------+
     |          ID          |      NAME       | FAMILY | PRODUCT IDS | STATUS |
     +----------------------+-----------------+--------+-------------+--------+
     |         ...          |        ...      |        |             |  ...   |
     | fd8gkcd3l6ov84aon8s1 | your-test-image |        |             | READY  |
     |         ...          |        ...      |        |             |  ...   |
     +----------------------+-----------------+--------+-------------+--------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного образа.
  1. Создайте ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance create \
       --name test-vm-from-image \
       --zone {{ region-id }}-a \
       --create-boot-disk name=disk1,size=5,image-id=fd8gkcd3l6ov84aon8s1 \
       --public-ip \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     Данная команда создаст ВМ с загрузочным диском на 5 ГБ из заранее загруженного образа с именем `test-vm-from-image`.

     {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     На ВМ будет создан пользователь `yc-user` с публичным ключом из файла `~/.ssh/id_ed25519.pub`. ВМ получит [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP, исключите флаг `--public-ip`.


- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать ВМ из пользовательского образа:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {

       name                      = "vm-from-image"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_в_ГБ>
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор_образа>"
         }
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
       name       = "subnet1"
       zone       = "<зона_доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:
     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор [загруженного](../image-create/upload.md) образа.
       * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#network). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}