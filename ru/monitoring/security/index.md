# Управление доступом

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ monitoring-full-name }}, назначьте пользователю нужные роли из приведенного ниже списка. 

На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Роли {#roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ monitoring-full-name }}.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-monitoring-viewer }} {#monitoring-viewer}

Пользователь с ролью `{{ roles-monitoring-viewer }}` может просматривать созданные дашборды и виджеты, а также загруженные метрики.

### {{ roles-monitoring-editor }} {#monitoring-editor}

Пользователь с ролью `{{ roles-monitoring-editor }}` может создавать дашборды и виджеты, загружать метрики и управлять алертами.

Помимо этого роль `{{ roles-monitoring-editor }}` включает в себя все разрешения роли `{{ roles-monitoring-viewer }}`.

### {{ roles-monitoring-admin }} {#monitoring-admin}

Пользователь с ролью `{{ roles-monitoring-admin }}` может создавать дашборды и виджеты, загружать метрики и управлять алертами.

Помимо этого роль `{{ roles-monitoring-admin }}` включает в себя все разрешения роли `{{ roles-monitoring-editor }}`.
