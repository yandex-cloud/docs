---
title: Как создать виртуальную машину из набора дисков
description: Следуя данной инструкции, вы сможете создать виртуальную машину из набора существующих дисков.
---

# Создать виртуальную машину из набора дисков


Создать [ВМ](../../concepts/vm.md) можно из существующих [дисков](../../concepts/disk.md). Диски должны находиться в одной из [зон доступности](../../../overview/concepts/geo-scope.md) и не быть добавленными к другим ВМ.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}


  @[youtube](https://www.youtube.com/watch?v=SsM2c6YW5sg&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=8&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте [диск](../../concepts/disk.md):

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Подключить существующий`.
      * Выберите нужный диск.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Получите список дисков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужных дисков.
  1. Создайте ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --use-boot-disk disk-name=first-disk \
       --attach-disk disk-name=second-disk \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     Данная команда создаст ВМ:
     * С именем `first-instance`.

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * В зоне доступности `{{ region-id }}-a`.
     * В [подсети](../../../vpc/concepts/network.md#network) `default-a`.
     * С [публичным IP-адресом](../../../vpc/concepts/address.md#public-addresses) и двумя дисками.

     Чтобы указать необходимость удаления диска при удалении ВМ, установите флаг `--auto-delete`:

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --use-boot-disk disk-name=first-disk,auto-delete=yes \
       --attach-disk disk-name=second-disk,auto-delete=yes \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать ВМ из набора дисков:
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
       name                      = "vm-from-disks"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_ГБ>
       }

       boot_disk {
         disk_id = <идентификатор_загрузочного_диска>
       }

       secondary_disk {
         disk_id = "<идентификатор_дополнительного_диска>"
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
     * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):
       * `name` — имя диска.
       * `type` — [тип](../../concepts/disk.md#disks_types) создаваемого диска.
       * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
       * `size` — размер диска в ГБ.
       * `image_id` — идентификатор [образа](../../concepts/image.md) для ВМ. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance` — описание [ВМ](../../concepts/vm.md):
       * `name` — имя ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной платформе.
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
       * `secondary_disk` — дополнительный диск для подключения к ВМ. Укажите идентификатор дополнительного диска. Если диска нет, [создайте](../disk-create/empty.md) его.
       * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ. Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata` — в метаданных необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}