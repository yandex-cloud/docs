# Создать приватную подсеть

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать [приватную подсеть](../concepts/private-network.md#private-subnet).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **BareMetal**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/nodes-right.svg) **Приватные подсети**.
  1. Справа вверху нажмите кнопку **Создать подсеть**.
  1. В поле **Зона доступности** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет арендован сервер.
  1. В поле **Пул** выберите [пул](../concepts/servers.md#server-pools), из которого будет арендован сервер.
  1. В поле **Имя** укажите имя подсети. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте **Описание** подсети.
  1. (Опционально) Добавьте метки.
  1. (Опционально) Настройте маршрутизацию для взаимодействия с серверами из других [пулов](../concepts/servers.md#server-pools):

     1. Включите опцию **IP-адресация и маршрутизация**.
     1. В поле **Виртуальный сетевой сегмент (VRF)** выберите имеющийся [VRF](../concepts/private-network.md#vrf-segment) или создайте новый.
     1. В поле **CIDR** задайте [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.
     1. В поле **Шлюз по умолчанию** задайте IP-адрес шлюза, через который трафик из подсети будет идти в другие подсети, подключенные к VRF.
     
         По умолчанию — это первый адрес из заданного CIDR диапазона подсети.

     1. (Опционально) Включите опцию **Назначение IP-адресов по DHCP**, чтобы подключенные к приватной подсети сетевые интерфейсы серверов получали IP-адреса по DHCP.
     1. Если вы включили опцию **Назначение IP-адресов по DHCP**, задайте диапазон адресов, из которого сетевым интерфейсам серверов могут назначаться IP-адреса.
     
         По умолчанию соответствует диапазону, заданному CIDR подсети.

  1. Нажмите кнопку **Создать подсеть**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для создания [приватной подсети](../concepts/private-network.md#private-subnet):

     ```bash
     yc baremetal private-subnet create --help
     ```
  
  1. Создайте подсеть:
     
     ```bash
     yc baremetal private-subnet create \
       --hardware-pool-id <пул> \
       --name <имя_приватной_подсети> \
       --description "<описание_приватной_подсети>" \
       --labels <ключ>=<значение> \
       --vrf-options "vrf-id=<идентификатор_VRF>,vrf-name=<имя_VRF>,cidr=<CIDR>,gateway-ip=<IP-адрес_шлюза>,dhcp=[start-ip=<начало_диапазона_IP-адресов>,end-ip=<конец_диапазона_IP-адресов>]"
     ```

     Где:
     * `--hardware-pool-id` — [пул](../concepts/servers.md#server-pools), из которого будет арендован сервер.
     * `--name` — имя подсети. Требования к имени:
       
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
       
     * `--description` — описание подсети. Необязательный параметр.
     * `--labels` — метки подсети. Необязательный параметр.
     * `--vrf-options` — настройки маршрутизации для взаимодействия с серверами из других пулов. Необязательный параметр. Возможные настройки:
       * `vrf-id` — идентификатор [виртуального сегмента сети (VRF)](../concepts/private-network.md#vrf-segment).
       * `vrf-name` — имя VRF.
       * `cidr` — [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.
       * `gateway-ip` — IP-адрес шлюза, через который трафик из подсети будет идти в другие подсети, подключенные к VRF. Необязательный параметр.
     
         По умолчанию — это первый адрес из заданного CIDR диапазона подсети.

       * `dhcp` — диапазон адресов, из которого сетевым интерфейсам серверов могут назначаться IP-адреса по DHCP. Необязательный параметр.
     
         По умолчанию соответствует диапазону, заданному CIDR подсети.

- API {#api}

  Чтобы создать приватную подсеть, воспользуйтесь методом REST API [create](../api-ref/PrivateSubnet/create.md) для ресурса [PrivateSubnet](../api-ref/PrivateSubnet/index.md) или вызовом gRPC API [PrivateSubnetService/Create](../api-ref/grpc/PrivateSubnet/create.md).

{% endlist %}

## Пример {#examples}

Создайте приватную подсеть с VRF, CIDR, шлюзом по умолчанию и диапазоном IP-адресов:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal private-subnet create \
    --hardware-pool-id ru-central1-m3 \
    --name demo-private-subnet \
    --description "My first private subnet" \
    --labels env=test \
    --hardware-pool-id ru-central1-m3 \
    --vrf-options "vrf-id=ly5j5qluq32z********,cidr=10.0.0.0/8,gateway-ip=10.0.0.1,dhcp=[start-ip=10.0.1.2,end-ip=10.0.1.10]"
  ```

  Результат:  
  
  ```text
  id: ly5p3zynykcg********
  cloud_id: b1gia87mbaom********
  folder_id: b1gcqo0asnc1********
  name: demo-private-subnet
  description: My first private subnet
  status: READY
  zone_id: ru-central1-m
  hardware_pool_id: ru-central1-m3
  vrf_options:
    vrf_id: ly5j5qluq32z********
    cidr: 10.0.0.0/8
    dhcp_options:
      start_ip: 10.0.1.2
      end_ip: 10.0.1.10
    gateway_ip: 10.0.0.1
  created_at: "2025-06-26T13:28:29.348159Z"
  labels:
    env: test
  ```

- API {#api}

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
      "folderId": "b1g07hj5r6i4********",
      "hardwarePoolId": "ru-central1-m3",
      "name": "demo-private-subnet",
      "description": "My first private subnet",
      "labels": {
        "env": "test"
      },
      "vrfOptionsSpec": {
        "vrfId": "ly5uyq2gbxu2********",
        "cidr": "10.0.*.*/8",
        "dhcpOptions": {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
        "gatewayIp": "10.0.*.*"
      }
    }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/privateSubnets"
  ```

  Где:

  * `<IAM-токен>` — IAM-токен для аутентификации.
  * `folderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
  * `hardwarePoolId` — идентификатор [пула](../concepts/servers.md#server-pools), из которого будет арендован сервер.
  * `name` — имя подсети. Требования к имени:
    
    * длина — от 3 до 63 символов;
    * может содержать строчные буквы латинского алфавита, цифры и дефисы;
    * первый символ — буква, последний — не дефис.
    
  * `description` — описание подсети. Необязательный параметр.
  * `labels` — метки подсети. Необязательный параметр.
  * `vrfId` — идентификатор [виртуального сегмента сети (VRF)](../concepts/private-network.md#vrf-segment).
  * `cidr` — [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети.
  * `gatewayIp` — IP-адрес шлюза. Необязательный параметр.
  * `startIp`, `endIp` — диапазон адресов для DHCP. Необязательный параметр.

  Результат:

  ```bash
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.CreatePrivateSubnetMetadata",
      "privateSubnetId": "ly52xefxa2hi********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.PrivateSubnet",
      "vrfOptions": {
        "dhcpOptions":
        {
          "startIp": "10.0.*.*",
          "endIp": "10.0.*.*"
        },
        "vrfId": "ly5licxve4z3********",
        "cidr": "10.0.*.*/8",
        "gatewayIp": "10.0.*.*"
      },
      "labels": {
        "env": "test"
      },
      "id": "ly52xefxa2hi********",
      "cloudId": "b1gia87mbaom********",
      "folderId": "b1g07hj5r6i4********",
      "name": "demo-private-subnet",
      "description": "My first private subnet",
      "status": "READY",
      "zoneId": "ru-central1-m",
      "hardwarePoolId": "ru-central1-m3",
      "createdAt": "2025-12-14T14:42:58.372557Z"
    },
    "id": "ly5hcnsbx3l4********",
    "description": "Private subnet create",
    "createdAt": "2025-12-14T14:42:58.375290Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-14T14:42:58.375290Z"
  }
  ```

  Отслеживайте статус операции по полю `done`.

{% endlist %}