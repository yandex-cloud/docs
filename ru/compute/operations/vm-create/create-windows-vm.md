---
title: "Как создать виртуальную машину Windows на базе публичного образа"
description: "Следуя данной инструкции вы сможете создать виртуальную машину с операционной системой Windows."
---

# Создать виртуальную машину из публичного образа Windows

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Windows. Для создания виртуальной машины на базе Linux воспользуйтесь инструкцией [{#T}](create-linux-vm.md).

{% include [ms-licensing-personal-data](../../../_includes/ms-licensing-personal-data.md) %}

{% list tabs %}

- Консоль управления

  {% include [create-instance-via-console-windows](../../_includes_service/create-instance-via-console-windows.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md) %}

- API

  Создайте виртуальную машину с помощью метода [Create](../../api-ref/Instance/create.md) для ресурса `Instance`:

  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:
     {% if product == "yandex-cloud" %}* [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.{% endif %}
     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
     * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
  1. [Получите идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога.
  1. Получите информацию об образе, из которого надо создать виртуальную машину (идентификатор образа и минимальный размер диска):
      * Если вы знаете [семейство образа](../../concepts/image.md#family), получите информации о последнем образе в этом семействе:
          ```bash
          export IAM_TOKEN=CggaATEVAgA...
          export FAMILY=windows-2016-gvlk
          curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"

          {
           "productIds": [
            "f2eu62v659or2tqv28l0"
           ],
           "os": {
            "type": "WINDOWS"
           },
           "id": "fd85s1nlcavgdpc16hj3",
           "folderId": "standard-images",
           "createdAt": "2019-04-30T10:53:56Z",
           "name": "windows-2016-gvlk-1556619485",
           "description": "Windows Server 2016 Datacenter is a operating system for virtualized private cloud environments. This version is activated with GVLK. Website and documentation: https://www.microsoft.com/en-us/cloud-platform/windows-server",
           "family": "windows-2016-gvlk",
           "storageSize": "26344423424",
           "minDiskSize": "26843545600",
           "status": "READY"
          }
          ```
      * Вы можете получить информацию об образе из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
  1. Получите идентификатор подсети и идентификатор зоны доступности. В запросе укажите идентификатор каталога, в котором создана подсеть:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      export FOLDER_ID=b1gvmob95yysaplct532
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
       "subnets": [
        {
         "v4CidrBlocks": [
          "10.130.0.0/24"
         ],
         "id": "b0c6n43ftldh30l0vfg2",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-09-23T12:15:00Z",
         "name": "default-{{ region-id }}-a",
         "description": "Auto-created default subnet for zone {{ region-id }}-a",
         "networkId": "enpe3m3fagludao8aslg",
         "zoneId": "{{ region-id }}-a"
        },
        ...
       ]
      }
      ```
  1. Создайте файл с телом запроса на создание виртуальной машины, например `body.json`:

      ```json
      {
        "folderId": "b1gvmob95yysaplct532",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-a",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "4294967296",
          "cores": "2",
        },
        "metadata": {
          "user-data": "#ps1\nnet user Administrator Passw0rd"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "26843545600",
            "imageId": "fd85s1nlcavgdpc16hj3"
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

      Где:

      * `folderId` — идентификатор каталога.
      * `name` — имя, которое будет присвоено виртуальной машине при создании.
      * `zoneId` — зона доступности, которая соответствует выбранной подсети.
      * `platformId` — [платформа](../../concepts/vm-platforms.md).
      * `resourceSpec` — ресурсы, доступные виртуальной машине. Значения должны соответствовать выбранной платформе.
      * `metadata` — в [метаданных](../../concepts/vm-metadata.md) в свойстве `user-data` необходимо передать скрипт с паролем администратора, например:

          ```json
          "metadata": {
            "user-data": "#ps1\nnet user Administrator Passw0rd"
          },
          ```

          {% include [include](../../../_includes/compute/password-requirements.md) %}

      * `bootDiskSpec` — настройки загрузочного диска. Укажите идентификатор выбранного образа и размер диска. Размер диска должен быть не меньше минимального размера диска, указанного в информации об образе.
      * `networkInterfaceSpecs` — настройки сети:
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

  1. Создайте виртуальную машину:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "windows-vm"
       platform_id = "standard-v3"

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
         user-data = "#ps1\nnet user Administrator <пароль администратора>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<зона доступности>"
       network_id = "${yandex_vpc_network.<имя сети>.id}"
     }
     ```

     Где:

     * `yandex_compute_instance` — описание [виртуальной машины](../../concepts/vm.md):
       * `name` — имя виртуальной машины.
       * `platform_id` — [платформа](../../concepts/vm-platforms.md).
       * `resources` — количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
       * `boot_disk` — настройки загрузочного диска. Укажите идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
       * `network_interface` — настройка сети. Укажите идентификатор выбранной подсети. Чтобы автоматически назначить виртуальной машине публичный IP-адрес, укажите `nat = true`.
       * `metadata` — в [метаданных](../../concepts/vm-metadata.md) в параметре `user-data` необходимо передать скрипт с паролем администратора.
     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#subnet), к которой будет подключена виртуальная машина.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  2. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     2. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  3. Разверните облачные ресурсы.
 
     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     2. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

Пароль администратора, указываемый при создании ВМ, сохраняется в метаданных в незашифрованном виде, поэтому рекомендуется [сбросить его](../vm-control/vm-reset-password.md).

Публичный IP-адрес можно сделать статическим. Подробнее читайте в разделе [{#T}](../vm-control/vm-set-static-ip.md).

#### См. также {#see-also}

- [{#T}](../vm-connect/rdp.md)
