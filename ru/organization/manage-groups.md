# Управление группами пользователей

Для организаций, в которых много участников, одинаковые права доступа к ресурсам {{ yandex-cloud }} могут потребоваться сразу нескольким пользователям. В этом случае роли и доступы удобнее выдавать не персонально, а для группы.

Вы можете группировать пользователей по любому признаку: например, в соответствии с их должностными обязанностями или отделом.

{% note info %}

Группы поддерживают только одноуровневую структуру.

Для групп установлены ограничения по умолчанию:
* количество групп в организации — 100;
* количество членов в группе — 1000;
* количество групп, в которых может состоять пользователь — 1000.

Для увеличения квот обратитесь в [техническую поддержку]({{ link-console-support }}).

{% endnote %}

## Создать группу {#create-group}

{% include [create-group-org](../_includes/organization/create-group-org.md) %}

## Добавить участников {#add-member}

{% include [group-add-member.md](../_includes/organization/group-add-member.md) %}

## Редактировать группу {#edit-group}

{% include [group-edit](../_includes/organization/group-edit.md) %}

## Настроить доступ к управлению группой {#access-manage-group}

Измените права [субъекта](../iam/concepts/access-control/index.md#subject) на доступ к группе как к ресурсу.

### Назначить роль {#set-access-binding}

{% include [accessbinding-group-as-object](../_includes/organization/accessbinding-group-as-object.md) %}

### Отозвать роль {#remove-access-binding}

{% include [accessbinding-remove](../_includes/organization/accessbinding-remove.md) %}

## Настроить доступ группы к работе в {{ yandex-cloud }} {#access}

Чтобы участники группы могли работать с сервисами {{ yandex-cloud }}, назначьте группе соответствующие [роли](../iam/concepts/access-control/roles.md).

### Назначить роль на отдельный ресурс {#access-services}

В консоли управления можно назначить роль на облако, каталог или сервисный аккаунт.

Чтобы выдать доступ группе на ресурс:

{% include [accessbinding-group-as-subject](../_includes/organization/accessbinding-group-as-subject.md) %}

### Назначить роль на всю организацию {#access-organization}

Роль, которая выдана на всю организацию, позволяет участникам группы управлять всеми ресурсами {{ yandex-cloud }}, которые подключены к организации, в соответствии с правами роли.

{% list tabs %}

- CLI

    {% include [accessbinding-group-as-subject-org](../_includes/organization/accessbinding-group-as-subject-org.md) %}

{% endlist %}