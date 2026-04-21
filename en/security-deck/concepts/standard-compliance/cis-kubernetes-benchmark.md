---
title: CIS Benchmark™ requirements for {{ k8s }}
description: This rule set contains CIS {{ k8s }} Benchmark security recommendations for the components that run on {{ k8s }} worker nodes.
---

# CIS Benchmark™ requirements for {{ k8s }}

{% include [note-preview](../../../_includes/note-preview.md) %}

This rule set contains [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) security recommendations for the components that run on {{ k8s }} worker nodes.

The rule set only lists automatic checks from the section `4. Worker Nodes`:

Rule | Security standard requirement | Rule check ID
--- | --- | ---
Restrictive permissions for Kubelet service file are set | 4.1.1 Restrictive permissions for Kubelet service file are set | [kspm.host-security.kubelet-service-file-perm-600](../../rules-reference/kspm.md#host-security.kubelet-service-file-perm-600)
Kubelet service file ownership is set to `root:root` | 4.1.2 Kubelet service file ownership is set to `root:root` | [kspm.host-security.kubelet-service-file-owner-root](../../rules-reference/kspm.md#host-security.kubelet-service-file-owner-root)
Restrictive permissions for `kubeconfig` configuration file are set | 4.1.5 Restrictive permissions for the `--kubeconfig kubelet.conf` file are set | [kspm.host-security.kubelet-conf-600](../../rules-reference/kspm.md#host-security.kubelet-conf-600)
The owner of `kubeconfig` configuration file is set to `root:root` | 4.1.6 The owner of the `--kubeconfig kubelet.conf` file is set to `root:root` | [kspm.host-security.kubelet-conf-owner-root](../../rules-reference/kspm.md#host-security.kubelet-conf-owner-root)
Restrictive permissions for Kubelet configuration file are set | 4.1.9 Restrictive permissions for the Kubelet `config.yaml` configuration file are set | [kspm.host-security.kubelet-config-permissions-600](../../rules-reference/kspm.md#host-security.kubelet-config-permissions-600)
The owner of Kubelet configuration file is set to `root:root` | 4.1.10 Kubelet `config.yaml` configuration file ownership is set to `root:root` | [kspm.host-security.kubelet-config-owner-root](../../rules-reference/kspm.md#host-security.kubelet-config-owner-root)
Requests from anonymous users to Kubelet server are disabled | 4.2.1 The `--anonymous-auth` argument is set to _false_ | [kspm.host-security.anonymous-auth-false](../../rules-reference/kspm.md#host-security.anonymous-auth-false)
Only explicitly authorized requests to Kubelet server are allowed | 4.2.2 The `--authorization-mode` argument is not set to _AlwaysAllow_ | [kspm.host-security.auth-mode-not-always-allow](../../rules-reference/kspm.md#host-security.auth-mode-not-always-allow)
Kubelet authentication via certificates is enabled | 4.2.3 The `--client-ca-file` argument is set to the proper location | [kspm.host-security.client-ca-file-set](../../rules-reference/kspm.md#host-security.client-ca-file-set)
Kubelet is allowed to manage iptables | 4.2.6 The `--make-iptables-util-chains` argument is set to _true_ | [kspm.host-security.make-iptables-util-chains-true](../../rules-reference/kspm.md#host-security.make-iptables-util-chains-true)
Kubelet client certificate rotation is enabled | 4.2.10 The `--rotate-certificates` argument is not set to _false_ | [kspm.host-security.rotate-certs-not-false](../../rules-reference/kspm.md#host-security.rotate-certs-not-false)