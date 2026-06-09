# Автоматическая привязка политики резервного копирования {{ backup-full-name }} к ВМ с помощью консоли управления, CLI или API

Чтобы создать виртуальную машину с автоматической привязкой к политике резервного копирования {{ backup-name }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Активируйте сервис](#service-activate).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте и настройте группу безопасности](#create-sg).
1. [Создайте политику резервного копирования](#create-policy).
1. [Создайте ВМ](#create-vm).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md#prices-instance-resources));
* плата за диски ВМ (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md#prices-storage));
* плата за использование динамического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md#prices-public-ip));
* плата за подключенные к сервису {{ backup-name }} ВМ и объем резервных копий (см. [тарифы {{ backup-full-name }}](../../../backup/pricing.md#rules)).

## Активируйте сервис {#service-activate}

{% note info %}

Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../../../backup/security/index.md#backup-user) `backup.user` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создавать резервные копии ВМ или серверов {{ baremetal-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Если сервис {{ backup-name }} еще не активирован, нажмите **{{ ui-key.yacloud.backup.button_action-activate }}**.

      Если кнопки **{{ ui-key.yacloud.backup.button_action-activate }}** нет, и вам доступно создание ВМ с подключением к {{ backup-name }}, значит, сервис уже активирован. Переходите к следующему шагу.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды [CLI](../../../cli/index.md) для активации сервиса:
  
     ```bash
     yc backup provider activate --help
     ```
  
  1. Активируйте сервис в каталоге по умолчанию:
  
     ```bash
     yc backup provider activate --async
     ```
  
     Где `--async` — отображение информации о прогрессе операции. Необязательный параметр.
  
  1. После выполнения команды появится предупреждение об активации `This command will activate backup provider for your folder. Do you confirm this action to be executed? [Yes/no][y/N]`. Подтвердите активацию — в терминале введите `yes` или `y`.
  
     {% note tip %}
  
     Чтобы активировать сервис без подтверждения, используйте флаг `--force`.
  
     {% endnote %}
  
     Результат:
  
     ```text
     id: cdgmnefxiatx********
     description: activate provider
     created_at: "2024-10-14T09:03:47.960564Z"
     created_by: ajec1gaqcmtr********
     modified_at: "2024-10-14T09:03:47.960564Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.backup.v1.ActivateProviderMetadata
       folder_id: b1go3el0d8fs********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
     ```
  
  После активации автоматически создаются следующие политики резервного копирования:
  * `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.
  
  Если вы не хотите их создавать, используйте параметр `--skip-default-policy`.

{% endlist %}

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором активирован сервис.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) — `backup-sa`.
  1. Нажмите кнопку ![plus-sign](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../../backup/security/index.md#backup-user) `backup.user`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Создайте сервисный аккаунт с именем `backup-sa`:

      ```bash
      yc iam service-account create --name backup-sa
      ```

      Результат:

      ```bash
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T16:05:14.237381531Z"
      name: backup-sa
      ```

      Подробнее о команде `yc iam service-account create` см. в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте сервисному аккаунту роль `backup.user` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role backup.user \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```bash
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: backup.user
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` см. в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `backup.user` на каталог, воспользуйтесь методом [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте облачную сеть и подсети {#create-network}

Создайте [облачную сеть](../../../vpc/concepts/network.md#network) с [подсетью](../../../vpc/concepts/network.md#subnet) в той [зоне доступности](../../../overview/concepts/geo-scope.md), где будет находиться виртуальная машина.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать облачную сеть.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `cloud-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** выберите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте облачную сеть с именем `cloud-network`:

      ```bash
      yc vpc network create cloud-network
      ```

      Результат:

      ```bash
      id: enptrcle5q3d********
      folder_id: b1g9hv2loamq********
      created_at: "2024-06-08T09:25:03Z"
      name: cloud-network
      default_security_group_id: enpbsnnop4ak********
      ```

      Подробнее о команде `yc vpc network create` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсеть `cloud-network-{{ region-id }}-d` в зоне доступности `{{ region-id }}-d`:

      ```bash
      yc vpc subnet create cloud-network-{{ region-id }}-d \
        --zone {{ region-id }}-d \
        --network-name cloud-network \
        --range 10.1.0.0/16
      ```

      Результат:

      ```bash
      id: e9bnnssj8sc8********
      folder_id: b1g9hv2loamq********
      created_at: "2024-06-08T09:27:00Z"
      name: cloud-network-{{ region-id }}-d
      network_id: enptrcle5q3d********
      zone_id: {{ region-id }}-d
      v4_cidr_blocks:
      - 10.1.0.0/16
      ```

      Подробнее о команде `yc vpc subnet create` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Создайте сеть `cloud-network` с помощью метода REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызова gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).
  1. Создайте подсеть `cloud-network-{{ region-id }}-d` с помощью метода REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызова gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}

## Создайте и настройте группу безопасности {#create-sg}

Чтобы [агент {{ backup-name }}](../../../backup/concepts/agent.md) мог обмениваться данными с серверами [провайдера резервного копирования](../../../backup/concepts/index.md#providers), группа безопасности должна содержать правила, разрешающие сетевой доступ к IP-адресам ресурсов сервиса {{ backup-name }}.

Также в группу безопасности будет добавлено правило для доступа на ВМ по SSH.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы хотите создать ВМ с подключением к {{ backup-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** укажите `backup-sg`.
  1. В поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** выберите `cloud-network`.
  1. В блоке **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}** перейдите на вкладку **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** и нажмите **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Последовательно добавьте следующие правила для исходящего трафика:

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | ---
      `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
      `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.201.181.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `178.176.128.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.193.0/24`
      `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `213.180.204.0/24`
      `7770-7800` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `8443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `84.47.172.0/24`
      `44445` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `51.250.1.0/24`
      
      
      
      {% note tip %}
      
      При установке [агента {{ backup-name }}](../../../backup/concepts/agent.md) на ВМ или сервер {{ baremetal-name }} может понадобиться доустановить отсутствующие компоненты ПО из интернета. Для этого добавьте в [группу безопасности](../../../vpc/concepts/security-groups.md) следующее правило для исходящего трафика:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
      После установки агента {{ backup-name }} вы можете удалить это правило.
      
      Для доступа к ВМ по протоколу [SSH](../../../compute/operations/vm-connect/ssh.md) добавьте следующее правило для входящего трафика:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
      
      {% endnote %}

  1. Добавьте правило для входящего трафика, которое обеспечит доступ на ВМ по SSH:

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | ---
      `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните следующую команду:

  ```bash
  yc vpc security-group create backup-sg \
    --network-name network-1 \
    --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
    --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.201.181.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[178.176.128.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
    --rule "direction=egress,from-port=7770,to-port=7800,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=8443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=44445,protocol=tcp,v4-cidrs=[51.250.1.0/24]" \
    --rule "direction=ingress,port=22,protocol=any,v4-cidrs=[0.0.0.0/0]"
  ```

  Результат:

  ```bash
  id: enp0v73fe8fs********
  folder_id: b1g86q4m5vej********
  created_at: "2024-07-22T20:17:43Z"
  name: backup-sgg
  network_id: enp3srbi9u49********
  status: ACTIVE
  rules:
  - id: enpporsovuhj********
      direction: EGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 213.180.193.0/24
  - id: enp7p6asol5i********
      direction: EGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 213.180.204.0/24
  ...
  - id: enp36mip5nhe********
      direction: INGRESS
      ports:
        from_port: "22"
        to_port: "22"
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
  ```

  Подробнее о команде `yc vpc security-group create` см. в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- API {#api}

  Чтобы создать группу безопасности, воспользуйтесь методом REST API [create](../../../vpc/api-ref/SecurityGroup/create.md) для ресурса [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) или вызовом gRPC API [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md).

{% endlist %}

## Создайте политику резервного копирования {#create-policy}

Вы можете создать новую или использовать одну из политик, автоматически созданных при активации сервиса.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать политику резервного копирования.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Перейдите на вкладку ![policies](../../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.backup.button_create-policy }}**.
  1. Укажите параметры политики:

      * **{{ ui-key.yacloud.common.name }}** — `weekly-backup`.
      * **{{ ui-key.yacloud.backup.policy-form.field_backup-type }}** — `{{ ui-key.yacloud.backup.policy-form.title_incremental-backup-card }}`.
      * **{{ ui-key.yacloud.backup.policy-form.field_schedule-type }}** — `{{ ui-key.yacloud.backup.policy-form.value_schedule-type-fixed }}`.
      * **{{ ui-key.yacloud.backup.policy-form.field_backup-periodicity }}** — `{{ ui-key.yacloud.backup.policy-form.value_periodicity-weekly }}`.
      * **{{ ui-key.yacloud.backup.policy-form.field_week-days }}** — `{{ ui-key.yacloud.common.units.label_day-Fr }}`.
      * **{{ ui-key.yacloud.backup.policy-form.field_start-time }}** — `03:00`.
      * **{{ ui-key.yacloud.backup.policy-form.field_retention }}** — `{{ ui-key.yacloud.backup.policy-form.value_retention-variant-save-all }}`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Опишите конфигурацию создаваемой политики резервного копирования в файле `backup-policy-scheme.json`.

      ```json
      {
        "compression": "NORMAL",
        "format": "AUTO",
        "multiVolumeSnapshottingEnabled": true,
        "preserveFileSecuritySettings": true,
        "reattempts": {
          "enabled": true,
          "interval": {
            "type": "SECONDS",
            "count": "30"
          },
          "maxAttempts": "30"
        },
        "silentModeEnabled": true,
        "splitting": {
          "size": "1099511627776"
        },
        "vmSnapshotReattempts": {
          "enabled": true,
          "interval": {
            "type": "MINUTES",
            "count": "5"
          },
          "maxAttempts": "3"
        },
        "vss": {
          "enabled": true,
          "provider": "TARGET_SYSTEM_DEFINED"
        },
        "archive": {
          "name": "'[Machine Name]-[Plan ID]-[Unique ID]A'"
        },
        "performanceWindow": {
          "enabled": true
        },
        "scheduling": {
          "backupSets": [
            {
              "time": {
                "weekdays": [
                  "FRIDAY"
                ],
                "repeatAt": [
                  {
                    "hour": "3"
                  }
                ],
                "type": "WEEKLY"
              }
            }
          ],
          "enabled": true,
          "maxParallelBackups": "2",
          "randMaxDelay": {
            "type": "MINUTES",
            "count": "30"
          },
          "scheme": "ALWAYS_INCREMENTAL",
          "weeklyBackupDay": "MONDAY"
        },
        "cbt": "ENABLE_AND_USE",
        "fastBackupEnabled": true,
        "quiesceSnapshottingEnabled": true
      }
      ```

  1. Создайте политику резервного копирования:

      ```bash
      yc backup policy create \
        --name weekly-backup \
        --settings-from-file ./backup-policy-scheme.json
      ```

      Результат:

      ```text
      id: cdgo5vytuw57********
      name: weekly-backup
      created_at: "2024-07-23T20:34:37Z"
      updated_at: "2024-07-23T20:34:37Z"
      enabled: true
      settings:
        compression: NORMAL
        format: AUTO
        multi_volume_snapshotting_enabled: true
        preserve_file_security_settings: true
        reattempts:
          enabled: true
          interval:
            type: SECONDS
            count: "30"
          max_attempts: "30"
        silent_mode_enabled: true
        splitting:
          size: "1099511627776"
        vm_snapshot_reattempts:
          enabled: true
          interval:
            type: MINUTES
            count: "5"
          max_attempts: "3"
        vss:
          enabled: true
          provider: TARGET_SYSTEM_DEFINED
        archive:
          name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
        performance_window:
          enabled: true
        retention: {}
        scheduling:
          backup_sets:
            - time:
                weekdays:
                  - FRIDAY
                repeat_at:
                  - hour: "3"
                type: WEEKLY
              type: TYPE_AUTO
          enabled: true
          max_parallel_backups: "2"
          rand_max_delay:
            type: MINUTES
            count: "30"
          scheme: ALWAYS_INCREMENTAL
          weekly_backup_day: MONDAY
        cbt: ENABLE_AND_USE
        fast_backup_enabled: true
        quiesce_snapshotting_enabled: true
      folder_id: b1g86q4m5vej********
      ```

      Сохраните идентификатор (`id`) политики.

      Подробнее о команде `yc backup policy create` см. в [справочнике CLI](../../../cli/cli-ref/backup/cli-ref/policy/create.md).

- API {#api}

  Чтобы создать [политику резервного копирования](../../../backup/concepts/policy.md), воспользуйтесь методом REST API [create](../../../backup/backup/api-ref/Policy/create.md) для ресурса [Policy](../../../backup/backup/api-ref/Policy/index.md) или вызовом gRPC API [PolicyService/Create](../../../backup/backup/api-ref/grpc/Policy/create.md).

{% endlist %}

## Создайте ВМ {#create-vm}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `Ubuntu 22.04 LTS` и выберите публичный образ [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md): `{{ region-id }}-d`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `cloud-network` и подсеть `cloud-network-{{ region-id }}-d`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** выберите группу безопасности `backup-sg`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя: `vm-user`.
      * В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-manual }}` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-upload }}` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `{{ ui-key.yacloud_components.ssh-key-add-dialog.value_radio-generate }}` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  1. Включите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}** и в поле **{{ ui-key.yacloud.backup.title_select-vm-backup-policies-row }}** выберите политику резервного копирования, [созданную ранее](#create-policy).
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `backup-instance`.
  1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите сервисный аккаунт `backup-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% note info %}
  
  Команды [`yc compute instance create`](../../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды {{ yandex-cloud }} CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
  
  Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
  
  Подробнее см. в разделе [{#T}](../../../compute/concepts/metadata/sending-metadata.md#environment-variables).
  
  {% endnote %}

  1. Опишите конфигурацию пользовательских метаданных в файле `user-data.yaml`:

      ```yaml
      #cloud-config
      datasource:
        Ec2:
        strict_id: false
      ssh_pwauth: no
      users:
      - name: vm-user
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - <публичный_SSH-ключ>
      packages:
        - curl
        - perl
        - jq
      runcmd:
        - curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
      ```

  1. Сохраните идентификатор политики `weekly-backup` в файле `cloudbackup.json`:

      ```json
      {"initialPolicies": ["<идентификатор_политики_weekly-backup>"]}
      ```

      Подробности о получении идентификатора политики см. на странице [{#T}](../../../backup/operations/policy-vm/get-info.md).

  1. Выполните команду:

      ```bash
      yc compute instance create \
        --name backup-instance \
        --zone {{ region-id }}-d \
        --network-interface subnet-name=cloud-network-{{ region-id }}-d,security-group-ids=<идентификатор_группы_безопасности_backup-sg>,ipv4-address=auto,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,size=15 \
        --metadata-from-file user-data=./user-data.yaml,cloudbackup=./cloudbackup.json \
        --service-account-name backup-sa
      ```

      Подробнее о команде `yc compute instance create` см. в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать ВМ, воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

  В теле запроса передайте:

  * в поле `metadata`: объект `user-data`, содержащий конфигурацию пользовательских метаданных со скриптом для установки агента {{ backup-name }};
  * в поле `cloudbackup`: идентификатор политики резервного копирования. Подробности о получении идентификатора политики см. на странице [{#T}](../../../backup/operations/policy-vm/get-info.md).

  Используйте `\n` в качестве разделителя строк:

  {% cut "Пример тела запроса" %}

  ```json
  {
    "folderId": "<идентификатор_каталога>",
    "name": "backup-instance",
    "zoneId": "{{ region-id }}-d",
    "platformId": "standard-v3",
    "resourcesSpec": {
      "memory": "2147483648",
      "cores": "2"
    },
    "metadata": {
      "user-data": "#cloud-config\ndatasource:\nEc2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: vm-user\n  shell: /bin/bash\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  ssh_authorized_keys:\n  - <публичный_SSH-ключ>\npackages:\n  - curl\n  - perl\n  - jq\nruncmd:\n  - curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash",
      "cloudbackup": "{\"initialPolicies\": [\"<идентификатор_политики>\"]}"
    },
    "bootDiskSpec": {
      "diskSpec": {
        "size": "16106127360",
        "imageId": "fd8ljvsrm3l1********"
      }
    },
    "networkInterfaceSpecs": [
      {
        "subnetId": "<идентификатор_подсети>",
        "primaryV4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "IPV4"
          }
        },
        "securityGroupIds": [
          "<идентификатор_группы_безопасности>"
        ]
      }
    ],
    "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
  }
  ```

  {% endcut %}

{% endlist %}

{% note info %}

Когда ВМ перейдет в статус `Running`, на нее начнет устанавливаться агент {{ backup-name }}. Установка займет от 5 до 10 минут.

Привязка политики выполняется асинхронно после создания и инициализации ВМ, а также установки и настройки агента {{ backup-name }}. Это может занимать до 10–15 минут. В итоге виртуальная машина появится в списке ВМ сервиса {{ backup-name }} и в списке ВМ, привязанных к политике `weekly-backup`.

{% endnote %}

За процессом установки можно следить с помощью [последовательного порта](../../../compute/operations/vm-info/get-serial-port-output.md) ВМ в консоли управления.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../backup/operations/delete-vm.md) ВМ из {{ backup-name }}.
1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) ВМ из {{ compute-name }}.
1. [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес, если вы его зарезервировали.
1. Если для ВМ были созданы резервные копии, [удалите](../../../backup/operations/backup-vm/delete.md) их.

#### См. также {#see-also}

* [{#T}](terraform.md)