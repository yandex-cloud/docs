# Возобновление процессов в группе виртуальных машин

При возобновлении будут запущены ранее остановленные процессы [обновления](../../concepts/instance-groups/deploy/), [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ, а также применены существенные изменения группы, связанные с приостановленными процессами (например, изменение размера группы или конфигурации ВМ).

Чтобы возобновить процессы в группе ВМ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.compute.groups.button_action-resume }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- API {#api}

  Воспользуйтесь методом REST API [resumeProcesses](../../instancegroup/api-ref/InstanceGroup/resumeProcesses.md) для ресурса [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/ResumeProcesses](../../instancegroup/api-ref/grpc/InstanceGroup/resumeProcesses.md).

{% endlist %}