# Updating node group OS

Starting with {{ k8s }} version 1.30, the node OS changed from Ubuntu 20.04 to Ubuntu 22.04. When you [update node groups](../operations/node-group/node-group-update.md) within these versions, new nodes are automatically created from an Ubuntu 22.04 [VM](../../compute/concepts/vm.md) [image](../../compute/concepts/image.md).

{% note info %}

The OS version update is available in the `RAPID` [release channel](release-channels-and-updates.md). This upgrade will later become available in the `REGULAR` and `STABLE` release channels.

{% endnote %}

## User resource updates {#user-resources-update}

In Ubuntu 22.04, system libraries and Linux kernel headers were updated, so GPU driver compilation may not work for node groups with custom GPU drivers.

How the problem manifests itself:

* You get driver build errors.
* GPU cannot be detected.
* Node group update fails.

To avoid all this, make sure your GPU Operator and driver versions are compatible when preparing for the update:

* Update GPU Operator to version `24.9.x+`.
* Update your driver to version `550.144.03` or higher.
* Use precompiled drivers. Do it by setting `--driver.usePrecompiled=true` when installing GPU Operator.

For more information on using a GPU with a custom driver, see [{#T}](../tutorials/driverless-gpu.md).

{% note warning %}

As Ubuntu 22.04 uses the new Linux kernel 5.15, updating the OS may disrupt the operation of custom kernel modules compiled with [DKMS](https://github.com/dkms-project/dkms).

{% endnote %}

## Preparation for migration {#prepare-to-migration}

Before migrating your {{ k8s }} cluster to a new OS version, test the update on the new cluster:

1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md) and specify the `RAPID` release channel for it.
1. [Create a node group](../operations/node-group/node-group-create.md) in the new cluster.
1. Test your apps, which may prove OS version-dependent, in the new cluster.

   Check key load indicators:

   * GPU load.
   * App status monitoring.
   * The functioning of monitoring agents and drivers.

## How to check node OS version {#how-to-check-os}

All nodes in the group use the same basic OS version image. You can check the OS version using these commands:

```bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.osImage}{"\n"}{end}'
```

```bash
kubectl get node <node-name> -o jsonpath='{.status.nodeInfo.osImage}{"\n"}'
```
