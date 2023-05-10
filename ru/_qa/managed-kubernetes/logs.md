# Логи

{% include [logs](../logs.md) %}


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../../managed-kubernetes/tutorials/fluent-bit-logging.md).


#### Можно ли использовать сервис {{ cloud-logging-full-name }} для просмотра логов? {#master-logging}

Да, для этого настройте отправку логов в [{{ cloud-logging-name }}](../../logging/) при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Настройка доступна только в CLI, {{ TF }} и API.

#### Есть ли поддержка Horizontal Pod Autoscaler? {#horizontal-pod-autoscaler}

Да, {{ managed-k8s-name }} поддерживает механизм [горизонтального автомасштабирования подов](../../managed-kubernetes/concepts/autoscale.md#hpa) (Horizontal Pod Autoscaler).