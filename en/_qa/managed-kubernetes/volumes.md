## Data storage

#### What are the features of disk storage when a database (for example, {{ MY }} or {{ PG }}) is located in a {{ k8s }} cluster? {#bd}

For a database located in a {{ k8s }} cluster, use [StatefulSet](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) controllers. We don't recommend starting stateful services with persistent volumes in {{ k8s }}. For stateful databases, use [{{ yandex-cloud }} managed databases]({{ link-cloud-services }}#data-platform), for example, {{ mmy-name }} or {{ mpg-name }}.

#### How do I connect to managed {{ yandex-cloud }} databases? {#mdb}

To connect to a [{{ yandex-cloud }} managed database]({{ link-cloud-services }}#data-platform) located in the same [network](../../vpc/concepts/network.md#network), specify its [hostname and FQDN](../../compute/concepts/network.md#hostname).

To connect a database certificate to a [pod](../../managed-kubernetes/concepts/index.md#pod), use `secret` or `configmap` objects.

#### What's the right way to add a persistent volume to a container? {#persistent-volume}

You can select connection mode for {{ compute-name }} [disks](../../compute/concepts/disk.md) depending on your needs:
* If you want {{ k8s }} to automatically provision a `PersistentVolume` object and configure a new disk, create a pod with a [dynamically provisioned](../../managed-kubernetes/operations/volumes/dynamic-create-pv.md) volume.
* To use existing {{ compute-name }} volumes, create a pod with a [statically provisioned](../../managed-kubernetes/operations/volumes/static-create-pv.md) pod.

For more information, see [Working with persistent volumes](../../managed-kubernetes/concepts/volume.md#persistent-volume).

#### What types of volumes does {{ managed-k8s-name }} support? {#supported-volumes}

{{ managed-k8s-name }} supports `temporary` volumes and `persistent` volumes. For more information, see [{#T}](../../managed-kubernetes/concepts/volume.md).