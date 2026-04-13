---
title: '{{ yandex-cloud }} Security Standard'
description: This section contains the list of security requirements that are part of the {{ yandex-cloud }} Security Standard rule set.
---

# {{ yandex-cloud }} Security Standard

{% include [note-preview](../../../_includes/note-preview.md) %}

This rule set contains security controls based on the [{{ yandex-cloud }} Security Standard](../../../security/standard/all.md).

The {{ yandex-cloud }} Security Standard provides comprehensive security requirements and best practices for protecting cloud infrastructure and applications deployed on {{ yandex-cloud }} platform.

These controls help ensure compliance with security policies and protect against common cloud security threats and vulnerabilities:

#|
|| Requirement ID | [Security standard](../../../security/standard/all.md) requirement | [{{ cspm-name }}](../cspm.md) rule check IDs ||
|| **Authentication and Access Management** {.cell-align-center} | > | > ||
|| `IAM1` | [Identity Federation (Single Sign-On, SSO) is configured](../../../security/standard/all.md#saml-federation) | [cspm.access.uses-federation](../../rules-reference/cspm.md#uses-federation) ||
|| `IAM2` | [User group mapping is set up in an identity federation](../../../security/standard/all.md#group-mapping) | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#access-user-groups-mapping) ||
|| `IAM4` | [The cookie lifetime in a federation is less than 6 hours](../../../security/standard/all.md#cookie-timeout) | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#cookie-timeout-organization) ||
|| `IAM5` | [Only appropriate administrators can manage IAM group membership](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| `IAM6` | [Service roles are used instead of primitive ones: admin, editor, viewer, auditor](../../../security/standard/all.md#min-privileges) | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| `IAM9` | [Service accounts are assigned minimum privileges](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| `IAM10` | [Only trusted administrators have access to service accounts](../../../security/standard/all.md#sa-admins) | [cspm.access.privileged-sa-access](../../rules-reference/cspm.md#access-privileged-sa-access) ||
|| `IAM11` | [Service account keys are rotated periodically](../../../security/standard/all.md#sa-key-rotation) | [cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
|| `IAM12` | [A scope is set for service account API keys](../../../security/standard/all.md#api-key-scopes) | [cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes) ||
|| `IAM16` | [Getting a token via AWS IMDSv1 is disabled on the VM](../../../security/standard/all.md#aws-token) | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| `IAM18` | [Only trusted administrators have privileged roles](../../../security/standard/all.md#privileged-users) | [cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles) ||
|| `IAM22` | [No public access for resources in the organization](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| `IAM23` | [Organization contact information is up to date](../../../security/standard/all.md#org-contacts) | [cspm.procedure.organization-contacts](../../rules-reference/cspm.md#organization-contacts) ||
|| `IAM24` | [Resource labels are used](../../../security/standard/all.md#labels) | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| `IAM27` | [Access permissions of users and service accounts are regularly audited using the {{ sd-full-name }} {{ ciem-name }}](../../../security/standard/all.md#ciem-access-control) | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings) ||
|| **Network Security** {.cell-align-center} | > | > ||
|| `NET1` | [A firewall or security groups are used for cloud resources](../../../security/standard/all.md#firewall) | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| `NET2` | [At least one security group exists in the {{ vpc-full-name }}](../../../security/standard/all.md#vpc-sg) | [cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall) ||
|| `NET3` | [Security groups do not contain overly broad access rules](../../../security/standard/all.md#access-rule) |
[cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#k8s-network-firewall-scope)
||
|| `NET4` | [Access through control ports is only allowed for trusted IPs](../../../security/standard/all.md#trusted-ip) |
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| `NET5` | [DDoS protection is enabled](../../../security/standard/all.md#ddos-protection) |
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
||
|| **Secure Virtual Environment Configuration** {.cell-align-center} | > | > ||
|| `ENV1` | [Use of the serial console is controlled or disabled](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| `ENV7` | [No public access to the {{ objstorage-name }} bucket](../../../security/standard/all.md#bucket-access) | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| `ENV8` | [{{ objstorage-name }} uses bucket policies](../../../security/standard/all.md#bucket-policy) | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| `ENV9` | [The Object lock feature is enabled in {{ objstorage-name }}](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| `ENV14` | [A Security Group is assigned to managed databases](../../../security/standard/all.md#db-security-group) | [cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group) ||
|| `ENV15` | [Managed databases do not have a public IP address assigned](../../../security/standard/all.md#db-ip) | [cspm.network.db-ip](../../rules-reference/cspm.md#db-ip) ||
|| `ENV16` | [Deletion protection is enabled](../../../security/standard/all.md#deletion-protection) | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| `ENV17` | [{{ datalens-name }} access is disabled unless required](../../../security/standard/all.md#db-datalens-access) | [cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access) ||
|| `ENV18` | [Console access to managed databases is disabled](../../../security/standard/all.md#db-console-access) | [cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access) ||
|| `ENV19` | [{{ serverless-containers-short-name }}/{{ sf-short-name }} uses the VPC internal network](../../../security/standard/all.md#vpc-functions) | [cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc) ||
|| `ENV26` | [No public access for {{ ydb-short-name }}](../../../security/standard/all.md#ydb-public) | [cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public) ||
|| `ENV28` | [ACL by IP address is configured for {{ container-registry-full-name }}](../../../security/standard/all.md#acl-container-registry) | [cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry) ||
|| `ENV29` | [{{ certificate-manager-full-name }} certificate validity is at least 30 days](../../../security/standard/all.md#certificate-validity) | [cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity) ||
|| `ENV33` | [{{ oslogin }} is used to access a virtual machine or {{ k8s }} node](../../../security/standard/all.md#os-login-onto-hosts) | [cspm.access.os-login-onto-hosts.vm](../../rules-reference/cspm.md#vm) ||
|| `ENV34` | [Vulnerability scanning is performed at the cloud IP address level](../../../security/standard/all.md#ip-level) | [cspm.active.ip-vulnerability-scan](../../rules-reference/cspm.md#ip-vulnerability-scan) ||
|| `ENV37` | [{{ backup-short-name }} or scheduled snapshots are used](../../../security/standard/all.md#snapshot) |
[cspm.compute.snapshot](../../rules-reference/cspm.md#snapshot)
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| **Data Encryption and Key Management** {.cell-align-center} | > | > ||
|| `CRYPT1` | [{{ objstorage-name }} data-at-rest encryption with a {{ kms-short-name }} key is enabled](../../../security/standard/all.md#storage-kms) | [cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption) ||
|| `CRYPT2` | [HTTPS is enabled for {{ objstorage-full-name }} static website hosting](../../../security/standard/all.md#storage-https) | [cspm.data.storage-https](../../rules-reference/cspm.md#storage-https) ||
|| `CRYPT3` | [HTTPS is used in {{ alb-full-name }}](../../../security/standard/all.md#alb-https) | [cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https) ||
|| `CRYPT4` | [HTTPS and a custom domain are used in {{ api-gw-full-name }}](../../../security/standard/all.md#api-gateway-https) | [cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https) ||
|| `CRYPT5` | [{{ cdn-full-name }} uses HTTPS and a custom SSL certificate](../../../security/standard/all.md#cdn-https) | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| `CRYPT7` | [Application-level data encryption is used](../../../security/standard/all.md#self-data-app) | [cspm.data.application-encryption](../../rules-reference/cspm.md#application-encryption) ||
|| `CRYPT8` | [VM disks and snapshots are encrypted](../../../security/standard/all.md#managed-vm-kms) | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| `CRYPT9` | [{{ kms-short-name }} keys are stored in a Hardware Security Module (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| `CRYPT10` | [Permissions to manage keys in {{ kms-short-name }} are granted to controlled users](../../../security/standard/all.md#keys-controlled-users) | [cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access) ||
|| `CRYPT11` | [{{ kms-short-name }} key rotation is enabled](../../../security/standard/all.md#keys-rotation) | [cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation) ||
|| `CRYPT12` | [{{ kms-short-name }} key deletion protection is enabled](../../../security/standard/all.md#keys-deletion-protection) | [cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection) ||
|| `CRYPT13` | [{{ lockbox-full-name }} is used in the organization for secure secret storage](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| `CRYPT14` | [{{ lockbox-short-name }} secrets are used for {{ serverless-containers-name }} and {{ sf-name }}](../../../security/standard/all.md#secrets-serverless-functions) | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| **Collection, Monitoring, and Analysis of Audit Logs** {.cell-align-center} | > | > ||
|| `AUDIT1` | [{{ at-full-name }} is enabled at the organization level](../../../security/standard/all.md#audit-trails) |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| `AUDIT5` | [OS-level audit logs are collected](../../../security/standard/all.md#os-level) | [cspm.o11y.os-logs-audited](../../rules-reference/cspm.md#os-logs-audited) ||
|| `AUDIT8` | [Data-plane events are monitored](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Application Protection** {.cell-align-center} | > | > ||
|| `APPSEC1` | [{{ captcha-full-name }} is used](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| `APPSEC2` | [Docker images are scanned upon upload to {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| `APPSEC3` | [Periodic scanning of Docker images stored in {{ container-registry-name }} is performed](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| `APPSEC4` | [Container images used in the production environment have the last scan date of one week ago or less](../../../security/standard/all.md#last-scan-date) | [cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan) ||
|| `APPSEC9` | [A {{ sws-name }} security profile is used](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| `APPSEC10` | [Web Application Firewall is used](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| `APPSEC11` | [Advanced Rate Limiter is used](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **{{ k8s }} Security** {.cell-align-center} | > | > ||
|| `K8S3` | [There is no access to the {{ k8s }} API](../../../security/standard/all.md#api-security) | [cspm.k8s.api-security](../../rules-reference/cspm.md#api-security) ||
|| `K8S4` | [Authentication and access management are configured in {{ managed-k8s-name }}](../../../security/standard/all.md#kubernetes-auth) | [cspm.k8s.access](../../rules-reference/cspm.md#access) ||
|| `K8S5` | [A secure configuration is used in {{ managed-k8s-full-name }}](../../../security/standard/all.md#kubernetes-safe-config) | [cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration) ||
|| `K8S8` | [One of the three latest {{ k8s }} versions is used and updates are monitored](../../../security/standard/all.md#version-update) | [cspm.k8s.version-update](../../rules-reference/cspm.md#version-update) ||
|| `K8S11` | [The {{ k8s }} security policy is in place](../../../security/standard/all.md#security-standards) | [cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm) ||
|| `K8S12` | [Audit log collection is configured for incident investigations](../../../security/standard/all.md#audit-logs) | [cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs)  ||
|#