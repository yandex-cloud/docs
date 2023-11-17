# Logs

{% include [logs](../logs.md) %}


#### Can I save logs myself? {#auto-logging}

For log collection and storage, use [Fluent Bit](../../managed-kubernetes/tutorials/fluent-bit-logging.md).


#### Can I use {{ cloud-logging-full-name }} for viewing logs? {#master-logging}

Yes, you can. To do this, set up sending logs to [{{ cloud-logging-name }}](../../logging/) when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). The setting is only available in the CLI, {{ TF }}, and API.

#### Is Horizontal Pod Autoscaler supported? {#horizontal-pod-autoscaler}

Yes, {{ managed-k8s-name }} supports [horizontal pod autoscaling](../../managed-kubernetes/concepts/autoscale.md#hpa).