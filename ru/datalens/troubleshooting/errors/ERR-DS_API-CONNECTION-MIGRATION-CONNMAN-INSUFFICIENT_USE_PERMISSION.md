---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.INSUFFICIENT_USE_PERMISSION
description: На странице приведено описание ошибки {{ datalens-full-name }} Нет доступа к подключению {{ connection-manager-name }}.
---

# [{{ datalens-full-name }}] Нет доступа к подключению {{ connection-manager-name }}

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.INSUFFICIENT_USE_PERMISSION`

Нет доступа к подключению {{ connection-manager-name }}. Подключение для пользователя базы данных нашлось, но у вас нет прав на его использование — для этого нужна роль `connection-manager.user` в этом каталоге или напрямую на подключение.

Запросите [роль]({{ link-docs }}/metadata-hub/security/connection-manager-roles#connection-manager-user) `connection-manager.user` в этом каталоге или напрямую на подключение у администратора и повторите миграцию.
