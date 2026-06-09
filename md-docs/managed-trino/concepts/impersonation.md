# Имперсонация в Managed Service for Trino

_Имперсонацией_ в Managed Service for Trino называется выполнение кластером Trino действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер Trino не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру Trino при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md#change-sa) кластера. После этого [координатор](index.md#coordinator) и [воркеры](index.md#workers) смогут аутентифицироваться от имени сервисного аккаунта. Например, аутентификация в хранилище Object Storage для [коннекторов](index.md#connector) Hive, Iceberg и Delta Lake выполняется от имени сервисного аккаунта кластера.

Благодаря имперсонации кластер Trino поддерживает интеграцию с другими сервисами Yandex Cloud. Среди них [Yandex Cloud Logging](../../logging/index.md), [Yandex Monitoring](../../monitoring/concepts/index.md) и [Yandex Connection Manager](../../metadata-hub/concepts/connection-manager.md).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту [роль](../security.md#managed-trino-integrationProvider) `managed-trino.integrationProvider`. Она позволяет кластеру записывать логи в Cloud Logging или поставлять метрики в Monitoring. Для использования подключений из Connection Manager и их [секретов](../../metadata-hub/concepts/secret.md) дополнительно назначьте сервисному аккаунту кластера роли `connection-manager.user` и `lockbox.payloadViewer`.

## Доступные для интеграции сервисы {#services}

### Connection Manager {#connection-manager-integration}

Connection Manager — это сервис управления параметрами подключений к пользовательским инсталляциям баз данных с безопасным хранением паролей к ним. Если в [каталоге](index.md#catalog) кластера Managed Service for Trino указан тип подключения **Connection Manager**, сервисный аккаунт кластера получает параметры подключения (сетевые адреса, порты, зашифрованные имя и пароль пользователя) по его идентификатору в Connection Manager.

### Cloud Logging {#cloud-logging-integration}

Cloud Logging — это сервис для хранения и чтения логов сервисов Yandex Cloud. Если в кластере Managed Service for Trino включено логирование, логи кластера сохраняются в [лог-группу по умолчанию](../../logging/concepts/log-group.md) выбранного каталога или в пользовательскую лог-группу Cloud Logging.

Включить логирование можно при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md#change-additional-settings) кластера.

### Monitoring {#monitoring-integration}

Monitoring — это сервис для сбора и хранения метрик сервисов Yandex Cloud. Метрики отображаются в виде графиков на странице кластера в разделе **Мониторинг**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах Managed Service for Trino. Список доступных метрик приведен в их [справочнике](../metrics.md).