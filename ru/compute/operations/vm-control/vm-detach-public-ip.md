# Отвязать от виртуальной машины публичный IP-адрес

Если ранее вы привязали к виртуальной машине публичный адрес, вы можете отвязать его.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Выберите виртуальную машину.
  1. В блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}** в правом верхнем углу нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.popup-confirm_button_remove-one-to-one-nat }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы отвязать публичный IP-адрес от ВМ, выполните команду CLI:

  ```bash
  yc compute instance remove-one-to-one-nat
    --id=<идентификатор_ВМ>
    --network-interface-index=<индекс_сетевого_интерфейса_ВМ>
  ```

  Где:

  * `id` — идентификатор (ID) ВМ. Получите список идентификаторов ВМ, доступных в каталоге, с помощью [команды CLI](../../../cli/cli-ref/managed-services/compute/instance/list.md) `yc compute instance list`.
  * `network-interface-index` — индекс сетевого интерфейса ВМ. По умолчанию — `0`.

  Подробнее о команде `yc compute instance remove-one-to-one-nat` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/remove-one-to-one-nat.md).

- API

  Воспользуйтесь методом REST API [removeOneToOneNat](../../api-ref/Instance/removeOneToOneNat.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/RemoveOneToOneNat](../../api-ref/grpc/instance_service.md#RemoveOneToOneNat).

{% endlist %}