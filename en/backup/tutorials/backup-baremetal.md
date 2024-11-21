# Connecting a {{ baremetal-full-name }} server to {{ backup-full-name }}

In {{ backup-name }}, you can configure [{{ baremetal-name }} server backup](../../baremetal/concepts/servers.md).

_{{ baremetal-name }} and the server backup feature will be released at the [Preview stage](../../overview/concepts/launch-stages.md) in Q4 2024._

The following server operating systems are supported: {#os-support}
* Ubuntu 22.04 LTS
* Ubuntu 20.04 LTS
* Ubuntu 18.04 LTS
* Ubuntu 16.04 LTS

To connect a server to {{ backup-full-name }}:
1. [Prepare your cloud](#before-you-begin).
1. [Create a service account](#prepare-service-account).
1. [Activate {{ backup-name }}](#activate-provider).
1. [Lease a test server](#server-lease).
1. [Connect to the server](#server-connect).
1. [Install a backup agent](#agent-install).
1. [Link your server to a backup policy](#add-policy).
1. [Take a backup of your server](#execute-policy).
1. [Restore your server from a backup](#server-recovery).

See also [How to cancel a lease and delete resources](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

{% include [include](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

### Required paid resources {#paid-resources}

Currently, {{ baremetal-name }} and the server backup feature are offered at no charge.

## Create a service account {#prepare-service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to lease a {{ baremetal-name }} server in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md). The name format requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `backup.editor` [role](../security/index.md#backup-editor).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. To select the service account you created earlier, click the row with its name.
  1. In the top panel, click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Select an encryption algorithm and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}** and then click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

  You will need the authorized key of the service account in the later steps.

{% endlist %}

## Activate {{ backup-name }} {#activate-provider}

To activate {{ backup-name }}, you need _at least_ the `backup.editor` [role](../security/index.md#backup-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to lease a server and connect it to {{ backup-name }}.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to lease a server and connect it to {{ backup-name }}.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. If you have not activated {{ backup-name }} yet, click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, {{ backup-name }} is already activated. Proceed to the next step.

{% endlist %}

After activation, the system automatically creates the following backup policies:
* `Default daily`: Daily incremental backup with the last 15 backups retained.
* `Default weekly`: Weekly incremental backup with the last 15 backups retained.
* `Default monthly`: Monthly incremental backup with the last 15 backups retained.

## Lease a test server {#server-lease}

If you are already leasing a server with an [appropriate OS](#os-support), go to [Connect to the server](#server-connect). Make sure to check the [network permissions](#ip-access) you need to configure on the server.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to lease a server in.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. Click **Lease server**.
  1. Select the `{{ region-id }}-m` [availability zone](../../overview/concepts/geo-scope.md).
  1. Select the `{{ region-id }}-m3` pool.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:
  
      1. Select the `BA-i103-S-10G` server configuration.
      1. Configure disk partitioning:

          1. Click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Keep the default partitioning and click **{{ ui-key.yacloud.common.save }}**.
  
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-product }}**, select the `Ubuntu 22.04 LTS` image.
  1. Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**, specify:

      1. **{{ ui-key.yacloud.baremetal.field_server-count }}**: `1`
      1. **{{ ui-key.yacloud.baremetal.field_server-lease-duration }}**: `{{ ui-key.yacloud.baremetal.label_one-month-duration }}`
  
  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.action-create-subnetwork }}**.
      1. Optionally, if you need to enable DHCP to assign IP addresses automatically, use the **Routing settings** section.
      1. Enter `bm-subnetwork` for the subnet name and click **Create subnet**.
      1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}`.

          For the {{ backup-name }} agent to exchange data with the [backup provider](../concepts/index.md#providers) servers, make sure the server has network access to the IP addresses of {{ backup-name }} resources based on the following table: {#ip-access}

          {% include [outgoing traffic](../../_includes/backup/outgoing-rules.md) %} 

  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      1. Generate a password for the root user. To do this, click **Generate** next to the **{{ ui-key.yacloud.baremetal.field_password }}** field. 

      {% note warning %}

      Once you have ordered your server, you will no longer be able to view the password. Save the password to a secure location right away.

      {% endnote %}

      1. In the **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** field, paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair yourself.

  1. Under **{{ ui-key.yacloud.baremetal.title_section-server-info }}**, enter the server **{{ ui-key.yacloud.baremetal.field_name }}**: `bm-server`.
  1. Click **Order server**.

{% endlist %}

Save the server name and ID for use in the later steps.

## Connect to the server {#server-connect}

{% list tabs group=operating_system %}

- KVM console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the server belongs to.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. In the row with the server you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Start KVM console**.
  1. In the window that opens, click **KVM console**.

- Linux/macOS {#linux-macos}

  To establish a server connection, specify its public IP address which can be found in the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server page.

  1. In the terminal, run this command:

      ```bash
      ssh root@<server_public_IP_address>
      ```

      If this is your first time connecting to the server, you will get an unknown host warning:

      ```text
      The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
      ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
      This key is not known by any other names.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Type `yes` in the terminal and press **Enter**.
  1. Enter the password you specified when creating the server and press **Enter**.

- Windows 10/11 {#windows}

  To establish a server connection, specify its public IP address which can be found in the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}** on the server page.
  
  Make sure that the Windows account has read privileges on the folder containing the keys.

  1. To connect to the server, run the following command in the command line:

      ```shell
      ssh root@<server_public_IP_address>
      ```

      If this is your first time connecting to the server, you will get an unknown host warning:

      ```text
      The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
      ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Type `yes` in the terminal and press **Enter**.
  1. Enter the password you specified when creating the server and press **Enter**.

{% endlist %}

## Install a backup agent {#agent-install}

1. Copy the file with the service account authorized key [you created earlier](#prepare-service-account) to the server. To do this, run this command _on the local machine_:

    ```bash
    scp <path_to_authorized_key_file_on_local_machine> \
    root@<server_public_IP_address>:<absolute_path_to_folder_on_server>
    ```

1. Install the [{{ yandex-cloud }} CLI](../../cli/). To do this, run this command _on the server_:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    ```

1. Authenticate in the {{ yandex-cloud }} CLI as a service account:

    ```bash
    yc config set service-account-key <absolute_path_to_authorized_key>
    ```

1. Get an IAM token:

    ```bash
    yc iam create-token
    ```

1. Install the [jq](https://jqlang.github.io/jq/) utility:

    ```bash
    apt update && apt install -y jq
    ```

1. Install the backup agent:

    ```bash
    wget https://{{ s3-storage-host }}/backup-distributions/agent_installer_bms.sh && \
    bash agent_installer_bms.sh \
      -i "`<server_ID>`-`date +%s`" \
      -n "`<server_name>`-`date +%Y%m%d.%H%M%S`" \
      -t "`<IAM_token>`"
    ```

    Wait for the message informing you the agent is registered:

    ```text
    ...
    Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
    ```

## Link your server to a backup policy {#add-policy}

1. Get a list of resources connected to {{ backup-name }}. To do this, run this command _on the local machine_:

    ```bash
    yc backup resource list
    ```

    The server connected to {{ backup-name }} will be displayed with `BMS` as its `TYPE`.
    
    Save the server ID (`INSTANCE ID`).

1. Get a list of backup policies:

    ```bash
    yc backup policy list
    ```

    Save the ID (`ID`) of the policy you want to link to the server.

1. Link your server to a backup policy:

    ```bash
    yc backup policy apply \
      --id <policy_ID> \
      --instance-ids="<server_ID>"
    ```

## Take a backup of your server {#execute-policy}

To take a server backup at a time other than the scheduled time defined in a backup policy, run this command:

```bash
yc backup policy execute \
  --id <policy_ID> \
  --instance-id <server_ID>
```

Wait for the operation to complete.

Also, you can run the command in asynchronous mode using the `--async` parameter and track the backup process using the [yc backup resource list-tasks](../../cli/cli-ref/managed-services/backup/vm/list-tasks.md) command.

## Restore your server from a backup {#server-recovery}

1. Get a list of server backups:

    ```bash
    yc backup backup list \
      --instance-id <server_ID>
    ```

    Save the backup `ID`.

1. Restore your server from the backup:

    ```bash
    yc backup backup recover \
      --source-backup-id="<backup_ID>" \
      --destination-instance-id="<server_ID>"
    ```

    Wait for the operation to complete.

    Also, you can run the command in asynchronous mode using the `--async` parameter and track the backup process using the [yc backup resource list-tasks](../../cli/cli-ref/managed-services/backup/vm/list-tasks.md) command.

## How to cancel a lease and delete resources {#clear-out}

1. [Cancel](../../baremetal/operations/servers/server-lease-cancel.md) a {{ baremetal-name }} server lease.
1. Delete the backup in {{ backup-name }} using the CLI.
