# Создать группу виртуальных машин фиксированного размера с L7-балансировщиком

Вы можете создать [группу ВМ](../../concepts/instance-groups/index.md) фиксированного размера, интегрированную с сервисом балансировки нагрузки [{{ alb-full-name }}](../../../application-load-balancer/index.yaml). Вместе с группой ВМ будет автоматически создана целевая группа {{ alb-name }}, которую можно привязать к балансировщику и распределять нагрузку между ВМ в группе на прикладном уровне. Подробнее см. в разделе [{#T}](../../concepts/instance-groups/balancers.md).

{% include [alb-warning.md](../../../_includes/instance-groups/alb-warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

{% include [password-reset-note](../../../_includes/compute/password-reset-note.md) %}

Чтобы создать группу ВМ с L7-балансировщиком нагрузки:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана группа ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
      * Введите имя и описание группы ВМ. Требования к имени:

        {% include [name-format](../../../_includes/name-format.md) %}

        {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

        {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * При необходимости включите опцию **{{ ui-key.yacloud.compute.groups.create.field_deletion-protection }}**. Пока опция включена, группу удалить невозможно.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** в поле **{{ ui-key.yacloud.compute.groups.create.field_zone }}** выберите нужные. ВМ группы могут находиться в [разных зонах и регионах доступности](../../../overview/concepts/geo-scope.md).
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}**, чтобы задать конфигурацию базовой ВМ:
      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите описание [шаблона](../../concepts/instance-groups/instance-template.md).
      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите, какую систему развернуть на загрузочном [диске](../../concepts/disk.md) ВМ.
      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_disk }}**:
        * Выберите [тип диска](../../../compute/concepts/disk.md#disks_types).
        * Укажите размер диска.
        * Чтобы добавить дополнительные диски, нажмите **{{ ui-key.yacloud.compute.instances.create.label_add-disk }}**.
      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
        * Выберите [платформу](../../../compute/concepts/vm-platforms.md).
        * Укажите необходимое количество vCPU, [гарантированную долю vCPU](../../concepts/performance-levels.md) и объем RAM.

        * {% include [include](../../../_includes/instance-groups/specify-preemptible-vm.md) %}

        * (опционально) Включите [программно-ускоренную сеть](../../concepts/software-accelerated-network.md).

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        {% include [network-settings-group](../../../_includes/compute/network-settings-group.md) %}

      * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:
        * Выберите сервисный аккаунт, который следует привязать к ВМ.
        * Если выбран [образ](../../concepts/image.md) на основе Linux, заполните поля **{{ ui-key.yacloud.compute.instances.create.field_user }}** и **{{ ui-key.yacloud.compute.instances.create.field_key }}**. В качестве ключа укажите содержимое файла [открытого ключа](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
        * При необходимости выберите опцию `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`.
      * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**:
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}** укажите, на какое количество ВМ можно превышать размер группы.
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}** укажите, на какое количество ВМ можно уменьшать размер группы.
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}** укажите, сколько ВМ можно одновременно создавать.
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-startup-duration }}** укажите срок, после которого ВМ начнет получать нагрузку.
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}** укажите, сколько ВМ можно одновременно останавливать.
      * В поле **{{ ui-key.yacloud.compute.groups.create.field_deploy-strategy }}** укажите одну из [стратегий](../../../compute/concepts/instance-groups/policies/deploy-policy.md#strategy):
        * `{{ ui-key.yacloud.compute.groups.create.value_strategy-proactive }}` — {{ ig-name }} самостоятельно выбирает, какие ВМ остановить при обновлении или уменьшении группы.
        * `{{ ui-key.yacloud.compute.groups.create.value_strategy-opportunistic }}` — {{ ig-name }} ожидает, когда ВМ остановятся самостоятельно или будут остановлены пользователем.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
      * Выберите `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}` [тип масштабирования](../../../compute/concepts/instance-groups/scale.md).
      * Укажите размер группы ВМ.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** включите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}**.
  1. Укажите настройки целевой группы. Подробнее см. в разделе [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
  1. При необходимости активируйте опцию **{{ ui-key.yacloud.compute.groups.create.section_health-check }}** для получения сведений о состоянии ВМ и их автоматического восстановления в случае сбоя.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-protocol }}** выберите протокол проверок состояния: `{{ ui-key.yacloud.common.label_http }}` или `{{ ui-key.yacloud.common.label_tcp }}`.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-path }}** (для типа HTTP) укажите URL‐путь запроса, на который {{ ig-name }} будет отправлять запросы проверки для HTTP.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-port }}** укажите номер порта от 1 до 32767, на который {{ ig-name }} будет отправлять запросы проверки.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-timeout }}** укажите время ожидания ответа от 1 до 60 секунд.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-interval }}** укажите интервал между повторными проверками от 1 до 60 секунд. Интервал должен быть больше времени ожидания минимум на 1 секунду.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-healthy-threshold }}** укажите количество успешных проверок, после которого ВМ будет считаться работающей нормально.
      * В поле **{{ ui-key.yacloud.load-balancer.network-load-balancer.label_health-check-unhealthy-threshold }}** укажите количество неудачных проверок, после которого ВМ будет считаться неработающей.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_variables }}** при необходимости укажите пары `{{ ui-key.yacloud.common.label_key }}`-`{{ ui-key.yacloud.common.label_value }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания группы ВМ:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Проверьте, есть ли в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) [сети](../../../vpc/concepts/network.md#network):

     ```bash
     yc vpc network list
     ```

     Если ни одной сети нет, [создайте ее](../../../vpc/operations/network-create.md).
  1. Выберите один из публичных образов {{ marketplace-full-name }} (например, [CentOS 7](/marketplace/products/yc/centos-7)).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Создайте YAML-файл с произвольным именем, например `specification.yaml`.
  1. Опишите в созданном файле:
     * Общую информацию о группе ВМ:

       ```yaml
       name: first-fixed-group-with-l7-balancer
       service_account_id: <идентификатор_сервисного_аккаунта>
       description: "This instance group was created from YAML config."
       ```

       Где:
       * `name` — произвольное имя группы ВМ. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.
       * `service_account_id` — идентификатор сервисного аккаунта.

         {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

       * `description` — произвольное описание группы ВМ.
     * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md), например:

       ```yaml
       instance_template:
         platform_id: standard-v3
         resources_spec:
           memory: 2g
           cores: 2
         boot_disk_spec:
           mode: READ_WRITE
           disk_spec:
             image_id: fdvk34al8k5n********
             type_id: network-hdd
             size: 32g
         network_interface_specs:
           - network_id: c64mknqgnd8a********
             primary_v4_address_spec: {}
             security_group_ids:
               - enps0ar5s3ti********
         placement_policy:
           placement_group_id: rmppvhrgm77g********
         scheduling_policy:
           preemptible: false
         ```

         {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

         Где:
         * `platform_id` — идентификатор [платформы](../../concepts/vm-platforms.md).
         * `memory` — количество памяти (RAM).
         * `cores` — количество ядер процессора (vCPU).
         * `mode` — режим доступа к [диску](../../concepts/disk.md).
           * `READ_ONLY` — доступ на чтение.
           * `READ_WRITE` — доступ на чтение и запись.
         * `image_id` — идентификатор публичного образа. Идентификаторы образа можно посмотреть в [консоли управления]({{ link-console-main }}) при создании ВМ или в [{{ marketplace-name }}](/marketplace) на странице образа в блоке **Идентификаторы продукта**.
         * `type_id` — тип диска.
         * `size` — размер диска.
         * `network_id` — идентификатор сети `default-net`.
         * `primary_v4_address_spec` — спецификация версии интернет протокола IPv4. Вы можете предоставить публичный доступ к ВМ группы, указав версию IP для [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses). Подробнее читайте в разделе [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `security_group_ids` — список идентификаторов [групп безопасности](../../../vpc/concepts/security-groups.md).
         * `scheduling_policy` — конфигурация политики планирования.
         * `preemptible` — флаг, указывающий создавать [прерываемые ВМ](../../concepts/preemptible-vm.md).
           * `true` — будет создана прерываемая ВМ.
           * `false` (по умолчанию) — обычная.

           Создавая группу прерываемых ВМ учитывайте, что ВМ будут останавливаться спустя 24 часа непрерывной работы, а могут быть остановлены еще раньше. При этом возможна ситуация, что {{ ig-name }} не сможет сразу перезапустить их из-за нехватки ресурсов. Это может произойти, если резко возрастет потребление вычислительных ресурсов в {{ yandex-cloud }}.
         * `placement_policy` — (опционально) параметры [группы размещения ВМ](../../concepts/placement-groups.md):
           * `placement_group_id` — идентификатор группы размещения.
     * [Политики](../../concepts/instance-groups/policies/index.md):

       ```yaml
       deploy_policy:
         max_unavailable: 1
         max_expansion: 0
       scale_policy:
         fixed_scale:
           size: 3
       allocation_policy:
         zones:
           - zone_id: {{ region-id }}-a
             instance_tags_pool:
             - first
             - second
             - third
       ```

       Где:
       * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
       * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
       * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md) и регионам.
     * [Целевую группу](../../../application-load-balancer/concepts/target-group.md) {{ alb-full-name }}:

       ```yaml
       application_load_balancer_spec:
         target_group_spec:
           name: first-target-group
       ```

       Где:
       * `target_group_spec` — спецификация целевой группы {{ alb-name }}, связанной с группой ВМ.
       * `name` — произвольное имя целевой группы {{ alb-name }}. Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не может быть дефисом. Максимальная длина имени — 63 символа.

       Подробнее о настройках целевой группы см. в разделе [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
 
     Полный код файла `specification.yaml`:

     ```yaml
     name: first-fixed-group-with-l7-balancer
     service_account_id: <идентификатор_сервисного_аккаунта>
     description: "This instance group was created from YAML config."
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2g
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: fdvk34al8k5n********
           type_id: network-hdd
           size: 32g
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
       placement_policy:
         placement_group_id: rmppvhrgm77g********
     deploy_policy:
       max_unavailable: 1
       max_expansion: 0
     scale_policy:
       fixed_scale:
         size: 3
     allocation_policy:
       zones:
         - zone_id: {{ region-id }}-a
           instance_tags_pool:
           - first
           - second
           - third
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     ``` 

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     Данная команда создаст группу из трех однотипных ВМ со следующими характеристиками:
     * С именем `first-fixed-group-with-l7-balancer`.
     * С OC CentOS 7.
     * В сети `default-net`.
     * В зоне доступности `{{ region-id }}-a`.
     * С 2 vCPU и 2 ГБ RAM.
     * С сетевым HDD-диском объемом 32 ГБ.
     * С целевой группой `first-target-group`.

  После этого вы можете добавить целевую группу `first-target-group` к [новой](../../../application-load-balancer/operations/backend-group-create.md) или [существующей группе бэкендов](../../../application-load-balancer/operations/backend-group-update.md) {{ alb-name }}, группу бэкендов — к [новому](../../../application-load-balancer/operations/http-router-create.md) или [существующему HTTP-роутеру](../../../application-load-balancer/operations/http-router-update.md), а роутер — к [новому](../../../application-load-balancer/operations/application-load-balancer-create.md) или [существующему L7-балансировщику](../../../application-load-balancer/operations/application-load-balancer-update.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_iam_service_account" "ig-sa" {
       name        = "ig-sa"
       description = "service account to manage IG"
     }

     resource "yandex_resourcemanager_folder_iam_member" "editor" {
       folder_id = "<идентификатор_каталога>"
       role      = "editor"
       member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
     }

     resource "yandex_compute_instance_group" "ig-1" {
       name                = "fixed-ig-with-balancer"
       folder_id           = "<идентификатор_каталога>"
       service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
       deletion_protection = "<защита_от_удаления>"
       instance_template {
         platform_id = "standard-v3"
         resources {
           memory = <объем_RAM_ГБ>
           cores  = <количество_ядер_vCPU>
         }

         boot_disk {
           mode = "READ_WRITE"
           initialize_params {
             image_id = "<идентификатор_образа>"
           }
         }

         network_interface {
           network_id         = "${yandex_vpc_network.network-1.id}"
           subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
           security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
         }

         metadata = {
           ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
         }
       }

       scale_policy {
         fixed_scale {
           size = <количество_ВМ_в_группе>
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

       {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `yandex_resourcemanager_folder_iam_member` — описание прав доступа к [каталогу](../../../resource-manager/concepts/resources-hierarchy.md#folder), которому принадлежит сервисный аккаунт. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `editor`.
     * `yandex_compute_instance_group` — описание группы ВМ:
       * Общая информация о группе ВМ:
         * `name` — имя группы ВМ.
         * `folder_id` — идентификатор каталога.
         * `service_account_id` — идентификатор сервисного аккаунта.
         * `deletion_protection` — защита группы ВМ от удаления: `true` или `false`. Пока опция включена, группу ВМ удалить невозможно. Значение по умолчанию `false`.
       * [Шаблон ВМ](../../concepts/instance-groups/instance-template.md):
         * `platform_id` — [платформа](../../concepts/vm-platforms.md).
         * `resources` — количество ядер vCPU и объем RAM, доступные ВМ. Значения должны соответствовать выбранной [платформе](../../concepts/vm-platforms.md).
         * `boot_disk` — настройки загрузочного [диска](../../concepts/disk.md).
           * Идентификатор выбранного образа. Вы можете получить идентификатор образа из [списка публичных образов](../images-with-pre-installed-software/get-list.md).
           * Режим доступа к диску: `READ_ONLY` (чтение) или `READ_WRITE` (чтение и запись).
         * `network_interface` — настройка [сети](../../../vpc/concepts/network.md#network). Укажите идентификаторы сети, [подсети](../../../vpc/concepts/network.md#subnet) и [групп безопасности](../../../vpc/concepts/security-groups.md).
         * `metadata` — в [метаданных](../../concepts/vm-metadata.md) необходимо передать открытый ключ для [SSH-доступа](../../../glossary/ssh-keygen.md) на ВМ. Подробнее в разделе [{#T}](../../concepts/vm-metadata.md).
       * [Политики](../../concepts/instance-groups/policies/index.md):
         * `deploy_policy` — [политика развертывания](../../concepts/instance-groups/policies/deploy-policy.md) ВМ в группе.
         * `scale_policy` — [политика масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе.
         * `allocation_policy` — [политика распределения](../../concepts/instance-groups/policies/allocation-policy.md) ВМ по [зонам доступности](../../../overview/concepts/geo-scope.md) и регионам.
       * [Целевая группа](../../../application-load-balancer/concepts/target-group.md) {{ alb-full-name }}:
         * `target_group_name` — имя целевой группы.
         * `target_group_description` — описание целевой группы.
         Подробнее о настройках целевой группы см. в разделе [{#T}](../../concepts/instance-groups/balancers.md#settings-alb).
     * `yandex_vpc_network` — описание облачной сети.
     * `yandex_vpc_subnet` — описание подсети, к которой будет подключена группа ВМ.

     {% note info %}

     Если у вас уже есть подходящие ресурсы (сервисный аккаунт, облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

     {% endnote %}

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/InstanceGroup/create.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create).

{% endlist %}
