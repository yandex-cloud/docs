---
title: Требования стандарта CIS Benchmark™ для {{ k8s }}
description: Этот набор правил содержит рекомендации стандарта CIS {{ k8s }} Benchmark, помогающие обеспечить безопасную работу компонентов, запущенных на узлах {{ k8s }}.
---

# Требования стандарта CIS Benchmark™ для {{ k8s }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Этот набор правил содержит рекомендации стандарта [CIS {{ k8s }} Benchmark](https://www.cisecurity.org/benchmark/kubernetes), помогающие обеспечить безопасную работу компонентов, запущенных на узлах {{ k8s }}.

Набор содержит только автоматические проверки, соответствующие разделу `4. Worker Nodes`:

Правило | Требование стандарта безопасности | Идентификатор проверки
--- | --- | ---
Установлены строгие разрешения для файла службы Kubelet | 4.1.1 Установлены строгие разрешения для файла службы Kubelet | [kspm.host-security.kubelet-service-file-perm-600](../../rules-reference/kspm.md#host-security.kubelet-service-file-perm-600)
Владелец файла службы Kubelet указан как `root:root` | 4.1.2 Владелец файла службы Kubelet указан как `root:root` | [kspm.host-security.kubelet-service-file-owner-root](../../rules-reference/kspm.md#host-security.kubelet-service-file-owner-root)
Установлены строгие разрешения для файла конфигурации `kubeconfig` | 4.1.5 Установлены строгие разрешения для файла `--kubeconfig kubelet.conf` | [kspm.host-security.kubelet-conf-600](../../rules-reference/kspm.md#host-security.kubelet-conf-600)
Владелец файла конфигурации `kubeconfig` указан как `root:root` | 4.1.6 Владелец файла `--kubeconfig kubelet.conf` указан как `root:root` | [kspm.host-security.kubelet-conf-owner-root](../../rules-reference/kspm.md#host-security.kubelet-conf-owner-root)
Установлены строгие разрешения для файла конфигурации Kubelet | 4.1.9 Установлены строгие разрешения для файла конфигурации Kubelet `config.yaml` | [kspm.host-security.kubelet-config-permissions-600](../../rules-reference/kspm.md#host-security.kubelet-config-permissions-600)
Владелец файла конфигурации Kubelet указан как `root:root` | 4.1.10 Владелец файла конфигурации Kubelet `config.yaml` указан как `root:root` | [kspm.host-security.kubelet-config-owner-root](../../rules-reference/kspm.md#host-security.kubelet-config-owner-root)
Отключены запросы от анонимных пользователей к серверу Kubelet | 4.2.1 Аргумент `--anonymous-auth` установлен в значение _false_ | [kspm.host-security.anonymous-auth-false](../../rules-reference/kspm.md#host-security.anonymous-auth-false)
Разрешены только явно авторизованные запросы к серверу Kubelet | 4.2.2 Аргумент `--authorization-mode` не установлен в значение _AlwaysAllow_ | [kspm.host-security.auth-mode-not-always-allow](../../rules-reference/kspm.md#host-security.auth-mode-not-always-allow)
Включена аутентификация Kubelet с использованием сертификатов | 4.2.3 Аргумент `--client-ca-file` установлен в правильное расположение | [kspm.host-security.client-ca-file-set](../../rules-reference/kspm.md#host-security.client-ca-file-set)
Kubelet разрешено управлять `iptables` | 4.2.6 Аргумент `--make-iptables-util-chains` установлен в значение _true_ | [kspm.host-security.make-iptables-util-chains-true](../../rules-reference/kspm.md#host-security.make-iptables-util-chains-true)
Включена ротация клиентских сертификатов Kubelet | 4.2.10 Аргумент `--rotate-certificates` не установлен в _false_ | [kspm.host-security.rotate-certs-not-false](../../rules-reference/kspm.md#host-security.rotate-certs-not-false)