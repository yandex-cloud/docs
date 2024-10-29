# Сервисные роли для управления подключениями с помощью {{ connection-manager-full-name }}

С помощью сервисных ролей {{ connection-manager-full-name }} вы сможете просматривать несекретные данные подключений и управлять подключениями. Просматривать секретные данные подключений, такие как пароли доступа к БД, можно в сервисе [{{ lockbox-full-name }}](../../lockbox/index.yaml). Для этого дополнительно необходима [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.

### connection-manager.auditor {#connection-manager-auditor}

{% include [connection-manager.auditor](../../_roles/connection-manager/auditor.md) %}

### connection-manager.viewer {#connection-manager-viewer}

{% include [connection-manager.viewer](../../_roles/connection-manager/viewer.md) %}


### connection-manager.editor {#connection-manager-editor}

{% include [connection-manager.editor](../../_roles/connection-manager/editor.md) %}

### connection-manager.admin {#connection-manager-admin}

{% include [connection-manager.admin](../../_roles/connection-manager/admin.md) %}

### connection-manager.user {#connection-manager-user}

{% include [connection-manager.user](../../_roles/connection-manager/user.md) %}


## Какие роли необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

| Действие                                                      | Необходимые роли                     |
|---------------------------------------------------------------|--------------------------------------|
| Получить информацию о подключениях                            | `connection-manager.viewer`          |
| Получить список подключений                                   | `connection-manager.viewer`          | 
| Создать подключение                                           | `connection-manager.editor`          | 
| Изменить подключение                                          | `connection-manager.editor`          |
| Удалить подключение                                           | `connection-manager.editor`          |
| Установить права доступа к подключению                        | `connection-manager.admin`           |
| Изменить права доступа к подключению                          | `connection-manager.admin`           |
