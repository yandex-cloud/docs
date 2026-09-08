---
title: How to sync users and groups with {{ microsoft-idp.ad-short }}
description: Follow this guide to sync {{ org-full-name }} users and groups with {{ microsoft-idp.ad-full }} using {{ ad-sync-agent }}.
---

# Syncing users and groups with {{ microsoft-idp.ad-full }}


If your company uses [{{ microsoft-idp.ad-full }}](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) for user management and you want your users to be able to access {{ yandex-cloud }}, you do not need to create {{ yandex-cloud }} accounts for your users manually. Instead, you can [sync](../concepts/ad-sync/index.md) users and groups created in your {{ microsoft-idp.ad-short }} directory with {{ org-full-name }}.

## Get {{ org-full-name }} ready for synchronization {#prepare-org}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create a new account.
1. On the **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account, [create one](../../billing/quickstart/index.md) and [link](../../billing/operations/pin-cloud.md) a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) to it.
1. [Create](./user-pools/create-userpool.md) a user pool in {{ org-full-name }} and [associate](./user-pools/add-domain.md#userpool) with it a [domain](../concepts/domains.md) identical to the one used in the {{ microsoft-idp.ad-short }} [domain controller](https://en.wikipedia.org/wiki/Domain_controller_(Windows)).

    Associating a custom domain with a [user pool](../concepts/user-pools.md) is optional. You can choose to associate another domain or the default one instead. In this case, you will have to set up domain replacement in the `replacement_domain` setting when configuring the [synchronization agent](../concepts/ad-sync/sync-agent.md). For more information, see [{#T}](../concepts/ad-sync/sync-agent.md#agent-config).
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) to it the following roles for the [organization](../concepts/organization.md) the user pool is in:

    {% include [ad-sync-sa-roles](../../_includes/organization/ad-sync-sa-roles.md) %}
1. Optionally, [create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) and save an [authorized key](../../iam/concepts/authorization/key.md) for your [service account](../../iam/concepts/users/service-accounts.md).

    {% include [ad-sync-iam-via-metadata-warning](../../_includes/organization/ad-sync-iam-via-metadata-warning.md) %}

## Prepare your {{ microsoft-idp.ad-short }} domain controller {#dc-setup}

{% include [ad-sync-presetup-ad](../../_includes/organization/ad-sync-presetup-ad.md) %}

## Configure and start the synchronization agent {#setup-agent}

You can install the [synchronization agent](../concepts/ad-sync/sync-agent.md) on any [Linux](https://en.wikipedia.org/wiki/Linux) or [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) server.

If you are installing a sync agent on a {{ compute-full-name }} [VM](../../compute/concepts/vm.md), [connect](../../compute/operations/vm-control/vm-connect-sa.md) the service account you created [earlier](#prepare-org) to that VM.

Before you start syncing, open the following network ports for incoming and outgoing network traffic on the server you are going to run the synchronization agent on:

* To access the {{ yandex-cloud }} API:

    * `443`: For [HTTPS](https://en.wikipedia.org/wiki/HTTPS).

* To access the {{ microsoft-idp.ad-short }} domain controller:

    {% include [ad-sync-ports](../../_includes/organization/ad-sync-ports.md) %}

{% include [ad-sync-kerberos-components-installation-info](../../_includes/organization/ad-sync-kerberos-components-installation-info.md) %}

To start syncing users and groups:

{% list tabs group=operating_system %}

- Linux {#linux}

  In the Linux terminal:

  1. To install the {{ ad-sync-agent }}, run this command:

      ```bash
      curl {{ ad-sync-agent-linuxlink }} | bash
      ```

      Result:

      ```text
      Example config file downloaded to /etc/yc-identityhub-sync-agent/config.yaml. Modify it with your values
      Service installed as yc-identityhub-sync-agent
      To start the service: sudo systemctl start yc-identityhub-sync-agent
      To enable the service to start on boot: sudo systemctl enable yc-identityhub-sync-agent
      To check service status: sudo systemctl status yc-identityhub-sync-agent
      yc-identityhub-sync-agent is installed to /usr/bin/yc-identityhub-sync-agent
      ```
  1. Optionally, if you are going to use the authorized key of the service account to authenticate the agent in the {{ yandex-cloud }} API, copy the previously saved authorized key file to your server.

      Do it using the `scp` command or any other suitable tool.
  1. Use any text editor to open the [YAML](https://yaml.org/) file containing the synchronization agent's configuration. This example uses the `nano` editor:

      ```bash
      nano /etc/yc-identityhub-sync-agent/config.yaml
      ```
  1. Specify the synchronization agent's configuration in the file that opens. The configuration depends on the [authentication type](../../organization/concepts/ad-sync/sync-agent.md#agent-ad-auth) used by the agent on the {{ microsoft-idp.ad-short }} side and uses the following format in the [YAML](https://yaml.org/) file:

      {% list tabs group=authentication_linux %}

      - Using a username and password {#password_linux}

        {% include [ad-sync-yaml-config](../../_includes/organization/ad-sync-yaml-config.md) %}

        {% cut "Configuration breakdown" %}

        {% include [ad-sync-yaml-config-complete-password-legend](../../_includes/organization/ad-sync-yaml-config-complete-password-legend.md) %}

        {% endcut %}

      - Using Kerberos {#kerberos_linux}

        {% include [ad-sync-yaml-config-kerberos](../../_includes/organization/ad-sync-yaml-config-kerberos.md) %}

        {% cut "Configuration breakdown" %}

        {% include [ad-sync-yaml-config-complete-kerberos-legend](../../_includes/organization/ad-sync-yaml-config-complete-kerberos-legend.md) %}

        {% endcut %}

      {% endlist %}

  1. Run the {{ ad-sync-agent }} to start syncing:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. To make sure syncing is in progress, look up the agent's log file. Here is an example:

      ```bash
      sudo cat /etc/yc-identityhub-sync-agent/identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../_includes/organization/check-sync-results-in-ui.md) %}

  1. To stop syncing, stop the synchronization agent's process:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```

      This will stop user and group syncing.

- Windows {#windows}

  In the PowerShell terminal:

  1. To install the {{ ad-sync-agent }}, run this command:

      ```bash
      iex (New-Object System.Net.WebClient).DownloadString('{{ ad-sync-agent-windowslink }}')
      ```

      Result:

      ```text
      Example config file downloaded to C:\ProgramData\YcIdentityHubSyncAgent\config.yaml. Modify it with your values
      yc-identityhub-sync-agent is installed to C:\Program Files\YcIdentityHubSyncAgent\bin\yc-identityhub-sync-agent.exe
      Config file is located at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml

      Status   Name               DisplayName
      ------   ----               -----------
      Stopped  yc-identityhub-... Yandex Identity Hub Sync Agent
      yc-identityhub-sync-agent installed as Windows service 'yc-identityhub-sync-agent' (not started automatically)
      1. Modify the config file at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml with your values
      2. Run: Start-Service yc-identityhub-sync-agent
      ```
  1. Copy to your server the file with service account's authorized key you saved earlier. You can do it using any suitable tool.
  1. Use any text editor to open the agent's [YAML](https://yaml.org/) configuration file (`config.yaml`) located at `C:\ProgramData\YcIdentityHubSyncAgent\`.
  1. Specify the synchronization agent's configuration in the file that opens. The configuration depends on the [authentication type](../../organization/concepts/ad-sync/sync-agent.md#agent-ad-auth) used by the agent on the {{ microsoft-idp.ad-short }} side and uses the following format in the [YAML](https://yaml.org/) file:

      {% list tabs group=authentication_windows %}

      - On behalf of a gMSA account {#gmsa-windows}

        {% include [ad-sync-yaml-config-gmsa](../../_includes/organization/ad-sync-yaml-config-gmsa.md) %}

        {% cut "Configuration breakdown" %}

        {% include [ad-sync-yaml-config-complete-gmsa-legend](../../_includes/organization/ad-sync-yaml-config-complete-gmsa-legend.md) %}

        {% endcut %}

      - Using a username and password {#password_windows}

        {% include [ad-sync-yaml-config](../../_includes/organization/ad-sync-yaml-config.md) %}

        {% cut "Configuration breakdown" %}

        {% include [ad-sync-yaml-config-complete-password-legend](../../_includes/organization/ad-sync-yaml-config-complete-password-legend.md) %}

        {% endcut %}

      - Using Kerberos {#kerberos_windows}

        {% include [ad-sync-yaml-config-kerberos](../../_includes/organization/ad-sync-yaml-config-kerberos.md) %}

        {% cut "Configuration breakdown" %}

        {% include [ad-sync-yaml-config-complete-kerberos-legend](../../_includes/organization/ad-sync-yaml-config-complete-kerberos-legend.md) %}

        {% endcut %}

      {% endlist %}

  1. Start the synchronization agent's service:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```

      {% include [runas-gmsa-account-notice](../../_includes/organization/runas-gmsa-account-notice.md) %}

  1. To make sure syncing is in progress, look up the agent's log file. Here is an example:

      ```bash
      cat C:\ProgramData\YcIdentityHubSyncAgent\identity_hub.log
      ```

      {% include [check-sync-results-in-ui](../../_includes/organization/check-sync-results-in-ui.md) %}

  1. To stop the syncing process, stop the service you created:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```

      This will stop user and group syncing.

{% endlist %}

## Test the agent configuration changes {#dry-run}

You can test {{ ad-sync-agent }} through the dry-run mode. Use this mode to try out the changes you make to the agent's configuration before applying them.

To dry-run an agent:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. In the Linux terminal, stop the synchronization agent service:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```
  1. Make the changes you want to test to the agent configuration.
  1. In the `dry_run` section of the agent configuration file, enable dry run mode:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. In the Linux terminal, run the agent executable manually and wait for it to complete:

      ```bash
      ./yc-identityhub-sync-agent \
        --config /etc/yc-identityhub-sync-agent/config.yaml
      ```

      {% include [ad-sync-dry-run-output](../../_includes/organization/ad-sync-dry-run-output.md) %}

  1. Review the log file. If there are no unexpected changes and the operations contain no errors, the changes made to the agent configuration are correct, and you can run the agent in production:

      1. Disable dry run mode by setting the field value to `enabled: false` in the `dry_run` section of the configuration file.
      1. In the Linux terminal, run {{ ad-sync-agent }} to start syncing:

          ```bash
          sudo systemctl start yc-identityhub-sync-agent
          ```

- Windows {#windows}

  1. In the PowerShell terminal, stop the sync agent service:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```
  1. Make the changes you want to test to the agent configuration.
  1. In the `dry_run` section of the agent configuration file, enable dry run mode:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. In the PowerShell terminal, run the agent executable manually and wait for it to complete:

      ```powershell
      ./yc-identityhub-sync-agent.exe \
        --config C:\ProgramData\YcIdentityHubSyncAgent\config.yaml
      ```

      {% include [ad-sync-dry-run-output](../../_includes/organization/ad-sync-dry-run-output.md) %}

  1. Review the log file. If there are no unexpected changes and the operations contain no errors, the changes made to the agent configuration are correct, and you can run the agent in production:

      1. Disable dry run mode by setting the field value to `enabled: false` in the `dry_run` section of the configuration file.
      1. In the PowerShell terminal, run {{ ad-sync-agent }} to start syncing:

          ```powershell
          Start-Service yc-identityhub-sync-agent
          ```

{% endlist %}

{% note info %}

{% include [ad-sync-account-expires-solution](../../_includes/organization/ad-sync-account-expires-solution.md) %}

{% endnote %}

#### Useful links {#see-also}

* [{#T}](../concepts/ad-sync/index.md)
* [{#T}](../concepts/ad-sync/sync-agent.md)

[*gmsa_account]: {% include notitle [get-folder-id](../../_popups/identity-hub/gmsa.md) %}