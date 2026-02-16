# Приостановка процессов в группе виртуальных машин

Если вы временно хотите отключить процессы [обновления](../../concepts/instance-groups/deploy/), [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе, приостановите их. Сами ВМ при этом продолжат работу.

{% include [stop-in-deleting-ig](../../../_includes/compute/stop-in-deleting-ig.md) %}

Чтобы приостановить процессы в группе ВМ:
 
{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.compute.groups.button_action-pause }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- API {#api}

  Воспользуйтесь методом REST API [pauseProcesses](../../instancegroup/api-ref/InstanceGroup/pauseProcesses.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/PauseProcesses](../../instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses.md).

{% endlist %}