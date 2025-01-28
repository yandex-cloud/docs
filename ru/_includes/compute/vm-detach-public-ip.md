{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Выберите виртуальную машину.
  1. В открывшемся окне в секции **{{ ui-key.yacloud.compute.instance.overview.section_network }}** в правом верхнем углу блока нужного сетевого интерфейса нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_remove-public-ip }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instance.overview.popup-confirm_button_remove-one-to-one-nat }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы отвязать публичный IP-адрес от ВМ, выполните команду CLI:

  ```bash
  yc compute instance remove-one-to-one-nat
    --id=<идентификатор_ВМ>
    --network-interface-index=<номер_сетевого_интерфейса_ВМ>
  ```

  Где:

  * `--id` — идентификатор (ID) ВМ. Получите список идентификаторов ВМ, доступных в каталоге, с помощью [команды CLI](../../cli/cli-ref/compute/cli-ref/instance/list.md) `yc compute instance list`.
  * `--network-interface-index` — номер сетевого интерфейса ВМ. По умолчанию — `0`. Чтобы получить список сетевых интерфейсов ВМ и их номера, выполните команду `yc compute instance get <идентификатор_ВМ>`.

  Подробнее о команде `yc compute instance remove-one-to-one-nat` см. в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/remove-one-to-one-nat.md).

- API {#api}

  Воспользуйтесь методом REST API [removeOneToOneNat](../../compute/api-ref/Instance/removeOneToOneNat.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/RemoveOneToOneNat](../../compute/api-ref/grpc/Instance/removeOneToOneNat.md).

{% endlist %}