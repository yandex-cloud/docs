# Logging Stack

{{ stackland-name }} собирает и хранит системные логи кластера с помощью опенсорс-инструментов:

* [Loki](https://grafana.com/oss/loki/) — централизованное хранилище логов.
* [Fluent Bit](https://fluentbit.io/) — агент поставки логов.
* [Grafana](https://grafana.com) — интерфейс для просмотра и анализа логов.

Управлять хранением и поставкой логов можно с помощью [кастомного ресурса](#configuration) `LoggingConfig`.

## Какие логи собираются {#log-streams}

По умолчанию Fluent Bit отправляет в Loki два потока логов:

* аудитные логи Kubernetes API из `/var/log/audit/kube/kube-apiserver.log` — в tenant `audit`;
* логи контейнеров из пространств имен `stackland-*` — в tenant `stackland`.

Логи контейнеров из других пространств имен в Loki не отправляются.

В Grafana каждому tenant соответствует отдельный источник данных:

| Источник данных | Tenant | Содержимое |
| --- | --- | --- |
| `audit-logs` | `audit` | Аудитные логи Kubernetes API |
| `stackland-logs` | `stackland` | Логи платформенных компонентов из пространств имен `stackland-*` |
| `audit-logs-legacy` | `audit` | Аудитные логи из `singleBinary` при одновременном использовании двух режимов |
| `stackland-logs-legacy` | `stackland` | Логи платформенных компонентов из `singleBinary` при одновременном использовании двух режимов |

## Просмотр логов в Grafana {#grafana}

Интерфейс Grafana доступен по адресу `https://grafana.sys.<домен кластера>`. Для входа используйте кнопку **Sign in with Stackland Auth**.

Откройте раздел **Explore** и выберите источник данных `stackland-logs` или `audit-logs`. Если одновременно включены `singleBinary` и `simpleScalable`, новые логи поступают в эти источники, а история из `singleBinary` доступна через `stackland-logs-legacy` и `audit-logs-legacy`. Также для системных логов доступно приложение **Logs**, которое использует источник `stackland-logs`.

По умолчанию запросы к обоим tenant проходят через прокси авторизации. Доступ разрешен участникам группы `stackland-cluster-admins`. Список групп можно изменить в параметре `tenantProxy.adminGroups`. Роль `Viewer` или `Editor` в Grafana сама по себе не предоставляет доступ к логам.

## Хранение логов {#storage}

Loki поддерживает два режима развертывания:

* `singleBinary` — один экземпляр Loki с данными на PVC;
* `simpleScalable` — масштабируемая конфигурация с компонентами `writer`, `reader` и `backend`, которая хранит данные во внутреннем S3. Для этого режима должен быть включен компонент [{{ objstorage-name }}](storage.md).

Одновременно должен быть включен хотя бы один режим. При переходе между режимами их можно временно включить одновременно.

Пример конфигурации `singleBinary`:

```yaml
logStorage:
  loki:
    singleBinary:
      enabled: true
      storage:
        storageClass: stackland-ssd
        size: 50Gi
      resources:
        requests:
          memory: 1Gi
          cpu: 500m
        limits:
          memory: 2Gi
          cpu: "1"
      limitsConfig:
        retentionPeriod: 30d
        maxLabelNamesPerSeries: 30
      compactor:
        retentionEnabled: true
        retentionDeleteDelay: 2h
```

* `storage.storageClass` — StorageClass для PVC. Если параметр не указан, используется StorageClass кластера по умолчанию.
* `storage.size` — размер PVC.
* `resources` — требования к ресурсам Loki.
* `limitsConfig.retentionPeriod` — срок хранения логов.
* `limitsConfig.maxLabelNamesPerSeries` — максимальное количество меток в одной серии.
* `compactor.retentionEnabled` — включает удаление данных с истекшим сроком хранения.
* `compactor.retentionDeleteDelay` — задержка перед удалением данных.

## Управление доступом к tenant {#tenant-proxy}

```yaml
logStorage:
  loki:
    tenantProxy:
      enabled: true
      adminGroups:
        - stackland-cluster-admins
      replicas: 1
      resources:
        requests:
          cpu: 50m
          memory: 64Mi
        limits:
          cpu: 200m
          memory: 256Mi
```

* `enabled` — направляет запросы Grafana к Loki через прокси авторизации. По умолчанию прокси включен.
* `adminGroups` — группы IAM, участники которых могут запрашивать tenant `audit` и `stackland`.
* `replicas` — количество реплик прокси.
* `resources` — требования к ресурсам прокси.

При `enabled: false` Grafana подключается к Loki напрямую, без проверки групп пользователя.

## Поставка логов {#shipment}

```yaml
logSender:
  fluentBit:
    logLevel: info
    sendToStacklandLogStorage: true
    flushInterval: 5s
    bufferSize: 5MB
    resources:
      requests:
        memory: 100Mi
        cpu: 100m
      limits:
        memory: 200Mi
        cpu: 200m
```

* `logLevel` — уровень логирования Fluent Bit: `debug`, `info`, `warn` или `error`.
* `sendToStacklandLogStorage` — включает отправку в Loki. По умолчанию имеет значение `true`.
* `flushInterval` — интервал отправки накопленных логов.
* `bufferSize` — размер буфера Fluent Bit.
* `resources` — требования к ресурсам Fluent Bit.

### Дополнительные получатели {#additional-outputs}

В `fluentBit.outputs` можно настроить до десяти дополнительных получателей типов `opensearch` и `stdout`. Если `sendToStacklandLogStorage: false`, должен быть включен хотя бы один дополнительный получатель.

Пример отправки логов одновременно в Loki и OpenSearch:

```yaml
logSender:
  fluentBit:
    sendToStacklandLogStorage: true
    outputs:
      - name: opensearch-main
        enabled: true
        type: opensearch
        match: "*"
        opensearch:
          host: opensearch.logging.svc.cluster.local
          port: 9200
          index: stackland-logs
          workers: 2
          retryLimit: 3
```

Для подключения по TLS и Basic Auth можно использовать `opensearch.tls.caSecret`, `opensearch.basicAuth.usernameSecret` и `opensearch.basicAuth.passwordSecret`. Секреты могут находиться в любом пространстве имен, если оно указано в ссылке; контроллер копирует нужные значения в пространство имен `stackland-logging`.

## Конфигурация {#configuration}

Полный пример `LoggingConfig`:

{% include notitle [YAML-файл](../../_includes/yamls/components/loggingconfig.md) %}

### Состояние компонента {#status}

В поле `status` ресурса отображаются:

* `datasourceConfigured` — источники данных Loki созданы в Grafana;
* `conditions` — условия готовности компонента и проверки дополнительных получателей;
* `message` — текущее состояние компонента;
* `observedGeneration` — последняя обработанная версия конфигурации.
