---
title: '{{ ad-sync-agent }} synchronization agent in {{ org-full-name }}'
description: '{{ ad-sync-agent }} reads user and user group data in the selected organization units in the {{ microsoft-idp.ad-full }} directory and syncs it with user and user group data in the {{ org-full-name }} pool.'
---

# {{ ad-sync-agent }}


{{ ad-sync-agent }} reads user and user group data in the [selected](#agent-config) Organization Units (OU) in the {{ microsoft-idp.ad-short }} directory and syncs it with user and user group data in the {{ org-full-name }} [pool](../user-pools.md).

The synchronization agent installation script is available for the following operating systems:

* [Linux]({{ ad-sync-agent-linuxlink }})
* [Windows]({{ ad-sync-agent-windowslink }})

### {{ microsoft-idp.ad-short }}-side authentication {#agent-ad-auth}

On the {{ microsoft-idp.ad-short }} side, the synchronization agent gets user and group data as an account [created](./index.md#dc-setup) in the {{ microsoft-idp.ad-short }} domain. To get this data, the agent uses [LDAP](https://learn.microsoft.com/en-us/windows/win32/api/_ldap/) and [DRSR](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-drsr/). The requests go to the {{ microsoft-idp.ad-short }} domain controller address specified in the agent [configuration](#agent-config).

Regardless of the operating system of the server hosting the synchronization agent, the agent can be authenticated on the {{ microsoft-idp.ad-short }} side with the domain user's name and password or via [Kerberos](https://en.wikipedia.org/wiki/Kerberos_(protocol)) version 5.

In addition, if the agent runs on a Windows server, you can configure agent authentication on the {{ microsoft-idp.ad-short }} side using a [gMSA account](*gmsa_account).

{% note tip %}

A gMSA account is the preferred authentication method for {{ microsoft-idp.ad-short }} because it does not require saving the password in the agent's configuration file or Kerberos keys on the server.

{% endnote %}

### {{ yandex-cloud }}-side authentication {#agent-yc-auth}

On the {{ yandex-cloud }} side, the synchronization agent manages users and user groups as a [service account](../../../iam/concepts/users/service-accounts.md) with [permissions](./index.md#yc-setup) for syncing. Requests to {{ yandex-cloud }} go to public endpoint `https://organization-manager.{{ api-host }}` over [HTTPS](https://en.wikipedia.org/wiki/HTTPS). To authenticate in the {{ yandex-cloud }} API, the agent uses a service account authorized key or, only if installed on a {{ compute-name }} VM, a service account [IAM token](../../../iam/concepts/authorization/iam-token.md) [obtained](../../../compute/operations/vm-metadata/get-vm-metadata.md#example5) via the VM [metadata service](../../../compute/concepts/vm-metadata.md).

### Synchronization process {#sync-process}

During the synchronization process, {{ ad-sync-agent }} can create, update, or delete users and user groups in {{ org-full-name }}. {{ org-full-name }} users and groups are synced with {{ microsoft-idp.ad-short }} users and groups in two stages: [primary synchronization](#full-sync) and [incremental synchronization](#incremental-sync).

During syncing, the user pool may be found to contain a user or user group with names identical to those of the user or user group that need to be synced, in which case, depending on [current settings](#agent-config), the agent will either overwrite the data from {{ microsoft-idp.ad-short }} for the existing {{ org-full-name }} user or group or return an error message.

#### Full (primary) synchronization {#full-sync}

When performing a full synchronization, the agent reads the data of all users, groups, and their attributes in the [selected](#agent-config) organization units in the {{ microsoft-idp.ad-short }} directory and creates the same users and groups with the same attributes in the {{ org-full-name }} user pool.

The full synchronization process for a large number of [objects](./index.md#sync-objects) may take a long time. If it gets interrupted due to an error, you can restart the agent to resume synchronization from where the previous attempt was interrupted. The agent tracks the progress of full synchronization using process token files in the running agent's directory:

* `main_sync_replication_token.json`
* `password_hash_replication_token.json`
* `user_control_replication_token.json`

After full synchronization is successfully completed, the agent, run as a standalone service or OS service, proceeds to continuously perform incremental synchronization.

{% note tip %}

You run full synchronization again by deleting the mentioned process token files and restarting the agent.

{% endnote %}

#### Incremental synchronization {#incremental-sync}

The running agent performs incremental synchronization continuously with the following frequency:

* _Syncing user passwords and states_: The agent tracks the lock/unlock status of users in the {{ microsoft-idp.ad-short }} domain and user password changes and transfers these updates to {{ org-full-name }} every few seconds. You cannot change the frequency for this synchronization type.
* _Syncing other values_: The agent tracks other changes in properties, attributes, and parameters of users and groups at an interval [specified](#agent-config) in the agent's configuration file.

#### Dry run {#dry-run}

You can test {{ ad-sync-agent }} through the dry-run mode. Use this mode to try out the changes you make to the agent's configuration before applying them.

In dry run mode, the agent does not alter the data of {{ org-full-name }} users and groups. Instead, it tests all operations caused by changes to the agent's configuration and [logs](#logging) the results of these tests.

For more information on how to dry run the agent, see [{#T}](../../operations/sync-ad.md#dry-run).

### Tracked changes {#tracked-changes}

During continuous synchronization, the agent tracks the following changes in {{ microsoft-idp.ad-short }} and transfers them to {{ org-full-name }}:

* Creating, editing, locking, unlocking, and deleting users.
* Creating, editing, and deleting user groups.
* Changing user and user group attributes.
* Adding users to groups and removing them from groups.
* Changing user passwords.

{% include [ad-sync-account-expires-solution](../../../_includes/organization/ad-sync-account-expires-solution.md) %}

### Synchronization logging {#logging}

{{ ad-sync-agent }} logs the events taking place during synchronization.

By default, the event and error info is fed into the [standard stream](https://en.wikipedia.org/wiki/Standard_streams) named `stdout`. You can configure saving logs to files in the agent's [configuration](#agent-config).

By default, the event info is output in text format, whether using the standard output stream or a file; you can, however, change it to [JSON](https://en.wikipedia.org/wiki/JSON) in the agent's configuration.

In the agent's [configuration](#agent-config), you can also configure log export to a {{ cloud-logging-full-name }} [log group](../../../logging/concepts/log-group.md).

Additionally, you can set the following logging conditions in the agent's configuration:

{% include [ad-sync-log-levels](../../../_includes/organization/ad-sync-log-levels.md) %}

### Checking access permissions for authentication data files {#auth-data-security}

When started, the synchronization agent can check access permissions assigned to files that are used by the agent and contain sensitive data:

* The [agent configuration](#agent-config) file may contain the password for the user account the agent uses for {{ microsoft-idp.ad-short }}-side synchronization.
* The `keytab` file contains the encryption keys required to authenticate to {{ microsoft-idp.ad-short }} via Kerberos.
* The service account [authorized key](../../../iam/concepts/authorization/key.md) file contains the key for access to {{ yandex-cloud }}.

With the permission check enabled, as soon as you start the synchronization agent, it checks that the following conditions are met:

{% list tabs group=operating_system %}

- Linux {#linux}

  * The files are owned by the user who started the agent.
  * Read and write permissions for the files are granted to their owner only (`chmod 600`).

- Windows {#windows}

  * Inheritance of access permissions is off for the files.
  * Only the `System` and `Local Administrator` subjects, and/or subjects of the `BUILTIN\Administrators` group, have full access (`FullAccess`) to the files.
  * Only the user who started the agent has read permission for the files.

{% endlist %}

If the agent detects a violation of these conditions at startup, execution terminates with an error.

You can turn the access permission check for sensitive data files on and off using the agent's `check_config_permissions` configuration setting.

### Agent configuration {#agent-config}

The synchronization agent's configuration is defined in a [YAML](https://yaml.org/) file and depends on the [authentication method](#agent-ad-auth) on the {{ microsoft-idp.ad-short }} side.

For configuration examples, see the [sync setup guide](../../operations/sync-ad.md#setup-agent), and for field descriptions, under [Agent configuration parameters](../../operations/sync-ad.md#agent-config).

#### Useful links {#see-also}

* [{#T}](./index.md)
* [{#T}](../../operations/sync-ad.md)

[*gmsa_account]: {% include notitle [get-folder-id](../../../_popups/identity-hub/gmsa.md) %}
