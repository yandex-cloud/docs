# Создать приватное соединение с облачными сетями

С помощью [{{ interconnect-full-name }}](../../interconnect/index.md) вы можете создать [приватное соединение](../concepts/private-network.md#private-connection-to-vpc) между [подсетями](../concepts/private-network.md#private-subnet) {{ baremetal-name }} и [подсетями](../../vpc/concepts/network.md#subnet) {{ vpc-full-name }}.

{% note info %}

Прежде чем создавать приватное соединение, убедитесь, что в вашем каталоге есть [VRF](../concepts/private-network.md#vrf-segment) c одной или более маршрутизируемыми подсетями в {{ baremetal-name }}, а также Routing Instance, в составе которого [анонсированы](../../interconnect/concepts/priv-con.md#prc-announce) один или несколько префиксов приватных подсетей {{ vpc-short-name }}. [Заказать](../tutorials/bm-vrf-and-vpc-interconnect.md#request-ri) Routing Instance вы можете через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.

{% endnote %}

Чтобы создать приватное соединение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks_kHgng }}** и выберите нужный виртуальный сегмент сети.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_interconnect-direct-id }}` и в поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-direct-type }}** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей {{ vpc-name }}, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в {{ interconnect-name }}.

          {% note warning %}
          
          Для успешной настройки сетевой связности между подсетями {{ baremetal-name }} и подсетями {{ vpc-short-name }}/on-prem, их диапазоны адресов, заданные CIDR, не должны совпадать или пересекаться.
          
          {% endnote %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  В результате на странице с информацией о VRF в блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** отобразится идентификатор созданного соединения и его статус.

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

  * `routingInstanceId` — идентификатор [Routing Instance](../../cloud-router/concepts/routing-instance.md) в {{ cr-name }}.
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