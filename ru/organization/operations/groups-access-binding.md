# Назначить роль группе пользователей

Назначьте [группе пользователей](../../organization/operations/manage-groups.md) роль, чтобы предоставить доступ к какому-либо ресурсу. Воспользуйтесь инструкцией [{#T}](../../iam/operations/groups/access-binding-object.md), чтобы дать [субъекту](../../iam/concepts/access-control/index.md#subject) права на доступ к группе.

В сервисе {{ org-full-name }} группе можно назначить роль на организацию, облако, каталог, другую группу или сервисный аккаунт.

## Назначить роль на облако или каталог {#access-binding-cloud}

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

## Назначить роль на организацию {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}

#### См. также {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
