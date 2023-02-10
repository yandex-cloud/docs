# Dynamic resource allocation

Nodes need resources to run the {{ k8s }} components in charge of running the node as part of the {{ k8s }} cluster. This is why the resulting amount of node resources may not match the resources allocated for the jobs in the {{ k8s }} cluster.

Some nodes need more resources:

* Nodes with a more powerful configuration, which can run more containers and more pods, need more resources allocated to them.
* Nodes running Windows Server. These nodes need more resources than Linux nodes, since they need more resources to support the Windows and Windows Server components that can't run in containers.

To view the node resources allocated to the {{ k8s }} components, run the command:

```
kubectl describe node <node name> | grep Allocatable -B 4 -A 3
```

## Amount of allocated RAM and CPU resources {#allocate}

### RAM resource allocation {#ram}

For RAM, the following resources are allocated:

* 255 MB of RAM for nodes with less than 1 GB of RAM.
* 25% from the first 4 GB of RAM.
* 20% from the next 4 GB of RAM (up to 8 GB).
* 10% from the next 8 GB of RAM (up to 16 GB).
* 6% from the next 112 GB (up to 128 GB).
* 2% from RAM over 128 GB.

100 MB of RAM is additionally reserved on each node for [kubelet eviction](https://kubernetes.io/docs/tasks/administer-cluster/out-of-resource/).

### CPU resource allocation {#cpu}

For processors, the following resources are allocated:

* 6% from the first core.
* 1% from the next core (up to 2 cores inclusive).
* 0.5% from the next two cores (up to 4 cores inclusive).
* 0.25% from 5 and more cores.