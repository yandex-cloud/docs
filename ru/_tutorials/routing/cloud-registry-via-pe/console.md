# Подключение к {{ cloud-registry-full-name }} из сети {{ vpc-full-name }} без доступа в интернет с помощью консоли управления, CLI или API


Чтобы организовать подключение к {{ cloud-registry-name }} из сети {{ vpc-name }} без доступа в интернет:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте подсеть и зарезервируйте IP-адреса](#create-subnet).
1. [Создайте локальный Docker-реестр {{ cloud-registry-name }}](#create-registry).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте сервисные подключения](#create-pes).
1. [Создайте виртуальные машины](#create-vms).
1. [Убедитесь в работоспособности решения](#validate).

При развертывании решения в продуктивных средах ознакомьтесь с [рекомендациями](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_tutorials_includes/cloud-registry-via-pe/paid-resources.md) %}


## Создайте облачную сеть {#create-network}

Чтобы создать [облачную сеть](../../../vpc/concepts/network.md#network):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** задайте имя `cr-private-net`.
  1. Отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc vpc network create \
    --name cr-private-net
  ```

  Результат:

  ```text
  id: enpm85hqd907********
  folder_id: b1gt6g8ht345********
  created_at: "2026-11-12T10:55:04Z"
  name: cr-private-net
  default_security_group_id: enpt0gk9qso4********
  ```

  Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/network/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).

{% endlist %}


## Создайте подсеть и зарезервируйте IP-адреса {#create-subnet}

Чтобы создать [подсеть](../../../vpc/concepts/network.md#subnet) и зарезервировать в ней статические IP-адреса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![subnets](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.button_action-create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** задайте имя `cr-private-subnet`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите облачную сеть `cr-private-net`, созданную ранее.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** задайте [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети `192.168.10.0/24`.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
  1. В открывшемся списке подсетей выберите вновь созданную подсеть `cr-private-subnet`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}** и нажмите кнопку **{{ ui-key.yacloud.vpc.Subnetwork.SubnetUsedAddressesList.button_create_sPV4s }}**. В открывшемся окне:

      1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя `storage-pe-address`.
      1. В поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_internal-v4-address }}** укажите IP-адрес `192.168.10.10`, который будет использоваться сервисным подключением {{ objstorage-name }}.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Повторите предыдущий шаг, чтобы зарезервировать еще два внутренних IP-адреса:

      Имя | IP-адрес | Назначение
      --- | --- | ---
      `cr-pe-address` | `192.168.10.11` | Для сервисного подключения {{ cloud-registry-name }}
      `private-vm-address` | `192.168.10.20` | Для тестовой виртуальной машины

- CLI {#cli}

  1. Создайте подсеть в облачной сети `cr-private-net`:

      ```bash
      yc vpc subnet create \
        --name cr-private-subnet \
        --zone {{ region-id }}-a \
        --network-name cr-private-net \
        --range 192.168.10.0/24
      ```

      Результат:

      ```text
      id: e9bl2n91sv5d********
      folder_id: b1gt6g8ht345********
      created_at: "2026-11-12T10:56:22Z"
      name: cr-private-subnet
      network_id: enpm85hqd907********
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
        - 192.168.10.0/24
      ```

      Сохраните идентификатор (значение поля `id`) созданной подсети — он понадобится позднее для создания других ресурсов инфраструктуры.

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

  1. Зарезервируйте внутренние IP-адреса `192.168.10.10`, `192.168.10.11` и `192.168.10.20`, которые будут использоваться сервисными подключениями и тестовой виртуальной машиной. В командах используйте идентификатор подсети, который сохранили ранее:

      ```bash
      yc vpc address create \
        --name storage-pe-address \
        --internal-ipv4 address=192.168.10.10,subnet=<идентификатор_подсети>

      yc vpc address create \
        --name cr-pe-address \
        --internal-ipv4 address=192.168.10.11,subnet=<идентификатор_подсети>

      yc vpc address create \
        --name private-vm-address \
        --internal-ipv4 address=192.168.10.20,subnet=<идентификатор_подсети>
      ```

      Результат:

      ```text
      id: e9bmaohhok24********
      folder_id: b1gt6g8ht345********
      created_at: "2026-11-12T11:05:46Z"
      name: storage-pe-address
      internal_ipv4_address:
        address: 192.168.10.10
        subnet_id: e9bl2n91sv5d********
      reserved: true
      type: INTERNAL
      ip_version: IPV4

      id: e9bot4v8d4jd********
      folder_id: b1gt6g8ht345********
      created_at: "2026-11-12T11:05:47Z"
      name: cr-pe-address
      internal_ipv4_address:
        address: 192.168.10.11
        subnet_id: e9bl2n91sv5d********
      reserved: true
      type: INTERNAL
      ip_version: IPV4

      ...
      ```

      Сохраните идентификаторы (значения полей `id`) адресов `192.168.10.10` и `192.168.10.11` — они понадобятся позднее для создания сервисных подключений.

      Подробнее о команде `yc vpc address create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/address/create.md).

- API {#api}

  Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../../vpc/api-ref/grpc/Subnet/create.md).

  Чтобы зарезервировать внутренний IP-адрес, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Address/create.md) для ресурса [Address](../../../vpc/api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../../../vpc/api-ref/grpc/Address/create.md).

{% endlist %}


## Создайте локальный Docker-реестр {{ cloud-registry-name }} {#create-registry}

Чтобы создать [локальный реестр](../../../cloud-registry/concepts/registry.md#local-registry) {{ cloud-registry-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/cloud-registry) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}** и нажмите кнопку **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
  1. Выберите формат реестра `Docker`.
  1. В поле **Тип реестра** выберите `Local`.
  1. В поле **{{ ui-key.yacloud.common.name }}** задайте имя `cr-private-demo`.
  1. Значения остальных параметров оставьте без изменений и нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc cloud-registry registry create \
    --name cr-private-demo \
    --registry-kind docker \
    --registry-type local
  ```

  Результат:

  ```text
  id: cn1kskoloo5e********
  folder_id: b1gt6g8ht345********
  name: cr-private-demo
  kind: DOCKER
  type: LOCAL
  status: ACTIVE
  created_at: "2026-11-12T11:07:04Z"
  modified_at: "2026-11-12T11:07:27Z"
  pattern_filter:
    include_patterns:
      - '**'
  ```

  Сохраните идентификатор (поле `id`) реестра — он понадобится позднее при загрузке и скачивании артефактов.

  Подробнее о команде `yc cloud-registry registry create` читайте в [справочнике CLI](../../../cli/cli-ref/cloud-registry/cli-ref/registry/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../../cloud-registry/api-ref/Registry/create.md) для ресурса [Registry](../../../cloud-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../../cloud-registry/api-ref/grpc/Registry/create.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Чтобы создать [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Задайте для сервисного аккаунта имя `cr-pusher`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../../cloud-registry/security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Создайте сервисный аккаунт `cr-pusher`:

      ```bash
      yc iam service-account create \
        --name cr-pusher
      ```

      Результат:

      ```text
      id: aje9uvk7pn3n********
      folder_id: b1gt6g8ht345********
      created_at: "2026-11-12T11:09:05Z"
      name: cr-pusher
      status: ACTIVE
      ```

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте сервисному аккаунту [роль](../../../cloud-registry/security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` на ваш каталог, указав его [идентификатор](../../../resource-manager/operations/folder/get-id.md):

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role cloud-registry.artifacts.pusher \
        --service-account-name cr-pusher
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


## Создайте сервисные подключения {#create-pes}

{% note warning %}

При создании сервисных подключений важна последовательность: сервисное подключение {{ objstorage-name }} должно быть создано до создания сервисного подключения {{ cloud-registry-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте [сервисное подключение](../../../vpc/concepts/private-endpoint.md) {{ objstorage-name }}:

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
      1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.vpc.switch_private-endpoints }}**. Если раздел не отображается, выберите его в меню **Еще**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vpc.private-endpoint.label_create-private-endpoint }}**.
      1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_name }}** задайте имя `storage-pe`.
      1. В блоке **{{ ui-key.yacloud.vpc.private-endpoint.label_network-section }}**:

          1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_network }}** выберите облачную сеть `cr-private-net`, созданную ранее.
          1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-type }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_address-type_list }}` и в появившемся поле **{{ ui-key.yacloud.vpc.private-endpoint.field_address-id }}** выберите внутренний IP-адрес `192.168.10.10`.
          1. В поле **{{ ui-key.yacloud.vpc.private-endpoint.field_service }}** выберите `{{ ui-key.yacloud.vpc.private-endpoint.label_endpoint-service_object-storage }}`.
          1. Включите опцию **{{ ui-key.yacloud.vpc.private-endpoint.label_dns-field-text }}**.
      1. Нажмите **{{ ui-key.yacloud.common.create }}**.

          {% include [dns-records-created1](../../_tutorials_includes/cloud-registry-via-pe/dns-records-created1.md) %}

  1. Аналогичным образом создайте сервисное подключение {{ cloud-registry-name }} со следующими параметрами:

      * **{{ ui-key.yacloud.vpc.private-endpoint.field_name }}** — `cloud-registry-pe`.
      * **{{ ui-key.yacloud.vpc.private-endpoint.field_address-id }}** — `192.168.10.11`.
      * **{{ ui-key.yacloud.vpc.private-endpoint.field_service }}** — `{{ ui-key.yacloud.vpc.private-endpoint.service-name_registry }}`.

      {% include [dns-records-created2](../../_tutorials_includes/cloud-registry-via-pe/dns-records-created2.md) %}

- CLI {#cli}

  1. Создайте сервисное подключение {{ objstorage-name }}, указав идентификатор IP-адреса `192.168.10.10`, который был сохранен ранее:

      ```bash
      yc vpc private-endpoint create storage-pe \
        --network-name cr-private-net \
        --service-name yandex.cloud.storage \
        --address-spec "address-id=<идентификатор_зарезервированного_IP-адреса>" \
        --private-dns-records-enabled
      ```

      Результат:

      ```text
      id: enpk54vtg0ip********
      folder_id: b1gt6g8ht345********
      created_at: "2026-11-12T11:41:23.965602Z"
      name: storage-pe
      network_id: enpm85hqd907********
      status: AVAILABLE
      address:
        subnet_id: e9bl2n91sv5d********
        address: 192.168.10.10
        address_id: e9bmaohhok24********
      dns_options:
        private_dns_records_enabled: true
      service_name: yandex.cloud.storage
      ```

      {% include [dns-records-created1](../../_tutorials_includes/cloud-registry-via-pe/dns-records-created1.md) %}

      Подробнее о команде `yc vpc private-endpoint create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/private-endpoint/create.md).

  1. Аналогичным образом создайте сервисное подключение {{ cloud-registry-name }} со следующими параметрами:

      * имя ресурса — `cloud-registry-pe`.
      * `--address-spec` — идентификатор IP-адреса `192.168.10.11`, который был создан ранее.
      * `--service-name` — `yandex.cloud.registry`.

      {% include [dns-records-created2](../../_tutorials_includes/cloud-registry-via-pe/dns-records-created2.md) %}

- API {#api}

  Чтобы создать сервисное подключение, воспользуйтесь методом REST API [create](../../../vpc/privatelink/api-ref/PrivateEndpoint/create.md) для ресурса [PrivateEndpoint](../../../vpc/privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Create](../../../vpc/privatelink/api-ref/grpc/PrivateEndpoint/create.md).

{% endlist %}

## Создайте виртуальные машины {#create-vms}

### Тестовая виртуальная машина {#create-test-vm}

Чтобы создать тестовую [виртуальную машину](../../../compute/concepts/vm.md) из образа [{{ coi }}](../../../cos/concepts/index.md) без доступа в интернет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ `cr-private-vm`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}** и в открывшемся окне:

      1. В строке поиска введите `{{ coi }}`.
      1. В списке с найденными образами выберите образ `{{ coi }}` и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть `cr-private-subnet` в облачной сети `cr-private-net`.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`, чтобы не назначать виртуальной машине публичный IP-адрес.
      1. Значение поля **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** оставьте без изменений.

          В этом случае виртуальной машине будет назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), которая разрешает любой исходящий трафик, а также входящий трафик на TCP- и UDP-порты `22` и `3389`. Этого достаточно для тестирования предлагаемого решения.

      1. Разверните блок **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** и в поле **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}`.
      1. В появившемся поле **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_address }}** выберите адрес `192.168.10.20`, который был зарезервирован ранее.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант `{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}` и укажите данные для доступа к ВМ:

      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя `yc-user`.
      1. {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}
  1. Отключите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}**.
  1. Разверните блок **{{ ui-key.yacloud.compute.instances.create.section_additional }}** и в поле **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** выберите сервисный аккаунт `cr-pusher`, созданный ранее.
  1. Значения других параметров оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name cr-private-vm \
    --hostname cr-private-vm \
    --zone {{ region-id }}-a \
    --network-interface "subnet-name=cr-private-subnet,ipv4-address=192.168.10.20" \
    --create-boot-disk "image-folder-id=standard-images,image-family=container-optimized-image" \
    --service-account-name cr-pusher \
    --ssh-key "<путь_к_публичному_SSH-ключу>"
  ```

  Где `<путь_к_публичному_SSH-ключу>` — путь к файлу публичного SSH-ключа, например `~/.ssh/id_ed25519.pub`.

  В результате виртуальной машине будет назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), которая разрешает любой исходящий трафик, а также входящий трафик на TCP- и UDP-порты `22` и `3389`. Этого достаточно для тестирования предлагаемого решения.

  Результат:

  ```text
  id: fhmluidql8a1********
  folder_id: b1gt6g8ht345********
  created_at: "2026-11-12T12:02:32Z"
  name: cr-private-vm
  zone_id: {{ region-id }}-a
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  boot_disk:
    mode: READ_WRITE
    device_name: fhm6d5tats21********
    auto_delete: true
    disk_id: fhm6d5tats21********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:15:f4:9b:aa
      subnet_id: e9bl2n91sv5d********
      primary_v4_address:
        address: 192.168.10.20
  fqdn: cr-private-vm.{{ region-id }}.internal
  scheduling_policy: {}
  service_account_id: aje9uvk7pn3n********
  network_settings:
    type: STANDARD
  placement_policy: {}
  gpu_settings: {}
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
    aws_v2_http_endpoint: ENABLED
    aws_v2_http_token: ENABLED
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

### Промежуточная виртуальная машина {#create-jump-vm}

Чтобы создать промежуточную виртуальную машину с доступом в интернет, которая будет использоваться для подключения к тестовой ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите]({{ link-console-main }}/link/compute) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** и нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ `jump-vm`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите публичный образ [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите зону доступности `{{ region-id }}-a`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите подсеть `cr-private-subnet` в облачной сети `cr-private-net`.
      1. В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант `{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}` и укажите данные для доступа к ВМ:

      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя `yc-user`.
      1. В поле **{{ ui-key.yacloud.compute.instances.create.field_key }}** выберите тот же SSH-ключ, который вы использовали при создании тестовой ВМ.

          {% note warning %}

          Одного SSH-ключа на две ВМ достаточно при тестировании сценария. В продуктивной среде для доступа к разным ВМ используйте разные SSH-ключи.

          {% endnote %}

  1. Отключите опцию **{{ ui-key.yacloud.compute.components.BackupSection.section_backup_1MXwy }}**.
  1. Значения других параметров оставьте без изменения и нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name jump-vm \
    --hostname jump-vm \
    --zone {{ region-id }}-a \
    --network-interface "subnet-name=cr-private-subnet,nat-ip-version=ipv4" \
    --create-boot-disk "image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin" \
    --ssh-key "<путь_к_публичному_SSH-ключу>"
  ```

  Где `<путь_к_публичному_SSH-ключу>` — путь к файлу с тем же публичным SSH-ключом, который вы использовали при создании тестовой ВМ.

  {% note warning %}

  Одного SSH-ключа на две ВМ достаточно при тестировании сценария. В продуктивной среде для доступа к разным ВМ используйте разные SSH-ключи.

  {% endnote %}

  {% cut "Результат" %}

  ```text
  id: fhmfon7k385t********
  folder_id: b1gt6g8ht345********
  created_at: "2026-11-12T12:10:12Z"
  name: jump-vm
  zone_id: {{ region-id }}-a
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  boot_disk:
    mode: READ_WRITE
    device_name: fhm396p0kp4b********
    auto_delete: true
    disk_id: fhm396p0kp4b********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:fc:5c:f4:1a
      subnet_id: e9bl2n91sv5d********
      primary_v4_address:
        address: 192.168.10.18
        one_to_one_nat:
          address: 51.250.***.***
          ip_version: IPV4
  fqdn: jump-vm.{{ region-id }}.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  gpu_settings: {}
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
    aws_v2_http_endpoint: ENABLED
    aws_v2_http_token: ENABLED
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

  {% endcut %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}


## Убедитесь в работоспособности решения {#validate}

{% include [validate](../../_tutorials_includes/cloud-registry-via-pe/validate.md) %}


## Рекомендации для использования в продуктивной среде {#recommendations}

{% include [recommendations](../../_tutorials_includes/cloud-registry-via-pe/recommendations.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. Удалите реестр {{ cloud-registry-name }}.
1. [Удалите](../../../iam/operations/sa/delete.md) сервисный аккаунт.
1. [Удалите](../../../vpc/operations/private-endpoint-delete.md) сервисные подключения.
1. [Удалите](../../../vpc/operations/private-ip-delete.md) зарезервированные IP-адреса, затем [удалите](../../../vpc/operations/subnet-delete.md) подсеть.
1. [Удалите](../../../vpc/operations/network-delete.md) облачную сеть.