# Monitoring

{{ stackland-name }} позволяет организовать мониторинг кластера и платформенных компонентов с помощью [Prometheus](https://prometheus.io), [Grafana](https://grafana.com) и Alertmanager.

* Prometheus — средство сбора метрик кластера и платформенных компонентов.
* Grafana — интерфейс для просмотра и визуализации метрик и логов.
* Alertmanager — средство управления правилами алертинга и отправки уведомлений о проблемах.

Сбор и хранение логов выполняет отдельный компонент [Logging Stack](logging.md). Он подключает источники данных Loki к Grafana.

## Интерфейс Grafana {#grafana}

Интерфейс Grafana доступен по адресу `https://grafana.sys.<домен кластера>`. Для входа используйте кнопку **Sign in with Stackland Auth**.

Компонент Monitoring подключает к Grafana источники данных `prometheus` и `alertmanager`. Компонент Logging Stack добавляет источники `stackland-logs` и `audit-logs`. Чтобы проверить подключенные источники, откройте страницу **Data sources** во вкладке **Connections**. Для просмотра метрик и логов откройте вкладку **Explore**.

## Управление доступом {#access}

В зависимости от [роли в кластере](../../access-management.md) пользователю будет назначаться глобальная роль в Grafana. Если пользователь входит в группу `stackland-cluster-admins`, то в Grafana пользователь сразу получит права администратора. Если входит в `stackland-cluster-editors` — роль `editor`. Если пользователь не состоит в группе, то он получит роль `viewer`.

После входа можно управлять правами на уровне отдельных ресурсов Grafana и отдельных пользователей. Подробнее об управлении доступами читайте в [документации Grafana](https://grafana.com/docs/grafana/latest/permissions/).

Доступ к источникам логов дополнительно проверяет tenant proxy компонента Logging Stack. По умолчанию логи доступны только участникам группы `stackland-cluster-admins`; роль Grafana `Viewer` или `Editor` сама по себе не предоставляет к ним доступ.

## Дашборды метрик {#dashboards}

На вкладке **Dashboards** находятся готовые дашборды: в папке `stackland-monitoring` находятся дашборды с метриками кластера. В других папках — дашборды с метриками платформенных компонентов, например, `stackland-managed-postgres`.

Помимо готовых дашбордов, вы можете создать собственные и добавить на них метрики ваших приложений. Про создание дашбордов читайте в разделе [{#T}](../../operations/monitoring/dashboard-create.md).

## Логи {#logs}

Системные логи можно просмотреть на вкладке **Explore** с помощью источника `stackland-logs`, аудитные логи Kubernetes API — с помощью `audit-logs`. Подробнее см. в разделе [{#T}](../../operations/logging/logs-view.md).

## Алерты {#alerts}

Настройка правил алертинга позволяет получать уведомления о проблемах в кластере или приложениях. Уведомления можно отправлять с помощью электронной почты, очередей сообщений или мессенджеров.

Про создание каналов уведомлений читайте в разделе [{#T}](../../operations/monitoring/alerts-create-contact-point.md).

## Конфигурация {#configuration}

### Общий вид {#general}

{% include notitle [YAML-файл](../../_includes/yamls/components/monitoringconfig.md) %}

#### Состояние компонента мониторинга {#status}

```yaml
status:
  datasourceConfigured: true
  grafanaReady: true
  s3ExtensionProvisioned: true
  message: Grafana is ready
  observedGeneration: 1
```

* `datasourceConfigured` — включенные источники данных Prometheus и Alertmanager созданы в Grafana.
* `grafanaReady` — Grafana готова к работе.
* `s3ExtensionProvisioned` — S3-ресурсы для долгосрочного хранения метрик Thanos переданы под управление Monitoring. Поле имеет значение `true`, если задан `thanos.longTermStorage.stackland` и контроллер начал создавать связанные ресурсы.
* `message` — сообщение о состоянии Grafana.
* `observedGeneration` — активная версия конфигурации.

#### Общие настройки {#common-settings}

```yaml
clusterIssuer: stackland-default
```

* `clusterIssuer` — имя ClusterIssuer для TLS-сертификатов.

#### Alertmanager {#alertmanager}

```yaml
alertmanager:
  enabled: true
  replicas: 3
  retention: "240h"
  ingressEnabled: true
  storage:
    enabled: true
    storageClass: stackland-ssd
    size: "1Gi"
  resources:
    requests:
      cpu: "100m"
      memory: "256Mi"
    limits:
      cpu: "500m"
      memory: "1Gi"
```

* `enabled` — включает Alertmanager.
* `replicas` — количество реплик Alertmanager.
* `retention` — срок хранения данных Alertmanager.
* `storage.enabled` — включает PVC для состояния Alertmanager. По умолчанию хранилище включено.
* `storage.storageClass` — StorageClass для PVC. Если параметр не указан, используется StorageClass кластера по умолчанию.
* `storage.size` — размер PVC. Если параметр не указан, используется `1Gi`.
* `ingressEnabled` — открывает доступ к Alertmanager через Ingress.
* `resources` — требования к ресурсам.

Поля `storage.enabled`, `storage.storageClass` и `storage.size` нельзя изменить после создания `MonitoringConfig`. Для изменения хранилища пересоздайте ресурс.

#### Grafana {#grafana}

```yaml
grafana:
  enabled: true
  resources:
    requests:
      cpu: "200m"
      memory: "512Mi"
    limits:
      cpu: "1"
      memory: "2Gi"
```

* `enabled` — включает Grafana.
* `resources` — требования к ресурсам.

#### Grafana Operator {#grafana-operator}

```yaml
grafanaOperator:
  enabled: true
  resources:
    requests:
      memory: "128Mi"
      cpu: "50m"
    limits:
      cpu: "200m"
      memory: "512Mi"
```

* `enabled` — включает Grafana Operator.
* `resources` — требования к ресурсам.


#### Prometheus {#prometheus}

```yaml
prometheus:
  enabled: true
  replicas: 2
  retention: 15d
  ingressEnabled: true
  storage:
    storageClass: stackland-ssd
    size: "10Gi"
  resources:
    requests:
      cpu: "1"
      memory: "2Gi"
    limits:
      cpu: "1"
      memory: "2Gi"
  thanos:
    longTermStorage:
      stackland: {}
```

* `enabled` — включает Prometheus.
* `replicas` — количество реплик Prometheus.
* `retention` — срок хранения данных Prometheus.
* `ingressEnabled` — открывает доступ к Prometheus через Ingress.
* `resources` — требования к ресурсам.
* `storage.storageClass` — StorageClass для PVC. Если параметр не указан, используется StorageClass кластера по умолчанию.
* `storage.size` — размер PVC; локальная глубина истории ограничивается автоматически как 80% от размера PVC.
* `thanos.longTermStorage.stackland` — включает долгосрочное хранение метрик во внутреннем S3. Для использования параметра должен быть включен компонент [{{ objstorage-name }}](storage.md).

Поля `storage.storageClass` и `storage.size` нельзя изменить после создания `MonitoringConfig`. Для изменения хранилища пересоздайте ресурс.

#### Мониторинг оборудования {#hardware-monitoring}

```yaml
hardwareMonitoring:
  enabled: true
  resources:
    requests:
      cpu: "50m"
      memory: "64Mi"
    limits:
      cpu: "200m"
      memory: "256Mi"
```

* `enabled` — включает сбор метрик состояния оборудования.
* `resources` — требования к ресурсам агента мониторинга оборудования.
