# Создать виртуальную машину из набора дисков

Создать [ВМ](../../concepts/vm.md) можно из существующих [дисков](../../concepts/disk.md). Диски должны находиться в одной из [зон доступности](../../../overview/concepts/geo-scope.md) и не быть добавленными к другим ВМ.

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

{% list tabs %}

- Консоль управления

  
  @[youtube](https://www.youtube.com/watch?v=SsM2c6YW5sg&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=8&pp=iAQB)


  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Введите имя и описание ВМ. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * Выберите зону доступности, в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** [добавьте диск](create-from-disks.md):
     * Нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
     * Введите имя диска.
     * Выберите [тип диска](../../concepts/disk.md#disks_types).
     * Укажите нужный размер блока.
     * Укажите нужный размер диска.
     * (Опционально) Включите опцию **{{ ui-key.yacloud.compute.instances.create-disk.field_auto-delete }}**, если нужно автоматически удалять диск при удалении ВМ, к которой он будет подключен.
     * Выберите наполнение `{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}`.
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
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.

       {% note alert %}

       Не используйте логин `root` или другие имена, зарезервированные операционной системой. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.

       {% endnote %}

     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [открытого ключа](../../operations/vm-connect/ssh.md#creating-ssh-keys).
     * Если требуется, разрешите доступ к [серийной консоли](../../operations/serial-console/index.md).

     {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

  1. Нажмите **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста (FQDN)](../../../vpc/concepts/address.md#fqdn).

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания ВМ:

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
     * В подсети `default-a`.
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

- API

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  Чтобы создать ВМ из набора дисков:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {

       name                      = "vm-from-disks"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_в_ГБ>
       }

       boot_disk {
         initialize_params {
           disk_id = "<идентификатор_загрузочного_диска>"
         }
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
     * `yandex_compute_instance` — описание [ВМ](../../concepts/vm.md):
       * `name` — имя ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — идентификатор зоны доступности, в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска. Если у вас нет готового загрузочного диска, укажите идентификатор публичного образа с помощью параметра `image_id`.

         {% include [id-info](../../../_includes/compute/id-info.md) %}

       * `secondary_disk` — дополнительный диск для подключения к ВМ. Укажите идентификатор дополнительного диска. Если диска нет, [создайте](../disk-create/empty.md) его.
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