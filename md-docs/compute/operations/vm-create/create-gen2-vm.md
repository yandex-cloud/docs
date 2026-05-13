# Создать виртуальную машину с оборудованием поколения Gen 2

[Виртуальная машина](../../concepts/vm.md) работает на оборудовании того [поколения](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за носителем, на основе которого создана эта ВМ — [образом](../../concepts/image.md), [снимком](../../concepts/snapshot.md) или [диском](../../concepts/disk.md).

Поэтому, чтобы создать виртуальную машину, работающую на оборудовании поколения `Gen 2`, необходимо предварительно создать носитель, за которым закреплено поколение `Gen 2`, а затем с использованием этого носителя [создать](#create-vm) виртуальную машину.

Чтобы создать виртуальную машину, работающую на виртуализированном оборудовании поколения `Gen 2`:

1. Подготовьте носитель одного из следующих типов: [образ](#create-image), [снимок](#create-snapshot) или [диск](#create-disk).
1. [Создайте виртуальную машину на основе подготовленного носителя](#create-vm).

## Создайте образ с закреплением поколения оборудования Gen 2 {#create-image}

Создать образ виртуальной машины с закреплением поколения оборудования `Gen 2` вы можете как из собственного образа, [предварительно загруженного](#upload-own-image) в Yandex Cloud, так и на основе [уже имеющихся](#create-image-from-existing-source) в Yandex Cloud образов, снимков и дисков.

### Загрузите свой образ диска в Yandex Cloud {#upload-own-image}

Вы можете загрузить в Compute Cloud свой собственный образ виртуальной машины с поддержкой UEFI и GPT, чтобы на его основе создавать виртуальные машины, работающие на оборудовании поколения `Gen 2`. Создать образ в Compute Cloud можно из подготовленного файла образа, загруженного в [Yandex Object Storage](../../../storage/index.md).

#### Подготовьте файл с образом {#prepare-file}

Для образов загрузочного диска должны выполняться следующие требования:

* Установлены драйверы `virtio-net`, `virtio-blk` и `virtio-pci`. Если вы собираетесь подключать к [виртуальной машине](../../concepts/vm.md) [файловые хранилища](../../concepts/filesystem.md), также должен быть установлен драйвер `virtiofs`. См. [инструкцию](../image-create/custom-image.md#virtio).
* Терминал `ttyS0` (порт COM1) настроен в качестве [серийной консоли](../serial-console/index.md). См. [инструкцию](../image-create/custom-image.md#serial-console).
* Сетевой интерфейс корректно запускается при старте ВМ и получает [IP-адрес](../../../vpc/concepts/address.md) по DHCP.
* Пакет `cloud-init` установлен и настроен для работы с нашим [сервисом метаданных](../vm-info/get-info.md#inside-instance). Установить пакет для CentOS можно с помощью команды `sudo yum install cloud-init`, для Debian или Ubuntu — `sudo apt update && sudo apt install -y cloud-init`.
* Если образ создан на основе Amazon Machine Image (AMI), в настройках `cloud-init` отключена проверка облачной платформы, на которой запускается ВМ. См. [инструкцию](../image-create/custom-image.md#ec2).
* В настройках системного файрвола открыт необходимый минимум портов для работы ваших приложений, а также порт для доступа по [SSH](../../../glossary/ssh-keygen.md) (по умолчанию это порт 22 TCP).
* SSH-сервер запускается автоматически при старте ВМ.
* Сервисы с вашим приложением устойчивы к перезагрузке ВМ.

* Для загрузочного диска используется [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID)-разбивка.

* Диск смонтирован по UUID, а не по имени.
* Файловая система не зашифрована.

Поддерживаемые форматы: `Qcow2`, `VMDK`, `RAW` и `VHD`.

Инструкции по настройке см. в разделе [Подготовить свой образ диска](../image-create/custom-image.md).

#### Загрузите файл образа в Object Storage {#upload-file}

Загрузите файл с образом в сервис Object Storage и получите ссылку на загруженный образ:

1. Если у вас еще нет [бакета](../../../storage/concepts/bucket.md) в Object Storage, [создайте](../../../storage/operations/buckets/create.md) его с ограниченным доступом.
1. Загрузите образ в ваш бакет, например, [через консоль управления](../../../storage/operations/objects/upload.md), с помощью [AWS CLI](../../../storage/tools/aws-cli.md) или [WinSCP](../../../storage/tools/winscp.md). В терминах Object Storage загружаемый файл образа будет называться _объектом_.
1. [Получите](../../../storage/operations/objects/link-for-download.md) подписанную [ссылку](../../../storage/concepts/pre-signed-urls.md) на скачивание образа из бакета. Используйте эту ссылку при создании образа в Compute Cloud.

#### Создайте в Compute Cloud образ с закреплением поколения оборудования Gen 2 {#create-image-from-link}

Чтобы создать новый образ по ссылке, полученной в [Object Storage](../../../storage/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![layers](../../../_assets/console-icons/layers.svg) **Образы**.
  1. Нажмите кнопку **Загрузить образ** и в открывшемся окне:

      1. В поле **Имя** задайте имя образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. (Опционально) В полях **Описание** и **Метки** добавьте произвольное описание и [метки](../../../resource-manager/concepts/labels.md) создаваемого образа.
      1. В поле **Ссылка на образ в Object Storage** вставьте ссылку на файл с образом, полученную ранее в Object Storage.
      1. В поле **Поколение оборудования** выберите [поколение оборудования](../../concepts/hardware-generations.md) `Gen 2 (GPT, UEFI)`.
      1. Чтобы включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания, раскройте секцию **Дополнительно** и включите опцию **Оптимизация**.
      1. Нажмите кнопку **Загрузить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды Yandex Cloud CLI для создания образа:

      ```bash
      yc compute image create --help
      ```
  1. Чтобы создать по ссылке новый образ с закреплением за ним поколения оборудования `Gen 2`, выполните команду:

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --source-uri "<URL_образа>" \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Где:
      * `--name` — имя, которое будет присвоено образу. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      
      * `--source-uri` — ссылка на образ, полученная в Object Storage.
      * `--pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Необязательный параметр. По умолчанию оптимизация отключена.

      Результат:

      ```bash
      done (12s)
      id: fd86a13e6ro9********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T16:26:46Z"
      name: my-own-gen2-image
      storage_size: "1891631104"
      min_disk_size: "1891631104"
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute image create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы создать образ:
  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<имя_образа>"
        source_url           = "<ссылка_на_образ>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено образу. Требования к имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `source_url` — ссылка на образ в Object Storage.
      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.
          
          Необязательный параметр. По умолчанию оптимизация выключена.

      Подробную информацию о параметрах ресурса `yandex_compute_image` см. в [документации провайдера Terraform](../../../terraform/resources/compute_image.md).
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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc compute image list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md).

  Например, чтобы создать образ с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание образа (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_образа>",
        "uri": "<ссылка_на_загруженный_образ>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается образ.
      * `name` — имя образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `uri` — ссылка на образ в Object Storage.
      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.

          Необязательный параметр. По умолчанию оптимизация выключена.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/images
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8g5p4hllq8********"
      },
      "id": "fd8m1tfm92kr********",
      "description": "Create image",
      "createdAt": "2025-12-05T16:41:54.452564354Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T16:41:54.452564354Z"
      }
      ```

{% endlist %}

После создания образа вы можете [удалить](../../../storage/operations/objects/delete.md) исходный файл из бакета.

### Создайте образ диска с закреплением поколения оборудования Gen 2 из другого образа, снимка или диска {#create-image-from-existing-source}

По умолчанию при создании образа за ним закрепляется то [поколение оборудования](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за исходным образом, снимком или диском, на основе которых создается этот образ. При этом вы можете явно задать для образа поколение оборудования, отличное от поколения, закрепленного за исходными образом, снимком или диском.

За [публичными образами](../../concepts/image.md#public), доступными для установки на ВМ в [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace), по умолчанию закреплено поколение оборудования `Gen 1.1` или `Gen 1.2`. В то же время некоторые публичные образы (например, образы с операционной системой Linux [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts)) поддерживают оборудование поколения `Gen 2` с режимом загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицей разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID), и из таких образов вы можете создать диск или собственный образ с закрепленным поколением оборудования `Gen 2`. Другие публичные образы не поддерживают UEFI-загрузку и поэтому создать на их основе виртуальную машину, работающую на оборудовании поколения `Gen 2`, нельзя.

{% note info %}

Создать новый образ с закреплением поколения оборудования `Gen 2` из [публичного образа](../../concepts/image.md#public) в [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace) можно только с помощью [Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md), [Terraform](../../../terraform/resources/compute_image.md) или [API](../../api-ref/Image/create.md).

{% endnote %}

Чтобы создать образ из существующего [образа](../../concepts/image.md), [снимка](../../concepts/snapshot.md) или [диска](../../concepts/disk.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. В зависимости от того, из какого источника вы хотите создать новый образ, на панели слева выберите ![archive](../../../_assets/console-icons/archive.svg) **Диски и хранилища**, ![picture](../../../_assets/console-icons/picture.svg) **Снимки дисков** или ![layers](../../../_assets/console-icons/layers.svg) **Образы**.
  1. В зависимости от выбранного типа источника в открывшемся списке в строке с нужным образом, снимком или диском нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![layers](../../../_assets/console-icons/layers.svg) **Создать образ**. В открывшемся окне:

      1. В поле **Имя** задайте имя создаваемого образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      1. (Опционально) В полях **Описание** и **Метки** добавьте произвольное описание и [метки](../../../resource-manager/concepts/labels.md) образа.
      1. Разверните секцию **Дополнительно** и в поле **Поколение оборудования** выберите `Gen 2 (GPT, UEFI)`.

          {% note alert %}
          
          Убедитесь, что загрузчик операционной системы источника поддерживает режим загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицу разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID). В противном случае, виртуальные машины, создаваемые из нового образа, не смогут запустить операционную систему.
          
          {% endnote %}

      1. Чтобы включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания, включите опцию **Оптимизация**.
      1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  {% note alert %}
  
  Убедитесь, что загрузчик операционной системы источника поддерживает режим загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицу разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID). В противном случае, виртуальные машины, создаваемые из нового образа, не смогут запустить операционную систему.
  
  {% endnote %}

  1. Посмотрите описание команды Yandex Cloud CLI для создания образа:

      ```bash
      yc compute image create --help
      ```

  1. Чтобы создать новый образ с закреплением поколения оборудования `Gen 2` из существующего [образа](../../concepts/image.md), [снимка](../../concepts/snapshot.md) или [диска](../../concepts/disk.md), выполните команду:

      ```bash
      yc compute image create \
        --name <имя_образа> \
        --source-image-id <идентификатор_образа-источника> \
        --source-snapshot-id <идентификатор_снимка-источника> \
        --source-disk-id <идентификатор_диска-источника> \
        --hardware-generation-id generation2 \
        --pooled
      ```

      Где:
      * `--name` — имя, которое будет присвоено образу. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * Выбор источника для образа:

          * `--source-image-id` — идентификатор образа-источника. Вместо идентификатора вы можете передать в команду имя образа-источника в параметре `--source-image-name`.
          * `--source-snapshot-id` — идентификатор снимка-источника. Вместо идентификатора вы можете передать в команду имя снимка-источника в параметре `--source-snapshot-name`.
          * `--source-disk-id` — идентификатор диска-источника. Вместо идентификатора вы можете передать в команду имя диска-источника в параметре `--source-disk-name`.

          {% note info %}

          Параметры `--source-image-id`, `--source-image-name`, `--source-snapshot-id`, `--source-snapshot-name`, `--source-disk-id` и `--source-disk-name` — взаимоисключающие. В команде вы можете указать только один из них.

          {% endnote %}

      * `--pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Необязательный параметр. По умолчанию оптимизация отключена.

      Результат:

      ```text
      done (9s)
      id: fd86kup8c7pa********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T06:57:09Z"
      name: my-sample-gen2-image
      storage_size: "9877585920"
      min_disk_size: "21474836480"
      product_ids:
        - f2ercusam4no********
      status: READY
      os:
        type: LINUX
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute image create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/image/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_image`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name                 = "<имя_образа>"
        source_image         = "<идентификатор_образа-источника>"
        source_snapshot      = "<идентификатор_снимка-источника>"
        source_disk          = "<идентификатор_диска-источника>"
        pooled               = "true|false"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      {% note alert %}
      
      Убедитесь, что загрузчик операционной системы источника поддерживает режим загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицу разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID). В противном случае, виртуальные машины, создаваемые из нового образа, не смогут запустить операционную систему.
      
      {% endnote %}

      Где:
      * `name` — имя, которое будет присвоено образу. Требования к имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * Выбор источника для образа:

          * `source_image` — идентификатор образа-источника.
          * `source_snapshot` — идентификатор снимка-источника.
          * `source_disk` — идентификатор диска-источника.

          {% note info %}

          Параметры `source_image`, `source_snapshot` и `source_disk` — взаимоисключающие. В файле конфигурации вы можете указать только один из них.

          {% endnote %}

      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.
          
          Необязательный параметр. По умолчанию оптимизация выключена.

          Подробную информацию о параметрах ресурса `yandex_compute_image` см. в [документации провайдера Terraform](../../../terraform/resources/compute_image.md).
          
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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc compute image list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Image/create.md) для ресурса [Image](../../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../../api-ref/grpc/Image/create.md).

  Например, чтобы создать образ с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание образа (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_образа>",
        "imageId": "<идентификатор_образа-источника>",
        "snapshotId": "<идентификатор_снимка-источника>",
        "diskId": "<идентификатор_диска-источника>",
        "pooled": "true|false",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается образ.
      * `name` — имя образа. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      {% note alert %}
      
      Убедитесь, что загрузчик операционной системы источника поддерживает режим загрузки [UEFI](https://ru.wikipedia.org/wiki/Extensible_Firmware_Interface) и таблицу разделов [GPT](https://ru.wikipedia.org/wiki/Таблица_разделов_GUID). В противном случае, виртуальные машины, создаваемые из нового образа, не смогут запустить операционную систему.
      
      {% endnote %}

      * Выбор источника для образа:

          * `imageId` — идентификатор образа-источника.
          * `snapshotId` — идентификатор снимка-источника.
          * `diskId` — идентификатор диска-источника.

          {% note info %}

          Поля `imageId`, `snapshotId` и `diskId` — взаимоисключающие. В запросе вы можете указать только одно из них.

          {% endnote %}

      * `pooled` — параметр, позволяющий включить [оптимизацию](../../concepts/image.md#images-optimized-for-deployment) образа для развертывания. Возможные значения:
      
          * `true` — оптимизация включена.
          * `false` — оптимизация выключена.

          Необязательный параметр. По умолчанию оптимизация выключена.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/images
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateImageMetadata",
        "imageId": "fd8j3jind4ij********"
      },
      "id": "fd8a7eged70b********",
      "description": "Create image",
      "createdAt": "2025-12-05T08:51:44.937021154Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T08:51:44.937021154Z"
      }
      ```

{% endlist %}

В результате будет создан образ, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.

## Создайте снимок диска с закреплением поколения оборудования Gen 2 {#create-snapshot}

Вы можете создать снимок загрузочного диска имеющейся виртуальной машины, работающей на виртуализированном оборудовании поколения `Gen 1.1` или `Gen 1.2`, с закреплением за этим снимком поколения оборудования `Gen 2`.

### Подготовьте диск к созданию снимка {#prepare-for-making-snapshot}

Снимок диска содержит только те данные, которые были записаны на диск в момент создания снимка. Если диск подключен к работающей виртуальной машине, то кеш приложений и операционной системы не попадет в снимок.

Чтобы обеспечить целостность данных снимка:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Остановите все операции записи на диск в приложениях.

  1. Запишите кеш операционной системы на диск:

      ```bash
      sync
      ```

  1. Заморозьте файловую систему:

      ```bash
      sudo fsfreeze --freeze <точка_монтирования>
      ```
      Где `--freeze` — параметр для заморозки файловой системы. Вместо `<точка_монтирования>` укажите каталог, к которому подключена файловая система. Например: `/mnt/vdc2`.

  1. Создайте снимок по инструкции [ниже](#create).

  1. Разморозьте файловую систему:

      ```bash
      sudo fsfreeze --unfreeze <точка_монтирования>
      ```
      Где `--unfreeze` — параметр для разморозки файловой системы. Вместо `<точка_монтирования>` укажите каталог, к которому подключена файловая система. Например: `/mnt/vdc2`.

- Другие ОС {#other}

  1. Остановите виртуальную машину (см. раздел [Остановить](../vm-control/vm-stop-and-start.md#stop)).
  1. Дождитесь, когда статус машины изменится на `STOPPED`.

{% endlist %}

### Создайте снимок {#create-snapshot-operation}

Чтобы создать снимок диска с закреплением поколения оборудования `Gen 2`:

{% note info %}

Закрепить за снимком поколение, отличное от поколения, которое закреплено за исходным диском, можно только с помощью [Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md), [Terraform](../../../terraform/resources/compute_snapshot.md) и [API](../../api-ref/Snapshot/create.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для создания снимков:

      ```bash
      yc compute snapshot create --help
      ```

  1. Создайте снимок в каталоге по умолчанию:

      ```bash
      yc compute snapshot create \
        --name <имя_снимка> \
        --disk-id <идентификатор_диска-источника> \
        --hardware-generation-id generation2
      ```

      Где:
      * `--name` — имя создаваемого снимка. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--disk-id` — идентификатор диска, для которого вы создаете снимок. Вместо идентификатора вы можете передать в команду имя диска в параметре `--disk-name`.

      Результат:

      ```text
      done (18s)
      id: fd8jnmpan5ff********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T14:10:15Z"
      name: my-gen2-snapshot
      storage_size: "3632267264"
      disk_size: "21474836480"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_disk_id: epd89t47vnhd********
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute snapshot create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/snapshot/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_snapshot`.

      Пример структуры конфигурационного файла:
      
      ```hcl
      resource "yandex_compute_snapshot" "snapshot-1" {
        name                 = "<имя_снимка>"
        source_disk_id       = "<идентификатор_диска>"
        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено снимку. Требования к имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `source_disk_id` — идентификатор диска, для которого вы создаете снимок.

      Подробную информацию о параметрах ресурса `yandex_compute_snapshot` см. в [документации провайдера Terraform](../../../terraform/resources/compute_snapshot.md).
          
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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc compute snapshot list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Snapshot/create.md) для ресурса [Snapshot](../../api-ref/Snapshot/index.md) или вызовом gRPC API [SnapshotService/Create](../../api-ref/grpc/Snapshot/create.md).

  Например, чтобы создать снимок с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание снимка (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_снимка>",
        "diskId": "<идентификатор_диска>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается снимок.
      * `name` — имя создаваемого снимка. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `diskId` — идентификатор [диска](../../concepts/disk.md), для которого делается снимок.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/snapshots
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateSnapshotMetadata",
        "snapshotId": "fd8apannhdo9********",
        "diskId": "epd89t47vnhd********"
      },
      "id": "epd473ndlm58********",
      "description": "Create snapshot",
      "createdAt": "2025-12-05T14:43:02.803028670Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-05T14:43:02.803028670Z"
      }
      ```

{% endlist %}

В результате будет создан снимок диска, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.


## Создайте диск с закреплением поколения оборудования Gen 2 {#create-disk}

По умолчанию при создании диска за ним закрепляется то [поколение оборудования](../../concepts/hardware-generations.md), которое [закреплено](../../concepts/hardware-generations.md#locking-generations) за исходным образом или снимком, на основе которых создается этот диск. При этом вы можете явно задать для диска поколение оборудования, отличное от поколения, закрепленного за исходными образом или снимком.

Чтобы создать диск с закреплением поколения оборудования `Gen 2`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В консоли управления выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать образ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![archive](../../../_assets/console-icons/archive.svg) **Диски и хранилища** и нажмите кнопку **Создать диск**. В открывшемся окне:

      1. В поле **Имя** задайте имя диска. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.
      1. В поле **Зона доступности** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой вы создаете диск.
      1. В зависимости от источника, на основе которого вы создаете диск, в поле **Наполнение** выберите `Снимок` или `Образ` и в появившемся списке выберите нужный снимок или образ.
      1. В поле **Тип** выберите [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `SSD` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `HDD` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `SSD IO` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
          * `Нереплицируемый SSD` — сетевой диск с повышенной производительностью без избыточности.
      1. В поле **Размер** задайте нужный размер диска.
      1. Разверните секцию **Дополнительно** и в поле **Поколение оборудования** выберите `Gen 2 (GPT, UEFI)`.
      1. Нажмите кнопку **Создать диск**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды Yandex Cloud CLI для создания диска:

      ```bash
      yc compute disk create --help
      ```
  1. Создайте диск с закрепленным поколением оборудования `Gen 2` в каталоге по умолчанию:

      ```
      yc compute disk create \
        --name <имя_диска> \
        --zone <зона_доступности> \
        --type <тип_диска> \
        --size <размер_диска> \
        --source-image-id <идентификатор_образа-источника> \
        --source-snapshot-id <идентификатор_снимка-источника> \
        --hardware-generation-id generation2
      ```

      Где:
      * `--name` — имя диска. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `--type` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
      * `--size` — размер диска в гигабайтах. Например, чтобы создать диск размером 32 ГБ, укажите `--size 32`.

      * Выбор источника для диска:

          * `--source-image-id` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск. Вместо идентификатора образа вы можете передать его имя в параметре `--source-image-name`.
          * `--source-snapshot-id` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск. Вместо идентификатора снимка вы можете передать его имя в параметре `--source-snapshot-name`.

          {% note info %}

          Параметры `--source-image-id`, `--source-image-name`, `--source-snapshot-id` и `--source-snapshot-name` — взаимоисключающие. В команде вы можете указать только один из них.

          {% endnote %}

      Результат:

      ```text
      done (9s)
      id: fv45fajiusvq********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-04T08:15:45Z"
      name: ununtu2404-gen2-disk
      type_id: network-hdd
      zone_id: ru-central1-a
      size: "34359738368"
      block_size: "4096"
      product_ids:
        - f2ebiogvi127********
      status: READY
      source_image_id: fd8bnguet48k********
      disk_placement_policy: {}
      hardware_generation:
        generation2_features: {}
      ```

  Подробнее о команде `yc compute disk create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/disk/create.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурса `yandex_compute_disk`.

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_compute_disk" "my-disk" {
        name            = "<имя_диска>"
        type            = "<тип_диска>"
        zone            = "<зона_доступности>"
        size            = <размер_диска>
        image_id        = "<идентификатор_образа-источника>"
        snapshot_id     = "<идентификатор_снимка-источника>"

        hardware_generation {
          generation2_features {}
        }
      }
      ```

      Где:
      * `name` — имя, которое будет присвоено диску. Требования к имени:
      
          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `type` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.

      * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `size` — размер диска в ГБ.
      * Выбор источника для диска:

          * `image_id` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск.
          * `snapshot_id` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск.

          {% note info %}

          Параметры `image_id` и `snapshot_id` — взаимоисключающие. В файле конфигурации вы можете указать только один из них.

          {% endnote %}

          Подробную информацию о параметрах ресурса `yandex_compute_disk` см. в [документации провайдера Terraform](../../../terraform/resources/compute_disk.md).
          
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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc compute disk list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Disk/create.md) для ресурса [Disk](../../api-ref/Disk/index.md) или вызовом gRPC API [DiskService/Create](../../api-ref/grpc/Disk/create.md).

  Например, чтобы создать диск с закреплением поколения оборудования `Gen 2` с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание диска (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_диска>",
        "typeId": "<тип_диска>",
        "zoneId": "<зона_доступности>",
        "size": "<размер_диска_в_байтах>",
        "imageId": "<идентификатор_образа-источника>",
        "snapshotId": "<идентификатор_снимка-источника>",
        "hardwareGeneration": {
          "generation2Features": {}
        }
      }
      ```

      Где:

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается диск.
      * `name` — имя диска. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `typeId` — [тип](../../concepts/disk.md#disks-types) диска. Доступные значения:

          * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
          * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
          * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
          * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.

      * `zoneId` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается диск.
      * `size` — размер диска в байтах.
      * Выбор источника для диска:

          * `imageId` — идентификатор [образа](../../concepts/image.md), на основе которого создается диск.
          * `snapshotId` — идентификатор [снимка](../../concepts/snapshot.md), на основе которого создается диск.

          {% note info %}

          Поля `imageId` и `snapshotId` — взаимоисключающие. В запросе вы можете указать только одно из них.

          {% endnote %}

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/disks
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
        "diskId": "fv4lmsdol4fi********"
      },
      "id": "fv4pt28gishg********",
      "description": "Create disk",
      "createdAt": "2025-12-04T09:19:00.743099068Z",
      "createdBy": "ajeol2afu1js********",
      "modifiedAt": "2025-12-04T09:19:00.743099068Z"
      }
      ```

{% endlist %}

В результате будет создан диск, к которому привязано [поколение](../../concepts/hardware-generations.md) виртуализированного оборудования `Gen 2`.

## Создайте виртуальную машину, работающую на оборудовании поколения Gen 2 {#create-vm}

{% note info %}

Прежде чем создавать ВМ, [подготовьте](../vm-connect/ssh.md#creating-ssh-keys) пару ключей (открытый и закрытый) для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ.

{% endnote %}

Используйте подготовленный ранее [образ](#create-image), [снимок](#create-snapshot) или [диск](#create-disk) с закрепленным поколением оборудования `Gen 2`, чтобы создать виртуальную машину, работающую на оборудовании этого поколения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Расположение** выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

      {% note info %}

      Если вы создаете ВМ, подключая к ней готовый загрузочный диск, убедитесь, что ваш диск находится в той же зоне доступности, в которой вы собираетесь создать ВМ.

      {% endnote %}

  1. В блоке **Образ загрузочного диска** перейдите на вкладку **Пользовательский** и нажмите кнопку **Выбрать**. В открывшемся окне:

      * Чтобы создать ВМ из [подготовленного ранее снимка](#create-snapshot):
      
          1. Убедитесь, что в верхней части экрана выбрана опция `Создать`, а в поле **Наполнение** выбрана опция `Снимок`.
          1. В списке снимков выберите нужный. При необходимости воспользуйтесь фильтром.
          1. В поле **Имя** задайте имя загрузочного диска ВМ. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.
          1. В полях **Тип** и **Размер** выберите нужные [тип](../../concepts/disk.md#disks-types) и размер создаваемого диска.
          1. (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **Добавить диск**.
      * Чтобы создать ВМ из [подготовленного ранее образа](#create-image):
      
          1. Убедитесь, что в верхней части экрана выбрана опция `Создать`.
          1. В поле **Наполнение** выберите опцию `Образ`.
          1. В списке образов выберите нужный. При необходимости воспользуйтесь фильтром.
          1. В поле **Имя** задайте имя загрузочного диска ВМ. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.
          1. В полях **Тип** и **Размер** выберите нужные [тип](../../concepts/disk.md#disks-types) и размер создаваемого диска.
          1. (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **Добавить диск**.
      * Чтобы создать ВМ из [подготовленного ранее диска](#create-disk):
      
          1. В верхней части экрана выберите опцию `Подключить существующий`.
          1. В списке дисков выберите нужный. При необходимости воспользуйтесь фильтром.
          1. (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, чтобы включить автоудаление создаваемого загрузочного диска вместе с ВМ.
          1. Нажмите кнопку **Добавить диск**.
  1. В блоке **Вычислительные ресурсы** выберите одну из готовых конфигураций или создайте свою. Чтобы создать свою конфигурацию:
     
     * Перейдите на вкладку **Своя конфигурация**.
     * Выберите [платформу](../../concepts/vm-platforms.md).
     * Укажите [гарантированную долю](../../concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
     * При необходимости включите [программно ускоренную сеть](../../concepts/software-accelerated-network.md).
     * При необходимости сделайте ВМ [прерываемой](../../concepts/preemptible-vm.md).
  1. В блоке **Сетевые настройки**:
     
     * В поле **Подсеть** укажите идентификатор подсети в зоне доступности создаваемой ВМ или выберите [облачную сеть](../../../vpc/concepts/network.md#network) из списка.
     
         * У каждой сети должна быть как минимум одна [подсеть](../../../vpc/concepts/network.md#subnet). Если подсети нет, создайте ее, выбрав **Создать подсеть**.
         * Если сети нет, нажмите **Создать сеть** и создайте ее:
     
             * В открывшемся окне укажите имя сети и выберите каталог, в котором она будет создана.
             * (Опционально) Выберите опцию **Создать подсети**, чтобы автоматически создать подсети во всех зонах доступности.
             * Нажмите **Создать сеть**.
     
     * В поле **Публичный IP-адрес** выберите способ назначения адреса:
     
         * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов Yandex Cloud. В этом случае можно включить [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md) при помощи опции ниже.
         * `Список` — чтобы выбрать публичный IP-адрес из списка зарезервированных заранее статических адресов. Подробнее читайте в разделе [Сделать динамический публичный IP-адрес статическим](../../../vpc/operations/set-static-ip.md).
         * `Без адреса` — чтобы не назначать публичный IP-адрес.
     
     * Выберите [подходящие группы безопасности](../../../vpc/concepts/security-groups.md). Если оставить поле пустым, то виртуальной машине будет автоматически назначена группа безопасности по умолчанию.
     
     * Разверните блок **Дополнительно** и в поле **Внутренний IPv4 адрес** выберите способ назначения внутренних адресов:
     
         * `Автоматически` — чтобы назначить случайный IP-адрес из пула адресов, доступных в выбранной подсети.
         * `Вручную` — чтобы задать внутренний IP-адрес ВМ вручную.
         * При необходимости включите опцию **Защита от DDoS-атак**. Опция доступна, если ранее в настройках публичного адреса вы выбрали автоматический способ назначения адреса.
     
     * (Опционально) Создайте записи для ВМ в [зоне DNS](../../../dns/concepts/dns-zone.md):
     
         * Разверните блок **Настройки DNS для внутренних адресов** и нажмите **Добавить запись**.
         * Укажите зону, FQDN и время жизни записи. При указании FQDN для зоны доступна опция `Определять автоматически`.
           Вы можете добавить несколько записей во [внутренние зоны](../../../dns/concepts/dns-zone.md) DNS. Подробнее см. [Интеграция Cloud DNS с Compute Cloud](../../../dns/concepts/compute-integration.md).
         * Чтобы создать еще одну запись, нажмите кнопку **Добавить запись**.
     
     Если вы хотите добавить на ВМ дополнительный [сетевой интерфейс](../../concepts/network.md), нажмите кнопку **Добавить сетевой интерфейс** и в появившемся блоке настроек нового интерфейса повторите действия, описанные выше в этом шаге. На одну ВМ можно добавить до восьми сетевых интерфейсов.
  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа к ВМ:
  
      * В поле **Логин** введите имя пользователя.
  
          {% note alert %}
  
          Не используйте логин `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
  
          {% endnote %}
  
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация** задайте имя ВМ:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

      {% note info %}
      
      Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
      
      {% endnote %}

  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```
  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance create \
        --name <имя_ВМ> \
        --zone <зона_доступности_ВМ> \
        --network-interface subnet-id=<идентификатор_подсети>,nat-ip-version=ipv4 \
        --create-boot-disk name=<имя_диска>,type=<тип_диска>,size=<размер_диска>,image-id=<идентификатор_образа>,snapshot-id=<идентификатор_снимка>,auto-delete=true \
        --use-boot-disk disk-id=<идентификатор_существующего_диска>,auto-delete=true \
        --ssh-key "<путь_к_публичному_SSH-ключу>"
      ```

      Где:
      * `--name` — имя ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

          {% note info %}
          
          Имя виртуальной машины используется для генерации [внутреннего FQDN](../../concepts/network.md#hostname) единожды — при создании ВМ. Если для вас важен внутренний FQDN, учитывайте это и задавайте нужное имя ВМ при создании.
          
          {% endnote %}

      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой создается ВМ.
      
          Зона доступности ВМ должна соответствовать зоне доступности используемой подсети.
          
          При создании ВМ с использованием подготовленного заранее загрузочного диска зона доступности ВМ должна соответствовать зоне доступности этого диска.
      * `--network-interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          * `subnet-id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
          * `nat-ip-version=ipv4` – [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Чтобы создать ВМ без публичного IP-адреса, исключите параметр.

          Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте параметр `--network-interface` необходимое количество раз. На одну ВМ можно добавить до восьми сетевых интерфейсов.

      * Настройки загрузочного диска виртуальной машины:

          {% note info %}

          Параметры `--create-boot-disk` и `--use-boot-disk` — взаимоисключающие. Вы можете использовать только один из них.

          {% endnote %}

          * `--create-boot-disk` — параметр, позволяющий создать для ВМ новый загрузочный диск на основе образа или снимка:

              * `name` — имя создаваемого диска. Требования к имени:

                  * длина — от 3 до 63 символов;
                  * может содержать строчные буквы латинского алфавита, цифры и дефисы;
                  * первый символ — буква, последний — не дефис.
              
              * `type` — [тип](../../concepts/disk.md#disks-types) создаваемого диска. Доступные значения:

                  * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
                  * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
                  * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
                  * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
              * `size` — размер диска в гигабайтах.
              * Выбор источника для создания загрузочного диска:

                  * `image-id` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
                  * `snapshot-id` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.

                      {% note info %}

                      Ключи `image-id` и `snapshot-id` — взаимоисключающие. Вы можете использовать только один из них.

                      {% endnote %}

              * `auto-delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [Автоудаление дисков](../../concepts/disk.md#autodelete-disks).
          * `--use-boot-disk` — параметр, позволяющий использовать в ВМ существующий загрузочный диск, [подготовленный ранее](#create-disk):

              * `disk-id` — идентификатор существующего загрузочного диска.
              * `auto-delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [Автоудаление дисков](../../concepts/disk.md#autodelete-disks).
      * `--ssh-key` — путь к файлу с [публичным SSH-ключом](../vm-connect/ssh.md#creating-ssh-keys). Для этого ключа на ВМ будет автоматически создан пользователь `yc-user`.

      Результат:

      ```text
      done (19s)
      id: fv4l7qqpi4e0********
      folder_id: b1gt6g8ht345********
      created_at: "2025-12-05T18:23:55Z"
      name: my-first-gen2-vm
      zone_id: ru-central1-a
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
        device_name: fv4h89mv71cb********
        auto_delete: true
        disk_id: fv4h89mv71cb********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:15:3e:b5:99
          subnet_id: fl8dmq91iruu********
          primary_v4_address:
            address: 192.168.3.3
            one_to_one_nat:
              address: 158.160.***.***
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: fv4l7qqpi4e0********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        generation2_features: {}
      application: {}
      ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_compute_disk" "boot-disk" {
        name            = "<имя_диска>"
        type            = "<тип_диска>"
        zone            = "<зона_доступности>"
        size            = "<размер_диска>"
        image_id        = "<идентификатор_образа-источника>"
        snapshot_id     = "<идентификатор_снимка-источника>"
      }

      resource "yandex_compute_instance" "vm-1" {
        name                      = "<имя_вм>"
        platform_id               = "standard-v3"
        zone                      = "<зона_доступности>"

        resources {
          cores  = "<количество_ядер_vCPU>"
          memory = "<объем_RAM_ГБ>"
        }

        boot_disk {
          auto_delete = true|false
          disk_id = yandex_compute_disk.boot-disk.id
        }

        network_interface {
          subnet_id = "<идентификатор_подсети>"
          nat       = true
        }

        metadata = {
          ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
        }
      }
      ```

      Где:
      * `yandex_compute_disk` — описание загрузочного [диска](../../concepts/disk.md):

          {% note info %}

          Используйте ресурс `yandex_compute_disk`, если для ВМ вы создаете новый загрузочный диск из подготовленных ранее образа или снимка.
          
          Если в новой ВМ вы будете использовать существующий загрузочный диск, [подготовленный ранее](#create-disk), укажите идентификатор этого диска в параметре `boot_disk.disk_id` ресурса `yandex_compute_instance`, не создавая нового ресурса `yandex_compute_disk`.

          {% endnote %}

          * `name` — имя создаваемого диска. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

          * `type` — [тип](../../concepts/disk.md#disks-types) создаваемого диска. Доступные значения:

              * `network-ssd` — быстрый сетевой диск, сетевое блочное хранилище на SSD-накопителе.
              * `network-hdd` — стандартный сетевой диск, сетевое блочное хранилище на HDD-накопителе.
              * `network-ssd-nonreplicated` — сетевой диск с повышенной производительностью без избыточности.
              * `network-ssd-io-m3` — сетевой диск с повышенной производительностью, обеспечивающий избыточность.
          * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться диск.
          * `size` — размер диска в ГБ.
          * Выбор источника для создания загрузочного диска:

              {% note info %}

              Параметры `image_id` и `snapshot_id` — взаимоисключающие. Вы можете использовать только один из них.

              {% endnote %}

              * `image_id` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
              * `snapshot_id` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.

          Подробную информацию о параметрах ресурса `yandex_compute_disk` см. в [документации провайдера Terraform](../../../terraform/resources/compute_disk.md).

      * `yandex_compute_instance` — описание ВМ:
          * `name` — имя ВМ. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

          * `platform_id` — [платформа](../../concepts/vm-platforms.md).
          * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

              Зона доступности виртуальной машины должна совпадать с зоной доступности используемой подсети, а также с зоной доступности загрузочного диска, если вы создаете ВМ из подготовленного заранее диска.
          * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
          * `boot_disk` — настройки загрузочного диска:
          
              * `disk_id` — идентификатор диска. Если в новой ВМ вы будете использовать существующий загрузочный диск, [подготовленный ранее](#create-disk), укажите его идентификатор в этом параметре.
              * `auto_delete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [Автоудаление дисков](../../concepts/disk.md#autodelete-disks).
          * `network_interface` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:
          
              * `subnet_id` — идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в той же зоне доступности, в которой создается виртуальная машина.
              * Чтобы автоматически назначить ВМ [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses), укажите `nat = true`.

              Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), задайте блок `network_interface` необходимое количество раз.

          * `metadata` — в метаданных необходимо передать имя пользователя и открытый SSH-ключ для доступа на ВМ. Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).

      Подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера Terraform](../../../terraform/resources/compute_instance.md).
          
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

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

      ```bash
      yc compute instance list
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

  Например, чтобы создать виртуальную машину с помощью REST API:

  1. Установите утилиту [cURL](https://curl.haxx.se).
  1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md), используемый для аутентификации в API:
      * [Инструкция](../../../iam/operations/iam-token/create.md) для пользователя с аккаунтом на Яндексе.
      * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
      * [Инструкция](../../../iam/operations/iam-token/create-for-federation.md) для федеративного аккаунта.
      * [Инструкция](../../../iam/operations/iam-token/create-for-local.md) для локального аккаунта.
  1. Для удобства выполнения запроса сохраните полученный IAM-токен в переменную окружения `IAM_TOKEN`:

      ```bash
      export IAM_TOKEN="<содержимое_IAM-токена>"
      ```
  1. Создайте файл с телом запроса на создание виртуальной машины (например, `body.json`) и добавьте в него следующий код:

      **body.json**

      ```json
      {
        "folderId": "<идентификатор_каталога>",
        "name": "<имя_ВМ>",
        "zoneId": "<зона_доступности>",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "<объем_RAM_в_байтах>",
          "cores": "<количество_ядер_vCPU>"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "autoDelete": true,
          "diskSpec": {
            "size": "<размер_диска_в_байтах>",
            "imageId": "<идентификатор_образа-источника>",
            "snapshotId": "<идентификатор_снимка-источника>"
          },
          "diskId": "<идентификатор_диска>"
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "<идентификатор_подсети>",
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

      * `folderId` — [идентификатор](../../../resource-manager/operations/folder/get-id.md) каталога, в котором создается виртуальная машина.
      * `name` — имя ВМ. Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * `zoneId` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться ВМ.

          Зона доступности виртуальной машины должна совпадать с зоной доступности используемой подсети, а также с зоной доступности загрузочного диска, если вы создаете ВМ из [подготовленного ранее диска](#create-disk).
      * `platformId` — [платформа](../../concepts/vm-platforms.md) виртуальной машины.
      * `resourceSpec` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
      * `metadata` — в метаданных необходимо передать открытый ключ для SSH-доступа на ВМ. Подробнее в разделе [Метаданные виртуальной машины](../../concepts/vm-metadata.md).
      * `bootDiskSpec` — настройки загрузочного диска виртуальной машины:

          * `autoDelete` — настройка автоудаления загрузочного диска вместе с ВМ. См. [Автоудаление дисков](../../concepts/disk.md#autodelete-disks).

          {% note info %}

          Параметры `diskSpec` и `diskId` — взаимоисключающие. Вы можете использовать только один из них.

          {% endnote %}

          * `diskSpec` — настройка нового загрузочного диска в случае его создания из подготовленного ранее образа или снимка:

              * `size` — размер создаваемого диска в байтах.
              * Выбор источника для создания загрузочного диска:

                  {% note info %}

                  Параметры `imageId` и `snapshotId` — взаимоисключающие. Вы можете использовать только один из них.

                  {% endnote %}

                  * `imageId` — идентификатор [подготовленного ранее образа](#create-image), на основе которого будет создан загрузочный диск ВМ.
                  * `snapshotId` — идентификатор [подготовленного ранее снимка](#create-snapshot), на основе которого будет создан загрузочный диск ВМ.
          * `diskId` — идентификатор существующего загрузочного диска, [подготовленного ранее](#create-disk), в случае его использования для создания ВМ.
      * `networkInterfaceSpecs` — настройки [сетевого интерфейса](../../concepts/network.md) ВМ:

          * `subnetId` — идентификатор выбранной [подсети](../../../vpc/concepts/network.md#subnet). Подсеть должна находиться в той же зоне доступности, в которой вы создаете ВМ.
          * `primaryV4AddressSpec` — IP-адрес, который будет присвоен ВМ. Чтобы добавить [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ, укажите:

            ```json
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```
          Если вы хотите добавить на ВМ несколько [сетевых интерфейсов](../../concepts/network.md), передайте в `networkInterfaceSpecs` массив с необходимым количеством объектов с настройками сетевых интерфейсов.

  1. Выполните HTTP-запрос:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.api.cloud.yandex.net/compute/v1/instances
      ```

      Результат:

      ```text
      {
      "done": false,
      "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateInstanceMetadata",
        "instanceId": "fv41kcr9qbd8********"
      },
      "id": "fv4tll89q78c********",
      "description": "Create instance",
      "createdAt": "2025-12-05T20:37:44.940310692Z",
      "createdBy": "ajeol2afu1jsk********",
      "modifiedAt": "2025-12-05T20:37:44.940310692Z"
      }
      ```

{% endlist %}

#### См. также {#see-also}

* [Поколения оборудования](../../concepts/hardware-generations.md)