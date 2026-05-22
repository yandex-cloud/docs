# Monitoring

{{ stackland-name }} позволяет организовать мониторинг кластера и платформенных компонентов с помощью [Prometheus](https://prometheus.io), [Loki](https://grafana.com/oss/loki/), [Fluent Bit](https://fluentbit.io/) и [Grafana](https://grafana.com).

* Prometheus — средство сбора метрик кластера и платформенных компонентов.
* Loki — средство централизованного сбора логов.
* Fluent Bit — средство поставки логов.
* Grafana — интерфейс для просмотра и визуализации метрик и логов.
* Alertmanager — средство управления правилами алертинга и отправки уведомлений о проблемах.

Вы можете расширить возможности мониторинга, добавив источники данных и плагины для работы с ними.

## Интерфейс Grafana {#grafana}

Интерфейс Grafana доступен по адресу `https://grafana.sys.<домен кластера>`. Для входа используйте кнопку **Sign in with Stackland Auth**.

К интерфейсу уже подключены источники данных Loki и Prometheus. Чтобы добавить новые источники или проверить уже подключенные, откройте страницу **Data sources** во вкладке **Connections**. Чтобы увидеть, какие метрики и логи собираются в кластере, откройте вкладку **Explore** и выберите **Metrics** или **Logs**.

## Управление доступом {#access}

В зависимости от [роли в кластере](../../access-management.md) пользователю будет назначаться глобальная роль в Grafana. Если пользователь входит в группу `stackland-cluster-admins`, то в Grafana пользователь сразу получит права администратора. Если входит в `stackland-cluster-editors` — роль `editor`. Если пользователь не состоит в группе, то он получит роль `viewer`.

После входа можно управлять правами на уровне отдельных ресурсов Grafana и отдельных пользователей. Подробнее об управлении доступами читайте в [документации Grafana](https://grafana.com/docs/grafana/latest/permissions/).

## Дашборды метрик {#dashboards}

На вкладке **Dashboards** находятся готовые дашборды: в папке `stackland-monitoring` находятся дашборды с метриками кластера. В других папках — дашборды с метриками платформенных компонентов, например, `stackland-managed-postgres`.

Помимо готовых дашбордов, вы можете создать собственные и добавить на них метрики ваших приложений. Про создание дашбордов читайте в разделе [{#T}](../../operations/monitoring/dashboard-create.md).

## Логи {#logs}

Логи кластера можно просмотреть на вкладке **Explore** в разделе **Logs**. По умолчанию для поставки логов используется сервис Fluent Bit.

## Алерты {#alerts}

Настройка правил алертинга позволяет получать уведомления о проблемах в кластере или приложениях. Уведомления можно отправлять с помощью электронной почты, очередей сообщений или мессенджеров.

Про создание каналов нотификаций читайте в разделе [{#T}](../../operations/monitoring/alerts-create-rule.md).

## Конфигурация {#configuration}

### Общий вид {#general}

{% include notitle [YAML-файл](../../_includes/yamls/components/monitoringconfig.md) %}

#### Состояние компонента мониторинга {#status}

```yaml
status:
  datasourceConfigured: true
  grafanaReady: true
  message: Grafana is ready
  observedGeneration: 1
```

* `datasourceConfigured` — Prometheus и Loki подключены к Grafana.
* `grafanaReady` — Grafana готова к работе.
* `message` — сообщение о состоянии Grafana.
* `observedGeneration` — активная версия конфигурации.

#### Alertmanager {#alertmanager}

```yaml
alertmanager:
  enabled: true
  ingressEnabled: true
  resources:
    requests:
      cpu: 50m
      memory: 200Mi
```

* `enabled` — включает Alertmanager.
* `ingressEnabled` — открывает доступ к Alertmanager через Ingress.
* `resources` — требования к ресурсам.

#### Grafana {#grafana}

```yaml
grafana:
  enabled: true
  resources:
    limits:
      cpu: 500m
      memory: 1Gi
    requests:
      cpu: 100m
      memory: 256Mi
```

* `enabled` — включает Grafana.
* `resources` — требования к ресурсам.

#### Grafana Operator {#grafana-operator}

```yaml
grafanaOperator:
  enabled: true
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 128Mi
```

* `enabled` — включает Grafana Operator.
* `resources` — требования к ресурсам.


#### Prometheus {#prometheus}

```yaml
prometheus:
  enabled: true
  ingressEnabled: true
  resources:
    limits:
      memory: 2Gi
    requests:
      cpu: 100m
      memory: 400Mi
  retention: 10d
```

* `enabled` — включает Prometheus.
* `ingressEnabled` — открывает веб-интерфейс Prometheus через Ingress.
* `resources` — требования к ресурсам.
* `retention` — время хранения данных перед удалением.
