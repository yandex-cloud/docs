---
title: Ransomware attack prevention standard
description: This section lists the control rules that constitute the ransomware attack prevention standard.
---

# Ransomware attack prevention standard

This ruleset contains security requirements to reduce risks from ransomware attacks in the {{ yandex-cloud }} cloud infrastructure.

Ransomware is one of the most common and destructive types of cyberattacks: attackers encrypt the victim's data and demand a ransom for recovery. In cloud environments, ransomware attacks can affect object storages, virtual machine disks, databases, and backups.

Complying with these requirements helps ensure protection against ransomware attacks and mitigate the consequences of a successful attack:

#|
||::{align="center"} Requirement ID | Requirement | Check ID in the [{{ cspm-name }}](../cspm.md) module ||
||::{align="center"} [IAM3](../../../security/standard/all.md#yandex-id-accounts) | Yandex ID accounts are used only in exceptional cases | [cspm.yid.organization](../../rules-reference/cspm.md#yid-organization) ||
||::{align="center"} [IAM9](../../../security/standard/all.md#sa-privileges) | Service accounts have minimal privileges. |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
||::{align="center"} [IAM11](../../../security/standard/all.md#sa-key-rotation) | Service account keys are periodically rotated. | [cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
||::{align="center"} [IAM17](../../../security/standard/all.md#twofa) | Two-factor authentication for privileged accounts is in place. | [cspm.access.userpool-mfa](../../rules-reference/cspm.md#userpool-mfa) ||
||::{align="center"} [ENV9](../../../security/standard/all.md#object-lock) | The _Object lock_ feature is enabled in {{ objstorage-name }}. | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
||::{align="center"} [ENV37](../../../security/standard/all.md#snapshot) | Disk and database backups are in place. | [cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks) ||
||::{align="center"} [IAM26](../../../security/standard/all.md#key-usage-control) | The last service account authentication date is tracked in {{ iam-name }}. | [cspm.iam.unused-service-account](../../rules-reference/cspm.md#unused-service-account) ||
|| ^ | The date of last access key use is tracked in {{ iam-name }}. | [cspm.iam.unused-key](../../rules-reference/cspm.md#unused-key) ||
||::{align="center"} [AUDIT1](../../../security/standard/all.md#audit-trails) | {{ at-full-name }} is enabled. | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|#
