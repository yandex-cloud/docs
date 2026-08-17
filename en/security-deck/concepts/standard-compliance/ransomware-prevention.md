---
title: Ransomware attack prevention standard
description: This section lists the control rules that constitute the ransomware attack prevention standard.
---

# Ransomware attack prevention standard

This ruleset contains security requirements to reduce risks from ransomware attacks in the {{ yandex-cloud }} cloud infrastructure.

Ransomware is one of the most common and destructive types of cyberattacks: attackers encrypt the victim's data and demand a ransom for recovery. In cloud environments, ransomware attacks can affect object storages, virtual machine disks, databases, and backups.

Complying with these requirements helps ensure protection against ransomware attacks and mitigate the consequences of a successful attack:

#|
|| Requirement | Check ID in the [{{ cspm-name }}](../cspm.md) module ||
|| [Two-factor authentication for privileged accounts is in place](../../../security/standard/all.md#mfa) | [cspm.access.userpool-mfa](../../rules-reference/cspm.md#userpool-mfa) ||
|| [The _Object lock_ feature is enabled in {{ objstorage-name }}](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| [Disk and database backups are in place](../../../security/standard/all.md#snapshot) | [cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks) ||
|| [Yandex ID accounts are only used in exceptional cases](../../../security/standard/all.md#yandex-id-accounts) | [cspm.yid.organization](../../rules-reference/cspm.md#yid-organization) ||
|| [Service accounts have minimal privileges](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| [The last service account authentication date is tracked in {{ iam-name }}](../../../security/standard/all.md#track-sa-authentication) | [cspm.iam.unused-service-account](../../rules-reference/cspm.md#unused-service-account) ||
|| [The date of last access key use is tracked in {{ iam-name }}](../../../security/standard/all.md#track-sa-authentication) | [cspm.iam.unused-key](../../rules-reference/cspm.md#unused-key) ||
|| [Service account keys are periodically rotated](../../../security/standard/all.md#sa-key-rotation) | [cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#iam-sa-key-rotation) ||
|| [{{ at-full-name }} is enabled](../../../security/standard/all.md#audit-trails) | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|#
