---
title: Ransomware attack prevention checklist
description: This article introduces you to the content of the ransomware attack prevention checklist for your {{ yandex-cloud }} infrastructure.
---

# Ransomware attack prevention checklist

This section presents security requirements for protection of your {{ yandex-cloud }} infrastructure against ransomware attacks. Ransomware is one of the most common and destructive types of cyberattacks: attackers encrypt the victim's data and demand a ransom for recovery. In cloud environments, ransomware attacks can affect object storages, virtual machine disks, databases, and backups.

Each requirement has a severity level, link to relevant rules in the Yandex {{ sd-name }} [Cloud Security Posture Management](../../security-deck/concepts/cspm.md) module ({{ cspm-name }}), and link to relevant section of the {{ yandex-cloud }} [infrastructure protection standard](../standard/all.md).

## Severity levels {#severity}

| Severity        | Description                                              |
|----------------|-----------------------------------------------------------------------------------|
| High        | Prioritized resolution. Significantly increases resistance to attack.     |
| Medium        | Recommended for implementation. Reduces attack surface.                            |
| Low         | Additional security measure.                                                       | 
| Informational | Recommendation to increase maturity.                                              |

## Multi-factor authentication for privileged accounts is in place {#enable-mfa}

| Severity | {{ yandex-cloud }} standard requirement     | Rule in {{ sd-name }} |
|-------------|---------------------------------------------|--------------------------|
| High     | [IAM17](../standard/authentication.md#twofa)| [cspm.access.userpool-mfa](../../security-deck/rules-reference/cspm.md#userpool-mfa) |

Accounts with privileged roles, such as `admin`, `editor`, `resource-manager.admin`, and similar must use [multi-factor authentication (MFA)](../../organization/concepts/mfa.md). A compromised privileged account without MFA allows the attacker to gain immediate access to all the organization's resources and delete backups before running encryption.

## Yandex ID accounts are used only in exceptional cases {#limit-yid}

| Severity | {{ yandex-cloud }} standard requirement                  | Rule in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| High     | [IAM3](../standard/authentication.md#yandex-id-accounts)| [cspm.yid.organization](../../security-deck/rules-reference/cspm.md#yid-organization) |

Personal Yandex ID accounts are not managed by corporate security policies: you cannot force MFA, set a password policy, or revoke access centrally. Use [federated accounts](../../iam/concepts/users/accounts.md#saml-federation) through {{ org-full-name }} for access to cloud resources. Yandex ID accounts are only permissible for technical purposes (e.g., initial organization setup) and must be documented as exceptions.

## Service account keys are periodically rotated {#rotate-keys}

| Severity | {{ yandex-cloud }} standard requirement | Rule in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| High     | [IAM11](../standard/authentication.md#sa-key-rotation) | [cspm.iam.sa-key-rotation](../../security-deck/rules-reference/cspm.md#sa-key-rotation) |

Static access keys for service accounts must be regularly rotated. The recommended [rotation](../standard/authentication.md#sa-key-rotation.md) period is at least once every 90 days. Keys without an expiration date increase the window of opportunity for attackers if leaked.

Whenever possible, use [ephemeral keys](../../iam/concepts/authorization/ephemeral-keys.md) or temporary tokens via [{{ sts-full-name }}](../../iam/concepts/authorization/sts.md) instead of static keys.

## Disk and database backups are in place {#configure-backup}

| Severity | {{ yandex-cloud }} standard requirement | Rule in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| High     | [ENV37](../standard/virtualenv-safe-config.md#snapshot)| [cspm.backup.compute-disks](../../security-deck/rules-reference/cspm.md#compute-disks) |

Automatic backups must be in place for all critical resources:

- VM disks. Use [{{ backup-full-name }}](../../backup/index.yaml) or a [snapshot schedule](../../compute/operations/snapshot-control/create-schedule.md). Recommended frequency: daily. Retention period: at least 14 days.
- [Managed databases](../../managed-postgresql/operations/cluster-backups.md) (MDB). Make sure automatic backups are enabled and retention period is at least 14 days.
- Backup storage. It is recommended to store backups in a separate folder with limited access. Ideally, in a separate cloud organization or outside it.

## Last service account authentication date and last use of access keys date are tracked {#track-last-used}

| Severity | {{ yandex-cloud }} standard requirement                  | Rules in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| Medium     | [IAM26](../standard/authentication.md#key-usage-control)| [cspm.iam.unused-service-account](../../security-deck/rules-reference/cspm.md#unused-service-account)<br/>[cspm.iam.unused-key](../../security-deck/rules-reference/cspm.md#unused-key) |

Unused static access keys and service accounts that have not been authenticated in a long time present a risk: attackers can use forgotten credentials to gain access. We recommend tracking the dates of last service account authentication and last use of access keys. Delete or deactivate keys and accounts unused for more than 90 days.

Whenever possible, use [ephemeral keys](../../iam/concepts/authorization/ephemeral-keys.md) or temporary tokens via [{{ sts-full-name }}](../../iam/concepts/authorization/sts.md) instead of static keys.

## Object Storage has Object Lock enabled {#enable-object-lock}

| Severity | {{ yandex-cloud }} standard requirement | Rule in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| Medium     | [ENV9](../standard/virtualenv-safe-config.md#object-lock)| [cspm.s3.used-object-lock](../../security-deck/rules-reference/cspm.md#used-object-lock) |

[Object Lock](../../storage/concepts/object-lock.md) is a mechanism that protects {{ objstorage-full-name }} objects against deletion and overwriting for a specified period. With Object Lock on, the attacker who gains access to the bucket will not be able to delete or modify protected objects until the lock expires. The recommended minimum lock period is 30 days. Object Lock only works when bucket [versioning](../../storage/concepts/versioning.md) is on.

## {{ at-full-name }} is enabled {#enable-audit-trails}

| Severity | {{ yandex-cloud }} standard requirement                  | Rule in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| Medium | [AUDIT1](../standard/audit-logs.md#audit-trails) | [cspm.o11y.audit-trails](../../security-deck/rules-reference/cspm.md#audit-trails) |

[{{ at-name }}](../../audit-trails/quickstart.md) logs all management actions with cloud resources: resource creation and deletion, access permission changes, operations with keys, etc. {{ at-name }} must be enabled at the organization or cloud level and configured to log events to a secure {{ objstorage-name }} bucket (with [Object Lock](../../storage/concepts/object-lock.md) on) or log group. The actual log bucket must be deletion-protected.

## Service accounts have minimal privileges {#limit-privileges}

| Severity | {{ yandex-cloud }} standard requirement                  | Rules in {{ sd-name }} |
|-------------|----------------------------------------------------------|--------------------------|
| Informational | [IAM9](../standard/authentication.md#sa-privileges)| [cspm.access.sa-privileges-org-roles](../../security-deck/rules-reference/cspm.md#sa-privileges-org-roles)<br/>[cspm.access.sa-privileges-service-roles](../../security-deck/rules-reference/cspm.md#sa-privileges-service-roles) |

Service accounts with excessive privileges (e.g., with the `editor` or `admin` role at the organization or cloud level) are targets of choice for ransomware: if compromised, an account like that allows the attacker to delete all backups and encrypt data. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to service accounts only the roles they need to perform their functions, and only at the proper level of the resource hierarchy (for folder, not cloud).

