# Запустить группу виртуальных машин

При запуске группы будут запущены все остановленные ВМ в группе. Вы можете запустить отдельную ВМ, например для диагностики, но для включения [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/scale.md), необходимо запустить группу целиком.

{% note warning %}

Если группа остановлена {{ yandex-cloud }} из-за блокировки за неуплату, снова запустить группу можно только после снятия блокировки.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.compute.groups.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска группы ВМ:

     ```bash
     {{ yc-compute-ig }} start --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Запустите группу ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} start first-instance-group
     ```

     {{ ig-name }} начнет запускать ВМ в группе. Когда все ВМ будут запущены, группа перейдет в статус `ACTIVE`.

- API {#api}

  Запустить группу можно с помощью метода REST API [start](../../api-ref/InstanceGroup/start.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызова gRPC API [InstanceGroupService/Start](../../api-ref/grpc/instance_group_service.md#Start).

  Список доступных групп запрашивайте методом REST API [listInstances](../../api-ref/InstanceGroup/listInstances.md) или вызовом gRPC API [InstanceGroupService/ListInstances](../../api-ref/grpc/instance_group_service.md#ListInstances).

{% endlist %}