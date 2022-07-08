# Создать автоматически масштабируемую группу виртуальных машин

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

Вы можете создать автоматически масштабируемую группу однотипных виртуальных машин. Управление размером такой группой будет осуществляться автоматически. Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/scale.md#auto-scale).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

Чтобы создать автоматически масштабируемую группу виртуальных машин:

{% list tabs %}

- Консоль управления

  {% include [create-autoscaled-group-via-concole.md](../../../_includes/instance-groups/create-autoscaled-group-via-concole.md) %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы виртуальных машин:

      ```
      {{ yc-compute-ig }} create --help
      ```

  1. Проверьте, есть ли в каталоге сети:

      ```
      yc vpc network list
      ```

      Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).

  1. Выберите один из [публичных образов](../images-with-pre-installed-software/get-list.md) {{ marketplace-name }} (например, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Создайте YAML-файл с произвольным именем, например `specification.yaml`.

  1. Опишите в созданном файле:

      * Общую информацию о группе:

          ```
          name: first-autoscaled-group
          service_account_id: <ID>
          description: "This instance group was created from YAML config."
          ```

          Ключи:

          Ключ | Значение
          ----- | -----
          `name` | Произвольное имя группы виртуальных машин. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
          `service_account_id` | Идентификатор сервисного аккаунта.
          `description` | Произвольное описание группы виртуальных машин.

      * [Шаблон виртуальной машины](../../concepts/instance-groups/instance-template.md), например:

          ```
          instance_template:
              platform_id: standard-v3
              resources_spec:
                  memory: 2g
                  cores: 2
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 32g
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
              scheduling_policy:
                  preemptible: false
          ```

          {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

          Ключи (в таблице приведены ключи, которые непосредственно определяют параметры ВМ):

          Ключ | Значение
          ----- | -----
          `platform_id` | Идентификатор платформы.
          `memory` | Количество памяти (RAM).
          `cores` | Количество ядер процессора (vCPU).
          `mode` | Режим доступа к диску.</br>- `READ_ONLY` — доступ на чтение.</br>- `READ_WRITE` — доступ на чтение и запись.
          `image_id` | Идентификатор публичного образа.
          `type_id` | Тип диска.
          `size` | Размер диска.
          `network_id` | Идентификатор сети `default-net`.
          `primary_v4_address_spec` | Спецификация версии интернет протокола IPv4. Вы можете предоставить публичный доступ к виртуальным машинам группы, указав версию IP для публичного IP-адреса. Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
          `scheduling_policy` | Конфигурация политики планирования.
          `preemptible` | Флаг, указывающий создавать [прерываемые виртуальные машины](../../concepts/preemptible-vm.md). Если значение `true` — будет создана прерываемая, если `false` (по умолчанию) — обычная.<br>Создавая группу прерываемых машин учитывайте, что виртуальные машины будут останавливаться спустя 24 часа непрерывной работ, а могут быть остановлены еще раньше. При этом возможна ситуация, что {{ ig-name }} не сможет сразу перезапустить их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в {{ yandex-cloud }}.
      * [Политики](../../concepts/instance-groups/policies/index.md):

          ```
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              auto_scale:
                  initial_size: 5
                  max_size: 15
                  min_zone_size: 3
                  measurement_duration: 30s
                  warmup_duration: 60s
                  stabilization_duration: 120s
                  cpu_utilization_rule: 0.75
          allocation_policy:
              zones:
                  - zone_id: {{ region-id }}-a
          ```

          Ключи:

          Ключ | Значение
          ----- | -----
          `deploy_policy` | [Политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) виртуальных машин в группе.
          `scale_policy` | [Политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) виртуальных машин в группе.
          `allocation_policy` | [Политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) виртуальных машин по зонам и регионам.

          Полный код файла `specification.yaml`:

          ```
          name: first-autoscaled-group
          service_account_id: ajed6ilf11qg839dcl1e
          description: "This instance group was created from YAML config."
          instance_template:
              platform_id: standard-v3
              resources_spec:
                  memory: 2g
                  cores: 2
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 32g
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              auto_scale:
                  initial_size: 5
                  max_size: 15
                  min_zone_size: 3
                  measurement_duration: 30s
                  warmup_duration: 60s
                  stabilization_duration: 120s
                  cpu_utilization_rule:
                      utilization_target: 75
          allocation_policy:
              zones:
                  - zone_id: {{ region-id }}-a
          ```

  1. Создайте группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      Данная команда создаст автоматически масштабируемую группу ВМ со следующими характеристиками:

      * С именем `first-autoscaled-group`.
      * С OC CentOS 7.
      * В сети `default-net`.
      * В зоне доступности `{{ region-id }}-a`.
      * С 2 vCPU и 2 ГБ RAM.
      * С сетевым HDD-диском объемом 32 ГБ.

- API

  Воспользуйтесь методом API [create](../../api-ref/InstanceGroup/create.md).

- Terraform

  Если у вас еще нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       {% note info %}

       Если у вас уже есть подходящие ресурсы (сервисный аккаунт, облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

       {% endnote %}

     * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.
     * `yandex_resourcemanager_folder_iam_binding` — описание прав доступа к каталогу, которому принадлежит сервисный аккаунт. Чтобы иметь возможность создавать, обновлять и удалять виртуальные машины в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`.
     * `yandex_compute_instance_group` — описание [группы виртуальных машин](../../concepts/index.md):

       * Общая информация о группе:

          Поле | Описание
          ----- | -----
          `name` | Имя группы виртуальных машин.
          `folder_id` | Идентификатор каталога.
          `service_account_id` | Идентификатор сервисного аккаунта.

       * [Шаблон виртуальной машины](../../concepts/instance-groups/instance-template.md):

          Поле | Описание
          ----- | -----
          `platform_id` | [Платформа](../../concepts/vm-platforms.md).
          `resources` | Количество ядер vCPU и объем RAM, доступные виртуальной машине. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
          `boot_disk` | Настройки загрузочного диска. Укажите: </br> - Идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md). </br> - Режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
          `network_interface` | Настройка сети. Укажите идентификаторы сети и подсети.
          `metadata` | В метаданных необходимо передать открытый ключ для SSH-доступа на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).

       * [Политики](../../concepts/instance-groups/policies/index.md):

          Поле | Описание
          ----- | -----
          `deploy_policy` | [Политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) виртуальных машин в группе.
          `scale_policy` | [Политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) виртуальных машин в группе.
          `allocation_policy` | [Политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) виртуальных машин по зонам и регионам.

     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#subnet), к которой будет подключена группа виртуальных машин.
            
     Пример структуры конфигурационного файла:
     
     ```
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "service account to manage IG"
     }

     resource "yandex_resourcemanager_folder_iam_binding" "editor" {
       folder_id = "<идентификатор каталога>"
       role      = "editor"
       members   = [
         "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
       ]
     }

     resource "yandex_compute_instance_group" "ig-1" {
       name               = "autoscaled-ig"
       folder_id          = "<идентификатор каталога>"
       service_account_id = "${yandex_iam_service_account.ig-sa.id}"
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = <объем RAM в ГБ>
           cores  = <количество ядер vCPU>
         }

         boot_disk {
           mode = "READ_WRITE"
           initialize_params {
             image_id = "<идентификатор образа>"
           }
         }

         network_interface {
           network_id = "${yandex_vpc_network.network-1.id}"
           subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
         }

         metadata = {
           ssh-keys = "<имя пользователя>:<содержимое SSH-ключа>"
         }
       }

       scale_policy {
         auto_scale {
           initial_size           = 3
           measurement_duration   = 60
           cpu_utilization_target = 75
           min_zone_size          = 3
           max_size               = 15
           warmup_duration        = 60
           stabilization_duration = 120
         }
       }

       allocation_policy {
         zones = ["{{ region-id }}-a"]
       }

       deploy_policy {
         max_unavailable = 1
         max_expansion   = 0
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "{{ region-id }}-a"
       network_id     = "${yandex_vpc_network.network-1.id}"
       v4_cidr_blocks = ["192.168.10.0/24"]
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

  1. Разверните облачные ресурсы.
  
     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}