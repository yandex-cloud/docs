---
title: Configuring masquerading in {{ managed-k8s-name }} clusters with multiple ranges of pod IP addresses
description: How to configure masquerading in a cluster with multiple ranges of pod IP addresses and synchronize _ip-masq-agent_ after adding a range.
---

# Configuring masquerading in clusters with multiple ranges of pod IP addresses

Create a cluster with multiple ranges of pod IP addresses and expand the address space of the existing cluster. Then, check the masquerading settings.

The `ConfigMap` object named `ip-masq-agent` in the `kube-system` namespace contains the settings for [pod IP address masquerading](../../concepts/index.md#pod-ip-masquerade). The `data.config.nonMasqueradeCIDRs` sets destination ranges, which, when accessed, do not get the pod IP address to be replaced with the node IP address.

In [clusters with multiple ranges of pod IP addresses](../../concepts/cluster-multi-cidr.md), save all the cluster's pod ranges in this list.

## Getting started {#before-you-begin}

You can specify the ranges when [creating a cluster](../kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) or add them later when [updating the cluster](../kubernetes-cluster/kubernetes-cluster-update.md#update-cluster).

[View and save the masquerading settings](#get-config) before adding a range to an existing cluster. If you use your own ranges or other settings, [enable manual management](#manual-management) to save them.

## Synchronize masquerading after adding a range {#sync-cidr}

1. [Check the management mode](#get-config) for `ip-masq-agent` ConfigMap.
1. Based on the mode, follow these steps:
   * `enforced`: Wait for the next configuration update and check that the new range is in `nonMasqueradeCIDRs`. Do not edit `data.config` manually: the service will overwrite the changes.
   * `disabled`: Run `kubectl -n kube-system edit configmap ip-masq-agent` and add the new range to `data.config.nonMasqueradeCIDRs`. Save the previous ranges and other settings. For a configuration example, see [this section](#manual-management).
   * No annotation: Wait for automatic mode selection and read ConfigMap again. If you need to save the custom settings, explicitly specify `disabled` before editing them.
1. [Check the result](#verify).

## Management modes {#management-modes}

The mode is specified by the `addon-cm-controller.mk8s.yc.io/mode` annotation:

#|
|| Value | Behavior ||
|| `enforced` | The service supports the entire `data.config` based on the system template. New pod ranges are added automatically. Custom values are overwritten. ||
|| `disabled` | The service does not change ConfigMap. The user supports system and custom ranges themselves. ||
|| No annotation | The service determines the mode based on the current contents and sets `enforced` or `disabled`. ||
|| Other value | The service does not change ConfigMap and creates an event with the `InvalidMode` reason. ||
|#

The configuration is checked periodically: every 60 seconds by default. Changing mode does not require restarting the cluster or nodes.

## View the current settings {#get-config}

{% include [kubectl](../../../_includes/managed-kubernetes/kubectl-before-you-begin.md) %}

Run this command to view the mode and ConfigMap contents:

```bash
kubectl -n kube-system get configmap ip-masq-agent -o yaml
```

Before editing, save the current configuration:

```bash
kubectl -n kube-system get configmap ip-masq-agent -o yaml > ip-masq-agent-backup.yaml
```

## Enable automatic management {#automatic-management}

Use `enforced` mode if you have enough pod system ranges and standard `ip-masq-agent` settings.

{% note warning %}

When enabling `enforced`, the service will overwrite the entire `data.config`. Custom ranges, `resyncInterval`, `masqLinkLocal` values, and other settings will not be saved. Before editing, save the current configuration.

{% endnote %}

Run this command to delegate management to the service:

```bash
kubectl -n kube-system annotate configmap ip-masq-agent \
  addon-cm-controller.mk8s.yc.io/mode=enforced --overwrite
```

When adding a new pod range, the service will automatically add it to `nonMasqueradeCIDRs`.

## Enable manual management {#manual-management}

If you are adding custom ranges or editing other `ip-masq-agent` settings:

1. Enable `disabled` mode:

   ```bash
   kubectl -n kube-system annotate configmap ip-masq-agent \
     addon-cm-controller.mk8s.yc.io/mode=disabled --overwrite
   ```

1. Open ConfigMap to edit it:

   ```bash
   kubectl -n kube-system edit configmap ip-masq-agent
   ```

1. In `nonMasqueradeCIDRs`, save all the cluster's pod ranges and add custom destination ranges that do not require masquerading. Here is an example:

   ```yaml
   data:
     config: |+
       nonMasqueradeCIDRs:
         - 10.112.0.0/16
         - 10.113.0.0/16
         - 10.200.0.0/16
       masqLinkLocal: false
       resyncInterval: 60s
   ```

   In the example, the first two ranges belong to pods, and the third, to the custom network. Replace them with your values. Save the other settings required for your network.

{% note warning %}

In `disabled` mode, manually update `nonMasqueradeCIDRs` after adding each pod range. The service does not combine system and custom settings.

{% endnote %}

## Automatic mode selection {#automatic-selection}

At the first run, the controller checks ConfigMap without any annotation. If the configuration only lists the expected system ranges, `enforced` mode is enabled. A configuration with additional, missing, or modified ranges is assigned `disabled` mode and saved without any changes.

Comparisons factor in the range order. IPv4 system ranges in the previous format that spanned half of the range may be recognized and replaced with full ones. A combined list of full and half ranges is considered a custom configuration.

{% note warning %}

If you only edited `resyncInterval`, `masqLinkLocal`, or other settings without changing the system CIDR list, the controller may select `enforced` and overwrite the settings. To save them, set `disabled` in advance.

{% endnote %}

Deleting the annotation triggers repeat automatic selection. To select an exact mode, explicitly specify `enforced` or `disabled`.

## Check the result {#verify}

1. After creating new nodes, check the address blocks assigned to them:

   ```bash
   kubectl get nodes -o custom-columns=NAME:.metadata.name,POD_CIDR:.spec.podCIDR,POD_CIDRS:.spec.podCIDRs
   ```

   The new range may not be used if the previous one still has unused blocks. When adding a range, the IP addresses of existing nodes and pods do not change.

1. Wait for the next configuration check and view the settings:

   ```bash
   kubectl -n kube-system get configmap ip-masq-agent -o yaml
   ```

1. Check the ConfigMap events:

   ```bash
   kubectl -n kube-system get events \
     --field-selector involvedObject.kind=ConfigMap,involvedObject.name=ip-masq-agent \
     --sort-by=.lastTimestamp
   ```

   If you see an `InvalidMode` event, fix the annotation value.

1. To check the node masquerading rules, [connect to that node over SSH](../node-connect-ssh.md) and run this command:

   ```bash
   sudo iptables -t nat -L IP-MASQ -v -n
   ```

Do not delete ConfigMap to reset the settings, as the service will recreate it using the system template. Use mode annotation to change the behavior.

#### Useful links {#see-also}

* [{#T}](../../concepts/cluster-multi-cidr.md)
* [{#T}](../../concepts/network.md)
