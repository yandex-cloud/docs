# Имперсонация в {{ mtr-name }}

_Имперсонацией_ в {{ mtr-name }} называется выполнение кластером {{ TR }} действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер {{ TR }} не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ TR }} при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md#change-sa) кластера. После этого [координатор](index.md#coordinator) и [воркеры](index.md#workers) смогут аутентифицироваться от имени сервисного аккаунта. Например, аутентификация в хранилище {{ objstorage-name }} для [коннекторов](index.md#connector) Hive, Iceberg и Delta Lake выполняется от имени сервисного аккаунта кластера.

Благодаря имперсонации кластер {{ TR }} поддерживает интеграцию с другими сервисами {{ yandex-cloud }}. Среди них [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ monitoring-full-name }}](../../monitoring/concepts/index.md) и [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту [роль](../security.md#managed-trino-integrationProvider) `managed-trino.integrationProvider`. Она позволяет кластеру записывать логи в {{ cloud-logging-name }} или поставлять метрики в {{ monitoring-name }}. Для использования подключений из {{ connection-manager-name }} и их [секретов](../../metadata-hub/concepts/secret.md) дополнительно назначьте сервисному аккаунту кластера роли `connection-manager.user` и `lockbox.payloadViewer`.

## Доступные для интеграции сервисы {#services}

### {{ connection-manager-name }} {#connection-manager-integration}

{{ connection-manager-name }} — это сервис управления параметрами подключений к пользовательским инсталляциям баз данных с безопасным хранением паролей к ним. Если в [каталоге](index.md#catalog) кластера {{ mtr-name }} указан тип подключения **Connection Manager**, сервисный аккаунт кластера получает параметры подключения (сетевые адреса, порты, зашифрованные имя и пароль пользователя) по его идентификатору в {{ connection-manager-name }}.

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} — это сервис для хранения и чтения логов сервисов {{ yandex-cloud }}. Если в кластере {{ mtr-name }} включено логирование, логи кластера сохраняются в [лог-группу по умолчанию](../../logging/concepts/log-group.md) выбранного каталога или в пользовательскую лог-группу {{ cloud-logging-name }}.

Включить логирование можно при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md#change-additional-settings) кластера.

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} — это сервис для сбора и хранения метрик сервисов {{ yandex-cloud }}. Метрики отображаются в виде графиков на странице кластера в разделе **{{ ui-key.yacloud.common.monitoring }}**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах {{ mtr-name }}. Список доступных метрик приведен в их [справочнике](../metrics.md).
