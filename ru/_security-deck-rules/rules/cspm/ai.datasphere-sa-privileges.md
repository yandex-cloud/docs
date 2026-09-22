### У сервисных аккаунтов сервиса Yandex DataSphere должны отсутствовать критичные роли {#datasphere-sa-privileges}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | ai.datasphere-sa-privileges ||
|#

#### Описание

**Как работает правило**: проверяется, что у сервисных аккаунтов, привязанных к [сообществам](https://yandex.cloud/ru/docs/datasphere/concepts/community) или проектам Yandex DataSphere, нет ролей выше `editor`.

В DataSphere пользовательский ML-код, [задания](https://yandex.cloud/en/docs/datasphere/concepts/jobs/) и операции с DataSphere Notebook могут выполняться от имени сервисного аккаунта или [сервисного агент](https://yandex.cloud/en/docs/iam/concepts/service-control#service-agent) проекта или сообщества, поэтому для них требуется строго соблюдать принцип минимальных привилегий. Особенно опасны роли, позволяющие управлять сервисом [Yandex Identity and Access Management](https://yandex.cloud/en/docs/iam/security/#service-roles), [сервисными аккаунтами](https://yandex.cloud/en/docs/iam/security/#iam-serviceAccounts-admin), секретами, ключами шифрования, объектными хранилищами, виртуальными машинами и сетями или ИИ-ресурсами.

#### Инструкции и решения по выполнению

1. Получите список проектов и сообществ DataSphere:

   ```bash
   yc datasphere community list --format json yc datasphere project list --community-id <id> --format json 
   ```

   Если команды CLI недоступны в вашей версии, используйте REST API или выгрузку через UI: 
   
   * [Список сообществ](https://datasphere.api.cloud.yandex.net/datasphere/v2/communities)
   * [Список проектов](https://datasphere.api.cloud.yandex.net/datasphere/v2/projects?communityId=<id>)
1. Для каждого проекта или сообщества определите связанный сервисный аккаунт или агент. Если поле недоступно через CLI/API, посмотрите в [интерфейсе Datasphere](https://datasphere.yandex.cloud/communities). 
1. Проверьте выданные доступы этих сервисных аккаунтов с помощью [Модуля диагностики доступов (CIEM)](https://yandex.cloud/ru/docs/security-deck/operations/ciem/view-permissions). 
1. Актуальные роли DataSphere, которые нужно сверять со [справочником ролей](https://yandex.cloud/ru/docs/iam/roles-reference#datasphere-roles) Yandex Identity and Access Management перед запуском сканера: `datasphere.community-projects.viewer, datasphere.community-projects.developer, datasphere.community-projects.editor, datasphere.community-projects.admin, datasphere.communities.viewer, datasphere.communities.developer, datasphere.communities.editor, datasphere.communities.admin`. 
1. Если конкретная роль отсутствует в tenant или справочнике, сканер не должен прекращать задание; логируйте role not found / not applicable. 
1. Запрещенные роли для среды выполнения/сервисных аккаунтов в DataSphere без исключения: `admin, editor, resource-manager.clouds.owner, resource-manager.admin, iam.serviceAccounts.admin, iam.serviceAccounts.tokenCreator, lockbox.admin, lockbox.editor, kms.admin, kms.editor, storage.admin, compute.admin, vpc.admin, datasphere.communities.admin, datasphere.communities.editor, datasphere.community-projects.admin, datasphere.community-projects.editor, ai.admin, ai.editor, ai.models.admin, ai.models.editor`, любые ненужные `*.admin / *.editor`. 
1. Разрешайте только минимальные роли к реально используемым ресурсам, например: 
   * `storage.viewer` / upload-роли только на конкретный бакет; 
   * `lockbox.payloadViewer` только на конкретный секрет; 
   * `ai.models.user` или конкретные `ai.*.user` роли, если проект реально вызывает модели; 
   * минимальные роли на логирование и мониторинг только при необходимости.

   **Решение**: удалить широкие роли, создать отдельный сервисный аккаунт для проекта или сообщества, назначить минимальные роли на минимальном списке ресурсов, провести повторное сканирование.
