---
title: Cloud infrastructure security standard {{ yandex-cloud }}
description: This section lists the control rules forming part of {{ yandex-cloud }}'s cloud infrastructure security standard.
---

# Cloud infrastructure security standard {{ yandex-cloud }}

The provided rule set contains security controls based on {{ yandex-cloud }}'s cloud infrastructure security [standard](../../../security/standard/all.md).

{{ yandex-cloud }}'s cloud infrastructure security standard provides comprehensive security requirements and best practices for protection of cloud infrastructure and applications deployed on the {{ yandex-cloud }} platform.

These controls help ensure security policy compliance and protection against common threats and security vulnerabilities in cloud environments:

#|
|| Requirement ID | [Security standard](../../../security/standard/all.md) requirement | Check IDs in the [{{ cspm-name }} module](../cspm.md) ||
|| **Authentication and access management** {align="center"} | > | > ||
|| `IAM1` | [An identity federation (Single Sign-On, SSO) is configured](../../../security/standard/all.md#saml-federation) | [cspm.access.idp](../../rules-reference/cspm.md#idp) ||
|| `IAM2` | [User group mapping is set up in the identity federation](../../../security/standard/all.md#group-mapping) | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#user-groups-mapping) ||
|| `IAM3` | [Yandex ID accounts are only used in exceptional cases](../../../security/standard/all.md#yandex-id-accounts) | [cspm.yid.organization](../../rules-reference/cspm.md#yid-organization) ||
|| `IAM4` | [Cookie lifetime in a federation is less than 6 hours](../../../security/standard/all.md#cookie-timeout) | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#organization) ||
|| `IAM5` | [Only appropriate administrators can manage IAM group membership](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| `IAM6` | [Service roles are used instead of primitive ones: admin, editor, viewer, and auditor](../../../security/standard/all.md#min-privileges) | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| `IAM9` | [Service accounts have minimal privileges](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| `IAM10` | [Only trusted administrators have access to service accounts](../../../security/standard/all.md#sa-admins) | [cspm.access.privileged-sa-access](../../rules-reference/cspm.md#privileged-sa-access) ||
|| `IAM11` | [Service account keys are periodically rotated](../../../security/standard/all.md#sa-key-rotation) | [cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
|| `IAM12` | [Minimum required scopes are configured for service account API keys](../../../security/standard/all.md#api-key-scopes) | [cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes) ||
|| `IAM16` | [Getting a token via AWS IMDSv1 is disabled on the VM](../../../security/standard/all.md#aws-token) | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| `IAM17` | [Two-factor authentication for privileged accounts is in place](../../../security/standard/all.md#twofa) | [cspm.access.userpool-mfa](../../rules-reference/cspm.md#userpool-mfa) ||
|| `IAM18` | [Only trusted administrators have privileged roles](../../../security/standard/all.md#privileged-users) | [cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles) ||
|| `IAM22` | [There is no public access to resources within the organization](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| `IAM24` | [Resource labels are used](../../../security/standard/all.md#labels) | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| `IAM26` | [The date of last service account authentication and last access key use in {{ iam-name }} are tracked](../../../security/standard/all.md#key-usage-control) |
[cspm.iam.unused-service-account](../../rules-reference/cspm.md#unused-service-account)
[cspm.iam.unused-key](../../rules-reference/cspm.md#unused-key)
||
|| **Network security** {align="center"} | > | > ||
|| `NET1` | [Cloud objects use a firewall or security groups](../../../security/standard/all.md#firewall) | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| `NET2` | [A security group is created in {{ vpc-full-name }}; the default security group is not used](../../../security/standard/all.md#vpc-sg) | [cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall) ||
|| `NET3` | [Security groups have no access rule that is too broad](../../../security/standard/all.md#access-rule) |
[cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#k8s-network-firewall-scope)
||
|| `NET4` | [Access through control ports is open only for trusted IPs](../../../security/standard/all.md#trusted-ip) |
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| `NET5` | [Protection against DDoS attacks is on](../../../security/standard/all.md#ddos-protection) |
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#l3)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
||
|| `NET10` | [Outbound internet access is controlled](../../../security/standard/all.md#outgoing-access) | [cspm.network.check-outgoing-internet-connection](../../rules-reference/cspm.md#check-outgoing-internet-connection) ||
|| **Secure virtual environment configuration** {align="center"} | > | > ||
|| `ENV1` | [A serial console is either used under control or not used](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| `ENV7` | [There is no public access to the {{ objstorage-name }} bucket](../../../security/standard/all.md#bucket-access) | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| `ENV8` | [{{ objstorage-name }} uses bucket policies](../../../security/standard/all.md#bucket-policy) | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| `ENV9` | [The **Object lock** feature is enabled in {{ objstorage-name }}](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| `ENV14` | [A security group is assigned in managed databases](../../../security/standard/all.md#db-security-group) | [cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group) ||
|| `ENV15` | [No public IP address is assigned in managed databases](../../../security/standard/all.md#db-ip) | [cspm.network.db-ip](../../rules-reference/cspm.md#db-ip) ||
|| `ENV16` | [The deletion protection feature is enabled](../../../security/standard/all.md#deletion-protection) | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| `ENV17` | [The setting for access from {{ datalens-name }} is off if not needed](../../../security/standard/all.md#db-datalens-access) | [cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access) ||
|| `ENV18` | [Access from the management console is disabled in managed databases](../../../security/standard/all.md#db-console-access) | [cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access) ||
|| `ENV19` | [{{ serverless-containers-name }}/{{ sf-short-name }} uses the internal {{ vpc-short-name }} network](../../../security/standard/all.md#vpc-functions) | [cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc) ||
|| `ENV26` | [No public access is allowed for {{ ydb-short-name }}](../../../security/standard/all.md#ydb-public) | [cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public) ||
|| `ENV28` | [ACL configured by IP addresses for {{ container-registry-full-name }}](../../../security/standard/all.md#acl-container-registry) | [cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry) ||
|| `ENV29` | [{{ certificate-manager-full-name }} certificate is valid for at least 30 days](../../../security/standard/all.md#certificate-validity) | [cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity) ||
|| `ENV30` | [{{ mgl-full-name }} instance security recommendations are followed](../../../security/standard/all.md#git-lab-secure) | [cspm.o11y.gitlab-audited](../../rules-reference/cspm.md#gitlab-audited) ||
|| `ENV33` | [{{ oslogin }} is used for connection to a VM or {{ k8s }} node](../../../security/standard/all.md#os-login-onto-hosts) | [cspm.access.os-login-onto-hosts.vm](../../rules-reference/cspm.md#vm) ||
|| `ENV37` | [{{ backup-short-name }} or scheduled snapshots are used](../../../security/standard/all.md#snapshot) | [cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks) ||
|| **Data encryption and key management** {align="center"} | > | > ||
|| `CRYPT1` | [At-rest encryption with a {{ kms-short-name }} key is enabled in {{ objstorage-full-name }}](../../../security/standard/all.md#storage-kms) | [cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption) ||
|| `CRYPT2` | [HTTPS for static website hosting is enabled in {{ objstorage-full-name }}](../../../security/standard/all.md#storage-https) | [cspm.data.storage-https](../../rules-reference/cspm.md#storage-https) ||
|| `CRYPT3` | [{{ alb-full-name }} uses HTTPS](../../../security/standard/all.md#alb-https) | [cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https) ||
|| `CRYPT4` | [{{ api-gw-full-name }} uses HTTPS and its own domain](../../../security/standard/all.md#api-gateway-https) | [cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https) ||
|| `CRYPT5` | [{{ cdn-full-name }} uses HTTPS and its own SSL certificate](../../../security/standard/all.md#cdn-https) | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| `CRYPT8` | [Disk and virtual machine snapshot encryption is used](../../../security/standard/all.md#managed-vm-kms) | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| `CRYPT9` | [{{ kms-name }} keys are stored in a Hardware Security Module (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| `CRYPT10` | [Permissions to manage keys in {{ kms-short-name }} are issued to controlled users](../../../security/standard/all.md#keys-controlled-users) | [cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access) ||
|| `CRYPT11` | [Rotation is enabled for {{ kms-short-name }} keys](../../../security/standard/all.md#keys-rotation) | [cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation) ||
|| `CRYPT12` | [Deletion protection is enabled for {{ kms-short-name }} keys](../../../security/standard/all.md#keys-deletion-protection) | [cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection) ||
|| `CRYPT13` | [The organization uses {{ lockbox-full-name }} for secure secret storage](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| `CRYPT14` | [For {{ serverless-containers-name }} and {{ sf-name }}, {{ lockbox-short-name }}](../../../security/standard/all.md#secrets-serverless-functions) secrets are used | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| `CRYPT16` | [Cloud administrator is instructed what to do if cloud secrets get compromised](../../../security/standard/all.md#secrets-scanning) | [cspm.crypto.leaked-secrets-detection](../../rules-reference/cspm.md#leaked-secrets-detection) ||
|| **Collection, monitoring, and analysis of audit logs** {align="center"} | > | > ||
|| `AUDIT1` | [{{ at-full-name }} is enabled at the organization level](../../../security/standard/all.md#audit-trails) |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#audit-trails-no-errors)
[cspm.o11y.gitlab-audited](../../rules-reference/cspm.md#gitlab-audited)
||
|| `AUDIT3` | [Response to {{ at-full-name }} events has been configured](../../../security/standard/all.md#reaction) | [cspm.o11y.audit-trails-reactions](../../rules-reference/cspm.md#audit-trails-reactions) ||
|| `AUDIT8` | [Data events are monitored](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Application security** {align="center"} | > | > ||
|| `APPSEC1` | [{{ captcha-full-name }} is used](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| `APPSEC2` | [Docker images are scanned when uploaded to {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| `APPSEC3` | [Docker images stored in {{ container-registry-name }} are regularly scanned](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| `APPSEC4` | [Container images used in production environment were last scanned one week ago or less](../../../security/standard/all.md#last-scan-date) | [cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan) ||
|| `APPSEC9` | [A {{ sws-full-name }} profile is used](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| `APPSEC10` | [A web application firewall is used](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| `APPSEC11` | [Advanced Rate Limiter is used](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **{{ k8s }} security** {align="center"} | > | > ||
|| `K8S3` | [There is no access to the {{ k8s }} API and node groups from untrusted networks](../../../security/standard/all.md#api-security) | [cspm.k8s.api-security](../../rules-reference/cspm.md#api-security) ||
|| `K8S4` | [Authentication and access management are configured in {{ managed-k8s-name }}](../../../security/standard/all.md#kubernetes-auth) | [cspm.k8s.access](../../rules-reference/cspm.md#access) ||
|| `K8S5` | [{{ managed-k8s-full-name }} uses a safe configuration](../../../security/standard/all.md#kubernetes-safe-config) |
[cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration)
[cspm.k8s.cis](../../rules-reference/cspm.md#cis)
||
|| `K8S11` | [A {{ k8s }} security policy is used](../../../security/standard/all.md#security-standards) |
[cspm.k8s.kspm](../../rules-reference/cspm.md#kspm)
[cspm.k8s.disallow-k8s-not-regional](../../rules-reference/cspm.md#disallow-k8s-not-regional)
||
|#