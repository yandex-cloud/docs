# Создать виртуальную машину из публичного образа Windows

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Windows. Для создания виртуальной машины на базе Linux воспользуйтесь инструкцией [{#T}](create-linux-vm.md).

Чтобы создать виртуальную машину:

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
     * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
     * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
  1. [Получите идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога.
  1. Получите информацию об образе, из которого надо создать виртуальную машину (идентификатор образа и минимальный размер диска):
      * Если вы знаете [семейство образа](../../concepts/image.md#family), получите информации о последнем образе в этом семействе:
          ```bash
          $ export IAM_TOKEN=CggaATEVAgA...
          $ export FAMILY=windows-2016-gvlk
          $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.api.cloud.yandex.net/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"

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
      * `metadata` — в [метаданных](../../concepts/vm-metadata.md) в свойстве `user-data` необходимо передать скрипт с паролем администратора, например:

          ```json
          "metadata": {
            "user-data": "#ps1\nnet user Administrator Passw0rd"
          },
          ```

          {% include [include](../../../_includes/compute/password-requirements.md) %}

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
  1. Создайте виртуальную машину:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/instances
      ```

{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

При создании виртуальной машине назначаются IP-адрес и FQDN. Эти данные можно использовать для доступа к виртуальной машине по RDP.

Публичный IP-адрес можно сделать статическим. Подробнее читайте в разделе [{#T}](../vm-control/vm-set-static-ip.md).

#### См. также

- [{#T}](../vm-connect/rdp.md)
