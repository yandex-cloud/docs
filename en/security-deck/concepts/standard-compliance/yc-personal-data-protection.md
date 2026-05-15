---
title: Requirements of the Federal Law FZ-152 on Personal Data
description: This collection of rules automates legal compliance monitoring for laws and regulations on personal data protection.
---

# Requirements of the Federal Law FZ-152 on Personal Data

{% include [note-preview](../../../_includes/note-preview.md) %}

This collection of rules automates legal compliance monitoring in {{ yandex-cloud }} resources as per Russian Federal Law No. 152-FZ of July 27, 2006.

These rules ensure protection of personal data in accordance with FSTEC Requirements (Order 21):

#|
|| Requirement ID | Security standard requirement | Check IDs in the [{{ cspm-name }} module](../cspm.md) ||
|| **Identification and authentication of access subjects and access objects** (IA) {.cell-align-center} | > | > ||
|| IA.1 | Identification and authentication of users who are the operator's employees | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings}) ||
|| IA.4 | Management of authentication means including the storage, issue, initialization and blocking of authentication means and taking relevant measures in case of loss and/or compromising a means of authentication |
[cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox)
[cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless)
[cspm.crypto.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation)
[cspm.aws-token](../../rules-reference/cspm.md#aws-token)
||
|| **Management of access by access subjects to access objects** (MA) {.cell-align-center} | > | > ||
|| MA.2 | Implementation of necessary access control methods (discretionary, mandate, role-based or other method), types (reading, recording, execution or other type) and rules |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.defined-key-scopes](../../rules-reference/cspm.md#defined-key-scopes)
[cspm.access.db-datalens-access](../../rules-reference/cspm.md#db-datalens-access)
[cspm.access.db-console-access](../../rules-reference/cspm.md#db-console-access)
||
|| MA.3 | Management of information flows between devices (filtration, routing, connection control, one-way transmission and other management methods), segments of the information system and information systems |
[cspm.network.firewall](../../rules-reference/cspm.md#firewall)
[cspm.network.db-security-group](../../rules-reference/cspm.md#db-security-group)
[cspm.network.db-ip](../../rules-reference/cspm.md#db-ip)
[cspm.network.ydb-public](../../rules-reference/cspm.md#ydb-public)
[cspm.network.serverless-uses-vpc](../../rules-reference/cspm.md#serverless-uses-vpc)
[cspm.trusted-ip](../../rules-reference/cspm.md#trusted-ip)
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
[cspm.k8s.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope)
||
|| MA.4 | Separation of powers (roles) of users, administrators and persons in charge of the information system's operation |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| MA.5 | Granting minimal necessary rights and privileges to users, administrators and persons in charge of the information system's operation |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
[cspm.access.kms-keys-access](../../rules-reference/cspm.md#kms-keys-access)
||
|| MA.6 | Limiting unsuccessful attempts to log in to the information system (access to the information system) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| MA.10 | Blocking access session to the information system upon the expiry of a determined user's idle time (inactivity) or at the user's request | [cspm.cookie-timeout.organization](../../rules-reference/cspm.md#cookie-timeout-organization) ||
|| MA.11 | Authorization (ban) of user's acts permitted before identification and authentication | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| MA.13 | Implementation of protected remote access by access subjects to access objects through external information telecommunication network | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| MA.17 | Providing trusted loading of computer equipment | [cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms) ||
|| **Software environment restrictions** (SER) {.cell-align-center} | > | > ||
|| SER.1 | Managing execution of software components, including defining components to be executed, configuring the execution parameters of components, and monitoring execution of software components |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm)
||
|| SER.2 | Managing installation of software components, including defining components to be installed, configuring the installation parameters of components, and monitoring installation of software components |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
||
|| SER.3 | Restrictions for only authorized software and/or installation of its components |
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
[cspm.access.acl-container-registry](../../rules-reference/cspm.md#acl-container-registry)
||
|| **Security event logging** (SEL) {.cell-align-center} | > | > ||
|| SEL.1 | Determining security events to be logged and their storage time |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| SEL.2 | Determining scope and contents of information about security events to be logged |
[cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events)
||
|| SEL.3 | Collecting, recording and storing information on security events during the determined storage time |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
[cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors)
||
|| SEL.4 | Responding to failures when recording security events, including hardware and software errors, failures in information collection mechanisms, and reaching the limit or overflow of memory capacity | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|| SEL.7 | Protection of information on security events |
[cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock)
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
||
|| **Virus protection** (VP) {.cell-align-center} | > | > ||
|| VP.1 | Implementation of virus protection |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| VP.2 | Updating the database of malware (virus) signatures | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| **Intrusion detection system** (IDS) {.cell-align-center} | > | > ||
|| IDS.1 | Intrusion detection |
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws)
||
|| IDS.2 | Decision rule base update | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| **Control (analysis) of personal data security** (AS) {.cell-align-center} | > | > ||
|| AS.1 | Detection and analysis of the information system's vulnerabilities and prompt elimination of newly detected vulnerabilities |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| AS.3 | Control of operability, settings and faultless operation of software and information protection means |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
||
|| AS.4 | Control of composition of hardware, software, and information protection means | [cspm.o11y.labeled-resources](../../rules-reference/cspm.md#labeled-resources) ||
|| AS.5 | Password policy | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| **Integrity of the information system and information** (INT) {.cell-align-center} | > | > ||
|| INT.2 | Control of integrity of information stored in the information system databases |
[cspm.data.object-storage-encryption](../../rules-reference/cspm.md#object-storage-encryption)
[cspm.crypto.managed-vm-kms](../../rules-reference/cspm.md#managed-vm-kms)
[cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm)
[cspm.crypto.keys-rotation](../../rules-reference/cspm.md#keys-rotation)
||
|| INT.3 | Ensuring recoverability of software, including information protection software, in emergencies |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| INT.4 | Detection and response to the receipt of unsolicited electronic messages (letters, documents) and other information that is not related to the functioning of the information system (spam protection) |
[cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha)
[cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf)
[cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl)
||
|| INT.6 | Restricting user permissions to enter information into the information system |
[cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges)
[cspm.access.sa-privileges](../../rules-reference/cspm.md#sa-privileges)
||
|| **Availability of personal data** (AVL) {.cell-align-center} | > | > ||
|| AVL.4 | Periodic information backup on machine media reserved for information backups |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| AVL.5 | Ensuring the possibility of restoring information from machine media reserved for information backups (backup copies) within a specified time interval |
[cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks)
||
|| **Protection of hardware** (PH) / **Virtualization environment protection** (VEP) {.cell-align-center} | > | > ||
|| VEP.1 | Identification and authentication of access subjects and access objects in the virtual infrastructure, including administrators of virtualization means |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.access](../../rules-reference/cspm.md#access)
||
|| VEP.2 | Managing access of access subjects to access objects in the virtual infrastructure, including access within virtual machines |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.k8s.access](../../rules-reference/cspm.md#access)
||
|| VEP.4 | Managing (filtering, routing, connection control, unidirectional transmission) information flows between virtual infrastructure components, as well as around the virtual infrastructure perimeter | [cspm.network.firewall](../../rules-reference/cspm.md#firewall) ||
|| VEP.6 | Managing the migration of virtual machines (containers) and the data processed on them | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|| VEP.7 | Control of integrity of the virtual infrastructure and its configurations | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|| VEP.9 | Anti-virus protection in the virtual infrastructure |
[cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
[cspm.appsec.registry-recently-scan](../../rules-reference/cspm.md#registry-recently-scan)
||
|| VEP.10 | Segmentation of the virtual infrastructure for processing of information by an individual user and/or group of users |
[cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config)
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| **Protection of the information system, its equipment, communication and data transmission systems** (PIS) {.cell-align-center} | > | > ||
|| PIS.1 | Segregation of duties for the management (administration) of the information system, management (administration) of the information protection system, information processing functions and other information system functions | [cspm.access.min-privileges](../../rules-reference/cspm.md#min-privileges) ||
|| PIS.3 | Protection of information against disclosure, modification and forcing (input of false information) during transferring (preparation for transferring) thereof through communication channels which go beyond the controlled zone |
[cspm.crypto.certificate-validity](../../rules-reference/cspm.md#certificate-validity)
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| PIS.4 | Trusted channel, route between the administrator, user, and means of information protection (security features of means of information protection) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| PIS.11 | Authenticity of network connections (interaction sessions), including protection against spoofing of network devices and services |
[cspm.data.storage-https](../../rules-reference/cspm.md#storage-https)
[cspm.appsec.alb-https](../../rules-reference/cspm.md#alb-https)
[cspm.appsec.api-gateway-https](../../rules-reference/cspm.md#api-gateway-https)
[cspm.appsec.cdn-https](../../rules-reference/cspm.md#cdn-https)
||
|| PIS.15 | Archived files protection, protection of information security tools settings and software, and other data that cannot be changed during the processing of information | [cspm.db.db-deletion-protection](../../rules-reference/cspm.md#db-deletion-protection) ||
|| PIS.17 | Dividing the information system into segments (segmentation of the information system) and ensuring the protection of the perimeters of the information system segments |
[cspm.trusted-ip-k8s](../../rules-reference/cspm.md#trusted-ip-k8s)
[cspm.k8s.api-security](../../rules-reference/cspm.md#api-security)
||
|| **Identifying and responding to incidents** (IM) {.cell-align-center} | > | > ||
|| IM.2 | Incident detection, identification and registration |
[cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails)
||
|| IM.6 | Planning and taking measures to prevent the recurrence of incidents |
[cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan)
||
|| **Management of configuration of the information system and the personal data protection** (MC) {.cell-align-center} | > | > ||
|| MC.1–MC.4 | Management of configuration of the information system and the personal data protection | [cspm.k8s.kubernetes-safe-config](../../rules-reference/cspm.md#kubernetes-safe-config) ||
|#