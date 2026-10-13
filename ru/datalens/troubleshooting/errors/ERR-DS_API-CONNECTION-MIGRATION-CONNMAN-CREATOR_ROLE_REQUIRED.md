---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.CREATOR_ROLE_REQUIRED
description: На странице приведено описание ошибки {{ datalens-full-name }} Недостаточно прав для создания подключения.
---

# [{{ datalens-full-name }}] Недостаточно прав для создания подключения

`ERR.DS_API.CONNECTION.MIGRATION.CONNMAN.CREATOR_ROLE_REQUIRED`

Недостаточно прав для создания подключения. Чтобы мигрировать подключение, {{ datalens-name }} создает подключение {{ connection-manager-name }} в каталоге кластера от вашего имени — для этого нужна роль `connection_manager.editor` в этом каталоге.

Чтобы исправить ошибку, запросите [роль]({{ link-docs }}/metadata-hub/security/connection-manager-roles#connection-manager-user) `connection_manager.editor` в каталоге кластера у администратора и повторите миграцию.
