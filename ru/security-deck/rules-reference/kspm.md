---
title: Правила {{ kspm-name }} {{ kspm-full-name }}
description: Правила для проверки конфигурации кластеров Kubernetes
editable: false
---

## {{ kspm-name }} {{ kspm-full-name }}

Правила для проверки конфигурации кластеров Kubernetes.

{% include [host-security.kubelet-service-file-perm-600](../../_security-deck-rules/rules/kspm/host-security.kubelet-service-file-perm-600.md) %}

{% include [host-security.kubelet-service-file-owner-root](../../_security-deck-rules/rules/kspm/host-security.kubelet-service-file-owner-root.md) %}

{% include [host-security.kubelet-conf-600](../../_security-deck-rules/rules/kspm/host-security.kubelet-conf-600.md) %}

{% include [host-security.kubelet-conf-owner-root](../../_security-deck-rules/rules/kspm/host-security.kubelet-conf-owner-root.md) %}

{% include [host-security.kubelet-config-permissions-600](../../_security-deck-rules/rules/kspm/host-security.kubelet-config-permissions-600.md) %}

{% include [host-security.kubelet-config-owner-root](../../_security-deck-rules/rules/kspm/host-security.kubelet-config-owner-root.md) %}

{% include [host-security.anonymous-auth-false](../../_security-deck-rules/rules/kspm/host-security.anonymous-auth-false.md) %}

{% include [host-security.auth-mode-not-always-allow](../../_security-deck-rules/rules/kspm/host-security.auth-mode-not-always-allow.md) %}

{% include [host-security.client-ca-file-set](../../_security-deck-rules/rules/kspm/host-security.client-ca-file-set.md) %}

{% include [host-security.make-iptables-util-chains-true](../../_security-deck-rules/rules/kspm/host-security.make-iptables-util-chains-true.md) %}

{% include [host-security.rotate-certs-not-false](../../_security-deck-rules/rules/kspm/host-security.rotate-certs-not-false.md) %}

