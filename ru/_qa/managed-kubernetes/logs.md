#### Как я могу отслеживать состояние кластера {{ managed-k8s-name }}? {#monitoring}

[Получите статистику кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-get-stats.md). Описание доступных метрик кластера приводится в [справочнике](../../managed-kubernetes/metrics.md).

{% include [logs](../logs.md) %}


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../../managed-kubernetes/tutorials/fluent-bit-logging.md).


#### Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов? {#master-logging}

Да, для этого настройте отправку логов в [{{ cloud-logging-name }}](../../logging/) при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Настройка доступна только в CLI, {{ TF }} и API.
