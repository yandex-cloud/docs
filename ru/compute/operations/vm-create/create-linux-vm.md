# Создать виртуальную машину из публичного образа Linux

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Linux. Для создания виртуальной машины на базе Windows воспользуйтесь инструкцией [{#T}](create-windows-vm.md).

Чтобы создать виртуальную машину:

{% list tabs %}

- Консоль управления

  {% include [create-instance-via-console-linux](../../_includes_service/create-instance-via-console-linux.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания виртуальной машины:

      ```
      $ yc compute instance create --help
      ```

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Выберите один из публичных [образов](../images-with-pre-installed-software/get-list.md) на базе операционной системы Linux (например, CentOS 7).

      {% include [standard-images](../../../_includes/standard-images.md) %}
  1. Выберите подсеть:
      ```bash
      $ yc vpc subnet list
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      | b0c6n43f9lgh3695v2k2 | default-ru-central1-c | enpe3m3fa00udao8g5lg |                | ru-central1-c | [10.130.0.0/24] |
      | e2l2da8a20b33g7o73bv | default-ru-central1-b | enpe3m3fa00udao8g5lg |                | ru-central1-b | [10.129.0.0/24] |
      | e9bnlm18l70ao30pvfaa | default-ru-central1-a | enpe3m3fa00udao8g5lg |                | ru-central1-a | [10.128.0.0/24] |
      +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
      ```
  1.  Создайте виртуальную машину в каталоге по умолчанию. Укажите следующие параметры:

      - `name` — Имя виртуальной машины.

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      - `zone` — зона доступности, которая соответствует выбранной подсети.
      - `subnet-name` — имя выбранной подсети.
      - `image-family` — [семейство образов](../../concepts/image.md#family), например `centos-7`. Эта опция позволит установить последнюю версию операционной системы из указанного семейства.
      - Публичный IP. Чтобы создать виртуальную машину без публичного IP, исключите опцию `nat-ip-version=ipv4`.

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      Будет создана виртуальная машина `first-instance`.
- API

  Создайте виртуальную машину с помощью метода [Create](../../api-ref/Instance/create.md) для ресурса `Instance`:

  1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на виртуальную машину.
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
     * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
  1. [Получите идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога.
  1. Получите информацию об образе, из которого надо создать виртуальную машину (идентификатор образа и минимальный размер диска):
      * Если вы знаете [семейство образа](../../concepts/image.md#family), получите информации о последнем образе в этом семействе:
          ```bash
          $ export IAM_TOKEN=CggaATEVAgA...
          $ export FAMILY=ubuntu-1804
          $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.api.cloud.yandex.net/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```
      * Вы можете получить информацию об образе из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
  1. Получите идентификатор подсети и идентификатор зоны доступности. В запросе укажите идентификатор каталога, в котором создана подсеть:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.api.cloud.yandex.net/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
       "subnets": [
        {
         "v4CidrBlocks": [
          "10.130.0.0/24"
         ],
         "id": "b0c6n43ftldh30l0vfg2",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-09-23T12:15:00Z",
         "name": "default-ru-central1-c",
         "description": "Auto-created default subnet for zone ru-central1-c",
         "networkId": "enpe3m3fagludao8aslg",
         "zoneId": "ru-central1-c"
        },
        ...
       ]
      }
      ```
  1. Создайте файл с телом запроса на создание виртуальной машины, например `body.json`. Укажите следующие параметры:

      * `folderId` — идентификатор каталога.
      * `name` — имя, которое будет присвоено виртуальной машине при создании.
      * `zoneId` — зона доступности, которая соответствует выбранной подсети.
      * `platformId` — [платформа](../../concepts/vm-platforms.md).
      * `resourceSpec` — ресурсы, доступные виртуальной машине. Значения должны соответствовать выбранной платформе.
      * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
      * `bootDiskSpec` — настройки загрузочного диска. Укажите идентификатор выбранного образа и размер диска. Размер диска должен быть не меньше минимального размера диска, указанного в информации об образе.
      * `networkInterfaceSpecs` — настройки сети.
        * `subnetId` — идентификатор выбранной подсети.
        * `primaryV4AddressSpec` — IP-адрес, который будет присвоен виртуальной машине. Чтобы добавить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) виртуальной машине, укажите:
            ```
            "primaryV4AddressSpec": {
                "oneToOneNatSpec": {
                  "ipVersion": "IPV4"
                }
              }
            ```

      Подробнее про формат тела запроса в [справочнике API](../../api-ref/Instance/create.md).

      Пример файла `body.json`:
      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "ru-central1-c",
        "platformId": "standard-v1",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2",
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3N... user@example.com"
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
  1. Создайте виртуальную машину:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/instances
      ```

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер Яндекс.Облака](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       {% note info %}

       Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md). 
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#network), к которой будет подключена виртуальная машина.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "linux-vm"
       platform_id = "standard-v2"

       resources {
         cores  = <количество ядер vCPU>
         memory = <объем RAM в ГБ>
       }

       boot_disk {
         initialize_params {
           image_id = "<идентификатор образа>"
         }
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<зона доступности>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     2. Выполните проверку с помощью команды:

        ```
        $ terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  3. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        $ terraform apply
        ```

     2. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### См. также {#see-also}

- [{#T}](../vm-connect/ssh.md)
