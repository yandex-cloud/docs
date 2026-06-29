# Имперсонация в {{ mtr-name }}

_Имперсонацией_ в {{ mtr-name }} называется выполнение кластером {{ TR }} действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер {{ TR }} не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ TR }} при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md#change-sa) кластера. После этого [координатор](index.md#coordinator) и [воркеры](index.md#workers) смогут аутентифицироваться от имени сервисного аккаунта. Например, аутентификация в хранилище {{ objstorage-name }} для [коннекторов](index.md#connector) Hive, Iceberg и Delta Lake выполняется от имени сервисного аккаунта кластера.

Благодаря имперсонации кластер {{ TR }} поддерживает интеграцию с другими сервисами {{ yandex-cloud }}. Среди них [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md) и [{{ objstorage-full-name }}](../../storage/index.yaml).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту роли:
* [managed-trino.integrationProvider](../security.md#managed-trino-integrationProvider) — она позволяет кластеру записывать логи в {{ cloud-logging-name }} или поставлять метрики в {{ monitoring-name }}.
* [connection-manager.user](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) — для использования подключений из {{ connection-manager-name }}.
* [lockbox.payloadViewer](../../lockbox/security/index.md#lockbox-payloadViewer) — для использования [секретов](../../metadata-hub/concepts/secret.md) из сервиса {{ lockbox-full-name }}.
* [storage.editor](../../storage/security/index.md#storage-editor) — для взаимодействия с бакетом {{ objstorage-name }}.

## Доступные для интеграции сервисы {#services}

### {{ connection-manager-name }} {#connection-manager-integration}

{{ connection-manager-name }} — это сервис управления параметрами подключений к пользовательским инсталляциям баз данных с безопасным хранением паролей к ним. Если в [каталоге](index.md#catalog) кластера {{ mtr-name }} указан тип подключения **Connection Manager**, сервисный аккаунт кластера получает параметры подключения (сетевые адреса, порты, зашифрованные имя и пароль пользователя) по его идентификатору в {{ connection-manager-name }}.

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} — это сервис для хранения и чтения логов сервисов {{ yandex-cloud }}. Если в кластере {{ mtr-name }} включено логирование, логи кластера сохраняются в [лог-группу по умолчанию](../../logging/concepts/log-group.md) выбранного каталога или в пользовательскую лог-группу {{ cloud-logging-name }}.

Включить логирование можно при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md#change-additional-settings) кластера.

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} — это сервис для сбора и хранения метрик сервисов {{ yandex-cloud }}. Метрики отображаются в виде графиков на странице кластера в разделе **{{ ui-key.yacloud.common.monitoring }}**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах {{ mtr-name }}. Список доступных метрик приведен в их [справочнике](../metrics.md).

### {{ objstorage-name }} {#objstorage-integration}

{{ objstorage-name }} — это сервис для хранения данных. Для взаимодействия {{ mtr-full-name }} с бакетом {{ objstorage-name }} необходим кластер {{ metastore-full-name }}. Сервисным аккаунтам, привязанным к кластерам {{ mtr-name }} и {{ metastore-full-name }}, нужно назначить роль `storage.editor`.
