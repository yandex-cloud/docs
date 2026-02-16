{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать приватное соединение.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и выберите нужный виртуальный сегмент сети.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_add-vrf-interconnect }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-select-type }}** выберите вариант `{{ ui-key.yacloud.baremetal.field_interconnect-direct-id }}` и в поле **{{ ui-key.yacloud.baremetal.label_vrf-interconnect-direct-type }}** вставьте идентификатор приватного соединения `Routing Instance`.

          Вы также можете выбрать вариант `{{ ui-key.yacloud.baremetal.field_interconnect-from-folder }}`. В этом случае в появившемся списке выберите нужный `Routing Instance`.

          В результате в форме отобразятся CIDR подсетей {{ vpc-name }}, которые будут [анонсироваться](../../interconnect/concepts/priv-con.md#prc-announce) в {{ interconnect-name }}.

          {% include [no-subnet-overlapping-warn](../../_tutorials/_tutorials_includes/bm-vrf-and-vpc-interconnect/no-subnet-overlapping-warn.md) %}
      1. Чтобы создать приватное соединение с указанными CIDR подсетей, нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

  В результате на странице с информацией о VRF в блоке **{{ ui-key.yacloud.baremetal.title_vrf-interconnect-section }}** отобразится идентификатор созданного соединения и его статус.

- API {#api}

  Чтобы создать приватное соединение с облачными сетями, воспользуйтесь методом REST API [PrivateCloudConnection.Create](../../baremetal/api-ref/PrivateCloudConnection/create.md) или вызовом gRPC API [PrivateCloudConnectionService/Create](../../baremetal/api-ref/grpc/PrivateCloudConnection/create.md).

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
  * `vrfId` — идентификатор VRF, который подключается к Routing Instance. Чтобы получить идентификатор VRF, воспользуйтесь методом [VrfService.List](../../baremetal/api-ref/Vrf/list.md).

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