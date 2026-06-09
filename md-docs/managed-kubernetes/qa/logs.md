# Мониторинг и логи

* [Как я могу отслеживать состояние кластера {{ managed-k8s-name }}?](#monitoring)

* [Я могу получить логи моей работы в сервисах?](#logs)


* [Можно ли самостоятельно сохранять логи?](#auto-logging)


* [Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов?](#master-logging)

#### Как я могу отслеживать состояние кластера {{ managed-k8s-name }}? {#monitoring}

[Получите статистику кластера](../operations/kubernetes-cluster/kubernetes-cluster-get-stats.md). Описание доступных метрик кластера приводится в [справочнике](../metrics.md).

#### Я могу получить логи моей работы в сервисах? {#logs}

Да, вы можете запросить информацию о работе с вашими ресурсами из логов сервисов {{ yandex-cloud }}. Для этого обратитесь в [техническую поддержку]({{ link-console-support }}).


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../tutorials/fluent-bit-logging.md).


#### Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов? {#master-logging}

Да, для этого настройте отправку логов в [{{ cloud-logging-name }}](../../logging/index.md) при [создании](../operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../operations/kubernetes-cluster/kubernetes-cluster-update.md) [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster). Настройка доступна только в CLI, {{ TF }} и API.