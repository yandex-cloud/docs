# Управление доступом в {{ baremetal-full-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ baremetal-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

{% endnote %}

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа в {{ baremetal-name }} можно использовать как сервисные, так и примитивные роли.

### Сервисные роли {#service-roles}

#### baremetal.auditor {#baremetal-auditor}

{% include [baremetal-auditor](../../_roles/baremetal/auditor.md) %}

#### baremetal.viewer {#baremetal-viewer}

{% include [baremetal-viewer](../../_roles/baremetal/viewer.md) %}

#### baremetal.operator {#baremetal-operator}

{% include [baremetal-operator](../../_roles/baremetal/operator.md) %}

#### baremetal.editor {#baremetal-editor}

{% include [baremetal-editor](../../_roles/baremetal/editor.md) %}

#### baremetal.admin {#baremetal-admin}

{% include [baremetal-admin](../../_roles/baremetal/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)
