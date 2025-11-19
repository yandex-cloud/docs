---
title: How to sync users and groups with {{ microsoft-idp.ad-short }}
description: Follow this guide to sync {{ org-full-name }} users and groups with {{ microsoft-idp.ad-full }} using the {{ ad-sync-agent }} agent.
---

# Syncing users and groups with {{ microsoft-idp.ad-full }}

{% include [note-preview](../../_includes/note-preview.md) %}

If your company uses [{{ microsoft-idp.ad-full }}](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) for user management and you want your users to be able to access {{ yandex-cloud }}, you do not need to create {{ yandex-cloud }} accounts for your users manually. Instead, you can [sync](../concepts/ad-sync.md) users and groups created in your {{ microsoft-idp.ad-short }} folder with {{ org-full-name }}.

## Prepare {{ org-name }} for synchronization {#prepare-org}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create a new account.
1. On the **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account, [create one](../../billing/quickstart/index.md) and [link](../../billing/operations/pin-cloud.md) a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) to it.
1. [Create](./user-pools/create-userpool.md) a user pool in {{ org-name }} and [associate](./user-pools/add-domain.md#userpool) with it a [domain](../concepts/domains.md) identical to the one used in the {{ microsoft-idp.ad-short }} [domain controller](https://en.wikipedia.org/wiki/Domain_controller_(Windows)).

    Associating your own domain with a [user pool](../concepts/user-pools.md) is optional. You can choose to associate another domain or the default one instead. In which case you will have to set up domain replacement in the `replacement_domain` parameter when configuring the [synchronization agent](../concepts/ad-sync.md#sync-agent). Learn more in [{#T}](../concepts/ad-sync.md#agent-config).
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) to it the following roles for the [organization](../concepts/organization.md) the user pool is in:

    {% include [ad-synk-sa-roles](../../_includes/organization/ad-synk-sa-roles.md) %}
1. [Create](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) and save an [authorized key](../../iam/concepts/authorization/key.md) for your [service account](../../iam/concepts/users/service-accounts.md).

## Prepare your {{ microsoft-idp.ad-short }} domain controller {#dc-setup}

{% include [ad-synk-presetup-ad](../../_includes/organization/ad-synk-presetup-ad.md) %}

## Configure and start the synchronization agent {#setup-agent}

You can install the [synchronization agent](../concepts/ad-sync.md#sync-agent) on any [Linux](https://en.wikipedia.org/wiki/Linux) or [Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) server.

Before you start syncing, open the following [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) ports for incoming and outgoing network traffic on the server you are going to run the synchronization agent on:

* To access the {{ yandex-cloud }} API:

    * `443`: For [HTTPS](https://en.wikipedia.org/wiki/HTTPS).

* To access the {{ microsoft-idp.ad-short }} domain controller:

    {% include [ad-synk-ports](../../_includes/organization/ad-synk-ports.md) %}

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
  1. Copy to your server the file with service account's authorized key you saved earlier.

      Do it using the `scp` command or any other suitable tool.
  1. Use any text editor to open the [YAML](https://yaml.org/) file containing the synchronization agent's configuration. This example uses the `nano` editor:

      ```bash
      nano /etc/yc-identityhub-sync-agent/config.yaml
      ```
  1. Specify the synchronization agent's configuration in the YAML file:

      {% include [ad-synk-yaml-config](../../_includes/organization/ad-synk-yaml-config.md) %}

      {% include [ad-synk-yaml-config-legend](../../_includes/organization/ad-synk-yaml-config-legend.md) %}
  1. Run the {{ ad-sync-agent }} to start syncing:

      ```bash
      sudo systemctl start yc-identityhub-sync-agent
      ```
  1. To make sure syncing is in progress, look up the agent's log file, e.g.,

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
  1. Use any text editor to open the agent's [YAML](https://yaml.org/) configuration file (`config.yaml`) located at `C:\ProgramData\YcIdentityHubSyncAgent\` and add the following configuration to it:

      {% include [ad-synk-yaml-config](../../_includes/organization/ad-synk-yaml-config.md) %}

      {% include [ad-synk-yaml-config-legend](../../_includes/organization/ad-synk-yaml-config-legend.md) %}

  1. Start the synchronization agent's service:

      ```powershell
      Start-Service yc-identityhub-sync-agent
      ```
  1. To make sure syncing is in progress, look up the agent's log file, e.g.,

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

#### See also {#see-also}

* [{#T}](../concepts/ad-sync.md)