# Имперсонация в {{ mtr-name }}

_Имперсонацией_ в {{ mtr-name }} называется выполнение кластером {{ TR }} действий с пользовательскими ресурсами от имени сервисного аккаунта.

По умолчанию кластер {{ TR }} не имеет прав доступа к пользовательским ресурсам. Чтобы обеспечить доступ к ним, [создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с нужными ролями и привяжите его к кластеру {{ TR }} при [создании](../operations/cluster-create.md#create-cluster) или [изменении](../operations/cluster-update.md) кластера. После этого [координатор](index.md#coordinator) и [воркеры](index.md#workers) смогут аутентифицироваться от имени сервисного аккаунта. Например, аутентификация в хранилище {{ objstorage-name }} для [коннекторов](index.md#connector) Hive, Iceberg и Delta Lake выполняется от имени сервисного аккаунта кластера.

Благодаря имперсонации кластер {{ TR }} поддерживает интеграцию с другими сервисами {{ yandex-cloud }}. Среди них [{{ cloud-logging-full-name }}](../../logging/index.yaml) и [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

Чтобы кластер мог взаимодействовать с сервисами, назначьте его сервисному аккаунту [роль](../security.md#managed-trino-integrationProvider) `managed-trino.integrationProvider`. Она позволяет кластеру записывать логи в {{ cloud-logging-name }} или поставлять метрики в {{ monitoring-name }}.

## Доступные для интеграции сервисы {#services}

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} — это сервис для хранения и чтения логов сервисов {{ yandex-cloud }}. Если в кластере {{ mtr-name }} включено логирование, логи кластера сохраняются в выбранную лог-группу {{ cloud-logging-name }}.


### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} — это сервис для сбора и хранения метрик для сервисов {{ yandex-cloud }}. Метрики отображаются в виде графиков на странице кластера, в разделе **{{ ui-key.yacloud.common.monitoring }}**. Метрики показывают текущее состояние и работоспособность кластера. Они доступны по умолчанию во всех кластерах {{ mtr-name }}.
