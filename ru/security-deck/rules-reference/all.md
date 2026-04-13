---
title: Все правила {{ sd-full-name }}
description: Полный список правил безопасности {{ sd-name }} на одной странице
editable: false
---

# Все правила {{ sd-full-name }}

На этой странице представлен полный список правил безопасности, используемых в {{ sd-name }}.

## {{ cspm-name }} — {{ cspm-full-name }} {#cspm}

Правила для проверки конфигурации облачных ресурсов.

{% include [access.user-groups-access](../../_security-deck-rules/rules/cspm/access.user-groups-access.md) %}

{% include [access.sa-privileges-org-roles](../../_security-deck-rules/rules/cspm/access.sa-privileges-org-roles.md) %}

{% include [access.sa-privileges-service-roles](../../_security-deck-rules/rules/cspm/access.sa-privileges-service-roles.md) %}

{% include [access.check-privileged-roles](../../_security-deck-rules/rules/cspm/access.check-privileged-roles.md) %}

{% include [o11y.labeled-resources](../../_security-deck-rules/rules/cspm/o11y.labeled-resources.md) %}

{% include [access.bucket-access-policy](../../_security-deck-rules/rules/cspm/access.bucket-access-policy.md) %}

{% include [backup.compute-disks](../../_security-deck-rules/rules/cspm/backup.compute-disks.md) %}

{% include [access.kms-keys-access](../../_security-deck-rules/rules/cspm/access.kms-keys-access.md) %}

{% include [appsec.registry-recently-scan](../../_security-deck-rules/rules/cspm/appsec.registry-recently-scan.md) %}

{% include [k8s.api-security](../../_security-deck-rules/rules/cspm/k8s.api-security.md) %}

{% include [k8s.secure-configuration](../../_security-deck-rules/rules/cspm/k8s.secure-configuration.md) %}

{% include [k8s.access](../../_security-deck-rules/rules/cspm/k8s.access.md) %}

{% include [o11y.gitlab-audited](../../_security-deck-rules/rules/cspm/o11y.gitlab-audited.md) %}

{% include [o11y.audit-trails-no-errors.ru](../../_security-deck-rules/rules/cspm/o11y.audit-trails-no-errors.ru.md) %}

{% include [k8s.kspm.ru](../../_security-deck-rules/rules/cspm/k8s.kspm.ru.md) %}

{% include [access.user-groups-mapping.ru](../../_security-deck-rules/rules/cspm/access.user-groups-mapping.ru.md) %}

{% include [access.privileged-sa-access.ru](../../_security-deck-rules/rules/cspm/access.privileged-sa-access.ru.md) %}

{% include [access.check-bindings.ru](../../_security-deck-rules/rules/cspm/access.check-bindings.ru.md) %}

{% include [access.acl-container-registry](../../_security-deck-rules/rules/cspm/access.acl-container-registry.md) %}

{% include [access.bucket-public-access](../../_security-deck-rules/rules/cspm/access.bucket-public-access.md) %}

{% include [access.compute-public-ip](../../_security-deck-rules/rules/cspm/access.compute-public-ip.md) %}

{% include [access.db-console-access](../../_security-deck-rules/rules/cspm/access.db-console-access.md) %}

{% include [access.db-datalens-access](../../_security-deck-rules/rules/cspm/access.db-datalens-access.md) %}

{% include [access.defined-key-scopes](../../_security-deck-rules/rules/cspm/access.defined-key-scopes.md) %}

{% include [access.min-privileges](../../_security-deck-rules/rules/cspm/access.min-privileges.md) %}

{% include [access.os-login-onto-hosts.vm](../../_security-deck-rules/rules/cspm/access.os-login-onto-hosts.vm.md) %}

{% include [access.public-access](../../_security-deck-rules/rules/cspm/access.public-access.md) %}

{% include [access.sa-privileges](../../_security-deck-rules/rules/cspm/access.sa-privileges.md) %}

{% include [access.serial-console](../../_security-deck-rules/rules/cspm/access.serial-console.md) %}

{% include [active.ip-vulnerability-scan](../../_security-deck-rules/rules/cspm/active.ip-vulnerability-scan.md) %}

{% include [appsec.alb-https](../../_security-deck-rules/rules/cspm/appsec.alb-https.md) %}

{% include [appsec.api-gateway-https](../../_security-deck-rules/rules/cspm/appsec.api-gateway-https.md) %}

{% include [appsec.cdn-https](../../_security-deck-rules/rules/cspm/appsec.cdn-https.md) %}

{% include [appsec.ddos-protection.l7](../../_security-deck-rules/rules/cspm/appsec.ddos-protection.l7.md) %}

{% include [appsec.ddos-protection.l3](../../_security-deck-rules/rules/cspm/appsec.ddos-protection.l3.md) %}

{% include [appsec.periodic-scan](../../_security-deck-rules/rules/cspm/appsec.periodic-scan.md) %}

{% include [appsec.upload-policy](../../_security-deck-rules/rules/cspm/appsec.upload-policy.md) %}

{% include [appsec.use-arl](../../_security-deck-rules/rules/cspm/appsec.use-arl.md) %}

{% include [appsec.use-smartcaptcha](../../_security-deck-rules/rules/cspm/appsec.use-smartcaptcha.md) %}

{% include [appsec.use-sws](../../_security-deck-rules/rules/cspm/appsec.use-sws.md) %}

{% include [appsec.use-waf](../../_security-deck-rules/rules/cspm/appsec.use-waf.md) %}

{% include [appsec.secure-registry](../../_security-deck-rules/rules/cspm/appsec.secure-registry.md) %}

{% include [aws-token](../../_security-deck-rules/rules/cspm/aws-token.md) %}

{% include [compute.snapshot](../../_security-deck-rules/rules/cspm/compute.snapshot.md) %}

{% include [crypto.certificate-validity](../../_security-deck-rules/rules/cspm/crypto.certificate-validity.md) %}

{% include [crypto.data.application-encryption](../../_security-deck-rules/rules/cspm/crypto.data.application-encryption.md) %}

{% include [crypto.keys-deletion-protection](../../_security-deck-rules/rules/cspm/crypto.keys-deletion-protection.md) %}

{% include [crypto.keys-hsm](../../_security-deck-rules/rules/cspm/crypto.keys-hsm.md) %}

{% include [crypto.keys-rotation](../../_security-deck-rules/rules/cspm/crypto.keys-rotation.md) %}

{% include [crypto.managed-vm-kms](../../_security-deck-rules/rules/cspm/crypto.managed-vm-kms.md) %}

{% include [crypto.sa-key-rotation](../../_security-deck-rules/rules/cspm/crypto.sa-key-rotation.md) %}

{% include [crypto.secrets-coi](../../_security-deck-rules/rules/cspm/crypto.secrets-coi.md) %}

{% include [crypto.secrets-lockbox](../../_security-deck-rules/rules/cspm/crypto.secrets-lockbox.md) %}

{% include [crypto.secrets-serverless](../../_security-deck-rules/rules/cspm/crypto.secrets-serverless.md) %}

{% include [data.object-storage-encryption](../../_security-deck-rules/rules/cspm/data.object-storage-encryption.md) %}

{% include [data.storage-https](../../_security-deck-rules/rules/cspm/data.storage-https.md) %}

{% include [db.db-deletion-protection](../../_security-deck-rules/rules/cspm/db.db-deletion-protection.md) %}

{% include [cookie-timeout.organization](../../_security-deck-rules/rules/cspm/cookie-timeout.organization.md) %}

{% include [k8s.audit-logs](../../_security-deck-rules/rules/cspm/k8s.audit-logs.md) %}

{% include [k8s.backup](../../_security-deck-rules/rules/cspm/k8s.backup.md) %}

{% include [k8s.kubernetes-safe-config](../../_security-deck-rules/rules/cspm/k8s.kubernetes-safe-config.md) %}

{% include [k8s.network-firewall-scope](../../_security-deck-rules/rules/cspm/k8s.network-firewall-scope.md) %}

{% include [k8s.network-policy](../../_security-deck-rules/rules/cspm/k8s.network-policy.md) %}

{% include [k8s.version-update](../../_security-deck-rules/rules/cspm/k8s.version-update.md) %}

{% include [iam.group-membership-admin](../../_security-deck-rules/rules/cspm/iam.group-membership-admin.md) %}

{% include [network.db-ip](../../_security-deck-rules/rules/cspm/network.db-ip.md) %}

{% include [network.db-security-group](../../_security-deck-rules/rules/cspm/network.db-security-group.md) %}

{% include [network.ddos-protection.l3](../../_security-deck-rules/rules/cspm/network.ddos-protection.l3.md) %}

{% include [network.firewall](../../_security-deck-rules/rules/cspm/network.firewall.md) %}

{% include [network.network-firewall-scope](../../_security-deck-rules/rules/cspm/network.network-firewall-scope.md) %}

{% include [network.network-firewall](../../_security-deck-rules/rules/cspm/network.network-firewall.md) %}

{% include [network.serverless-uses-vpc](../../_security-deck-rules/rules/cspm/network.serverless-uses-vpc.md) %}

{% include [network.ydb-public](../../_security-deck-rules/rules/cspm/network.ydb-public.md) %}

{% include [o11y.audit-trails](../../_security-deck-rules/rules/cspm/o11y.audit-trails.md) %}

{% include [o11y.data-plane-events](../../_security-deck-rules/rules/cspm/o11y.data-plane-events.md) %}

{% include [s3.used-object-lock](../../_security-deck-rules/rules/cspm/s3.used-object-lock.md) %}

{% include [trusted-ip](../../_security-deck-rules/rules/cspm/trusted-ip.md) %}

{% include [trusted-ip-k8s](../../_security-deck-rules/rules/cspm/trusted-ip-k8s.md) %}

## {{ kspm-name }} — {{ kspm-full-name }} {#kspm}

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

