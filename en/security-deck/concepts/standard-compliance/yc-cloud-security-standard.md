---
title: '{{ yandex-cloud }} Security Standard'
description: This section contains the list of security requirements that are part of the {{ yandex-cloud }} Security Standard rule set.
---

# {{ yandex-cloud }} Security Standard

{% include [note-preview](../../../_includes/note-preview.md) %}

This rule set contains security controls based on the [{{ yandex-cloud }} Security Standard](../../../security/standard/all.md).

The {{ yandex-cloud }} Security Standard provides comprehensive security requirements and best practices for protecting cloud infrastructure and applications deployed on {{ yandex-cloud }} platform.

These controls help ensure compliance with security policies and protect against common cloud security threats and vulnerabilities:

Requirement ID | [Security standard](../../../security/standard/all.md) requirement | [CSPM](../cspm.md) rule check ID
--- | --- | ---
`IAM6` | [Service roles are used instead of primitive ones: admin, editor, viewer, auditor](../../../security/standard/all.md#min-privileges) | `cspm.access.min-privileges`
`IAM9` | [Service accounts are assigned minimum privileges](../../../security/standard/all.md#sa-privileges) | `cspm.access.sa-privileges`
`IAM12` | [A scope is set for service account API keys](../../../security/standard/all.md#api-key-scopes) | `cspm.access.defined-key-scopes`
`IAM22` | [No public access for resources in the organization](../../../security/standard/all.md#public-access) | `cspm.access.public-access`
`NET2` | [At least one security group exists in the {{ vpc-full-name }}](../../../security/standard/all.md#vpc-sg) | `cspm.network.network-firewall`
`NET3` | [Security groups do not contain overly broad access rules](../../../security/standard/all.md#access-rule) | `cspm.network.network-firewall-scope`
`NET5` | [DDoS protection is enabled](../../../security/standard/all.md#ddos-protection) | `cspm.appsec.ddos-protection.l7`
`ENV1` | [Use of the serial console is controlled or disabled](../../../security/standard/all.md#serial-console) | `cspm.access.serial-console`
`ENV7` | [No public access to the {{ objstorage-full-name }} bucket](../../../security/standard/all.md#bucket-access) | `cspm.access.bucket-public-access`
`ENV14` | [A Security Group is assigned to managed databases](../../../security/standard/all.md#db-security-group) | `cspm.network.db-security-group`
`ENV15` | [Managed databases do not have a public IP address assigned](../../../security/standard/all.md#db-ip) | `cspm.network.db-ip`
`ENV16` | [Deletion protection is enabled](../../../security/standard/all.md#deletion-protection) | `cspm.db.db-deletion-protection`
`ENV17` | [{{ datalens-full-name }} access is disabled unless required](../../../security/standard/all.md#db-datalens-access) | `cspm.access.db-datalens-access`
`ENV18` | [Console access to managed databases is disabled](../../../security/standard/all.md#db-console-access) | `cspm.access.db-console-access`
`ENV26` | [No public access for {{ ydb-short-name }}](../../../security/standard/all.md#ydb-public) | `cspm.network.ydb-public`
`ENV28` | [ACL by IP address is configured for {{ container-registry-full-name }}](../../../security/standard/all.md#acl-container-registry) | `cspm.access.acl-container-registry`
`ENV29` | [{{ certificate-manager-full-name }} certificate validity is at least 30 days](../../../security/standard/all.md#certificate-validity) | `cspm.crypto.certificate-validity`
`ENV33` | [{{ oslogin }} is used to access a virtual machine or {{ k8s }} node](../../../security/standard/all.md#os-login-onto-hosts) | `cspm.access.os-login-onto-hosts.vm`
`ENV34` | [Vulnerability scanning is performed at the cloud IP address level](../../../security/standard/all.md#ip-level) | `cspm.active.ip-vulnerability-scan`
`CRYPT1` | [{{ objstorage-full-name }} data-at-rest encryption with a {{ kms-short-name }} key is enabled](../../../security/standard/all.md#storage-kms) | `cspm.data.object-storage-encryption`
`CRYPT3` | [HTTPS is used in {{ alb-full-name }}](../../../security/standard/all.md#alb-https) | `cspm.appsec.alb-https`
`CRYPT5` | [{{ cdn-full-name }} uses HTTPS and a custom SSL certificate](../../../security/standard/all.md#cdn-https) | `cspm.appsec.cdn-https`
`CRYPT7` | [Application-level data encryption is used](../../../security/standard/all.md#self-data-app) | `cspm.data.application-encryption`
`CRYPT8` | [VM disks and snapshots are encrypted](../../../security/standard/all.md#managed-vm-kms) | `cspm.crypto.managed-vm-kms`
`CRYPT11` | [{{ kms-short-name }} key rotation is enabled](../../../security/standard/all.md#keys-rotation) | `cspm.crypto.keys-rotation`
`CRYPT12` | [{{ kms-short-name }} key deletion protection is enabled](../../../security/standard/all.md#keys-deletion-protection) | `cspm.crypto.keys-deletion-protection`
`CRYPT13` | [{{ lockbox-full-name }} is used in the organization for secure secret storage](../../../security/standard/all.md#secrets-lockbox) | `cspm.crypto.secrets-lockbox`
`CRYPT14` | [{{ lockbox-name }} secrets are used for {{ serverless-containers-full-name }} and {{ sf-full-name }}](../../../security/standard/all.md#secrets-serverless-functions) | `cspm.crypto.secrets-serverless`
`AUDIT1` | [{{ at-full-name }} is enabled at the organization level](../../../security/standard/all.md#audit-trails) | `cspm.o11y.audit-trails`
`AUDIT8` | [Data-plane events are monitored](../../../security/standard/all.md#data-plane-events) | `cspm.o11y.data-plane-events`
`APPSEC2` | [Docker images are scanned upon upload to {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | `appsec.secure-registry`
`APPSEC3` | [Periodic scanning of Docker images stored in {{ container-registry-name }} is performed](../../../security/standard/all.md#periodic-scan) | `cspm.appsec.periodic-scan`
`APPSEC9` | [A {{ sws-full-name }} security profile is used](../../../security/standard/all.md#use-sws) | `cspm.appsec.use-sws`
`APPSEC11` | [Advanced Rate Limiter is used](../../../security/standard/all.md#use-arl) | `cspm.appsec.use-arl`
`K8S5` | [A secure configuration is used in {{ managed-k8s-full-name }}](../../../security/standard/all.md#kubernetes-safe-config) | `cspm.k8s.secure-configuration`
`K8S8` | [One of the three latest {{ k8s }} versions is used and updates are monitored](../../../security/standard/all.md#version-update) | `cspm.k8s.version-update`
`K8S12` | [Audit log collection is configured for incident investigations](../../../security/standard/all.md#audit-logs) | `cspm.k8s.audit-logs`