---
title: How to connect an external resource to {{ backup-full-name }}
description: Follow this guide to connect a VM or server located outside {{ yandex-cloud }} to {{ backup-full-name }}.
---

# Connecting a VM or server from outside {{ yandex-cloud }} to {{ backup-name }}

With {{ backup-full-name }}, you can back up and recover virtual machines and servers located within your own infrastructure or that of a third-party provider.

To [connect](../../concepts/vm-connection/external-resources.md) an external VM or server to {{ backup-name }}, the resource must be running one of the [supported operating systems](../../concepts/vm-connection/external-resources.md#supported-oss).

{% include [requirements](../../../_includes/backup/requirements.md) %}

To connect an external VM or server running a Linux Ubuntu OS to {{ backup-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect your external resource to {{ backup-name }}.
  1. [Navigate]({{ link-console-main }}/link/backup) to **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}**.
  1. In the top-right corner, click ![image](../../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.backup.button_connect-external-resource }}**.
  1. In the **{{ ui-key.yacloud.backup.dialog_connect-external-resource_title }}** window that opens:

      1. In the **{{ ui-key.yacloud.backup.field_connect-external-resource_resource-type }}** field, select the type of the external resource you want to connect: **{{ ui-key.yacloud.backup.value_external-vm }}** or **{{ ui-key.yacloud.backup.value_external-server }}**.
      1. In the **{{ ui-key.yacloud.backup.field_connect-external-resource_policies }}** field, select one or more [backup policies](../../concepts/policy.md) to automatically apply to the external resource after installing the agent. You can also [associate](../policy-vm/attach-and-detach-vm.md) these policies later.
      1. Under **{{ ui-key.yacloud.backup.section_connect-external-resource_command }}**, copy the command for installing the {{ backup-name }} agent on an external resource.

  1. Connect to the external VM or server and run the command you copied with administrator privileges.

      Result:

      ```text
      ...
      Fetched instance id from file: cdgd246kiae3********
      fetched registration token: 802C-AE...
      installing agent with rain https://ru01-cloud.cyberprotect.ru (log: /var/log/baas-agent-installer/log.txt)
      Trying to register agent using RegisterAgent...
      Agent registered with id E6B1A5DC-ECE0-****-A9B8-AFD2********
      ```

  1. Make sure the external resource is connected to {{ backup-name }}. To do this, on the ![resources](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.backup.label_connected-resources }}** page, open the **{{ ui-key.yacloud.backup.label_external-vm-instances }}** or **{{ ui-key.yacloud.backup.label_external-server-instances }}** tab, depending on your resource type. The list should include the resource you connected.

- {{ yandex-cloud }} CLI {#cli}

  1. [Install](../../../cli/quickstart.md#install) and [initialize](../../../cli/quickstart.md#initialize) the {{ yandex-cloud }} CLI.

      You can install the {{ yandex-cloud }} CLI either directly on your target VM or server or on any other machine.

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      {% note warning %}

      Make sure the [account](../../../iam/concepts/users/accounts.md) you got authenticated under when creating the {{ yandex-cloud }} CLI profile has the `backup.user` [role](../../security/index.md#backup-user) or higher. If needed, [assign](../../../iam/operations/roles/grant.md) the required role to your account.

      {% endnote %}

  1. Get the script code for installing the {{ backup-name }} agent on an external resource. The exact command depends on the type of resource you want to connect:

      {% list tabs group=backup_resource_type %}

      - VM {#vm}

        ```bash
        yc backup agent install-external vm
        ```

        Result:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Server {#baremetal-server}

        ```bash
        yc backup agent install-external server
        ```

        Result:

        ```bash
        sudo apt-get update && sudo apt-get install -y jq gawk curl && curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
        ```

      {% endlist %}

  1. Run the bash script you got in the previous step:

      {% list tabs group=backup_resource_type %}

      - VM {#vm}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_vm.sh | sudo bash -s -- --instance-registration-token="13d1d696-0ea4-****-93a9-f8c5********"
        ```

      - Server {#baremetal-server}

        ```bash
        sudo apt-get update && \
          sudo apt-get install -y jq gawk curl && \
          curl https://{{ s3-storage-host-ru }}/backup-distributions/agent_installer_external_server.sh | sudo bash -s -- --instance-registration-token="ed6991f2-f364-****-a08e-75a7********"
        ```

      {% endlist %}

      Result:

      ```text
      ...
      Fetched instance id from file: cdgd246kiae3********
      fetched registration token: 802C-AE...
      installing agent with rain https://ru01-cloud.cyberprotect.ru (log: /var/log/baas-agent-installer/log.txt)
      Trying to register agent using RegisterAgent...
      Agent registered with id E6B1A5DC-ECE0-****-A9B8-AFD2********
      ```

      Your external resource is now connected to {{ backup-name }} and has an ID. In the above example, this is `cdgd246kiae3********`.
  1. Make sure the external resource is connected to {{ backup-name }} by specifying the ID you got in the previous step:

      ```bash
      yc backup vm get <external_resource_ID_in_Cloud_Backup>
      ```

      Result:

      ```text
      compute_instance_id: cdgd246kiae3********
      created_at: "2026-04-24T14:23:06.382900082Z"
      updated_at: "2026-04-29T19:48:22.013489248Z"
      enabled: true
      status: IDLE
      last_backup_time: "2026-04-27T13:07:05Z"
      next_backup_time: "2026-04-29T21:00:00Z"
      resource_id: d1fdd342-0ea8-****-9906-fa6c********
      is_active: true
      init_status: REGISTRED
      metadata: "null"
      type: EXTERNAL_VM
      agent_info:
        current_version: 18.0.38811
      ```

- API {#api}

  1. Get the command for installing the {{ backup-name }} agent on an external resource. To do this, use the [getAgentInstallCommand](../../backup/api-ref/Setup/getAgentInstallCommand.md) REST API method for the [Setup](../../backup/api-ref/Setup/index.md) resource or the [SetupService/GetAgentInstallCommand](../../backup/api-ref/grpc/Setup/getAgentInstallCommand.md) gRPC API call. In the request parameters, specify the target resource type: `EXTERNAL_VM` or `EXTERNAL_SERVER`.
  1. Connect to the external VM or server and run the command with administrator privileges.
  1. Once the agent is installed, the external resource gets automatically registered in {{ backup-name }}. To get a list of connected resources, use the [list](../../backup/api-ref/Resource/list.md) REST API method for the [Resource](../../backup/api-ref/Resource/index.md) resource or the [ResourceService/List](../../backup/api-ref/grpc/Resource/list.md) gRPC API call.

{% endlist %}

To back up and restore your connected external resource using {{ backup-name }}, associate that resource with a [backup policy](../../concepts/policy.md). For more information, see [{#T}](../policy-vm/attach-and-detach-vm.md).

#### Useful links {#see-also}

* [{#T}](../../concepts/vm-connection/external-resources.md)
* [{#T}](../policy-vm/attach-and-detach-vm.md)
* [{#T}](../backup-vm/create.md)
* [{#T}](./recover.md)
