# Приостановка процессов в группе виртуальных машин

Если вы временно хотите отключить процессы [обновления](../../concepts/instance-groups/deploy/index.md), [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ в группе, приостановите их. Сами ВМ при этом продолжат работу.

{% note info %}

Нельзя приостановить процессы в группе ВМ, которая находится в процессе удаления. Также нельзя запускать любые операции для групп с приостановленными процессами.

{% endnote %}

Чтобы приостановить процессы в группе ВМ:
 
{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) откройте каталог, в котором находится нужная группа ВМ.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **Группы виртуальных машин**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Приостановить процессы**.
  1. В открывшемся окне нажмите кнопку **Приостановить**.

- API {#api}

  Воспользуйтесь методом REST API [pauseProcesses](../../instancegroup/api-ref/InstanceGroup/pauseProcesses.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/PauseProcesses](../../instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses.md).

{% endlist %}