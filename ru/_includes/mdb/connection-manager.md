## Управление параметрами подключения к базе данных с {{ connection-manager-name }} {#connection-manager}

Если вашему облаку или каталогу предоставлен доступ к Public Preview сервиса [{{ connection-manager-name }}](../../metadata-hub/concepts), то после создания кластера в вашем каталоге появится новая сущность — [_подключение_](../../metadata-hub/concepts/connection-manager.md) для управления параметрами подключения к базам данных. 

Пароли и другая чувствительная информация будет храниться в [_секрете_ {{ lockbox-name }}](../../metadata-hub/concepts/secret.md). Чтобы посмотреть, какие секреты хранят информацию о подключениях вашего кластера, выберите в вашем каталоге в списке сервисов **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**. На странице **{{ ui-key.yacloud.lockbox.label_section-secrets }}** в колонке зависимостей секретов будет указан идентификатор вашего кластера. 

Вы также можете [настраивать доступ к подключениям в {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md). 
