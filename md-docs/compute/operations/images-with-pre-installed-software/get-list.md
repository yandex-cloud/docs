[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Образы > С предустановленным ПО > Получить информацию о публичном образе

# Получить информацию о публичном образе

В процессе создания виртуальной машины вам необходимо выбрать [образ](../../concepts/image.md) машины с программным обеспечением, которое вы будете использовать.

## Получить список публичных образов {#get-list}

Чтобы получить список [публичных образов](../../concepts/image.md#public) в Yandex Compute Cloud:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Список доступных публичных образов можно посмотреть при создании виртуальной машины:

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором будет создана виртуальная машина.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** нажмите кнопку **Показать все продукты Marketplace**. Отобразится список всех доступных публичных образов.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Список публичных образов размещен в каталоге **standard-images**.

  * Получите полный список публичных образов.
  
      Чтобы получить список доступных образов с помощью CLI, выполните команду:
      
      ```bash
      yc compute image list \
        --folder-id standard-images
      ```
      
      Результат:
      
      ```text
      +----------------------+-------------------------------------+--------------------------+----------------------+--------+
      |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
      +----------------------+-------------------------------------+--------------------------+----------------------+--------+
      ...
      | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
      | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
      | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
      ...
      +----------------------+-------------------------------------+--------------------------+----------------------+--------+
      ```
      
      Где:
      
      * `ID` — идентификатор образа.
      * `NAME` — имя образа.
      * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
      * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) Yandex Cloud Marketplace, связанных с образом.
      * `STATUS` — текущий статус образа. Может принимать одно из значений:
      
          * `STATUS_UNSPECIFIED` — статус образа не определен.
          * `CREATING` — образ в процессе создания.
          * `READY` — образ готов к использованию.
          * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
          * `DELETING` — образ в процессе удаления.

      {% note info %}

      По умолчанию команда выводит лишь первые 1000 образов. Чтобы просмотреть полный список образов, задайте параметр `--limit 0`.

      {% endnote %}

  * Получите список идентификаторов доступных [семейств образов](../../concepts/image.md#family):
    
    ```bash
    yc compute image list \
      --folder-id standard-images \
      --limit 0 \
      --jq '.[].family' | sort | uniq
    ```
    
    Результат:
    
    ```text
    ...
    ubuntu-2204-lts
    ubuntu-2204-lts-oslogin
    ubuntu-2004-lts-gpu
    ...
    ```  
  * Получите список доступных публичных образов определенного семейства:

      ```bash
      yc compute image list \
        --folder-id standard-images \
        | grep <идентификатор_семейства>
      ```

      Где `<идентификатор_семейства>` — идентификатор нужного семейства образов, например: `ubuntu-2204-lts-oslogin`.

      Результат:

      ```text
      ...
      | fd827n44qr0q******** | ubuntu-2204-lts-oslogin-v20240617 | ubuntu-2204-lts-oslogin | f2eofgd2cj0e******** | READY |
      | fd827ukfjohd******** | ubuntu-2204-lts-oslogin-v20240701 | ubuntu-2204-lts-oslogin | f2evubhrcfsh******** | READY |
      | fd82sdt0b96a******** | ubuntu-2204-lts-oslogin-v20240304 | ubuntu-2204-lts-oslogin | f2ecb2d55npl******** | READY |
      ...
      ```

  Подробнее о команде `yc compute image list` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/list.md).

- API {#api}

  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в примерах:

      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Чтобы получить список публичных образов от Yandex Cloud, воспользуйтесь методом REST API [List](../../api-ref/Image/list.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/List](../../api-ref/grpc/Image/list.md). В запросе укажите следующие параметры:

      * В качестве идентификатора каталога укажите `standard-images`.
      * В каталоге много образов, поэтому укажите `pageSize=1000` или используйте полученное значение `nextPageToken`, чтобы получить продолжение списка.
      * Результат запишите в файл, например, в `output.json`.

      **Пример запроса:**

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://compute.api.cloud.yandex.net/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
      ```

      {% note info %}

      Чтобы записать в файл только информацию об образах определенного [семейства образов](../../concepts/image.md#family), воспользуйтесь утилитой `grep`.

      {% endnote %}

{% endlist %}

Посмотреть информацию обо всех доступных публичных образах также можно в [Cloud Marketplace](https://yandex.cloud/ru/marketplace).

## Получить подробную информацию о публичном образе {#get-info}

  Чтобы получить подробную информацию о [публичном образе](../../concepts/image.md#public), в том числе его идентификатор:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** нажмите кнопку **Показать все продукты Marketplace**.
  
      Отобразится список всех доступных публичных образов.
  1. В открывшемся списке выберите публичный образ, информацию о котором вы хотите получить. При необходимости воспользуйтесь строкой поиска или фильтром.

      В результате откроется окно с подробной информацией о публичном образе. Идентификатор образа отобразится внизу страницы с информацией в блоке **Идентификаторы продукта** в поле **Образ ВМ**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Посмотрите описание команды CLI для получения информации о [публичном образе](../../concepts/image.md#public):

      ```bash
      yc compute image get --help
      ```
  1. Получите информацию об образе, указав его идентификатор:

      ```bash
      yc compute image get <идентификатор_образа>
      ```

      Результат:

      ```text
      id: fd8udtumfhpr********
      folder_id: standard-images
      created_at: "2026-08-10T18:33:51Z"
      name: ubuntu-2404-lts-oslogin-v20260810
      description: Ubuntu 24.04 lts with oslogin  v20260807040314
      labels:
        version: "20260807040314"
        x-hopper-operation-id: d9pm50s8l14n********
        x-hopper-source-image-id: fd8go5if6b3c********
      family: ubuntu-2404-lts-oslogin
      size: "10737418240"
      storage_size: "2969567232"
      min_disk_size: "10737418240"
      product_ids:
        - f2e00cd2gepc********
      status: READY
      os:
        type: LINUX
      pooled: true
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

      Идентификатор публичного образа указан в поле `id`.
  1. Получите список идентификаторов доступных [семейств образов](../../concepts/image.md#family):
     
     ```bash
     yc compute image list \
       --folder-id standard-images \
       --limit 0 \
       --jq '.[].family' | sort | uniq
     ```
     
     Результат:
     
     ```text
     ...
     ubuntu-2204-lts
     ubuntu-2204-lts-oslogin
     ubuntu-2004-lts-gpu
     ...
     ```
  1. Получите подробную информацию о наиболее актуальном публичном образе семейства образов, указав полученный на предыдущем шаге идентификатор семейства:

      ```bash
      yc compute image get-latest-from-family <идентификатор_семейства> \
        --folder-id standard-images
      ```

      Результат:

      ```text
      id: fd8udtumfhpr********
      folder_id: standard-images
      created_at: "2026-08-10T18:33:51Z"
      name: ubuntu-2404-lts-oslogin-v20260810
      description: Ubuntu 24.04 lts with oslogin  v20260807040314
      labels:
        version: "20260807040314"
        x-hopper-operation-id: d9pm50s8l14n********
        x-hopper-source-image-id: fd8go5if6b3c********
      family: ubuntu-2404-lts-oslogin
      size: "10737418240"
      storage_size: "2969567232"
      min_disk_size: "10737418240"
      product_ids:
        - f2e00cd2gepc********
      status: READY
      os:
        type: LINUX
      pooled: true
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V2
      ```

      Идентификатор публичного образа указан в поле `id`.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о публичном образе с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_compute_image" "my_image" {
        family = "<имя_семейства>"
      }

      output "image" {
        value = data.yandex_compute_image.my_image
      }
      ```

      Где:

      * `data "yandex_compute_image"` — описание публичного образа в качестве источника данных:

          * `family` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится нужный публичный образ.

              Чтобы получить идентификатор семейства образов, воспользуйтесь [командой](../../../cli/cli-ref/compute/cli-ref/image/list.md) Yandex Cloud CLI `yc compute image list`. Подробнее читайте в разделе [Получить список публичных образов](#get-list).

      * `output "image"` — выходная переменная, которая содержит информацию о наиболее актуальном публичном образе выбранного семейства:
        * `value` — возвращаемое значение.

      Подробнее о параметрах источника данных `yandex_compute_image` читайте в [документации провайдера](../../../terraform/data-sources/compute_image.md).

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

      Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      image = {
        "created_at" = "2026-08-10T18:33:51Z"
        "description" = "Ubuntu 24.04 lts with oslogin  v20260807040314"
        "family" = "ubuntu-2404-lts-oslogin"
        "folder_id" = "standard-images"
        "hardware_generation" = tolist([
          {
            "generation2_features" = tolist([])
            "legacy_features" = tolist([
              {
                "pci_topology" = "PCI_TOPOLOGY_V2"
              },
            ])
          },
        ])
        "id" = "fd8udtumfhpr********"
        "image_id" = "fd8udtumfhpr********"
        "kms_key_id" = tostring(null)
        "labels" = tomap({
          "version" = "20260807040314"
          "x-hopper-operation-id" = "d9pm50s8l14n********"
          "x-hopper-source-image-id" = "fd8go5if6b3c********"
        })
        "min_disk_size" = 10
        "name" = "ubuntu-2404-lts-oslogin-v20260810"
        "os_type" = "linux"
        "pooled" = true
        "product_ids" = toset([
          "f2e00cd2gepc********",
        ])
        "size" = 2
        "status" = "ready"
      }
      ```

      Идентификатор публичного образа указан в поле `image_id`.

- API {#api}

  Чтобы получить подробную информацию об образе по его идентификатору, воспользуйтесь методом REST API [Get](../../api-ref/Image/get.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Get](../../api-ref/grpc/Image/get.md).

  Чтобы получить подробную информацию о наиболее актуальном образе из [семейства образов](../../concepts/image.md#family), воспользуйтесь методом REST API [GetLatestByFamily](../../api-ref/Image/getLatestByFamily.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService.GetLatestByFamily](../../api-ref/grpc/Image/getLatestByFamily.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Образы](../../concepts/image.md)