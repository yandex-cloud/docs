# Возобновление процессов в группе виртуальных машин

При возобновлении будут запущены ранее остановленные процессы [обновления](../../concepts/instance-groups/deploy/), [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/policies/scale-policy.md) ВМ, а также применены существенные изменения группы, связанные с приостановленными процессами (например, изменение размера группы или конфигурации ВМ).

Чтобы возобновить процессы в группе ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) откройте каталог, в котором находится нужная группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. В строке с нужной группой ВМ нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.compute.groups.button_action-resume }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- API

  Воспользуйтесь методом REST API [resumeProcesses](../../api-ref/InstanceGroup/resumeProcesses.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/index.md) или вызовом gRPC API [InstanceGroupService/ResumeProcesses](../../api-ref/grpc/instance_group_service.md#ResumeProcesses).

{% endlist %}