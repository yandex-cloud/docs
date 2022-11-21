# Создать группу виртуальных машин фиксированного размера с L7-балансировщиком

Вы можете создать группу виртуальных машин фиксированного размера совместно с L7-балансировщиком, который будет распределять входящий HTTP- или gRPC-трафик по ВМ. Подробнее читайте в разделе [{#T}](../../../application-load-balancer/concepts/index.md).

{% include [alb-warning.md](../../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

Чтобы создать группу виртуальных машин с L7-балансировщиком нагрузки:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа виртуальных машин.
  1. В списке сервисов выберите **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Нажмите кнопку **Создать группу**.
  1. В блоке **Базовые параметры**:
      * Введите **Имя** и **Описание** группы ВМ. Требования к имени:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять виртуальные машины в группе, назначьте сервисному аккаунту роль `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.
      * Включите опцию **Защита от удаления** при необходимости. Пока опция включена, невозможно удалить группу.
  1. В блоке **Распределение** выберите нужные **Зоны доступности**. Виртуальные машины группы могут находиться в разных зонах и регионах доступности. [Подробнее о географии {{ yandex-cloud }}](../../../overview/concepts/geo-scope.md).
  1. В блоке **Шаблон виртуальной машины** нажмите кнопку **Задать**, чтобы задать конфигурацию базовой виртуальной машины:
      * В блоке **Базовые параметры** введите **Описание** шаблона.
      * В блоке **Выбор образа/загрузочного диска** выберите, какую систему развернуть на загрузочном диске ВМ.

        
      * В блоке **Диски**:
          * Выберите [тип диска](../../concepts/disk.md#disks_types).
          * Укажите **Размер** диска.
          * Укажите **Наполнение** диска.
          * (опционально) Чтобы добавить дополнительные диски, нажмите **Добавить диск**.
      * В блоке **Вычислительные ресурсы**:
          * Выберите [платформу](../../concepts/vm-platforms.md).
          * Укажите необходимое количество **vCPU**, [гарантированную долю vCPU](../../concepts/performance-levels.md) и объем **RAM**.
          * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}
      * В блоке **Сетевые настройки**:

        {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

      * В блоке **Доступ** укажите данные для доступа на виртуальную машину:
          * Укажите **Сервисный аккаунт**, который следует привязать к виртуальной машине.
          * Если выбран образ на основе Linux, заполните поля **Логин** и **SSH-ключ**. В качестве ключа укажите содержимое файла [открытого ключа](../vm-connect/ssh.md#creating-ssh-keys).
          * Если выбран образ на основе Windows, укажите **Пароль** пользователя `Administrator`.
          * При необходимости **Разрешите доступ к серийной консоли**.
      * Нажмите кнопку **Сохранить**.
  1. В блоке **В процессе создания и обновления разрешено**:
      * В поле **Добавлять выше целевого значения** укажите, на какое количество виртуальных машин можно превышать размер группы.
      * В поле **Уменьшать относительно целевого значения** укажите, на какое количество виртуальных машин можно уменьшать размер группы.
      * В поле **Одновременно создавать** укажите, сколько виртуальных машин можно одновременно создавать.
      * В поле **Время запуска** укажите срок, после которого ВМ начнет получать нагрузку.
      * В поле **Одновременно останавливать** укажите, сколько виртуальных машин можно одновременно останавливать.
      * В поле **Останавливать машины по стратегии** укажите одну из [стратегий](../../concepts/instance-groups/policies/deploy-policy.md#strategy):
          * **Принудительная** — {{ ig-name }} самостоятельно выбирает, какие ВМ остановить при обновлении или уменьшении группы.
          * **Деликатная** — {{ ig-name }} ожидает, когда ВМ остановятся самостоятельно или будут остановлены пользователем.
  1. В блоке **Масштабирование**:
      * Выберите **Фиксированный** [тип масштабирования](../../concepts/instance-groups/scale.md).
      * Укажите размер группы.
  1. В блоке **Интеграция с {{ alb-name }}** включите опцию **Создать целевую группу**.
  1. Введите **Имя целевой группы** и **Описание целевой группы**.
  1. При необходимости активируйте **Проверку состояний** для получения сведений о состоянии виртуальных машин и их автоматического восстановления в случае сбоя.
      * В поле **Тип** выберите протокол проверок состояния: **HTTP** или **TCP**.
      * В поле **Путь** (для типа HTTP) укажите URL‐путь запроса, на который {{ ig-name }} будет отправлять запросы проверки для HTTP.
      * В поле **Порт** укажите номер порта от 1 до 32767, на который {{ ig-name }} будет отправлять запросы проверки.
      * В поле **Время ожидания, с** укажите время ожидания ответа от 1 до 60 секунд.
      * В поле **Интервал, c** укажите интервал между повторными проверками от 1 до 60 секунд. Интервал должен быть больше времени ожидания минимум на 1 секунду.
      * В поле **Порог работоспособности** укажите количество успешных проверок, после которого ВМ будет считаться работающей нормально.
      * В поле **Порог неработоспособности** укажите количество неудачных проверок, после которого ВМ будет считаться неработающей.
  1. В блоке **Пользовательские переменные** при необходимости укажите пары **Ключ**-**Значение**.
  1. Нажмите кнопку **Создать**.

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
          name: first-fixed-group-with-l7-balancer
          service_account_id: <ID>
          description: "This instance group was created from YAML config."
          ```

          Где:

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

          Где (в таблице приведены ключи, которые непосредственно определяют параметры ВМ):

          Ключ | Значение
          ----- | -----
          `platform_id` | Идентификатор платформы.
          `memory` | Количество памяти (RAM).
          `cores` | Количество ядер процессора (vCPU).
          `mode` | Режим доступа к диску.</br> - `READ_ONLY` — доступ на чтение.</br>- `READ_WRITE` — доступ на чтение и запись.
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
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: {{ region-id }}-a
          ```

          Где:

          Ключ | Значение
          ----- | -----
          `deploy_policy` | [Политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) виртуальных машин в группе.
          `scale_policy` | [Политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) виртуальных машин в группе.
          `allocation_policy` | [Политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) виртуальных машин по зонам и регионам.

      * Целевую группу {{ alb-name }}:

          ```
          application_load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

          Где:

          Ключ | Значение
          ----- | -----
          `target_group_spec` | Спецификация целевой группы {{ alb-name }}, связанной с группой виртуальных машин.
          `name` | Произвольное имя целевой группы {{ alb-name }}. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.

          Полный код файла `specification.yaml`:

          ```
          name: first-fixed-group-with-l7-balancer
          service_account_id: <ID>
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
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: {{ region-id }}-a
          application_load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

  1. Создайте группу виртуальных машин в каталоге по умолчанию:

      ```
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      Данная команда создаст группу из трех однотипных виртуальных машин со следующими характеристиками:

      * С именем `first-fixed-group-with-l7-balancer`.
      * С OC CentOS 7.
      * В сети `default-net`.
      * В зоне доступности `{{ region-id }}-a`.
      * С 2 vCPU и 2 ГБ RAM.
      * С сетевым HDD-диском объемом 32 ГБ.
      * С целевой группой `first-target-group`.
  
  После этого вы можете добавить целевую группу `first-target-group` к [новой](../../../application-load-balancer/operations/backend-group-create.md) или [существующей группе бэкендов](../../../application-load-balancer/operations/backend-group-update.md) {{ alb-name }}, группу бэкендов — к [новому](../../../application-load-balancer/operations/http-router-create.md) или [существующему HTTP-роутеру](../../../application-load-balancer/operations/http-router-update.md), а роутер — к [новому](../../../application-load-balancer/operations/application-load-balancer-create.md) или [существующему L7-балансировщику](../../../application-load-balancer/operations/application-load-balancer-update.md).

- API

  Воспользуйтесь методом API [create](../../api-ref/InstanceGroup/create.md).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).  

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

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
       name               = "fixed-ig-with-balancer"
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
         fixed_scale {
           size = <количество ВМ в группе>
         }
       }

       allocation_policy {
         zones = ["{{ region-id }}-a"]
       }

       deploy_policy {
         max_unavailable = 1
         max_expansion   = 0
       }

       application_load_balancer {
         target_group_name        = "target-group"
         target_group_description = "load balancer target group"
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

     Где:

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
          `boot_disk` | Настройки загрузочного диска. Укажите:</br> - Идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).</br> - Режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
          `network_interface` | Настройка сети. Укажите идентификаторы сети и подсети.
          `metadata` | В метаданных необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на виртуальную машину. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).


       * [Политики](../../concepts/instance-groups/policies/index.md):

          Поле | Описание
          ----- | -----
          `deploy_policy` | [Политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) виртуальных машин в группе.
          `scale_policy` | [Политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) виртуальных машин в группе.
          `allocation_policy` | [Политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) виртуальных машин по зонам и регионам.
          
       * Целевая группа {{ alb-name }}:

          Поле | Описание
          ----- | -----
          `target_group_name` | Имя целевой группы.
          `target_group_description` | Описание целевой группы.

     * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#subnet), к которой будет подключена группа виртуальных машин.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (сервисный аккаунт, облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}
