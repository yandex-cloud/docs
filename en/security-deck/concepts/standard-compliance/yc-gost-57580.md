---
title: GOST R 57580 requirements
description: This section sets forth rules that help you automate compliance with the GOST R 57580 Russian national security standard for banking and financial operations.
---

# GOST R 57580 requirements

{% include [note-preview](../../../_includes/note-preview.md) %}

GOST R 57580 is the national security standard for banking and financial operations. This standard defines information protection levels and establishes baseline administrative and technical safeguards for each tier.

The standard aligns implemented controls with the active threat landscape and accepted operational risks associated with financial and banking services, including money transfers.

These rules help ensure compliance with GOST R 57580:

#|
|| Security standard requirement | Check IDs in the [{{ cspm-name }} module](../cspm.md) ||
|| **7.2.1. Subprocess _Managing accounts and permissions of logical access subjects_** {.cell-align-center} | > ||
|| УЗП.10; УЗП.17–УЗП.21 | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| УЗП.22–УЗП.27 | [cspm.access.check-privileged-roles](../../rules-reference/cspm.md#check-privileged-roles) ||
|| УЗП.22–УЗП.25; УЗП.28 | [cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access) ||
|| УЗП.8–УЗП.13; УЗП.17–УЗП.20 | [cspm.access.check-bindings](../../rules-reference/cspm.md#check-bindings) ||
|| УЗП.10; УЗП.17–УЗП.21 | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| РД.14–РД.15 | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#ccookie-timeout-organization) ||
|| УЗП.22–УЗП.25 | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| РД.31; УЗП.17–УЗП.20 | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#user-groups-mapping) ||
|| **7.2.2. Subprocess _Identification, authentication, and authorization (access control) associated with logical access_** {.cell-align-center} | > ||
|| РД.30-РД.31; РД.39-РД.44 |
[cspm.access.idp](../../rules-reference/cspm.md#idp)
[cspm.k8s.access](../../rules-reference/cspm.md#access)
||
|| РД.14–РД.15; РД.30–РД.31 | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| РД.17–РД.18 |
[cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| РЗИ.14 | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| РД.30–РД.31 |
[cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access)
[cspm.access.os-login-onto-hosts.vm](../../rules-reference/cspm.md#vm)
||
|| РД.31; УЗП.17–УЗП.20 | [cspm.access.user-groups-mapping](../../rules-reference/cspm.md#user-groups-mapping) ||
|| РД.30–РД.31; ИУ.7–ИУ.8 | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| РД.31 | [cspm.k8s.kspm](../../rules-reference/cspm.md#kspm) ||
|| **7.2.4. Subprocess _Identifying and registering resources and access objects_** {.cell-align-center} | > ||
|| УЗП.10; УЗП.17–УЗП.20 |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| УЗП.22–УЗП.25 | [cspm.access.privileged-sa-access](../../rules-reference/cspm.md#privileged-sa-access) ||
|| РД.29; РД.43–РД.44 | [cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
|| РД.30–РД.31 | [cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes) ||
|| СМЭ.16–СМЭ.19; ИУ.7–ИУ.8 | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| ИУ.1–ИУ.4 | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| РД.30–РД.31; ИУ.7–ИУ.8 | [cspm.access.bucket-access-policy](../../rules-reference/cspm.md#bucket-access-policy) ||
|| **7.3.1. Subprocess _Network segmentation and firewalling_** {.cell-align-center} | > ||
|| СМЭ.3; СМЭ.9; СМЭ.16; СМЭ.21 | [cspm.network.network-firewall](../../rules-reference/cspm.md#network-firewall) ||
|| СМЭ.3; СМЭ.16 | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| СМЭ.16–СМЭ.19; СМЭ.21 |
[cspm.access.public-access](../../rules-reference/cspm.md#public-access)
[cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| СМЭ.16–СМЭ.19 |
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc)
[cspm.k8s.api-security](../../rules-reference/cspm.md#api-security)
||
|| СМЭ.1 | [cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc) ||
|| СМЭ.17 | [cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access) ||
|| СМЭ.19 | [cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry) ||
|| СМЭ.16–СМЭ.19; ИУ.7–ИУ.8 | [cspm.access.bucket-public-access](../../rules-reference/cspm.md#bucket-public-access) ||
|| **7.3.2. Subprocess _Detecting intrusions and network attacks_** {.cell-align-center} | > ||
|| ВСА.8; ВСА.9 | [cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3) ||
|| ВСА.1–ВСА.7; BCA.11–BCA.13 |
[cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws)
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
||
|| ВСА.1–ВСА.7 | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **7.3.3. Subprocess _Protecting information transmitted over computer networks_** {.cell-align-center} | > ||
|| 3ВС.1–3ВС.2 | [cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity) ||
|| 3ВС.2 |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| **7.4.2. Subprocess _Vulnerability management_** {.cell-align-center} | > ||
|| ЦЗИ.4–ЦЗИ.6 | [cspm.aws-token](../../rules-reference/cspm.md#aws-token) ||
|| ЦЗИ.1–ЦЗИ.11; ЦЗИ.20–ЦЗИ.26 | [cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration) ||
|| ЦЗИ.1–ЦЗИ.11; ЦЗИ.20–ЦЗИ.26 | [cspm.o11y.gitlab-audited](../../rules-reference/cspm.md#gitlab-audited) ||
|| **7.4.3. Subprocess _Software placement, storage, and update governance_** {.cell-align-center} | > ||
|| ЦЗИ.16 | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| ЦЗИ.1–ЦЗИ.11; ЦЗИ.20–ЦЗИ.26 | [cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration) ||
|| ЦЗИ.1–ЦЗИ.11; ЦЗИ.20–ЦЗИ.26 | [cspm.o11y.gitlab-audited](../../rules-reference/cspm.md#gitlab-audited) ||
|| **7.4.4. Subprocess _Software inventory management and integrity control across the IT infractructure_** {.cell-align-center} | > ||
|| ЦЗИ.1–ЦЗИ.11; ЦЗИ.20–ЦЗИ.26 |
[cspm.k8s.secure-configuration](../../rules-reference/cspm.md#secure-configuration)
[cspm.o11y.gitlab-audited](../../rules-reference/cspm.md#gitlab-audited)
||
|| **7.5. Process 4 _Protection against malicious code_** {.cell-align-center} | > ||
|| ЗВК.8–ЗВК.12 | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| ЗВК.11–ЗВК.12 | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| ЗВК.20; ЗВК.12 | [cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan) ||
|| ЗВК.20; ЗВК.11–ЗВК.12 | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| **7.7.1. Subprocess _Information security event monitoring and analysis_** {.cell-align-center} | > ||
|| МАС.1–МАС.9 |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha)
||
|| МАС.1–МАС.7 | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| МАС.22 | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| **6.12. General provisions for the use of cryptographic information protection tools** {.cell-align-center} | > ||
|| РЗИ.14 |
[cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm)
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| РД.17–РД.18 | [cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https) ||
|| УЗП.28 |
[cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation)
[cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection)
||
|#
