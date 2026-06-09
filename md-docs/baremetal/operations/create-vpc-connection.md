# Создать приватное соединение с облачными сетями

С помощью [Yandex Cloud Interconnect](../../interconnect/index.md) вы можете создать [приватное соединение](../concepts/private-network.md#private-connection-to-vpc) между [подсетями](../concepts/private-network.md#private-subnet) BareMetal и [подсетями](../../vpc/concepts/network.md#subnet) Yandex Virtual Private Cloud.

{% note info %}

Прежде чем создавать приватное соединение, убедитесь, что в вашем каталоге есть [VRF](../concepts/private-network.md#vrf-segment) c одной или более маршрутизируемыми подсетями в BareMetal, а также Routing Instance, в составе которого [анонсированы](../../interconnect/concepts/priv-con.md#prc-announce) один или несколько префиксов приватных подсетей VPC. [Заказать](../tutorials/bm-vrf-and-vpc-interconnect.md#request-ri) Routing Instance вы можете через [обращение](https://center.yandex.cloud/support/tickets/create) в службу технической поддержки.

{% endnote %}

Чтобы создать приватное соединение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. Перейдите в сервис **BareMetal**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **VRF** и выберите нужный виртуальный сегмент сети.
  1. В блоке **Приватное соединение с облачными сетями** нажмите кнопку **Настроить соединение** и в открывшемся окне:

      1. В поле **Способ настройки** выберите вариант `Указать идентификатор` и в поле **Идентификатор соединения** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `Выбрать из каталога`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей Virtual Private Cloud, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в Cloud Interconnect.

          {% note warning %}
          
          Для успешной настройки сетевой связности между подсетями BareMetal и подсетями VPC/on-prem, их диапазоны адресов, заданные CIDR, не должны совпадать или пересекаться.
          
          {% endnote %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **Сохранить**.

  В результате на странице с информацией о VRF в блоке **Приватное соединение с облачными сетями** отобразится идентификатор созданного соединения и его статус.

- API {#api}

  Чтобы создать приватное соединение с облачными сетями, воспользуйтесь методом REST API [PrivateCloudConnection.Create](../api-ref/PrivateCloudConnection/create.md) или вызовом gRPC API [PrivateCloudConnectionService/Create](../api-ref/grpc/PrivateCloudConnection/create.md).

  Выполните запрос:

  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '{
      "routingInstanceId":"fokrf2in3c7********",
      "vrfId":"ly5uyq2gbxu2********"
      }' \
    "https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/privateCloudConnections"
  ```

  Где:

  * `routingInstanceId` — идентификатор [Routing Instance](../../cloud-router/concepts/routing-instance.md) в Cloud Router.
  * `vrfId` — идентификатор VRF, который подключается к Routing Instance. Чтобы получить идентификатор VRF, воспользуйтесь методом [VrfService.List](../api-ref/Vrf/list.md).

  Результат:

  ```json
  {
    "done": false,
    "id": "arpas4mne3********",
    "description": "Create private cloud connection",
    "createdAt": "2024-01-01T12:00:00Z",
    "createdBy": "user-id",
    "modifiedAt": "2024-01-01T12:00:00Z",
    "metadata": {
      "privateCloudConnectionId": "kor4msi1aqq********"
    }
  }
  ```

  Операция создания приватного соединения выполняется асинхронно. Отслеживайте статус операции по полю `done`.

{% endlist %}

{% note info %}

Создание приватного соединения может занять до двух рабочих дней — в это время соединение будет находиться в статусе `Creating`. После создания статус соединения изменится на `Ready`.

{% endnote %}

Приватное соединение c облачными сетями может находиться в одном из следующих статусов:

* `CREATING` — соединение создается.
* `READY` — соединение сконфигурировано и готово к работе.
* `ERROR` — возникла проблема с приватным соединением, для устранения необходимо обратиться в поддержку.
* `DELETING` — соединение удаляется.
* `UPDATING` — настройки приватного соединения обновляются.