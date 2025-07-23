
# Connecting an existing {{ baremetal-full-name }} server to {{ backup-full-name }}


You can connect an existing [{{ baremetal-name }} server](../../baremetal/concepts/servers.md) to {{ backup-name }} and configure backups of its data.

For more information about connecting a {{ baremetal-name }} server to {{ backup-name }} when ordering it, see [{#T}](../../backup/operations/backup-baremetal/lease-server-with-backup.md).

For more information on managing {{ baremetal-name }} servers, see [Step-by-step guides for {{ baremetal-full-name }}](../../baremetal/operations/index.md).

Connecting to {{ backup-name }} is supported for servers running the following operating systems: {#os-support}

{% include [baremetal-os-list](../../_includes/backup/baremetal-os-list.md) %}

To connect an existing server to {{ backup-name }}:
1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#prepare-service-account).
1. [Activate {{ backup-name }}](#activate-provider).
1. [Lease a test server](#server-lease).
1. [Connect to the server](#server-connect).
1. [Install the {{ backup-name }} agent](#agent-install).
1. [Associate the server with a backup policy](#assign-policy).
1. [Run the backup process](#execute-policy).
1. [Restore your server from the backup](#server-recovery).

See also [How to cancel a lease and delete resources](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Server lease fee (see [{{ baremetal-full-name }} pricing](../../baremetal/pricing.md)).
* Fee for the {{ baremetal-name }} server connected to {{ backup-name }} and the backup size (see [{{ backup-full-name }} pricing](../../backup/pricing.md)).

{% include [bms-backup-free-traffic](../../_includes/baremetal/bms-backup-free-traffic.md) %}

## Create a service account {#prepare-service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to lease a {{ baremetal-name }} server.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md). Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `backup.editor` and `baremetal.editor` roles to the service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Select the service account you created by clicking the row with its name.
  1. In the top panel, click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}**.
  1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Select an encryption algorithm and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}** and then click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**.

  You will need the authorized key of the service account in the later steps.

{% endlist %}

## Activate {{ backup-name }} {#activate-provider}

To activate {{ backup-name }}, you need _at least_ the `backup.editor` [role](../../backup/security/index.md#backup-editor) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to lease a server and connect it to {{ backup-name }}.

{% include [agent-send-data](../../_includes/backup/agent-send-data.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to lease a server and connect it to {{ backup-name }}.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. If you have not activated {{ backup-name }} yet, click **{{ ui-key.yacloud.backup.button_action-activate }}**.

      If there is no **{{ ui-key.yacloud.backup.button_action-activate }}** button, {{ backup-name }} is already activated. Proceed to the next step.

- CLI {#cli}

  {% include [cli-activate-service](../../_includes/backup/operations/cli-activate-service.md) %}

{% endlist %}

After activation, the system automatically creates the following backup policies:
* `Default daily`: Daily incremental backup with the latest 15 backups retained.
* `Default weekly`: Weekly incremental backup with the latest 15 backups retained.
* `Default monthly`: Monthly incremental backup with the latest 15 backups retained.

## Lease a test server {#server-lease}

If you are already leasing a server with an [appropriate OS](#os-support), proceed to [Connect to the server](#server-connect). Make sure to check the [network permissions](#ip-access) you need to configure on the server.

{% list tabs group=instructions %}

- Management console {#console}

  1. {% include [server-lease-step1](../../_includes/baremetal/instruction-steps/server-lease-step1.md) %}
  1. {% include [server-lease-step2](../../_includes/baremetal/instruction-steps/server-lease-step2.md) %}
  1. {% include [server-lease-step3](../../_includes/baremetal/instruction-steps/server-lease-step3.md) %}
  1. {% include [server-lease-step4](../../_includes/baremetal/instruction-steps/server-lease-step4.md) %}
  1. {% include [server-lease-step5](../../_includes/baremetal/instruction-steps/server-lease-step5.md) %}
  1. {% include [server-lease-step6](../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}

      {% include [server-lease-backup-partitioning-notice](../../_includes/baremetal/instruction-steps/server-lease-backup-partitioning-notice.md) %}

  1. {% include [server-lease-step7-backup](../../_includes/baremetal/instruction-steps/server-lease-step7-backup.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**:

      1. In the **{{ ui-key.yacloud.baremetal.field_server-count }}** field, specify `1`.
      1. {% include [server-lease-step6-substep](../../_includes/baremetal/instruction-steps/server-lease-step6-substep.md) %}
  1. {% include [server-lease-step9-backup](../../_includes/baremetal/instruction-steps/server-lease-step9-backup.md) %}
  1. Under **{{ ui-key.yacloud.baremetal.title_server-access }}**:

      {% include [server-lease-access](../../_includes/baremetal/server-lease-access.md) %}

  1. {% include [server-lease-step11](../../_includes/baremetal/instruction-steps/server-lease-step11.md) %}
  1. {% include [server-lease-step12](../../_includes/baremetal/instruction-steps/server-lease-step12.md) %}

{% endlist %}

Save the server name and ID, as you will need them later.

For more information on leasing a server, see [this {{ baremetal-name }} guide](../../baremetal/operations/servers/server-lease.md).

## Connect to the server {#server-connect}

{% list tabs group=operating_system %}

- KVM console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your server.
  1. In the list of services, select **{{ baremetal-name }}**.
  1. Find the server you need, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, and select **Start KVM console**.
  1. In the window that opens, click **KVM console**.

- Linux/macOS {#linux-macos}

  To establish a server connection, specify the server public IP address which you can get using the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **Network settings** on the server page.

  1. In the terminal, run this command:

      ```bash
      ssh root@<server_public_IP_address>
      ```

      If this is your first time connecting to the server, you will get this unknown host warning:

      ```text
      The authenticity of host '51.250.83.243 (51.250.83.243)' can't be established.
      ED25519 key fingerprint is SHA256:6Mjv93NJDCaf/vu3NYwiLQK4tKI+4cfLtkd********.
      This key is not known by any other names.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Type `yes` into the terminal and press **Enter**.
  1. Enter the password you specified when creating the server and press **Enter**.

- Windows 10/11 {#windows}

  To establish a server connection, specify the server public IP address which you can get using the management console, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field under **Network settings** on the server page.

  Make sure the Windows account has read access to the key folder.

  1. To connect to the server, run the following command in the command line:

      ```shell
      ssh root@<server_public_IP_address>
      ```

      If this is your first time connecting to the server, you will get this unknown host warning:

      ```text
      The authenticity of host '89.169.132.223 (89.169.132.223)' can't be established.
      ECDSA key fingerprint is SHA256:DfjfFB+in0q0MGi0HnqLNMdHssLfm1yRanB********.
      Are you sure you want to continue connecting (yes/no/[fingerprint])?
      ```

  1. Type `yes` into the terminal and press **Enter**.
  1. Enter the password you specified when creating the server and press **Enter**.

{% endlist %}

## Install the {{ backup-name }} agent {#agent-install}

1. Copy the file with the service account's authorized key [you created earlier](#prepare-service-account) to the server. To do this, run the following command _on the local machine_:

    ```bash
    scp <path_to_authorized_key_file_on_local_machine> \
    root@<server_public_IP_address>:<absolute_path_to_folder_on_server>
    ```

1. Install the [{{ yandex-cloud }} CLI](../../cli/) by running this command _on the server_:

    ```bash
    curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
    ```

1. Install the required packages and utilities:

    {% list tabs group=operating_system %}

    - Debian/Ubuntu {#ubuntu}

      ```bash
      apt update && apt install -y jq
      ```

    - CentOS {#centos}

      ```bash
      yum install epel-release -y && \
      yum update -y && \
      yum install jq -y && \
      yum install wget -y
      ```

    {% endlist %}

1. Authenticate in the {{ yandex-cloud }} CLI using service account credentials:

    ```bash
    yc config set service-account-key <absolute_path_to_authorized_key>
    ```

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md):

    ```bash
    yc iam create-token
    ```

1. Install the {{ backup-name }} agent, specifying the service account IAM token you got earlier:

    ```bash
    wget https://{{ s3-storage-host }}/backup-distributions/agent_installer_bms.sh && \
    sudo bash ./agent_installer_bms.sh \
    -t=<IAM_token>
    ```

    Wait until you see the message confirming {{ backup-name }} agent registration:

    ```text
    ...
    Agent registered with id D9CA44FC-716A-4B3B-A702-C6**********
    ```

## Associate the server with a backup policy {#assign-policy}

You can create backups in {{ backup-name }} only as part of a [backup policy](../../backup/concepts/policy.md). By default, {{ baremetal-name }} servers are not associated with any policy.

To associate a server with a backup policy:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to associate a server with a backup policy.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud_billing.backup.label_policies }}**.
  1. Select the policy to associate your server with.
  
      [Create](../../backup/operations/policy-vm/create.md) a new backup policy as needed.
  1. Under **{{ ui-key.yacloud.backup.title_linked-recourses }}**, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.backup.button_attach-instance }}**.
  1. In the window that opens, select the **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab and select the server from the list.
  1. Click **{{ ui-key.yacloud_billing.backup.button_attach-instance-submit }}**.

- CLI {#cli}

  1. See the description of the CLI command for associating a {{ baremetal-name }} server with a backup policy: 

      ```bash
      yc backup policy apply --help
      ```

  1. Get the ID of the policy you want to associate your server with:

      {% include [get-policy-id](../../_includes/backup/operations/get-policy-id.md) %}

      [Create](../../backup/operations/policy-vm/create.md) a new backup policy as needed.

  1. Get the ID of the server to associate. To do this, go to the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}** from the list of services. The IDs are specified in the server list, the **{{ ui-key.yacloud.common.id }}** field.

  1. Associate the server with the backup policy, specifying the policy ID:

      ```bash
      yc backup policy apply <policy_ID> \
        --instance-ids <server_ID>
      ```

      Where `--instance-ids` is the ID of the {{ baremetal-name }} server being associated with the policy.

  For more information about this command, see the [CLI reference](../../cli/cli-ref/backup/cli-ref/policy/apply.md).

{% endlist %}

## Run the backup process {#execute-policy}

{% note info %}

{% include [lvm-restoration-notice](../../_includes/backup/lvm-restoration-notice.md) %}

{% endnote %}

To start a {{ baremetal-name }} server backup outside the backup policy schedule:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your backup policy.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![bms](../../_assets/console-icons/objects-align-justify-horizontal.svg) **{{ ui-key.yacloud.backup.label_baremetal-instances }}**.
  1. Find the server you need, click ![options](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yacloud.backup.action_start_backup }}**.
  1. In the window that opens, select the backup policy for creating the backup and click **{{ ui-key.yacloud.common.create }}**.

  {{ backup-name }} will start creating a backup of the {{ baremetal-name }} server. You can see the progress in the relevant server row in the **{{ ui-key.yacloud.backup.column_baremetal-instance-status }}** field.

- CLI {#cli}

  Run this command, specifying the backup policy and server IDs:

  ```bash
  yc backup policy execute \
    --id <policy_ID> \
    --instance-id <server_ID>
  ```

  Wait for the operation to complete.

  You can also run this command in asynchronous mode using the `--async` parameter and track the backup process using the [yc backup resource list-tasks](../../cli/cli-ref/backup/cli-ref/vm/list-tasks.md) command.

{% endlist %}

## Restore your server from the backup {#server-recovery}

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

If you need to restore one server's backup to another server, or if the OS has been reinstalled on the source server, [reinstall](#agent-install) the {{ backup-name }} agent on that server.

{% include [avoid-errors-when-restoring-from-backup.md](../../_includes/backup/avoid-errors-when-restoring-from-backup.md) %}

{% note tip %}

If the server used a RAID array, we recommend restoring the backup to a server with a similar partition configuration. We also recommend that you make the partitions at least as large as on the source server.

{% endnote %}

To restore your server from a backup:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the backup.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. In the left-hand panel, select ![backups](../../_assets/console-icons/archive.svg) **{{ ui-key.yacloud.backup.label_backups }}** and open the **{{ ui-key.yacloud.backup.value_bms-recourses }}** tab.
  1. Next to the backup you need to restore your {{ baremetal-name }} server from, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.backup.action_bms-recovery }}**.
  1. In the window that opens, select the server used to create the selected backup. This server will be marked in the list as `({{ ui-key.yacloud.backup.context_current-bms }})`.
  1. Click **{{ ui-key.yacloud.backup.action_recovery-start }}**.

  This will start the {{ baremetal-name }} server restoration from the backup. Wait for it to complete.

- CLI {#cli}

  1. Get a list of backups for the server, specifying its ID:

      ```bash
      yc backup backup list \
        --instance-id <server_ID>
      ```

      Save the backup `ID`.

  1. Restore your server from the backup, specifying their IDs:

      ```bash
      yc backup backup recover \
        --destination-instance-id="<server_ID>" \
        --source-backup-id="<backup_ID>"
      ```

      The recovery of your {{ baremetal-name }} server will start. Wait for it to complete.

      You can also run this command in asynchronous mode using the `--async` parameter and track the backup process using the [yc backup resource list-tasks](../../cli/cli-ref/backup/cli-ref/vm/list-tasks.md) command.

      For more information about the `yc backup backup recover` command, see the [CLI reference](../../cli/cli-ref/backup/cli-ref/backup/recover.md).

{% endlist %}

{% include [non-native-bms-restore-connectivity-loss](../../_includes/backup/operations/non-native-bms-restore-connectivity-loss.md) %}

## How to cancel a lease and delete resources {#clear-out}

1. [Cancel](../../baremetal/operations/servers/server-lease-cancel.md) your {{ baremetal-name }} server lease.
1. [Delete](../../backup/operations/backup-vm/delete.md) the backup in {{ backup-name }} using the CLI.

#### See also {#see-also}

* [{#T}](../../backup/operations/backup-baremetal/lease-server-with-backup.md)