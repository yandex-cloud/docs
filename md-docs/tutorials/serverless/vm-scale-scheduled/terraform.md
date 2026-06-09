# Масштабирование группы виртуальных машин по расписанию с помощью Terraform

Чтобы настроить [масштабирование группы виртуальных машин по расписанию](index.md) c помощью Terraform:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте масштабирование группы ВМ](#test-scale).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* плата за [диски](../../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Compute Cloud](../../../compute/pricing.md));
* плата за вызовы [функции](../../../functions/concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы Cloud Functions](../../../functions/pricing.md)).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Создайте инфраструктуру с помощью Terraform:

1. [Установите Terraform](../../infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-scheduled-scaling
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `vm-scale-scheduled.tf` — конфигурация создаваемой инфраструктуры.
        * `vm-scale-scheduled.auto.tfvars` — файл с пользовательскими данными.
        * `vm-scale-scheduled-function.zip` — архив с кодом функции Cloud Functions.


   - Вручную {#manual}

     1. Создайте папку для файлов.
     1. Создайте в папке:
        * Конфигурационный файл `vm-scale-scheduled.tf`:

          {% cut "vm-scale-scheduled.tf" %}

          ```hcl
          # Объявление переменных для конфиденциальных параметров
          
          variable "folder_id" {
            type = string
          }
          
          variable "username" {
            type = string
          }
          
          variable "ssh_key_path" {
            type = string
          }
          
          # Настройка провайдера
          
          terraform {
            required_providers {
              yandex = {
                source  = "yandex-cloud/yandex"
                version = ">= 0.47.0"
              }
            }
          }
          
          provider "yandex" {
            folder_id = var.folder_id
          }
          
          # Создание сервисного аккаунта и назначение ему ролей
          
          resource "yandex_iam_service_account" "vm-scale-scheduled-sa" {
            name      = "vm-scale-scheduled-sa"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "vm-scale-scheduled-sa-role-compute" {
            folder_id = var.folder_id
            role      = "compute.editor"
            member    = "serviceAccount:${yandex_iam_service_account.vm-scale-scheduled-sa.id}"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "vm-scale-scheduled-sa-role-iam" {
            folder_id = var.folder_id
            role      = "iam.serviceAccounts.user"
            member    = "serviceAccount:${yandex_iam_service_account.vm-scale-scheduled-sa.id}"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "vm-scale-scheduled-sa-role-functions" {
            folder_id = var.folder_id
            role      = "functions.functionInvoker"
            member    = "serviceAccount:${yandex_iam_service_account.vm-scale-scheduled-sa.id}"
          }
          
          # Создание облачной сети и подсетей
          
          resource "yandex_vpc_network" "vm-scale-scheduled-network" {
            name = "vm-scale-scheduled-network"
          }
          
          resource "yandex_vpc_subnet" "vm-scale-scheduled-subnet-a" {
            name           = "vm-scale-scheduled-subnet-a"
            zone           = "ru-central1-a"
            v4_cidr_blocks = ["192.168.1.0/24"]
            network_id     = yandex_vpc_network.vm-scale-scheduled-network.id
          }
          
          resource "yandex_vpc_subnet" "vm-scale-scheduled-subnet-b" {
            name           = "vm-scale-scheduled-subnet-b"
            zone           = "ru-central1-b"
            v4_cidr_blocks = ["192.168.2.0/24"]
            network_id     = yandex_vpc_network.vm-scale-scheduled-network.id
          }
          
          # Создание образа
          
          resource "yandex_compute_image" "vm-scale-scheduled-image" {
            source_family = "ubuntu-2004-lts"
          }
          
          # Создание группы ВМ
          
          resource "yandex_compute_instance_group" "vm-scale-scheduled-ig" {
            name               = "vm-scale-scheduled-ig"
            service_account_id = yandex_iam_service_account.vm-scale-scheduled-sa.id
          
            allocation_policy {
              zones = [
                "ru-central1-a",
                "ru-central1-b"
              ]
            }
          
            instance_template {
              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = yandex_compute_image.vm-scale-scheduled-image.id
                  size     = 15
                }
              }
          
              platform_id = "standard-v3"
              resources {
                cores         = 2
                core_fraction = 20
                memory        = 2
              }
          
              network_interface {
                network_id = yandex_vpc_network.vm-scale-scheduled-network.id
                subnet_ids = [
                  yandex_vpc_subnet.vm-scale-scheduled-subnet-a.id,
                  yandex_vpc_subnet.vm-scale-scheduled-subnet-b.id
                ]
              }
          
              metadata = {
                user-data = "#cloud-config\nusers:\n  - name: ${var.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
              }
            }
          
            scale_policy {
              fixed_scale {
                size = 2
              }
            }
          
            deploy_policy {
              max_unavailable = 2
              max_creating    = 2
              max_expansion   = 2
              max_deleting    = 2
            }
          
            depends_on = [
              yandex_resourcemanager_folder_iam_member.vm-scale-scheduled-sa-role-compute,
              yandex_resourcemanager_folder_iam_member.vm-scale-scheduled-sa-role-iam
            ]
          }
          
          # Создание функции
          
          resource "yandex_function" "vm-scale-scheduled-function" {
            name               = "vm-scale-scheduled-function"
            runtime            = "bash"
          
            user_hash          = "function-v1"
            entrypoint         = "handler.sh"
            content {
              zip_filename = "vm-scale-scheduled-function.zip"
            }
          
            execution_timeout  = "60"
            memory             = "128"
            service_account_id = yandex_iam_service_account.vm-scale-scheduled-sa.id
          
            environment = {
              IG_NAME      = yandex_compute_instance_group.vm-scale-scheduled-ig.name
              IG_BASE_SIZE = "2"
              FOLDER_ID    = var.folder_id
            }
          
            depends_on = [
              yandex_resourcemanager_folder_iam_member.vm-scale-scheduled-sa-role-functions
            ]
          }
          
          # Создание тригера
          
          resource "yandex_function_trigger" "vm-scale-scheduled-trigger" {
            name = "vm-scale-scheduled-trigger"
            timer {
              cron_expression = "*/2 * * * ? *"
            }
            function {
              id                 = yandex_function.vm-scale-scheduled-function.id
              tag                = "$latest"
              service_account_id = yandex_iam_service_account.vm-scale-scheduled-sa.id
            }
          
            depends_on = [
              yandex_resourcemanager_folder_iam_member.vm-scale-scheduled-sa-role-functions
            ]
          }
          ```

          {% endcut %}

        * Файл с пользовательскими данными `vm-scale-scheduled.auto.tfvars`:

          {% cut "vm-scale-scheduled.auto.tfvars" %}

          ```hcl
          folder_id    = "<идентификатор_каталога>"
          username     = "<имя_пользователя_ВМ>"
          ssh_key_path = "<путь_к_публичному_SSH-ключу>"
          ```

          {% endcut %}

        * Файл с кодом функции Cloud Functions `handler.sh`:

          {% cut "handler.sh" %}

          {% note warning %}
          
          Если вы создаете файл в Windows, убедитесь, что переносы строк имеют формат Unix: `\n`, а не `\r\n`. Заменить переносы можно в текстовом редакторе, например [Notepad++](https://notepad-plus-plus.org/), или с помощью утилиты [dos2unix](https://waterlan.home.xs4all.nl/dos2unix.html) или [Tofrodos](https://www.thefreecountry.com/tofrodos/).
          
          {% endnote %}

          ```bash
          # Get ID and current size of the instance group
          IG_SPEC=$(yc compute instance-group get --name $IG_NAME --folder-id $FOLDER_ID --format json)
          IG_ID=$(jq -r ".id" <<< $IG_SPEC)
          IG_SIZE=$(jq -r ".scale_policy.fixed_scale.size" <<< $IG_SPEC)
          
          # Calculate new size for the instance group
          if [ $IG_SIZE = $IG_BASE_SIZE ]; then
              IG_SIZE="$(($IG_BASE_SIZE + 1))"
          else
              IG_SIZE=$IG_BASE_SIZE
          fi
          
          # Update the instance group
          yc compute instance-group update --id $IG_ID --scale-policy-fixed-scale-size $IG_SIZE
          ```

          {% endcut %}

     1. Создайте в папке архив `vm-scale-scheduled-function.zip`, содержащий файл `handler.sh`.

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Сеть](../../../vpc/concepts/network.md#network) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md).
   * [Подсети](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Образ ВМ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Группа ВМ](../../../compute/concepts/instance-groups/index.md) — [yandex_compute_instance_group](../../../terraform/resources/compute_instance_group.md).
   * [Функция](../../../functions/concepts/function.md) — [yandex_function](../../../terraform/resources/function.md).
   * [Триггер](../../../functions/concepts/trigger/index.md) — [yandex_function_trigger](../../../terraform/resources/function_trigger.md).

1. В файле `vm-scale-scheduled.auto.tfvars` задайте пользовательские параметры:

   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
   * `username` — имя пользователя, который будет создан на ВМ.
   * `ssh_key_path` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Создать пару ключей можно по [инструкции](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

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

После создания инфраструктуры, [проверьте масштабирование группы ВМ](#test-scale).

## Проверьте масштабирование группы ВМ {#test-scale}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог `example-folder`.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. Выберите группу `vm-scale-scheduled-ig`.
  1. Убедитесь, что в блоке **Виртуальные машины** каждые две минуты изменяется количество ВМ: увеличивается с 2 до 3, затем уменьшается с 3 до 2 и т. д. Также вы можете проверить обновление группы на вкладке ![image](../../../_assets/console-icons/list-check.svg) **Операции**.

- CLI {#cli}

  Несколько раз выполните следующую команду:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```

  Результат:

  ```yaml
  id: cl1l0ljqbmkp********
  folder_id: b1g9hv2loamq********
  created_at: "2022-03-28T13:24:20.693Z"
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```

  Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

- API {#api}

  Несколько раз получите информацию о группе ВМ `vm-scale-scheduled-ig` с помощью метода REST API [get](../../../compute/instancegroup/api-ref/InstanceGroup/get.md) для ресурса [InstanceGroup](../../../compute/instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Get](../../../compute/instancegroup/api-ref/grpc/InstanceGroup/get.md). Значение в поле `target_size` (целевой размер группы) должно меняться с `2` на `3` и обратно.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `vm-scale-scheduled.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

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

#### См. также {#see-also}

* [Масштабирование группы виртуальных машин по расписанию с помощью консоли управления](console.md).