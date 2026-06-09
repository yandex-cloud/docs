# Зашифровать образ

Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.

{% note alert %}

Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее см. [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../../kms/operations/key.md#create) ключ шифрования {{ kms-full-name }}. Подробнее см. [{#T}](../../concepts/encryption.md).
  1. Создайте зашифрованный диск из образа, который вы хотите зашифровать:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещен исходный образ.
      1. Перейдите в сервис **{{ compute-name }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks.label_title }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.compute.storage.button_create-disk }}**.
      1. Введите имя диска.

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), а также [размер блока](../../concepts/disk.md#maximum-disk-size) и [размер диска](../../concepts/disk.md#maximum-disk-size).
      1. В поле **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** выберите `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` и в списке ниже отметьте нужный образ. Для поиска образа воспользуйтесь фильтром.
      1. В блоке **{{ ui-key.yacloud.compute.disk-form.section_encryption }}** включите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}** и в поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../../kms/concepts/key.md), созданный ранее.

      1. Нажмите кнопку **{{ ui-key.yacloud.compute.storage.button_create-disk }}**.

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. [Создайте](../image-create/create-from-disk.md) образ из зашифрованного диска, созданного ранее.
  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](delete.md) исходный образ.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте ключ шифрования {{ kms-full-name }}:

      ```bash
      yc kms symmetric-key create \
        --name <имя_ключа> \
        --default-algorithm aes-256 \
        --rotation-period 24h \
        --deletion-protection
      ```

      Где `--name` — имя создаваемого ключа {{ kms-name }}.

      Результат:

      ```text
      id: abj73fd9mekk********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:27:35Z"
      name: my-key1
      status: ACTIVE
      primary_version:
        id: abjdno4pqi67********
        key_id: abj73fd9mekk********
        status: ACTIVE
        algorithm: AES_256
        created_at: "2025-05-20T17:27:35Z"
        primary: true
      default_algorithm: AES_256
      rotation_period: 86400s
      deletion_protection: true
      ```

  1. Получите список всех образов в каталоге по умолчанию:

      ```bash
      yc compute image list
      ```

      Результат:

      ```text
      +----------------------+--------------------+------------------------+----------+
      |          ID          |        NAME        |       PRODUCT IDS      |  STATUS  |
      +----------------------+--------------------+------------------------+----------+
      | fd823vsvcmop******** | image-ubuntu-24-04 | igf2etq3erab3o******** | READY    |
      | fd8p8l3asgud******** | image-debian-2025  | goa2etq3erab3o******** | READY    |
      +----------------------+--------------------+------------------------+----------+
      ```

  1. Создайте зашифрованный диск из образа, который вы хотите зашифровать:

      ```bash
      yc compute disk create <имя_зашифрованного_диска> \
        --source-image-name <имя_образа> \
        --kms-key-name <имя_ключа>
      ```

      Где:
      * `--source-image-name` — имя образа для создания зашифрованного диска.
      * `--kms-key-name` — имя ключа шифрования.

      Результат:

      ```text
      done (53s)
      id: fhmihpagi991********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:39:01Z"
      name: fromcliencrypted
      type_id: network-hdd
      zone_id: {{ region-id }}-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      source_image_id: sd1lb3jnrcs2********
      disk_placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abj73fd9mekk********
        version_id: abjdno4pqi67********
      ```

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. Получите список всех дисков в каталоге по умолчанию:

      ```bash
      yc compute disk list
      ```

      Результат:

      ```text
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      |          ID          |     NAME     |    SIZE     |     ZONE      | STATUS |     INSTANCE IDS     |       DESCRIPTION       |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | {{ region-id }}-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | {{ region-id }}-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Создайте образ из зашифрованного диска, созданного ранее:
  
      ```bash
      yc compute image create \
        --name <имя_создаваемого_образа> \
        --source-disk-name <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      done (8s)
      id: fd87fubin9ql********
      folder_id: b1geoelk7fld********
      created_at: "2025-06-25T10:52:31Z"
      name: encrypted-image
      min_disk_size: "5368709120"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      kms_key:
        key_id: abjgkrgibtmo********
        version_id: abjvf41ltfi8********
      ```

  1. Удалите зашифрованный диск:

      ```bash
      yc compute disk delete <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      done (4s)
      ```

  1. Удалите исходный образ:

      ```bash
      yc compute image delete <имя_незашифрованного_образа>
      ```

      Результат:

      ```text
      done (2s)
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы зашифровать образ с помощью {{ TF }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      # Создание ключа {{ kms-full-name }}

      resource "yandex_kms_symmetric_key" "my-key" {
        name                = "encrypt-key"
        default_algorithm   = "AES_256"
        rotation_period     = "8760h"
        deletion_protection = true
        lifecycle {
          prevent_destroy = true
        }
      }

      # Создание зашифрованного диска

      resource "yandex_compute_disk" "encrypted-disk" {
        name       = "new-encrypted-disk"
        type       = "network-hdd"
        zone       = "{{ region-id }}-a"
        size       = 20
        block_size = 4096
        image_id   = "<идентификатор_незашифрованного_образа>"
        kms_key_id = yandex_kms_symmetric_key.my-key.id
      }

      # Создание зашифрованного образа

      resource "yandex_compute_image" "encrypted-image" {
        name           = "<имя_зашифрованного_образа>"
        source_disk_id = yandex_compute_disk.encrypted-disk.id
        depends_on     = [yandex_compute_disk.encrypted-disk]
      }
      ```

      Где:
      * `image_id` — идентификатор незашифрованного образа.
      * `name` — имя создаваемого зашифрованного образа.

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_image).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](delete.md) исходный образ.

- API {#api}

  1. Создайте ключ шифрования {{ kms-full-name }} с помощью метода REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

  1. Создайте зашифрованный диск из образа, используя метод REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

      Список доступных образов запрашивайте методом REST API [list](../../api-ref/Image/list.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md).

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. Для зашифрованного диска создайте образ с помощью метода REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md).

  1. Удалите зашифрованный диск, используя метод REST API [delete](../../api-ref/Disk/delete.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Delete](../../api-ref/grpc/Disk/delete.md).

  1. Удалите исходный образ, используя метод REST API [delete](../../api-ref/Image/delete.md) для ресурса [Image](../../api-ref/Image/index.md) или вызов gRPC API [ImageService/Delete](../../api-ref/grpc/Image/delete.md).

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)