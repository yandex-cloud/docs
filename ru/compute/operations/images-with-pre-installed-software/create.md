# Создать виртуальную машину из публичного образа

Чтобы создать [ВМ](../../concepts/vm.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.

  1. В открывшемся списке выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
     * Введите имя ВМ. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

     * Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный [образ](../../concepts/image.md) с программным обеспечением, которое хотите использовать.
  1. (Опционально) Если вы хотите добавить к ВМ дополнительные [диски](../../concepts/disk.md), [выберите их](../vm-create/create-from-disks.md) в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.instances.create.section_disk }}**.

  

  1. (Опционально) Если вы хотите подключить к ВМ дополнительные [файловые хранилища](../../concepts/filesystem.md), подключите их в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** на вкладке **{{ ui-key.yacloud.compute.nfs.label_filesystems }}**. Предварительно необходимо [создать](../filesystem/create.md) хранилища.



  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU и объем RAM.

     {% note info %}

     Каждый публичный образ имеет свои минимальные системные требования к ВМ. Например, для образа [{{ GL }}](/marketplace/products/yc/gitlab) из {{ marketplace-full-name }} требуется не меньше 4 виртуальных ядер и 8 ГБ оперативной памяти.

     {% endnote %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
     * Укажите идентификатор [подсети](../../../vpc/concepts/network.md#subnet) или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка. Можно выбрать зону поиска: в текущем каталоге или во всех каталогах. Если сети нет, нажмите кнопку ![image](../../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** и создайте ее:
       * В открывшемся окне укажите каталог, в котором будет располагаться новая сеть, и имя сети.
       *  В поле **{{ ui-key.yacloud.component.vpc.create-network-dialog.field_advanced }}** выберите опцию **{{ ui-key.yacloud.component.vpc.create-network-dialog.field_is-default }}** — у каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet).

       * Нажмите кнопку **{{ ui-key.yacloud.component.vpc.create-network-dialog.button_create }}**.
     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите способ назначения адреса:
       * `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` — чтобы назначить случайный [IP-адрес](../../../vpc/concepts/address.md) из пула адресов {{ yandex-cloud }}.
       * `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` — чтобы выбрать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [{#T}](../../../vpc/operations/set-static-ip.md).
       * `{{ ui-key.yacloud.component.compute.network-select.switch_none }}` — чтобы не назначать публичный IP-адрес.

     

     * (опционально) При необходимости в поле **{{ ui-key.yacloud.component.compute.network-select.field_advanced }}** выберите опцию [защиты от DDoS-атак](../../../vpc/ddos-protection/index.md).


     * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md) (если соответствующего поля нет, для ВМ будет разрешен любой входящий и исходящий трафик).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
     * (опционально) Выберите или создайте [сервисный аккаунт](../../../iam/concepts/index.md#sa). Использование сервисного аккаунта позволяет гибко настраивать права доступа к ресурсам.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
     * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла [публичного ключа](../vm-connect/ssh.md#creating-ssh-keys).
     * (опционально) При необходимости  в поле **{{ ui-key.yacloud.compute.instances.create.field_access-advanced }}** разрешите доступ к [серийной консоли](../index.md#serial-console).

     {% include [vm-connect-linux](../../../_includes/vm-connect-linux.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Создание ВМ занимает несколько минут. Когда ВМ перейдет в статус `RUNNING`, переходите к [настройке программного обеспечения](setup.md). Следить за статусами ВМ можно в списке ВМ каталога.

- CLI

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
     | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.130.0.0/24] |
     | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
     | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.128.0.0/24] |
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
      * `image-family` — [семейство образов](../../concepts/image.md#family), например `centos-7`. Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
      * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.
      * `ssh-key` — путь до [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.







    {% include [vm-create-check](../../../_includes/compute/vm-create-check.md) %}

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_compute_instance" "linux-vm" {

       name        = "linux-vm"
       platform_id = "standard-v3"
       zone        = "<зона_доступности>"

       resources {
         cores  = "<количество_ядер_vCPU>"
         memory = "<объем_RAM_в_ГБ>"
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор_образа>"
         }
       }

       network_interface {
         subnet_id = yandex_vpc_subnet.subnet-1.id
         nat       = true
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
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
     * `yandex_compute_instance` — описание ВМ:
       * `name` — имя ВМ.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — идентификатор [зоны доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md). Укажите идентификатор выбранного [образа](../../concepts/image.md). Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

       * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#network). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать имя пользователя и [публичный ключ для SSH-доступа](../vm-connect/ssh.md#creating-ssh-keys) на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md). 
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