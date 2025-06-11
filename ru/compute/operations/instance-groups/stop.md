# Остановить группу виртуальных машин

Если вам временно не нужны ВМ в группе, остановите группу. Все ВМ в группе будут остановлены. Остановка будет эффективнее удаления группы или уменьшения ее размера до нуля, если размер группы очень большой и создание такого количества ВМ займет много времени.

{% note info %}

Если вы остановите отдельную ВМ в группе, а не саму группу, то {{ ig-name }} [автоматически перезапустит](../../concepts/instance-groups/autohealing.md) ВМ.

{% endnote %}

Для остановленных ВМ тарифицируются только диски. Если вы не хотите платить за использование дисков, тогда сократите размер группы до 0, или [удалите группу](delete.md). Чтобы не потерять данные, [сделайте снимки дисков](../disk-control/create-snapshot.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.compute.groups.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_stop }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки группы ВМ:

     ```bash
     {{ yc-compute-ig }} stop --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Остановите группу ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} stop first-instance-group
     ```

     {{ ig-name }} начнет останавливать ВМ в группе. Когда все ВМ будут остановлены, группа перейдет в статус `STOPPED`.

- API {#api}

  Остановить группу можно с помощью метода REST API [stop](../../instancegroup/api-ref/InstanceGroup/stop.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Stop](../../instancegroup/api-ref/grpc/InstanceGroup/stop.md).

  Список доступных групп запрашивайте методом REST API [listInstances](../../instancegroup/api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../instancegroup/api-ref/grpc/InstanceGroup/listInstances.md).

{% endlist %}