# Логи

{% include [logs](../../_qa/logs.md) %}


#### Можно ли самостоятельно сохранять логи? {#auto-logging}

Для сбора и хранения логов используйте [Fluent Bit](../tutorials/fluent-bit-logging.md).


#### Есть ли поддержка Horizontal Pod Autoscaler? {#horizontal-pod-autoscaler}

Да, {{ managed-k8s-name }} поддерживает механизм [горизонтального автомасштабирования подов](../concepts/autoscale.md#hpa) (Horizontal Pod Autoscaler).