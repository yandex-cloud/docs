---
title: Ransomware attack prevention checklist
description: This article introduces you to the content of the ransomware attack prevention checklist for your {{ yandex-cloud }} infrastructure.
---

# Ransomware attack prevention checklist

This section presents security requirements for protection of your {{ yandex-cloud }} infrastructure against ransomware attacks. Ransomware is one of the most common and destructive types of cyberattacks: attackers encrypt the victim's data and demand a ransom for recovery. In cloud environments, ransomware attacks can affect object storages, virtual machine disks, databases, and backups.



  

## Two-factor authentication for privileged accounts is in place {#enable-mfa}


Accounts with privileged roles, such as `admin`, `editor`, `resource-manager.admin`, and similar must use [multi-factor authentication (MFA)](../../organization/concepts/mfa.md). A compromised privileged account without MFA allows the attacker to gain immediate access to all the organization's resources and delete backups before running encryption.

## Yandex ID accounts are used only in exceptional cases {#limit-yid}


Personal Yandex ID accounts are not managed by corporate security policies: you cannot force MFA, set a password policy, or revoke access centrally. Use [federated accounts](../../iam/concepts/users/accounts.md#saml-federation) through {{ org-full-name }} for access to cloud resources. Yandex ID accounts are only permissible for technical purposes (e.g., initial organization setup) and must be documented as exceptions.

## Service accounts have minimal privileges {#limit-privileges}


Service accounts with excessive privileges (e.g., with the `editor` or `admin` role at the organization or cloud level) are targets of choice for ransomware: if compromised, an account like that allows the attacker to delete all backups and encrypt data. [Assign](../../iam/operations/sa/assign-role-for-sa.md) to service accounts only the roles they need to perform their functions, and only at the proper level of the resource hierarchy (for folder, not cloud).

## Last service account authentication date and last use of access keys date are tracked {#track-last-used}


Unused static access keys and service accounts that have not been authenticated in a long time present a risk: attackers can use forgotten credentials to gain access. We recommend tracking the dates of last service account authentication and last use of access keys. Delete or deactivate keys and accounts unused for more than 90 days.

Whenever possible, use [ephemeral keys](../../iam/concepts/authorization/ephemeral-keys.md) or temporary tokens via [{{ sts-full-name }}](../../iam/concepts/authorization/sts.md) instead of static keys.

## Service account keys are periodically rotated {#rotate-keys}


Static access keys for service accounts must be regularly rotated. The recommended [rotation](../standard/authentication.md#sa-key-rotation.md) period is at least once every 90 days. Keys without an expiration date increase the window of opportunity for attackers if leaked. 

Whenever possible, use [ephemeral keys](../../iam/concepts/authorization/ephemeral-keys.md) or temporary tokens via [{{ sts-full-name }}](../../iam/concepts/authorization/sts.md) instead of static keys.

## Object Storage has Object Lock enabled {#enable-object-lock}


[Object Lock](../../storage/concepts/object-lock.md) is a mechanism that protects {{ objstorage-full-name }} objects against deletion and overwriting for a specified period. With Object Lock on, the attacker who gains access to the bucket will not be able to delete or modify protected objects until the lock expires. The recommended minimum lock period is 30 days. Object Lock only works when bucket [versioning](../../storage/concepts/versioning.md) is on.

## Disk and database backups are in place {#configure-backup}


Automatic backups must be in place for all critical resources:

- VM disks. Use [{{ backup-full-name }}](../../backup/index.yaml) or a [snapshot schedule](../../compute/operations/snapshot-control/create-schedule.md). Recommended frequency: daily. Retention period: at least 14 days.
- [Managed databases](../../managed-postgresql/operations/cluster-backups.md) (MDB). Make sure automatic backups are enabled and retention period is at least 14 days.
- Backup storage. It is recommended to store backups in a separate folder with limited access. Ideally, in a separate cloud organization or outside it.

## {{ at-full-name }} is enabled {#enable-audit-trails}


[{{ at-name }}](../../audit-trails/quickstart.md) logs all management actions with cloud resources: resource creation and deletion, access permission changes, operations with keys, etc. {{ at-name }} must be enabled at the organization or cloud level and configured to log events to a secure {{ objstorage-name }} bucket (with [Object Lock](../../storage/concepts/object-lock.md) on) or log group. The actual log bucket must be deletion-protected.

## {{ objstorage-name }} bucket activity logging is enabled {#enable-logging}


In addition to {{ at-name }}, which logs management events, we recommend to enable [logging](../../storage/operations/buckets/enable-logging.md) of access to objects in {{ objstorage-name }} buckets. This will allow you to track object read and write operations (`GET`, `PUT`, `DELETE`), which is critical for investigation of incidents involving ransomware attacks on data storage facilities. Access logs should be sent to a separate secure bucket.
