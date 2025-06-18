Подключениями к БД кластера управляет сервис {{ connection-manager-name }}. Вместе с кластером автоматически создаются:

* [Подключение {{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) с информацией о соединении с БД.

* [Секрет {{ lockbox-name }}](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя — владельца БД. Хранение паролей в сервисе {{ lockbox-name }} обеспечивает их безопасность.

Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md).

Использование сервиса {{ connection-manager-name }} и секретов, созданных с его помощью, не тарифицируется.
