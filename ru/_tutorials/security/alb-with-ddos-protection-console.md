# Создание L7-балансировщика с защитой от DDoS с помощью консоли управления или CLI


Чтобы создать балансировщик с защитой от DDoS c помощью консоли управления {{ yandex-cloud }} или CLI:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте группы безопасности](#create-security-groups).
1. [Создайте группу виртуальных машин](#create-vms).
1. [Зарезервируйте статический публичный IP-адрес](#reserve-ip).
1. [Создайте группу бэкендов](#create-backend-group).
1. [Создайте HTTP-роутер](#create-http-routers-sites).
1. [Создайте L7-балансировщик](#create-balancer).
1. [Проверьте работу балансировщика](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-with-ddos-protection/paid-resources.md) %}


## Создайте облачную сеть {#create-network}

Все ресурсы, созданные в практическом руководстве, будут относиться к одной [облачной сети](../../vpc/concepts/network.md).

Чтобы создать сеть:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Укажите имя сети `ddos-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте облачную сеть в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc vpc network create \
       --name ddos-network
     ```

     Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/network/create.md).

  1. Создайте [подсети](../../vpc/concepts/network.md#subnet) в каждой [зоне доступности](../../overview/concepts/geo-scope.md), указав идентификатор облачной сети с помощью флага `--network-name`:

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-a \
       --network-name ddos-network \
       --zone {{ region-id }}-a \
       --range 192.168.0.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-b \
       --network-name ddos-network \
       --zone {{ region-id }}-b \
       --range 192.168.1.0/24
     ```

     ```bash
     yc vpc subnet create \
       --name ddos-network-ru-d \
       --network-name ddos-network \
       --zone {{ region-id }}-d \
       --range 192.168.2.0/24
     ```

     Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

{% endlist %}


## Создайте группы безопасности {#create-security-groups}

[Группы безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) содержат правила, которые разрешают балансировщику получать входящий трафик и отправлять его на ВМ, а ВМ — получать этот трафик. В сценарии будут созданы две группы безопасности: для балансировщика и для всех ВМ.

Чтобы создать группы безопасности:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Создайте группу безопасности для балансировщика:

     1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** группы безопасности: `ddos-sg-balancer`.
     1. Выберите **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** `ddos-network`.
     1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** создайте следующие правила по инструкции под таблицей:

        Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник /<br>назначение | {{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}
        --- | --- | --- | --- | --- | ---
        `Исходящий` | `any` | `Весь` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
        `Входящий` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | —

        1. Выберите вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** или **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** укажите один порт или диапазон портов, куда или откуда будет поступать трафик.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** укажите нужный протокол или оставьте `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`, чтобы разрешить передачу трафика по всем протоколам.
        1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** или **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** выберите назначение правила:

           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` — правило будет применено к диапазону IP-адресов. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** укажите CIDR и маски подсетей, в которые или из которых будет поступать трафик. Чтобы добавить несколько CIDR, нажимайте кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_add-cidr }}**.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` — правило будет применено к ВМ из текущей группы или из выбранной группы безопасности.
           * `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` — правило, которое позволяет балансировщику проверять состояние ВМ.

        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**. Таким образом создайте все правила из таблицы.

     1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  1. Аналогично создайте группу безопасности для ВМ с именем `ddos-sg-vms`, той же сетью `ddos-network` и следующими правилами:

     Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Источник | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
     --- | --- | --- | --- | --- | ---
     `Входящий` | `balancer` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}` | `ddos-sg-balancer`
     `Входящий` | `ssh` | `22` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

- CLI {#cli}

  Чтобы создать группу безопасности для балансировщика, выполните команду:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-balancer \
    --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks" \
    --network-name ddos-network
  ```

  Чтобы создать группу безопасности для ВМ, выполните команду:

  ```bash
  yc vpc security-group create \
    --name ddos-sg-vms \
    --rule "direction=ingress,port=22,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,security-group-id=<идентификатор_группы_безопасности>" \
    --network-name ddos-network
  ```

  Где `security-group-id` — идентификатор группы безопасности `ddos-sg-balancer`.

  Подробнее о команде `yc vpc security-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/vpc/security-group/create.md).

{% endlist %}


## Создайте группу ВМ {#create-vms}

На ВМ из [целевой группы](../../application-load-balancer/concepts/target-group.md) развертываются бэкенды вашего приложения. Целевая группа ВМ будет подключена к балансировщику, чтобы на эндпоинты бэкендов вашего приложения можно было направлять запросы. В этом сценарии достаточно создать [группу ВМ](../../compute/concepts/instance-groups/index.md) с минимальной конфигурацией.

Чтобы создать группу ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**. Нажмите кнопку **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_base }}**:

     * Введите **{{ ui-key.yacloud.compute.groups.create.field_name }}** группы ВМ: `ddos-group`.
     * Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) из списка или создайте новый. Чтобы иметь возможность создавать, обновлять и удалять ВМ в группе, назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `editor`. По умолчанию все операции в {{ ig-name }} выполняются от имени сервисного аккаунта.

  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_allocation }}** выберите несколько зон доступности, чтобы обеспечить отказоустойчивость хостинга.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_instance }}** нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** и укажите конфигурацию базовой ВМ:

     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** введите **{{ ui-key.yacloud.common.description }}** шаблона.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** откройте вкладку **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. Выберите продукт [LEMP](/marketplace/products/yc/lemp) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** укажите:

       * **{{ ui-key.yacloud.compute.disk-form.field_type }}** — `HDD`.
       * **{{ ui-key.yacloud.compute.disk-form.field_size }}** диска — `3 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** укажите:

       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Cascade Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `5%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

       * Выберите облачную сеть `ddos-network` и ее подсети.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** выберите `{{ ui-key.yacloud.compute.instances.create.value_address-auto }}`.
       * Выберите группу безопасности `ddos-sg-vms`.

     * В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите данные для доступа на ВМ:

       * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя.
       * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** вставьте содержимое файла открытого ключа.

        Для подключения по [SSH](../../glossary/ssh-keygen.md) необходимо создать пару ключей. Подробнее в разделе [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

     * Нажмите кнопку **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_scale }}** укажите **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** группы ВМ — `2`.
  1. В блоке **{{ ui-key.yacloud.compute.groups.create.section_alb }}** выберите опцию **{{ ui-key.yacloud.compute.groups.create.field_target-group-attached }}** и укажите имя группы: `tg-ddos`. [Подробнее о целевых группах](../../application-load-balancer/concepts/target-group.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Получите идентификаторы ресурсов, необходимые для создания группы ВМ, с помощью команд:

     * [yc iam service-account get <имя_сервисного_аккаунта>](../../cli/cli-ref/managed-services/iam/service-account/get.md) — для сервисного аккаунта.
     * [yc vpc network get ddos-network](../../cli/cli-ref/managed-services/vpc/network/get.md) — для сети `ddos-network`.
     * [yc vpc subnet get <имя_подсети>](../../cli/cli-ref/managed-services/vpc/subnet/get.md) — для подсетей `ddos-network-ru-a`, `ddos-network-ru-b` и `ddos-network-ru-d`.
     * [yc compute image get-latest-by-family lemp --folder-id standard-images](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md) — для образа загрузочного диска.
     * [yc vpc security-group get ddos-sg-vms](../../cli/cli-ref/managed-services/vpc/security-group/get.md) — для группы безопасности `ddos-sg-vms`.

  1. Создайте YAML-файл с именем `specification.yaml`.
  1. Добавьте в него описание конфигурации базовой ВМ:

     ```yaml
     name: ddos-group
     service_account_id: <идентификатор_сервисного_аккаунта>
     description: "DDoS alb scenario"
     instance_template:
         platform_id: standard-v3
         resources_spec:
             memory: 1g
             cores: 2
             core_fraction: 5
         boot_disk_spec:
             mode: READ_WRITE
             disk_spec:
                 image_id: <идентификатор_образа>
                 type_id: network-hdd
                 size: 3g
         network_interface_specs:
             - network_id: <идентификатор_облачной_сети>
               subnet_ids:
                 - <идентификатор_подсети_в_зоне_{{ region-id }}-a>
                 - <идентификатор_подсети_в_зоне_{{ region-id }}-b>
                 - <идентификатор_подсети_в_зоне_{{ region-id }}-d>
               primary_v4_address_spec: {}
               security_group_ids:
                 - <идентификатор_группы_безопасности>
     deploy_policy:
         max_unavailable: 1
         max_expansion: 0
     scale_policy:
         fixed_scale:
             size: 2
     allocation_policy:
         zones:
             - zone_id: {{ region-id }}-a
             - zone_id: {{ region-id }}-b
             - zone_id: {{ region-id }}-d
     application_load_balancer_spec:
         target_group_spec:
             name: tg-ddos
     ```

     Где `security_group_ids` — идентификатор группы безопасности `ddos-sg-vms`.

  1. Создайте группу ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance-group create \
       --file specification.yaml
     ```

     Результат:

     ```text
     done (25s)
     id: cl1qjhlcdofg********
     folder_id: b1g86q4m5vej********
     created_at: "2021-08-30T19:25:02.031Z"
     name: ddos-group
     description: DDoS scenario
     instance_template:
       platform_id: standard-v2
       resources_spec:
         memory: "1073741824"
         cores: "2"
         core_fraction: "5"
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           type_id: network-hdd
           size: "3221225472"
           image_id: fd8r6kq84o7b********
       network_interface_specs:
       - network_id: enp3srbi9u49********
         subnet_ids:
         - e9b17pi15695********
         - e2lt87g1rlig********
         - b0c7kl8riq24********
         primary_v4_address_spec: {}
         security_group_ids:
         - enpi08rif04d********
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "2"
     deploy_policy:
       max_unavailable: "1"
       startup_duration: 0s
       strategy: PROACTIVE
     allocation_policy:
       zones:
       - zone_id: {{ region-id }}-a
       - zone_id: {{ region-id }}-b
       - zone_id: {{ region-id }}-d
     load_balancer_state: {}
     managed_instances_state:
       target_size: "2"
     service_account_id: aje2stn6id9k********
     status: ACTIVE
     application_load_balancer_spec:
       target_group_spec:
         name: first-target-group
     application_load_balancer_state:
       target_group_id: ds78imh0ds2e********
     ```

     Подробнее о команде `yc compute instance-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/compute/instance-group/create.md).

{% endlist %}


## Зарезервируйте статический публичный IP-адрес {#reserve-ip}

{% note info %}

Этот шаг нельзя выполнить через [интерфейс командной строки (CLI)](../../cli/).

{% endnote %}

Чтобы защитить балансировщик от DDoS-атак, необходимо зарезервировать для него статический публичный IP-адрес с опцией **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. Выберите зону доступности, в которой нужно зарезервировать IP-адрес.
  1. Включите опцию **{{ ui-key.yacloud.common.field_ddos-protection-provider }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}


## Создайте группу бэкендов {#create-backend-group}

Целевую группу, созданную вместе с группой ВМ, нужно привязать к [группе бэкендов](../../application-load-balancer/concepts/backend-group.md) с настройками распределения трафика.

Для бэкендов в группах будут созданы [проверки состояния](../../application-load-balancer/concepts/backend-group.md#health-checks): балансировщик будет периодически отправлять проверочные запросы к ВМ и ожидать ответа в течение определенного периода.

Чтобы создать группу бэкендов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** группы бэкендов: `ddos-backend-group`.
  1. В блоке **{{ ui-key.yacloud.alb.label_backends }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** бэкенда: `backend-1`.
  1. В поле **{{ ui-key.yacloud.alb.label_target-groups }}** выберите группу `tg-ddos`.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать входящий трафик от балансировщика: `80`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-healthcheck }}**.
  1. Укажите **{{ ui-key.yacloud.alb.label_port }}**, на котором ВМ бэкенда будут принимать проверочные соединения: `80`.
  1. Укажите **{{ ui-key.yacloud.alb.label_path }}**, к которому будет обращаться балансировщик при проверке состояния: `/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте группу бэкендов:

     ```bash
     yc alb backend-group create ddos-backend-group
     ```

     Результат:

     ```text
     id: a5dg2cv4ngne********
     name: ddos-backend-group
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T20:46:21.688940670Z"
     ```

     Подробнее о команде `yc alb backend-group create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/create.md).

  1. Добавьте в группу бэкенд и проверку состояния:

     ```bash
     yc alb backend-group add-http-backend \
       --backend-group-name ddos-backend-group \
       --name backend-1 \
       --weight 1 \
       --port 80 \
       --target-group-id=<идентификатор_целевой_группы> \
       --http-healthcheck timeout=1s,interval=1s,port=80,path=/
     ```

     Где:
     * `--backend-group-name` — имя группы бэкендов.
     * `--name` — имя бэкенда.
     * `--weight` — вес бэкенда.
     * `--port` — порт.
     * `--target-group-id` — идентификатор целевой группы.
     * `--http-healthcheck` — параметры проверки состояния ресурсов.
       * `port` — порт.
       * `timeout` — таймаут.
       * `interval` — интервал.
       * `host` — адрес хоста.
       * `path` — путь.

     Результат:

     ```text
     done (21s)
     id: ds7fea2pggr2********
     name: ddos-backend-group
     folder_id: b1g86q4m5vej********
     http:
     backends:
     - name: backend-1
       backend_weight: "1"
       port: "80"
       target_groups:
         target_group_ids:
         - ds78ate00f8e********
       healthchecks:
       - timeout: 1s
         interval: 1s
         healthcheck_port: "80"
         http:
           path: /
     created_at: "2021-08-08T07:59:22.922603189Z"
     ```

     Подробнее о команде `yc alb backend-group add-http-backend` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/backend-group/add-http-backend.md).

{% endlist %}


## Создайте HTTP-роутер {#create-http-routers-sites}

Группу бэкендов нужно привязать к [HTTP-роутеру](../../application-load-balancer/concepts/http-router.md) с правилами маршрутизации HTTP-запросов.

Чтобы создать HTTP-роутер и добавить в него маршрут:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**. Нажмите кнопку **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** HTTP-роутера: `ddos-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
  1. Укажите **{{ ui-key.yacloud.common.name }}** виртуального хоста: `ddos-host`.
  1. Укажите значение **{{ ui-key.yacloud.alb.label_authority }}**: `alb-with-ddos.com`.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-route }}**.
  1. Введите **{{ ui-key.yacloud.common.name }}**: `route-1`.
  1. В поле **{{ ui-key.yacloud.alb.label_path }}** выберите `{{ ui-key.yacloud.alb.label_match-prefix }}` и укажите путь `/`.
  1. В поле **{{ ui-key.yacloud.alb.label_route-action }}** оставьте `{{ ui-key.yacloud.alb.label_route-action-route }}`.
  1. В списке **{{ ui-key.yacloud.alb.label_backend-group }}** выберите созданную ранее группу.
  1. Остальные настройки оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Выполните команду:

     ```bash
     yc alb http-router create ddos-router
     ```

     Результат:

     ```text
     id: a5dcsselagj4********
     name: ddos-router
     folder_id: aoerb349v3h4********
     created_at: "2021-08-08T21:04:59.438292069Z"
     ```

     Подробнее о команде `yc alb http-router create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/http-router/create.md).

  1. Создайте виртуальный хост, указав имя HTTP-роутера:

     ```bash
     yc alb virtual-host create ddos-host \
       --http-router-name ddos-router
       --authority alb-with-ddos.com
     ```

     Подробнее о команде `yc alb virtual-host create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/create.md).

  1. Добавьте маршрут, указав имя роутера и параметры маршрутизации:

     ```bash
     yc alb virtual-host append-http-route route-1 \
       --virtual-host-name ddos-host \
       --http-router-name ddos-router \
       --prefix-path-match / \
       --backend-group-name ddos-backend-group \
       --request-timeout 60s
     ```

     Результат:

     ```text
     done (1s)
      name: ddos-host
      routes:
      - name: route-1
        http:
          match:
            path:
              prefix_match: /
          route:
            backend_group_id: ds7fea2pggr2********
            timeout: 60s
     ```

     Подробнее о команде `yc alb virtual-host append-http-route` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/virtual-host/append-http-route.md).

{% endlist %}


## Создайте балансировщик {#create-balancer}

Чтобы создать балансировщик:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. В меню слева выберите **{{ ui-key.yacloud.alb.label_load-balancers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_load-balancer-create }}**.
  1. Введите имя балансировщика: `ddos-protect-alb`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть `ddos-network` и группу безопасности `ddos-sg-balancer`.
  1. В блоке **{{ ui-key.yacloud.alb.section_allocation-settings }}** выберите подсети для узлов балансировщика в каждой зоне доступности и включите передачу трафика.
  1. В блоке **{{ ui-key.yacloud.alb.label_listeners }}** нажмите кнопку **{{ ui-key.yacloud.alb.button_add-listener }}**. Задайте настройки обработчика:

     1. Введите имя обработчика: `ddos-listener`.
     1. В блоке **{{ ui-key.yacloud.alb.section_external-address-specs }}** включите передачу трафика.
     1. Укажите порт `80`.
     1. Выберите тип **{{ ui-key.yacloud.alb.label_address-list }}** и укажите [зарезервированный ранее](#reserve-ip) IP-адрес с защитой от DDoS.

  1. В поле **{{ ui-key.yacloud.alb.label_http-router }}** выберите `ddos-router`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Создайте балансировщик с узлами в подсетях облачной сети:

     ```bash
     yc alb load-balancer create ddos-protect-alb \
       --network-name ddos-network \
       --location subnet-name=ddos-network-ru-a,zone={{ region-id }}-a \
       --location subnet-name=ddos-network-ru-b,zone={{ region-id }}-b \
       --location subnet-name=ddos-network-ru-d,zone={{ region-id }}-d
     ```

     Подробнее о команде `yc alb load-balancer create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/create.md).

  1. Добавьте обработчик:

     ```bash
     yc alb load-balancer add-listener ddos-protect-alb \
       --listener-name ddos-listener \
       --http-router-id <идентификатор_HTTP-роутера> \
       --external-ipv4-endpoint port=80, address=<IP-адрес_с_защитой_от_DDoS>
     ```

     Подробнее о команде `yc alb load-balancer add-listener` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/application-load-balancer/load-balancer/add-listener.md).

{% endlist %}

После создания балансировщика, [проверьте](#test) его работу.

## Проверьте работу балансировщика {#test}

{% include [test](../_tutorials_includes/alb-with-ddos-protection/test.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу хостинга и перестать платить за созданные ресурсы:

1. Удалите нетарифицируемые ресурсы, которые блокируют удаление тарифицируемых ресурсов:

   1. [Удалите](../../application-load-balancer/operations/application-load-balancer-delete.md) L7-балансировщик `ddos-protect-alb`.
   1. [Удалите](../../application-load-balancer/operations/http-router-delete.md) HTTP-роутер `ddos-router`.
   1. [Удалите](../../application-load-balancer/operations/backend-group-delete.md) группу бэкендов `ddos-backend-group`.

1. [Удалите](../../compute/operations/instance-groups/delete.md) группу ВМ `ddos-group`.
1. [Удалите](../../vpc/operations/address-delete.md) зарезервированный статический публичный IP-адрес.