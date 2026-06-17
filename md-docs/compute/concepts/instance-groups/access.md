# Доступ

По умолчанию все операции в Instance Groups выполняются от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

Сервисный аккаунт — это специальная учетная запись, которая может использоваться службами и приложениями для взаимодействия с другими [API](../../../glossary/rest-api.md) Yandex Cloud от вашего имени. Подробнее про сервисные аккаунты и управление доступом в Yandex Cloud читайте в документации сервиса [Yandex Identity and Access Management](../../../iam/index.md).

Instance Groups используют [авторизованные ключи](../../../iam/concepts/authorization/key.md) сервисного аккаунта для аутентификации в наборе API и выполняют операции с ресурсами в пределах ролей, предоставленных сервисному аккаунту. Например, Instance Groups использует сервисный аккаунт для создания, обновления и удаления виртуальных машин.

Группа ВМ может иметь только один сервисный аккаунт, созданный в том же каталоге, что и группа.

Чтобы сервисный аккаунт имел возможность создавать, изменять, запускать, перезапускать, останавливать и удалять ВМ в группе, [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль [compute.editor](../../security/index.md#compute-editor) на каталог, в котором вы хотите разместить группу ВМ.

Если вы хотите интегрировать группу ВМ с сетевым балансировщиком [Yandex Network Load Balancer](../../../network-load-balancer/index.md), дополнительно назначьте сервисному аккаунту роль [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor).

Чтобы интегрировать группу ВМ с L7-балансировщиком [Yandex Application Load Balancer](../../../application-load-balancer/index.md), назначьте сервисному аккаунту роль [alb.editor](../../../application-load-balancer/security/index.md#alb-editor).

Подробнее см. на странице [Интеграция группы ВМ с Network Load Balancer или Application Load Balancer](balancers.md).

{% note info %}

Сервисный аккаунт, от имени которого управляется группа ВМ, нельзя удалить, пока он связан с группой. Сначала [измените](../../operations/instance-groups/update.md) сервисный аккаунт в настройках группы ВМ или [удалите](../../operations/instance-groups/delete.md) группу ВМ, а потом удалите сервисный аккаунт.

{% endnote %}

## Примеры использования {#examples}

* [Работа с группой виртуальных машин с автоматическим масштабированием](../../tutorials/vm-autoscale/index.md)

#### Полезные ссылки {#see-also}

- [Создание группы виртуальных машин](../../quickstart/ig.md).
- [Создание сервисного аккаунта](../../../iam/operations/sa/create.md).
- [Создать группу виртуальных машин фиксированного размера с сетевым балансировщиком нагрузки](../../operations/instance-groups/create-with-balancer.md).
- [Создать группу виртуальных машин фиксированного размера с L7-балансировщиком](../../operations/instance-groups/create-with-load-balancer.md).