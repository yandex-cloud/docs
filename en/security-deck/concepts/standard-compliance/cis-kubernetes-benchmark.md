---
title: CIS Benchmark™ requirements for {{ k8s }}
description: This ruleset contains the CIS {{ k8s }} Benchmark recommendations for secure operation of components running on {{ k8s }} nodes.
---

# CIS Benchmark™ requirements for {{ k8s }}

{% include [note-preview](../../../_includes/note-preview.md) %}

This ruleset contains the [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes) recommendations for secure operation of components running on {{ k8s }} nodes.

The ruleset contains only automatic checks corresponding to the `4. Worker Nodes` section:

Rule | Security standard requirement | Check ID
--- | --- | ---
Strict file permissions are enforced for the kubelet service file | 4.1.1 Strict file permissions are enforced for the kubelet service file | [kspm.host-security.kubelet-service-file-perm-600](../../rules-reference/kspm.md#host-security.kubelet-service-file-perm-600)
The kubelet service file owner is specified as `root:root` | 4.1.2 The kubelet service file owner is specified as `root:root` | [kspm.host-security.kubelet-service-file-owner-root](../../rules-reference/kspm.md#host-security.kubelet-service-file-owner-root)
Strict file permissions are enforced for the `kubeconfig` configuration file | 4.1.5 Strict file permissions are enforced for the `--kubeconfig kubelet.conf` file | [kspm.host-security.kubelet-conf-600](../../rules-reference/kspm.md#host-security.kubelet-conf-600)
The `kubeconfig` configuration file owner is specified as `root:root` | 4.1.6 The `--kubeconfig kubelet.conf` file owner is specified as `root:root` | [kspm.host-security.kubelet-conf-owner-root](../../rules-reference/kspm.md#host-security.kubelet-conf-owner-root)
Strict file permissions are enforced for the kubelet configuration file | 4.1.9 Strict file permissions are enforced for the `config.yaml` kubelet configuration file | [kspm.host-security.kubelet-config-permissions-600](../../rules-reference/kspm.md#host-security.kubelet-config-permissions-600)
The kubelet configuration file owner is specified as `root:root` | 4.1.10 The `config.yaml` kubelet configuration file owner is specified as `root:root` | [kspm.host-security.kubelet-config-owner-root](../../rules-reference/kspm.md#host-security.kubelet-config-owner-root)
Anonymous requests to the kubelet server are disabled | 4.2.1 The `--anonymous-auth` argument is set to _false_ | [kspm.host-security.anonymous-auth-false](../../rules-reference/kspm.md#host-security.anonymous-auth-false)
Only explicitly authorized requests to the kubelet server are allowed | 4.2.2 The `--authorization-mode` argument is not set to _AlwaysAllow_ | [kspm.host-security.auth-mode-not-always-allow](../../rules-reference/kspm.md#host-security.auth-mode-not-always-allow)
Kubelet authentication with certificates is enabled | 4.2.3 The `--client-ca-file` argument is set correctly | [kspm.host-security.client-ca-file-set](../../rules-reference/kspm.md#host-security.client-ca-file-set)
Kubelet is permitted to manage `iptables` | 4.2.6 The `--make-iptables-util-chains` argument is set to _true_ | [kspm.host-security.make-iptables-util-chains-true](../../rules-reference/kspm.md#host-security.make-iptables-util-chains-true)
Kubelet client certificate rotation is enabled | 4.2.10 The `--rotate-certificates` argument is not set to _false_ | [kspm.host-security.rotate-certs-not-false](../../rules-reference/kspm.md#host-security.rotate-certs-not-false)