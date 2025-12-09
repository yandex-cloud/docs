# Развертывание S2S VPN с помощью strongSwan в {{ yandex-cloud }}


В этом руководстве вы развернете защищенное site‑to‑site (S2S) VPN‑соединение между облачной инфраструктурой в {{ yandex-cloud }} и удаленной площадкой с помощью IPsec‑шлюза на базе [strongSwan](https://www.strongswan.org/). Для этого будет использоваться приложение [strongSwan S2S VPN](/marketplace/products/yc/ipsec-sgw) из каталога [{{ cloud-apps-full-name }}](/services/cloud-apps/). Приложение автоматизирует развертывание и базовую настройку IPsec‑туннеля, позволяя:

* быстро создать защищенный канал поверх публичного интернета;
* обеспечить шифрование трафика между подсетями;
* интегрировать облачные ресурсы в корпоративную сеть с сохранением контроля над маршрутизацией.

{% note info %}

Готовое приложение автоматизирует развертывание инфраструктуры в {{ yandex-cloud }}.

При использовании strongSwan S2S VPN на удаленной площадке (в вашем локальном ЦОД, филиале или другом облаке) необходима настройка вручную.

{% endnote %}

Чтобы развернуть защищенное соединение:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#create-service-account).
1. [Создайте облачную сеть](#create-vpc).
1. [Зарезервируйте публичный статический IP-адрес](#reserve-public-static-ip).
1. [Создайте пару ключей SSH](#create-ssh-keys).
2. [Разверните приложение](#app-deploy).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.


## Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания инфраструктуры для данного решения входят:

* Плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../../compute/pricing.md)).
* Плата за использование статического внешнего IP-адреса (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).
* Плата за исходящий трафик (см. [тарифы {{ vpc-full-name }}](../../../vpc/pricing.md))


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


## Создайте сервисный аккаунт {#create-service-account}

Создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) `s2s-vpn-sa` для автоматического создания ресурсов при установке приложения. Назначьте ему роли `resource-manager.admin`, `iam.admin`, `compute.admin` и `vpc.admin`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Укажите имя сервисного аккаунта: `s2s-vpn-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли:
      * `resource-manager.admin`
      * `iam.admin`
      * `compute.admin`
      * `vpc.admin`.

  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт `s2s-vpn-sa`:

      ```bash
      yc iam service-account create --name s2s-vpn-sa
      ```

      Результат:

      ```text
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-03-21T10:36:29.726397755Z"
      name: s2s-vpn-sa
      ```

      Сохраните идентификатор сервисного аккаунта `s2s-vpn-sa` (`id`) и каталога, в котором его создали (`folder_id`).

  1. Назначьте сервисному аккаунту роли `resource-manager.admin`, `iam.admin`, `compute.admin` и `vpc.admin` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role resource-manager.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role iam.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role compute.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>

      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role vpc.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      done (1s)
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роли на каталог, воспользуйтесь методом [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте облачную сеть {#create-vpc}

Создайте [облачную сеть](../../../vpc/concepts/network.md), в которой будет размещена ВМ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `s2s-vpn-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc network create s2s-vpn-network
  ```

  Результат:

  ```text
  id: enp1gg8kr3pv********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-20T20:08:11Z"
  name: s2s-vpn-network
  default_security_group_id: enppne4l2eg5********
  ```

- API {#api}

  Чтобы создать облачную сеть, воспользуйтесь методом REST API [create](../../../vpc/api-ref/Network/create.md) для ресурса [Network](../../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md).

{% endlist %}


## Зарезервируйте публичный статический IP-адрес {#reserve-public-static-ip}

Зарезервируйте статический [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) для ВМ, на которой будет установлено приложение.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** и нажмите **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** выберите `{{ region-id }}-b` и нажмите **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}


## Создайте пару ключей SSH {#create-ssh-keys}

Чтобы подключаться к [ВМ](../../../compute/concepts/vm.md) по [SSH](../../../glossary/ssh-keygen.md), нужна пара ключей: открытый ключ размещается на ВМ, а закрытый ключ хранится у пользователя. Такой способ безопаснее, чем подключение по логину и паролю.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

Чтобы создать пару ключей:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}


## Разверните приложение {#app-deploy}

### Установите приложение {#install-app}

В результате установки приложения будут автоматически созданы ресурсы {{ yandex-cloud }}:

* [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md);
* [подсеть](../../../vpc/concepts/network.md#subnet);
* [IP-адрес](../../../vpc/concepts/address.md#public-addresses);
* [таблица маршрутизации](../../../vpc/concepts/routing.md#rt-vm);
* [группа безопасности](../../../vpc/concepts/security-groups.md);
* [виртуальная машина](../../../compute/concepts/vm.md).

{% note warning %}

[Убедитесь](../../../quota-manager/operations/read-quotas.md), что в целевом облаке не израсходованы квоты:

* **{{ ui-key.yacloud_billing.iam.cloud.quotas.label_quota-name-iam.serviceAccounts.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.subnets.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.externalStaticAddresses.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.routeTables.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.staticRoutes.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.securityGroups.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instances.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instanceMemory.size }}**

Если какая-либо квота израсходована, создайте запрос на расширение квоты и дождитесь его исполнения.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.cloud-apps.label_marketplace }}**.
  1. В поле **Поиск продуктов** введите `strongswan`, выберите **strongSwan S2S VPN** и нажмите **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. В открывшемся окне укажите:

      * **Имя** — `s2s-vpn`.
      * **Сервисный аккаунт** — `s2s-vpn-sa`.
      * **Сеть VPC** — `s2s-vpn-network`.
      * **CIDR новой подсети** — `10.130.0.0/24`.
      * **Зона новой подсети** — `{{ region-id }}-b`.
      * **IP-адрес удалённого шлюза** — IP-адрес удаленного VPN-шлюза, который будет добавлен в конфигурацию strongSwan.
      * **CIDR удаленных подсетей** — список подсетей в виде перечисления CIDR через запятую, которые будут автоматически добавлены в таблицу маршрутизации.
      * **Ключ SSH** — содержимое открытого SSH-ключа, созданного [ранее](#create-ssh-keys).
      * **IPsec IKE Proposal** — `aes128gcm16-prfsha256-ecp256`.
      * **IPsec ESP Proposal** — `aes128gcm16`.
      * **IPsec PSK** — ключ IPsec Pre-Shared Key (PSK), который будет указан в конфигурации strongSwan.

  1. Нажмите **Установить** и дождитесь завершения установки.

{% endlist %}


### Привяжите таблицу маршрутизации {#bind-table}

Чтобы трафик между облачной и удаленной сетями направлялся через VPN-туннель, свяжите таблицу маршрутизации и подсеть.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. В строке автоматически созданной подсети `ipsec-sgw-...` нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}** и выберите автоматически созданную таблицу `ipsec-sgw-...`.
  1. Нажмите **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc vpc subnet update <имя_автоматически_созданной_подсети> \
    --route-table-name=<имя_автоматически_созданной_таблицы>
  ```

  Результат:

  ```text
  id: e9b6n3jj3gh6********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:24:58Z"
  name: ipsec-sgw-{{ region-id }}-b
  network_id: enppoggov6ub********
  zone_id: {{ region-id }}-b
  v4_cidr_blocks:
    - 10.1.0.0/16
  route_table_id: enp4v8foko6s********
  dhcp_options: {}
  ```

- API {#api}

  Чтобы привязать таблицу маршрутизации к подсети, воспользуйтесь методом REST API [update](../../../vpc/api-ref/Subnet/update.md) для ресурса [Subnet](../../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Update](../../../vpc/api-ref/grpc/Subnet/update.md).

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}


### Настройте виртуальную машину {#configure-vm}

После установки приложения выполните финальную настройку IPsec-шлюза на ВМ.

1. [Подключитесь](../../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) к ВМ по SSH. Для этого используйте логин `admin` и закрытый SSH-ключ [созданный ранее](#create-ssh-keys).
1. Получите права администратора:

    ```bash
    sudo su
    ```

1. Перейдите в домашнюю папку администратора и запустите скрипт:

    ```bash
    cd /root
    ./update.sh
    ```

    В папке `/root` будут созданы текстовые файлы `ipsec-*.txt`, которые могут быть использованы как пример для настройки подключения на удаленном эндпоинте.

    {% note tip %}

    В случае совпадения IP-диапазонов в {{ yandex-cloud }} и удаленной сети может потребоваться использование Source NAT. Для этого выполните команду:

    ```bash
    iptables \
      -t nat \
      -A POSTROUTING \
      -s <локальная_подсеть> \
      -d <удаленная_подсеть> \
      -j SNAT \
      --to-source <новый_адрес>
    ```

    {% endnote %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* Удалите приложение strongSwan S2S VPN:

    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
    1. В строке с приложением нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

        Вместе с приложением удалятся все связанные с ним ресурсы.

* [Удалите](../../../vpc/operations/delete-route-table.md) таблицу маршрутизации.
* [Удалите](../../../iam/operations/sa/delete.md) сервисный аккаунт.
* [Удалите](../../../vpc/operations/address-delete.md) статический публичный IP-адрес.
* [Удалите](../../../vpc/operations/network-delete.md) облачную сеть.