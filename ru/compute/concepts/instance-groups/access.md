# Доступ

По умолчанию все операции в {{ ig-name }} выполняются от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

Сервисный аккаунт — это специальная учетная запись, которая может использоваться службами и приложениями для взаимодействия с другими [API](../../../glossary/rest-api.md) {{ yandex-cloud }} от вашего имени. Подробнее про сервисные аккаунты и управление доступом в {{ yandex-cloud }} читайте в документации сервиса [{{ iam-full-name }}](../../../iam/).

{{ ig-name }} используют [авторизованные ключи](../../../iam/concepts/authorization/key.md) сервисного аккаунта для авторизации в наборе API и выполняют операции с ресурсами в пределах ролей, предоставленных сервисному аккаунту. Например, {{ ig-name }} использует сервисный аккаунт для создания, обновления и удаления виртуальных машин.

Группа ВМ может иметь только один сервисный аккаунт, созданный в том же каталоге, что и группа.

Чтобы сервисный аккаунт имел возможность создавать, изменять, запускать, перезапускать, останавливать и удалять ВМ в группе, [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль [compute.editor](../../security/index.md#compute-editor) на каталог, в котором вы хотите разместить группу ВМ.

Если вы хотите интегрировать группу ВМ с сетевым балансировщиком [{{ network-load-balancer-full-name }}](../../../network-load-balancer/), дополнительно назначьте сервисному аккаунту роль [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor).

Чтобы интегрировать группу ВМ с L7-балансировщиком [{{ alb-full-name }}](../../../application-load-balancer/), назначьте сервисному аккаунту роль [alb.editor](../../../application-load-balancer/security/index.md#alb-editor).

Подробнее см. на странице [{#T}](balancers.md).

{% note info %}

{% include [sa-dependence](../../../_includes/instance-groups/sa-dependence.md) %}

{% endnote %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/vm-autoscale/index.md)

#### См. также {#see-also}

- [{#T}](../../quickstart/ig.md).
- [{#T}](../../../iam/operations/sa/create.md).
- [{#T}](../../operations/instance-groups/create-with-balancer.md).
- [{#T}](../../operations/instance-groups/create-with-load-balancer.md).