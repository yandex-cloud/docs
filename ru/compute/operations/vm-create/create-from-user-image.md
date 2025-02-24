
# Создать виртуальную машину из пользовательского образа

## Перед началом работы {#before-you-begin}

[Подготовьте и загрузите](../image-create/upload.md) [образ](../../concepts/image.md) в {{ compute-name }}, из которого будет создаваться [ВМ](../../concepts/vm.md).

Убедитесь, что загруженный образ находится в состоянии `READY`.

## Создайте ВМ из подготовленного образа {#create-vm-from-image}

{% include [independent-resources](../../../_includes/compute/independent-resources.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  [Смотреть видеоинструкцию о создании виртуальной машины из пользовательского образа в консоли управления {{ yandex-cloud }} на YouTube](https://www.youtube.com/watch?v=M9KoXX4ueAI&list=PL1x4ET76A10bW1KU3twrdm7hH376z8G5R&index=9&pp=iAQB).



  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}**.
      * Нажмите кнопку **{{ ui-key.yacloud.common.select }}** и в открывшемся окне выберите **{{ ui-key.yacloud.common.create-new }}**.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в списке ниже выберите нужный образ.
      * (Опционально) В поле **{{ ui-key.yacloud.compute.field_additional }}** включите опцию **{{ ui-key.yacloud.compute.field_disk-autodelete }}**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. Добавьте [диск](../../concepts/disk.md):

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * В открывшемся окне выберите **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Создать новый`.
      * В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в списке ниже выберите нужный образ.
      * Укажите имя диска.
      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужные размер диска и размер блока.
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

  ВМ появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

  За статусом ВМ можно наблюдать в серийной консоли или в [выводе последовательного порта](../vm-info/get-serial-port-output.md).

- CLI {#cli}

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
     | fd8gkcd3l6ov******** | your-test-image |        |             | READY  |
     |         ...          |        ...      |        |             |  ...   |
     +----------------------+-----------------+--------+-------------+--------+
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного образа.

  1. Выберите [подсеть](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Результат:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance create \
       --name <имя_ВМ> \
       --zone <зона_доступности> \
       --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
       --create-boot-disk name=<имя_диска>,size=<размер_диска_ГБ>,image-id=<идентификатор_пользовательского_образа>,kms-key-id=<идентификатор_ключа> \
       --ssh-key <путь_к_файлу_открытого_ключа>
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
         * `name` — имя загрузочного диска. Требования к имени:

             {% include [name-format](../../../_includes/name-format.md) %}

         * `size` — размер диска в ГБ.
         * `image-id` — идентификатор пользовательского образа для ВМ. Укажите идентификатор [загруженного](../image-create/upload.md) образа.
         * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
           
           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}
           
     * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

         Если вы хотите добавить на ВМ одновременно нескольких пользователей с SSH-ключами, [задайте](../../concepts/metadata/sending-metadata.md) данные этих пользователей с помощью параметра `--metadata-from-file`.

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

     Результат:

      ```text
      id: fhmue131en37********
      folder_id: b1g681qpemb4********
      created_at: "2024-03-02T12:58:43Z"
      name: test-vm-from-image
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fhmn9n1uhutc********
        auto_delete: true
        disk_id: fhmn9n1uhutc********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1e:70:46:17
          subnet_id: e9bb9n0v4h17********
          primary_v4_address:
            address: 10.12*.*.**
            one_to_one_nat:
              address: 178.154.***.***
              ip_version: IPV4
      gpu_settings: {}
      fqdn: fhmue131en37********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы создать ВМ из пользовательского образа:
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<имя_диска>"
       type     = "<тип_диска>"
       zone     = "<зона_доступности>"
       size     = "<размер_диска>"
       image_id = "<идентификатор_пользовательского_образа>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-from-image"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<зона_доступности>"

       resources {
         cores  = <количество_ядер_vCPU>
         memory = <объем_RAM_ГБ>
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
       name       = "subnet1"
       zone       = "<зона_доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Где:

     * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):
       * `name` — имя диска. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

       * `type` — тип создаваемого диска.
       * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
       * `size` — размер диска в ГБ.
       * `image_id` — идентификатор пользовательского образа для ВМ. Укажите идентификатор [загруженного](../image-create/upload.md) образа.
     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

{% endlist %}

## Отключите проверку метаданных {#disable-metadata-check}

{% include [disable-metadata-check](../../../_includes/compute/disable-metadata-check.md) %}

#### См. также {#see-also}

* [{#T}](../image-create/custom-image.md)
* [{#T}](../vm-connect/ssh.md)
