[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Снимки дисков > Зашифровать снимок

# Зашифровать снимок

Если деактивировать ключ, которым были зашифрованы диск, снимок или образ, доступ к данным будет приостановлен, пока ключ не будет снова активирован.

{% note alert %}

Если удалить ключ или его [версию](../../../kms/concepts/version.md), которыми были зашифрованы диск, снимок или образ, то доступ к данным будет безвозвратно потерян. Подробнее смотрите [Удаление версии ключа](../../../kms/concepts/version.md#version-distruct).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Создайте](../../../kms/operations/key.md#create) ключ шифрования Yandex Key Management Service. Подробнее смотрите [Шифрование в Compute Cloud](../../concepts/encryption.md).
  1. Создайте зашифрованный диск из снимка, который вы хотите зашифровать:

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором размещен исходный снимок.
      1. Перейдите в сервис **Compute Cloud**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/hard-drive.svg) **Диски**.
      1. Нажмите кнопку **Создать диск**.
      1. Введите имя диска.

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. Задайте параметры диска: [тип диска](../../concepts/disk.md#disks_types), а также [размер блока](../../concepts/disk.md#maximum-disk-size) и [размер диска](../../concepts/disk.md#maximum-disk-size).
      1. В поле **Наполнение** выберите `Снимок` и в списке ниже отметьте снимок, который создали ранее. Для поиска снимка воспользуйтесь фильтром.
      1. В блоке **Шифрование** включите опцию **Зашифрованный диск** и в поле **Ключ KMS** выберите [ключ](../../../kms/concepts/key.md), созданный ранее.

      1. Нажмите кнопку **Создать диск**.

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. [Создайте](../disk-control/create-snapshot.md) снимок из зашифрованного диска, созданного ранее.
  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](delete.md) исходный снимок.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте ключ шифрования Yandex Key Management Service:

      ```bash
      yc kms symmetric-key create \
        --name <имя_ключа> \
        --default-algorithm aes-256 \
        --rotation-period 24h \
        --deletion-protection
      ```

      Где `--name` — имя создаваемого ключа Key Management Service.

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

  1. Получите список всех снимков в каталоге по умолчанию:

      ```bash
      yc compute snapshot list
      ```

      Результат:
      ```text
      +----------------------+-----------------------+----------------------+----------+
      |          ID          |         NAME          |     PRODUCT IDS      |  STATUS  |
      +----------------------+-----------------------+----------------------+----------+
      | fd823vsvcmop******** | snap-ubuntu-24-04-lts | f2etq3erab3o******** | READY    |
      | fd8p8l3asgud******** | snap-debian-2025      | f2etq3erab3o******** | READY    |
      +----------------------+-----------------------+----------------------+----------+
      ```

  1. Создайте зашифрованный диск из снимка, который вы хотите зашифровать:

      ```bash
      yc compute disk create <имя_зашифрованного_диска> \
        --source-snapshot-name <имя_снимка> \
        --kms-key-name <имя_ключа>
      ```

      Где:
      * `--source-snapshot-name` — имя снимка для создания зашифрованного диска.
      * `--kms-key-name` — имя ключа шифрования.

      Результат:

      ```text
      done (53s)
      id: fhmihpagi991********
      folder_id: b1geoelk7fld********
      created_at: "2025-05-20T17:39:01Z"
      name: fromcliencrypted
      type_id: network-hdd
      zone_id: ru-central1-a
      size: "21474836480"
      block_size: "4096"
      status: READY
      source_snapshot_id: fd8lb5jnr2m2********
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
      | a7lqgbt0bb9s******** | first-disk   | 20401094656 | ru-central1-a | READY  | a7lcvu28njbh******** |                         |
      | a7lv5j5hm1p1******** | second-disk  | 21474836480 | ru-central1-a | READY  |                      |                         |
      +----------------------+--------------+-------------+---------------+--------+----------------------+-------------------------+
      ```

  1. Создайте снимок из зашифрованного диска, созданного ранее:
  
      ```bash
      yc compute snapshot create \
        --name <имя_создаваемого_снимка> \
        --disk-name <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      id: fhmu3pfcpicd********
      description: Create snapshot
      created_at: "2025-06-02T16:14:07.523160478Z"
      created_by: ajevfb0tjfts********
      modified_at: "2025-06-02T16:14:07.523160478Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.compute.v1.CreateSnapshotMetadata
        snapshot_id: fd8pb5en4j9m********
        disk_id: fhmqgef7vh76********
      ```

  1. Удалите зашифрованный диск:
      ```bash
      yc compute disk delete <имя_зашифрованного_диска>
      ```

      Результат:

      ```text
      done (5s)
      ```

  1. Удалите исходный снимок:
      ```bash
      yc compute snapshot delete <имя_незашифрованного_снимка>
      ```

      Результат:

      ```text
      done (7s)
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы зашифровать диск с помощью Terraform:
  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      # Создание ключа Yandex Key Management Service

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
        name        = "new-encrypted-disk"
        type        = "network-hdd"
        zone        = "ru-central1-a"
        size        = 20
        block_size  = 4096
        snapshot_id = "<идентификатор_незашифрованного_снимка>"
        kms_key_id  = yandex_kms_symmetric_key.my-key.id
      }

      # Создание зашифрованного снимка

      resource "yandex_compute_snapshot" "encrypted-snapshot" {
        name           = "<имя_зашифрованного_снимка>"
        source_disk_id = yandex_compute_disk.encrypted-disk.id
        depends_on     = [yandex_compute_disk.encrypted-disk]
      }
      ```

      Где:
      * `snapshot_id` — идентификатор незашифрованного снимка.
      * `name` — имя создаваемого зашифрованного снимка.

      Более подробную информацию о параметрах ресурса `yandex_compute_snapshot` читайте в [документации провайдера](../../../terraform/resources/compute_snapshot.md).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. [Удалите](../disk-control/delete.md) зашифрованный диск.
  1. [Удалите](delete.md) исходный снимок.


- API {#api}

  1. Создайте ключ шифрования Yandex Key Management Service с помощью метода REST API [create](../../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../../kms/api-ref/grpc/SymmetricKey/create.md).

  1. Создайте зашифрованный диск из снимка, используя метод REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

      Список доступных снимков запрашивайте методом REST API [list](../../api-ref/Snapshot/list.md) или вызовом gRPC API [SnapshotService/List](../../api-ref/grpc/Snapshot/list.md).

      После создания диск перейдет в статус `Creating`. Дождитесь, когда диск перейдет в статус `Ready`, прежде чем его использовать.

  1. Для зашифрованного диска создайте снимок с помощью метода REST API [create](../../api-ref/Snapshot/create.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызовом gRPC API [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md).

  1. Удалите зашифрованный диск, используя метод REST API [delete](../../api-ref/Disk/delete.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызов gRPC API [DiskService/Delete](../../api-ref/grpc/Disk/delete.md).

  1. Удалите исходный снимок, используя метод REST API [delete](../../api-ref/Snapshot/delete.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызов gRPC API [SnapshotService/Delete](../../api-ref/grpc/Snapshot/delete.md).

{% endlist %}


#### Полезные ссылки {#see-also}

* [Шифрование в Compute Cloud](../../concepts/encryption.md)
* [Зашифровать диск](../disk-control/disk-encrypt.md)
* [Зашифровать образ](../image-control/encrypt.md)