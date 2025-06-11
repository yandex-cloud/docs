---
title: Сделать виртуальную машину прерываемой
description: Следуя данной инструкции, вы сможете сделать виртуальную машину прерываемой.
---

# Сделать виртуальную машину прерываемой


Вы можете [создать прерываемую](#create-preemptible) [ВМ](../../concepts/vm.md) или [изменить тип](#preemptible-to-regular) существующей ВМ.

{% include [role-note](../../../_includes/compute/role-note.md) %}

## Создать прерываемую ВМ {#create-preemptible}

Чтобы создать [прерываемую ВМ](../../concepts/preemptible-vm.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана прерываемая ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите один из [образов](../../concepts/image.md) и версию операционной системы.

      {% include [change-custom-disk-settings-image](../../../_includes/compute/create/change-custom-disk-settings-image.md) %}

  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться прерываемая ВМ.
  1. (Опционально) В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** настройте загрузочный [диск](../../concepts/disk.md):

      * Выберите [тип диска](../../concepts/disk.md#disks_types).
      * Задайте нужный размер диска.
      * {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}

      {% include [change-custom-disk-settings-storages](../../../_includes/compute/create/change-custom-disk-settings-storages.md) %}
  1. {% include [section-storages-secondary-disk](../../../_includes/compute/create/section-storages-secondary-disk.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Перейдите на вкладку **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
      * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../../../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
      * В поле **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** включите опцию **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
      * (Опционально) Включите [программно-ускоренную сеть](../../concepts/software-accelerated-network.md).
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя прерываемой ВМ:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Прерываемая ВМ появится в списке.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания прерываемой ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. [Подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на прерываемую ВМ.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) [{{ marketplace-full-name }}](../../../marketplace/) на базе ОС Linux (например, [CentOS 7](/marketplace/products/yc/centos-7)).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Создайте прерываемую ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance create \
       --name first-preemptible-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --preemptible \
       --create-boot-disk image-folder-id=standard-images,image-family=centos-7,kms-key-id=<идентификатор_ключа> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     {% include [vm-platform-cli](../../../_includes/compute/vm-platform-cli.md) %}

     Где:
     * `--name` — имя прерываемой ВМ. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), которая соответствует выбранной [подсети](../../../vpc/concepts/network.md#subnet).
     * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
         * `subnet-name` — имя выбранной подсети.
         * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--preemptible` — выбор прерываемого типа ВМ.
     * `--create-boot-disk` — настройки загрузочного диска ВМ:
         * `image-family` — [семейство образов](../../concepts/image.md#family), например, `centos-7`. Эта опция позволит установить последнюю версию ОС из указанного семейства.
         * `kms-key-id` — идентификатор [симметричного ключа {{ kms-short-name }}](../../../kms/concepts/key.md) для создания зашифрованного загрузочного диска. Необязательный параметр.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
           
           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на прерываемой ВМ будет автоматически создан пользователь `yc-user`.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

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
       name                      = "preemptible-vm"
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

       scheduling_policy {
         preemptible = true
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
       * `image_id` — идентификатор [образа](../../concepts/image.md) для прерываемой ВМ. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance` — описание прерываемой ВМ:
       * `name` — имя прерываемой ВМ.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `zone` — зона доступности, в которой будет находиться прерываемая ВМ.
       * `resources` — количество ядер vCPU и объем RAM, доступные прерываемой ВМ. Значения должны соответствовать выбранной платформе.
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор диска.
       * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ. Укажите идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata` — в метаданных необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на прерываемую ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy` — политика планирования. Чтобы создать прерываемую ВМ, укажите `preemptible = true`.
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена прерываемая ВМ.

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

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

## Сменить тип ВМ {#preemptible-to-regular}

Чтобы сменить тип ВМ, например, сделать ВМ непрерываемой:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится прерываемая ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. В строке с нужной ВМ нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**. Статус ВМ изменится на `Stopped`.
  1. В строке с нужной ВМ нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** выключите опцию **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
  1. Нажмите **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. Справа сверху нажмите ![image](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.common.start }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки ВМ:

     ```bash
     yc compute instance stop --help
     ```

  1. Получите список всех ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop <имя_или_идентификатор_ВМ>
     ```

     Результат:

     ```text
     done (15s)
     ```

  1. Измените параметры ВМ:

     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --preemptible=false
     ```

     Результат:

     ```text
     done (1s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

  1. Вновь запустите ВМ:

     ```bash
     yc compute instance start <имя_или_идентификатор_ВМ>
     ```

     Результат:

     ```text
     done (11s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Найдите в конфигурационном файле описание политики планирования ВМ, которую нужно сделать непрерываемой:

     ```hcl
     scheduling_policy {
       preemptible = true
     }
     ```

  1. Удалите поле `scheduling_policy` со значением `preemptible = true`.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
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

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md). В теле запроса в блоке `schedulingPolicy` укажите `"preemptible": false`.

{% endlist %}

Тарификация ВМ после этого изменится. Подробнее о [тарификации ВМ](../../pricing.md#prices-instance-resources).

#### См. также {#see-also}

* [{#T}](../vm-connect/ssh.md).
* [{#T}](../../tutorials/nodejs-cron-restart-vm.md).
* [{#T}](../../tutorials/hpc-on-preemptible.md).
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md).