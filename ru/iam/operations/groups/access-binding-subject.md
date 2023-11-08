# Назначение прав группе пользователей

Выдайте [группе](../../../organization/operations/manage-groups.md) права на доступ к какому-либо ресурсу. Чтобы дать [субъекту](../../concepts/access-control/index.md#subject) права на доступ к группе, воспользуйтесь инструкцией [{#T}](access-binding-object.md).

Управление [доступом](../../concepts/access-control/index.md#how-do-i-perform-access-management) в {{ yandex-cloud }} построено на основе ролей.

В консоли управления группе можно назначить роль на облако, каталог или сервисный аккаунт. В сервисе {{ org-full-name }} группе можно назначить роль только на другую группу. Чтобы назначить группе роль на организацию, используйте CLI.

## Назначить роль на облако или каталог {#access-binding-cloud}

{% include [accessbinding-group-as-object](../../../_includes/organization/accessbinding-group-as-subject.md) %}

## Назначить роль на Организацию {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../../_includes/organization/accessbinding-group-as-subject-org.md) %}
