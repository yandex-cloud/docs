# Logs

{% include [logs](../../_qa/logs.md) %}

{% if product == "yandex-cloud" %}

#### Can I save logs myself? {#auto-logging}

For log collection and storage, use [Fluent Bit](../tutorials/fluent-bit-logging.md).

{% endif %}

#### Is horizontal pod autoscaler supported? {#horizontal-pod-autoscaler}

Yes, {{ managed-k8s-name }} supports [horizontal pod autoscaling](../concepts/autoscale.md#hpa).