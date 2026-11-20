[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Практические руководства](../index.md) > [Подключение к Cloud Registry из сети Virtual Private Cloud без доступа в интернет](index.md) > Консоль управления, CLI, API

# Подключение к Yandex Cloud Registry из сети Yandex Virtual Private Cloud без доступа в интернет с помощью консоли управления, CLI или API


Чтобы организовать подключение к Cloud Registry из сети Virtual Private Cloud без доступа в интернет:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть](#create-network).
1. [Создайте подсеть и зарезервируйте IP-адреса](#create-subnet).
1. [Создайте локальный Docker-реестр Cloud Registry](#create-registry).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте сервисные подключения](#create-pes).
1. [Создайте виртуальные машины](#create-vms).
1. [Убедитесь в работоспособности решения](#validate).

При развертывании решения в продуктивных средах ознакомьтесь с [рекомендациями](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за вычислительные ресурсы и диски [виртуальных машин](../../../compute/concepts/vm.md) ([тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), [сервисных подключений](../../../vpc/concepts/private-endpoint.md) и обработку сервисными подключениями входящего и исходящего трафика ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md));
* плата за использование хранилища Cloud Registry, входящий и исходящий трафик ([тарифы Yandex Cloud Registry](../../pricing.md)).


## Создайте облачную сеть {#create-network}

Чтобы создать [облачную сеть](../../../vpc/concepts/network.md#network):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/vpc) в сервис **Virtual Private Cloud**.
  1. Нажмите кнопку **Создать сеть**.
  1. В поле **Имя** задайте имя `cr-private-net`.
  1. Отключите опцию **Создать подсети**.
  1. Нажмите **Создать сеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/vpc) в сервис **Virtual Private Cloud**.
  1. На панели слева выберите ![subnets](../../../_assets/console-icons/nodes-right.svg) **Подсети** и нажмите кнопку **Создать подсеть**.
  1. В поле **Имя** задайте имя `cr-private-subnet`.
  1. В поле **Зона доступности** выберите [зону доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В поле **Сеть** выберите облачную сеть `cr-private-net`, созданную ранее.
  1. В поле **CIDR** задайте [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети `192.168.10.0/24`.
  1. Нажмите **Создать подсеть**.
  1. В открывшемся списке подсетей выберите вновь созданную подсеть `cr-private-subnet`.
  1. Перейдите на вкладку **IP-Адреса** и нажмите кнопку **Зарезервировать IP-адрес**. В открывшемся окне:

      1. В поле **Имя** задайте имя `storage-pe-address`.
      1. В поле **Внутренний IPv4 адрес** укажите IP-адрес `192.168.10.10`, который будет использоваться сервисным подключением Object Storage.
      1. Нажмите кнопку **Создать**.
  1. Повторите предыдущий шаг, чтобы зарезервировать еще два внутренних IP-адреса:

      Имя | IP-адрес | Назначение
      --- | --- | ---
      `cr-pe-address` | `192.168.10.11` | Для сервисного подключения Cloud Registry
      `private-vm-address` | `192.168.10.20` | Для тестовой виртуальной машины

- CLI {#cli}

  1. Создайте подсеть в облачной сети `cr-private-net`:

      ```bash
      yc vpc subnet create \
        --name cr-private-subnet \
        --zone ru-central1-a \
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
      zone_id: ru-central1-a
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


## Создайте локальный Docker-реестр Cloud Registry {#create-registry}

Чтобы создать [локальный реестр](../../concepts/registry.md#local-registry) Cloud Registry:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/cloud-registry) в сервис **Cloud Registry**.
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Реестры** и нажмите кнопку **Создать реестр**.
  1. Выберите формат реестра `Docker`.
  1. В поле **Тип реестра** выберите `Local`.
  1. В поле **Имя** задайте имя `cr-private-demo`.
  1. Значения остальных параметров оставьте без изменений и нажмите кнопку **Создать**.

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

  Воспользуйтесь методом REST API [create](../../api-ref/Registry/create.md) для ресурса [Registry](../../api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../api-ref/grpc/Registry/create.md).

{% endlist %}


## Создайте сервисный аккаунт {#create-sa}

Чтобы создать [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Задайте для сервисного аккаунта имя `cr-pusher`.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher`.
  1. Нажмите кнопку **Создать**.

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

  1. Назначьте сервисному аккаунту [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` на ваш каталог, указав его [идентификатор](../../../resource-manager/operations/folder/get-id.md):

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

При создании сервисных подключений важна последовательность: сервисное подключение Object Storage должно быть создано до создания сервисного подключения Cloud Registry.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте [сервисное подключение](../../../vpc/concepts/private-endpoint.md) Object Storage:

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
      1. [Перейдите](https://console.yandex.cloud/link/vpc) в сервис **Virtual Private Cloud**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/globe.svg) **Сервисные подключения**. Если раздел не отображается, выберите его в меню **Еще**.
      1. Нажмите кнопку **Создать подключение**.
      1. В поле **Имя** задайте имя `storage-pe`.
      1. В блоке **Сетевые настройки**:

          1. В поле **Сеть** выберите облачную сеть `cr-private-net`, созданную ранее.
          1. В поле **Адрес** выберите `Список` и в появившемся поле **IP-адрес** выберите внутренний IP-адрес `192.168.10.10`.
          1. В поле **Сервис** выберите `Object Storage`.
          1. Включите опцию **Создать основную DNS-запись**.
      1. Нажмите **Создать**.

          В результате будет создано сервисное подключение, а также во внутренней DNS-зоне будут автоматически созданы следующие [ресурсные записи](../../../dns/concepts/resource-record.md#a):
          
          Имя | Тип | Значение
          --- | --- | ---
          storage.pe.yandexcloud.net. | A | 192.168.10.10
          *.storage.pe.yandexcloud.net. | A | 192.168.10.10
          storage.yandexcloud.net. | A | 192.168.10.10
          *.storage.yandexcloud.net. | A | 192.168.10.10

  1. Аналогичным образом создайте сервисное подключение Cloud Registry со следующими параметрами:

      * **Имя** — `cloud-registry-pe`.
      * **IP-адрес** — `192.168.10.11`.
      * **Сервис** — `Cloud Registry`.

      В результате во внутренней DNS-зоне будут автоматически созданы следующие ресурсные записи:
      
      Имя | Тип | Значение
      --- | --- | ---
      registry.pe.yandexcloud.net. | A | 192.168.10.11
      registry.yandexcloud.net. | A | 192.168.10.11

- CLI {#cli}

  1. Создайте сервисное подключение Object Storage, указав идентификатор IP-адреса `192.168.10.10`, который был сохранен ранее:

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

      В результате будет создано сервисное подключение, а также во внутренней DNS-зоне будут автоматически созданы следующие [ресурсные записи](../../../dns/concepts/resource-record.md#a):
      
      Имя | Тип | Значение
      --- | --- | ---
      storage.pe.yandexcloud.net. | A | 192.168.10.10
      *.storage.pe.yandexcloud.net. | A | 192.168.10.10
      storage.yandexcloud.net. | A | 192.168.10.10
      *.storage.yandexcloud.net. | A | 192.168.10.10

      Подробнее о команде `yc vpc private-endpoint create` читайте в [справочнике CLI](../../../cli/cli-ref/vpc/cli-ref/private-endpoint/create.md).

  1. Аналогичным образом создайте сервисное подключение Cloud Registry со следующими параметрами:

      * имя ресурса — `cloud-registry-pe`.
      * `--address-spec` — идентификатор IP-адреса `192.168.10.11`, который был создан ранее.
      * `--service-name` — `yandex.cloud.registry`.

      В результате во внутренней DNS-зоне будут автоматически созданы следующие ресурсные записи:
      
      Имя | Тип | Значение
      --- | --- | ---
      registry.pe.yandexcloud.net. | A | 192.168.10.11
      registry.yandexcloud.net. | A | 192.168.10.11

- API {#api}

  Чтобы создать сервисное подключение, воспользуйтесь методом REST API [create](../../../vpc/privatelink/api-ref/PrivateEndpoint/create.md) для ресурса [PrivateEndpoint](../../../vpc/privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Create](../../../vpc/privatelink/api-ref/grpc/PrivateEndpoint/create.md).

{% endlist %}

## Создайте виртуальные машины {#create-vms}

### Тестовая виртуальная машина {#create-test-vm}

Чтобы создать тестовую [виртуальную машину](../../../compute/concepts/vm.md) из образа [Container Optimized Image](../../../cos/concepts/index.md) без доступа в интернет:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Общая информация** задайте имя ВМ `cr-private-vm`.
  1. В блоке **Образ загрузочного диска** нажмите кнопку **Показать все продукты Marketplace** и в открывшемся окне:

      1. В строке поиска введите `Container Optimized Image`.
      1. В списке с найденными образами выберите образ `Container Optimized Image` и нажмите кнопку **Использовать**.
  1. В блоке **Расположение** выберите зону доступности `ru-central1-a`.
  1. В блоке **Сетевые настройки**:

      1. В поле **Подсеть** выберите подсеть `cr-private-subnet` в облачной сети `cr-private-net`.
      1. В поле **Публичный IP-адрес** выберите `Без адреса`, чтобы не назначать виртуальной машине публичный IP-адрес.
      1. Значение поля **Группы безопасности** оставьте без изменений.

          В этом случае виртуальной машине будет назначена [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), которая разрешает любой исходящий трафик, а также входящий трафик на TCP- и UDP-порты `22` и `3389`. Этого достаточно для тестирования предлагаемого решения.

      1. Разверните блок **Дополнительно** и в поле **Внутренний IPv4-адрес** выберите `Список`.
      1. В появившемся поле **IP-адрес** выберите адрес `192.168.10.20`, который был зарезервирован ранее.
  1. В блоке **Доступ** выберите вариант `SSH-ключ` и укажите данные для доступа к ВМ:

      1. В поле **Логин** введите имя пользователя `yc-user`.
      1. В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../../organization/concepts/membership.md).
         
         Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
         
         1. Нажмите кнопку **Добавить ключ**.
         1. Задайте имя SSH-ключа.
         1. Выберите вариант:
         
             * `Ввести вручную` — вставьте содержимое открытого [SSH](../../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
             * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
             * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
             
               При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
         
         1. Нажмите кнопку **Добавить**.
         
         SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  1. Отключите опцию **Резервное копирование**.
  1. Разверните блок **Дополнительно** и в поле **Сервисный аккаунт** выберите сервисный аккаунт `cr-pusher`, созданный ранее.
  1. Значения других параметров оставьте без изменения и нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name cr-private-vm \
    --hostname cr-private-vm \
    --zone ru-central1-a \
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
  zone_id: ru-central1-a
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
  fqdn: cr-private-vm.ru-central1.internal
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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создаете инфраструктуру.
  1. [Перейдите](https://console.yandex.cloud/link/compute) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/server.svg) **Виртуальные машины** и нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Общая информация** задайте имя ВМ `jump-vm`.
  1. В блоке **Образ загрузочного диска** выберите публичный образ [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin).
  1. В блоке **Расположение** выберите зону доступности `ru-central1-a`.
  1. В блоке **Сетевые настройки**:

      1. В поле **Подсеть** выберите подсеть `cr-private-subnet` в облачной сети `cr-private-net`.
      1. В поле **Публичный IP-адрес** выберите `Автоматически`.
  1. В блоке **Доступ** выберите вариант `SSH-ключ` и укажите данные для доступа к ВМ:

      1. В поле **Логин** введите имя пользователя `yc-user`.
      1. В поле **SSH-ключ** выберите тот же SSH-ключ, который вы использовали при создании тестовой ВМ.

          {% note warning %}

          Одного SSH-ключа на две ВМ достаточно при тестировании сценария. В продуктивной среде для доступа к разным ВМ используйте разные SSH-ключи.

          {% endnote %}

  1. Отключите опцию **Резервное копирование**.
  1. Значения других параметров оставьте без изменения и нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc compute instance create \
    --name jump-vm \
    --hostname jump-vm \
    --zone ru-central1-a \
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
  zone_id: ru-central1-a
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
  fqdn: jump-vm.ru-central1.internal
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

### Настройте безопасное SSH-подключение к тестовой ВМ через промежуточную ВМ {#setup-ssh-connection}

1. На вашем локальном компьютере в любом текстовом редакторе откройте файл `~/.ssh/config`. Если такого файла не существует, создайте его.

    Тильда (`~`) в пути означает домашний каталог пользователя (например, `/home/user` в Linux или `C:\Users\user` в Windows).
1. Добавьте в файл `~/.ssh/config` следующие правила подключения:

    {% note info %}

    Если текущий файл `~/.ssh/config` содержит раздел `Host *` с общими правилами подключения, новые правила необходимо добавить перед этим разделом.

    {% endnote %}

    ```text
    Host jump-vm
        HostName <публичный_IP-адрес_промежуточной_ВМ>
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ForwardAgent no

    Host cr-private-vm
        HostName 192.168.10.20
        User yc-user
        IdentityFile <локальный_путь_к_закрытому_SSH-ключу>
        IdentitiesOnly yes
        ProxyJump jump-vm
        ForwardAgent no
    ```

    Где:

    * `<публичный_IP-адрес_промежуточной_ВМ>` — публичный IP-адрес ВМ `jump-vm`, который можно узнать в поле **Публичный IPv4-адрес** сетевого интерфейса в блоке **Сеть** на странице ВМ в [консоли управления](https://console.yandex.cloud/link/compute) или с помощью команды [Yandex Cloud CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) `yc compute instance get jump-vm`.
    * `<локальный_путь_к_закрытому_SSH-ключу>` — локальный путь к закрытой части SSH-ключа, который вы указали при создании виртуальных машин. Например: `~/.ssh/id_ed25519`.
1. Настройте необходимые права доступа к созданному файлу конфигурации. Способ настройки зависит от операционной системы вашего компьютера:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux}

      В терминале выполните команду:

      ```bash
      chmod 600 ~/.ssh/config
      ```

    - Windows (PowerShell) {#windows}

      В терминале PowerShell выполните команды:

      ```powershell
      icacls "$env:USERPROFILE\.ssh\config" /inheritance:r
      icacls "$env:USERPROFILE\.ssh\config" /grant:r "$($env:USERNAME):(R,W)"
      ```

    {% endlist %}

### Подключитесь к тестовой виртуальной машине {#connect-to-test-vm}

1. Чтобы подключиться к тестовой виртуальной машине через промежуточную ВМ, в терминале вашего локального компьютера выполните команду:

    ```bash
    ssh cr-private-vm
    ```

    Результат:

    ```text
    The authenticity of host '51.250.***.*** (51.250.***.***)' can't be established.
    ED25519 key fingerprint is: SHA256:C/+mc/qPAhH6ls2NhwSNyYZoRziZ8GOd3z5********
    This key is not known by any other names.
    Are you sure you want to continue connecting (yes/no/[fingerprint])?
    ```

1. Дважды разрешите подключение (введите `yes` и нажмите `ENTER`).

    Результат:

    ```bash
    yc-user@cr-private-vm:~$
    ```

### Проверьте работу DNS и убедитесь, что на тестовой ВМ нет доступа в интернет {#check-internet-connection}

В терминале тестовой виртуальной машины выполните действия:

1. Проверьте разрешение DNS-имен во [внутренней DNS-зоне](../../../dns/concepts/dns-zone.md#private-zones):

    ```bash
    getent ahostsv4 registry.yandexcloud.net | awk '{print $1}' | sort -u
    getent ahostsv4 storage.yandexcloud.net | awk '{print $1}' | sort -u
    ```

    Результат:

    ```text
    192.168.10.11
    192.168.10.10
    ```
1. Убедитесь, что публичные сайты недоступны:

    ```bash
    curl --connect-timeout 5 --max-time 10 https://yandex.ru
    ```

    Если все настроено правильно, команда должна завершиться ошибкой:

    ```text
    curl: (28) Failed to connect to yandex.ru port 443 after 4427 ms: Connection timed out
    ```

### Аутентифицируйтесь в Cloud Registry {#authenticate-in-cr}

В терминале тестовой виртуальной машины выполните действия:

1. Через [сервис метаданных](../../../compute/concepts/vm-metadata.md#metadata-formats) ВМ получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта `cr-pusher`, который привязан к ВМ:

    ```bash
    IAM_TOKEN="$(
      curl --silent --fail \
        --header Metadata-Flavor:Google \
        http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | sed -n 's/.*"access_token"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p'
    )"
    ```
1. Убедитесь, что IAM-токен успешно получен и сохранен в переменную:

    ```bash
    if test -n "$IAM_TOKEN"; then
      echo "IAM-токен получен"
    else
      echo "Не удалось получить IAM-токен из метаданных" >&2
      exit 1
    fi
    ```

    Результат:

    ```text
    IAM-токен получен
    ```
1. Аутентифицируйтесь в Cloud Registry с помощью полученного IAM-токена:

    ```bash
    printf '%s' "$IAM_TOKEN" | docker login \
      --username iam \
      --password-stdin \
      registry.yandexcloud.net
    ```

    Результат:

    ```text
    ...
    Login Succeeded
    ```
1. Удалите переменную с IAM-токеном:

    ```bash
    unset IAM_TOKEN
    ```

### Соберите локальный Docker-образ {#compile-image}

На тестовой виртуальной машине отсутствует доступ в интернет, поэтому скачать классический пример тестового образа `hello-world` из [Docker Hub](https://hub.docker.com/) не получится.

Вместо этого в целях тестирования вы соберете локальный Docker-образ с использованием статического исполняемого файла [busybox](https://www.busybox.net/) с набором утилит для Linux. Этот файл доступен в образе Container Optimized Image, из которого создана тестовая виртуальная машина.

В терминале тестовой виртуальной машины выполните действия:

1. Создайте локальный Docker-образ:

    ```bash
    mkdir -p /tmp/img/bin && cd /tmp/img
    cp $(which busybox) bin/busybox
    tar -cf rootfs.tar bin/busybox
    docker import rootfs.tar my-busybox:latest
    ```

    Результат:

    ```text
    sha256:137a8aff429ba2f8445450f8d063c2db394496d7a0e683555a573ab8********
    ```
1. Запустите локальный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Загрузите Docker-образ в реестр {#push-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
    my-busybox    latest    137a********   18 minutes ago   2.19MB
    ```
1. Присвойте Docker-образу URL вида, в котором его можно загрузить в реестр Cloud Registry:

    ```bash
    docker tag my-busybox:latest \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Где `<идентификатор_реестра>` — идентификатор реестра Cloud Registry, который вы создали ранее. Получить идентификатор реестра вы можете в [консоли управления](https://console.yandex.cloud/link/cloud-registry) или с помощью команды [Yandex Cloud CLI](../../../cli/cli-ref/cloud-registry/cli-ref/registry/list.md) `yc cloud-registry registry list`.
1. Загрузите собранный образ `my-busybox` в ваш реестр Cloud Registry:

    ```bash
    docker push \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    The push refers to repository [registry.yandexcloud.net/cn1tsdfufbue********/my-busybox]
    a7c1********: Pushed 
    latest: digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb******** size: 527
    ```

### Скачайте Docker-образ из реестра {#pull-image}

В терминале тестовой виртуальной машины выполните действия:

1. Получите список доступных Docker-образов:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    my-busybox                                                 latest    137a********   25 minutes ago   2.19MB
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   25 minutes ago   2.19MB
    ```
1. Перед скачиванием удалите все имеющиеся локальные образы:

    ```bash
    docker rmi -f $(docker images -q)
    ```
1. Убедитесь, что локальных образов больше нет:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
    ```
1. Скачайте образ из реестра Cloud Registry:

    ```bash
    docker pull \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest
    ```

    Результат:

    ```text
    latest: Pulling from cn1tsdfufbue********/my-busybox
    1391********: Pull complete 
    Digest: sha256:2ab6804ba443d3621bf4be33f19c576775c59eef7e059da5735a0fcb********
    Status: Downloaded newer image for registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox:latest
    ```
1. Убедитесь, что скачанный образ появился в локальном списке:

    ```bash
    docker images
    ```

    Результат:

    ```text
    REPOSITORY                                                 TAG       IMAGE ID       CREATED          SIZE
    registry.yandexcloud.net/cn1tsdfufbue********/my-busybox   latest    137a********   33 minutes ago   2.19MB
    ```
1. Запустите скачанный Docker-образ, чтобы убедиться в его работоспособности:

    ```bash
    docker run --rm \
      registry.yandexcloud.net/<идентификатор_реестра>/my-busybox:latest /bin/busybox echo "Hello offline"
    ```

    Результат:

    ```text
    Hello offline
    ```

### Убедитесь в прохождении трафика через сервисные подключения {#check-traffic}

С помощью [метрик](../../../monium/metrics/quickstart-app.md) Yandex Monium убедитесь, что через сервисные подключения `storage-pe` и `cloud-registry-pe` при загрузке и скачивании Docker-образа проходил сетевой трафик:

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. Откройте [Monium](https://monium.yandex.cloud) и на панели сверху выберите [проект каталога](*monium-folder-project), в котором находится ваша инфраструктура.
  
      Имя и идентификатор проекта Monium, в который выгружается телеметрия ресурсов в вашем каталоге, соответствуют имени и идентификатору этого каталога.
  1. На панели слева выберите ![compass](../../../_assets/console-icons/compass.svg) **Обзор**, затем ![rectangle-pulse](../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
  1. В строке формирования запроса включите режим кода, нажав ![image](../../../_assets/console-icons/code.svg), и введите следующий запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_bytes"}
      ```
  1. Нажмите кнопку **Добавить запрос**, переключите его в режим кода и введите еще один запрос:

      ```json
      {project = "folder__<идентификатор_каталога>", cluster = "default", service = "__private-endpoint__", name = "processed_packets"}
      ```
  1. Включите опцию **Один график на запрос**.
  1. Нажмите кнопку **Выполнить запрос**.
  1. Убедитесь, что на графиках отображается прохождение входящего и исходящего трафика через сервисные подключения в моменты времени, когда вы загружали Docker-образ в реестр и скачивали его из реестра.

      {% note tip %}

      Используйте шкалу времени в верхней части экрана, чтобы изменить или сместить в нужном направлении анализируемое окно времени.

      {% endnote %}

{% endlist %}

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.


## Рекомендации для использования в продуктивной среде {#recommendations}

* Используйте существующие сервисные подключения повторно: они действуют для всех ресурсов в выбранной облачной сети.
* Резервируйте статические внутренние IP-адреса для сервисных подключений и документируйте каждый случай такого резервирования.
* Выдавайте рабочим нагрузкам только минимально необходимые [роли](../../security/index.md#service-roles):

    * `cloud-registry.artifacts.puller` для скачивания артефактов.
    * `cloud-registry.artifacts.pusher` для загрузки артефактов. Выдавайте эту роль только тем субъектам, которым действительно нужна возможность загружать артефакты.
* Получайте короткоживущие IAM-токены для субъекта рабочей нагрузки. Не размещайте статические ключи в образах ВМ и контейнеров.
* При использовании корпоративного или пользовательского DNS заранее убедитесь, что в нем корректно разрешаются оба стандартных FQDN и wildcard-имена Object Storage и Cloud Registry.
* Помните, что у Cloud Registry есть публичный эндпоинт. Использование сервисного подключения не запрещает доступ к реестру из других сетей и не отменяет необходимости управлять доступом к реестрам при помощи ресурсов Identity and Access Management.
* Для [удаленных](../../concepts/registry.md#remote-registry) и [виртуальных](../../concepts/registry.md#virtual-registry) реестров отдельно оценивайте зависимость от внешних репозиториев: сервисные подключения обеспечивают путь от рабочей нагрузки до сервиса Cloud Registry, но не гарантируют доступность сторонних репозиториев.
* Вместо группы безопасности по умолчанию вы можете [создать](../../../vpc/operations/security-group-create.md) и привязать к ВМ собственную группу безопасности, которая разрешает только минимально необходимый трафик ВМ:

    * Исходящий TCP-трафик на порт `443` к IP-адресам обоих сервисных подключений.
    * Исходящие DNS-запросы к DNS-серверу в подсети. Под DNS-сервер в подсети выделяется второй по счету IP-адрес диапазона. Подробнее читайте в разделе [Подсети](../../../vpc/concepts/network.md#subnet).
    * Входящий трафик, который обеспечивает административный доступ только из вашей доверенной сети, если такой доступ нужен.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. Удалите реестр Cloud Registry.
1. [Удалите](../../../iam/operations/sa/delete.md) сервисный аккаунт.
1. [Удалите](../../../vpc/operations/private-endpoint-delete.md) сервисные подключения.
1. [Удалите](../../../vpc/operations/private-ip-delete.md) зарезервированные IP-адреса, затем [удалите](../../../vpc/operations/subnet-delete.md) подсеть.
1. [Удалите](../../../vpc/operations/network-delete.md) облачную сеть.

#### Полезные ссылки {#see-also}

* [Подключение к Yandex Cloud Registry из сети Yandex Virtual Private Cloud без доступа в интернет с помощью Terraform](terraform.md)