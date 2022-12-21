# Logs

{% include [logs](../logs.md) %}

{% if product == "yandex-cloud" %}

#### Can I save logs myself? {#auto-logging}

For log collection and storage, use [Fluent Bit](../../managed-kubernetes/tutorials/fluent-bit-logging.md).

{% endif %}

#### Is Horizontal Pod Autoscaler supported? {#horizontal-pod-autoscaler}

Yes, {{ managed-k8s-name }} supports [horizontal pod autoscaling](../../managed-kubernetes/concepts/autoscale.md#hpa).