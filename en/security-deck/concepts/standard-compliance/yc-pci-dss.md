---
title: PCI DSS requirements
description: This section sets forth rules that help you automate compliance with the Payment Card Industry Data Security Standard (PCI DSS).
---

# PCI DSS requirements

{% include [note-preview](../../../_includes/note-preview.md) %}

These rules help you automate compliance with data security standards designed to protect payment card data.

The standard was established by the Payment Card Industry Security Standards Council (PCI SSC) founded by major international payment systems including Visa, MasterCard, American Express, Discover, and JCB.

To ensure PCI DSS compliance, use the following rules:

#|
|| Requirement ID | Security standard requirement | Check IDs in the [{{ cspm-name }} module](../cspm.md) ||
|| **1. Installing and maintaining network security controls** {.cell-align-center} | > | > ||
|| 1.2 | Configuration and maintenance of network security controls (NSCs) |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
||
|| 1.3 | Restricted network access to and from the cardholder data environment (CDE) |
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
||
|| 1.4 | Control of network connections between trusted and untrusted networks |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
||
|| **2. Applying secure configurations to all system components** {.cell-align-center} | > | > ||
|| 2.2 | Secure configuration and management of system components |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
||
|| **3. Protecting stored account data** {.cell-align-center} | > | > ||
|| 3.2, 3.3, 3.4 | Minimized storage time, prohibition to store SAD, masked PAN display | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| 3.5 | Ensuring that stored PANs are unreadable |
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
||
|| 3.6, 3.7 | Protection and management of cryptographic keys |
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm)
[cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation)
[cspm.crypto.keys-deletion-protection](../../rules-reference/cspm.md#keys-deletion-protection)
[cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
||
|| **4. Protecting transmission of cardholder data over public networks with strong cryptography** {.cell-align-center} | > | > ||
|| 4.2 | Protection of PANs with strong cryptography during transmission |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
||
|| **5. Protecting all systems and networks against malware** {.cell-align-center} | > | > ||
|| 5.2, 5.3 | Prevention, detection, and removal of malware; ensuring the mechanisms are actively running | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| 5.4 | Protecting users against phishing attacks | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| **6. Developing and maintaining secure systems and software** {.cell-align-center} | > | > ||
|| 6.3 | Detecting and addressing security vulnerabilities |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| 6.4 | Protecting public-facing web applications against attacks |
[cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws)
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl)
[cspm.appsec.ddos-protection.l7](../../rules-reference/cspm.md#l7)
[cspm.appsec.ddos-protection.l3](../../rules-reference/cspm.md#appsec-ddos-protection-l3)
||
|| **7. Restricting access to system components and cardholder data based on need to know** {.cell-align-center} | > | > ||
|| 7.2 | Proper identification of system components and data and provision of access to them |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
[cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access)
[cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| 7.3 | Managing access to system components and data via one or more access management systems | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| **8. User identification and authentication for access to system components** {.cell-align-center} | > | > ||
|| 8.3 | Reliable authentication for users and administrators |
[cspm.access.serial-console](../../rules-reference/cspm.md#serial-console)
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
||
|| 8.6 | Managing the use of application or system accounts |
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
||
|| **10. Recording and monitoring all access events to system components and cardholder data** {.cell-align-center} | > | > ||
|| 10.2 | Generating security event logs with required details |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
[cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events)
||
|| **11. Regular testing of system and network security** {.cell-align-center} | > | > ||
|| 11.3 | Regular detection, prioritization, and elimination of external and internal vulnerabilities |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
||
|| **12. Maintaining information security with organizational policies and programs** {.cell-align-center} | > | > ||
|| 12.10 | Incident response |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|#
