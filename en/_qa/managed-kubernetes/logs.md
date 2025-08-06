#### How can I monitor the {{ managed-k8s-name }} cluster state? {#monitoring}

[Get the cluster statistics](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-get-stats.md). You can view the description of the available cluster metrics in the [reference](../../managed-kubernetes/metrics.md).

{% include [logs](../logs.md) %}


#### Can I save logs myself? {#auto-logging}

For log collection and storage, use [Fluent Bit](../../managed-kubernetes/tutorials/fluent-bit-logging.md).


#### Can I use {{ cloud-logging-full-name }} for viewing logs? {#master-logging}

Yes, you can. To do this, set up sending logs to [{{ cloud-logging-name }}](../../logging/) when [creating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) or [updating](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md) a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). The setting is only available in the CLI, {{ TF }}, and API.
