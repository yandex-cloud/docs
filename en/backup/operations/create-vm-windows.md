# Creating a Windows Server VM with a connection to {{ backup-name }}

You can back up {{ compute-name }} [VMs](../../compute/concepts/vm.md) with [supported Windows-based operating systems](../concepts/vm-connection.md#windows).

{% include [requirements](../../_includes/backup/requirements.md) %}

## Getting started {#before-you-begin}

1. [Create](../../iam/operations/sa/create.md) a service account with the `backup.editor` [role](../../iam/concepts/access-control/roles.md#backup-editor).
1. [Set up](../concepts/vm-connection.md#vm-network-access) network access for your VM.

## Creating a VM {#creating-vm}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-pic.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter a name and description for the VM. The naming requirements are as follows:

        {% include [name-format](../../_includes/name-format.md) %}

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the Windows Server 2019 or 2022 image.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      1. Choose a subnet in the selected availability zone.
      1. In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
      1. Select a security group configured to work with {{ backup-name }}.
  1. Under **{{ ui-key.yacloud.compute.instances.create.label_backup }}**, enable the {{ backup-name }} connection option for your VM.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select the service account with the `backup.editor` role.
  1. Specify the other VM parameters as needed.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI

  1. Select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | wasdcjs6be29******** | my-folder          |                  | ACTIVE |
      | qwertys6be29******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Select a [subnet](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet list --folder-id <folder_ID>
      ```

      Result:

      ```text
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      | b0c6n43f9lgh******** | default-{{ region-id }}-c     | enpe3m3fa00u******** |                | {{ region-id }}-c | [10.***.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b | [10.***.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a | [10.***.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Create a file named `init.ps1` with a script for installing the {{ backup-name }} agent on your VM:

      ```powershell
      #ps1_sysnative
      echo 'Starting to execute backup agent installation'
      Invoke-WebRequest https://storage.yandexcloud.net/backup-distributions/agent_installer.ps1 -UseBasicParsing | Invoke-Expression
      ```

  1. Create a VM:

      ```bash
      yc compute instance create \
        --folder-id <folder_ID> \
        --name <VM_name> \
        --zone <availability_zone> \
        --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4,security-group-ids=<security_group_ID> \
        --create-boot-disk image-id=<image_ID>,size=<boot_disk_size> \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name <service_account_name> \
        --metadata-from-file user-data=<path_to_script_file>
      ```

      Where:
      * `name`: VM name.

         {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) that corresponds to the selected subnet.
      * `subnet-name`: Name of the selected [subnet](../../vpc/concepts/network.md#subnet).
      * `security-group-ids`: ID of the [security group](../../vpc/concepts/security-groups.md) configured to work with {{ backup-name }}.
      * `image-id`: OS [image](../../compute/concepts/image.md) ID.
      * `size`: Boot disk size.
      * `cores`: [Number of vCPUs](../../compute/concepts/vm.md) in your VM.
      * `core-fraction`: Guaranteed vCPU performance in %.
      * `memory`: [Amount of RAM](../../compute/concepts/vm.md) in your VM.
      * `service-account-name`: Name of the [service account](../../iam/concepts/users/service-accounts.md) with the `backup.editor` role.
      * `user-data`: Path to the previously created file with a script for installing the {{ backup-name }} agent on your VM.

      In this example, a VM running on Windows Server 2022 is created:

      ```bash
      yc compute instance create \
        --name my-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=my-vpc-{{ region-id }}-b,nat-ip-version=ipv4,security-group-ids=abcd3570sbqg******** \
        --create-boot-disk image-id=fd890bh2sapn********,size=60 \
        --cores 2 \
        --core-fraction 100 \
        --memory 4 \
        --service-account-name backup-editor \
        --metadata-from-file user-data=init.ps1
      ```

      Result:

      ```bash
      done (46s)
      id: abcdho6nspdk********
      folder_id: wasdcjs6be29********
      created_at: "2023-10-09T14:57:06Z"
      name: my-vm
      ...
      placement_policy: {}
      ```

{% endlist %}

{% include [agent-installation-timespan](../../_includes/backup/agent-installation-timespan-win.md) %}

{% include [agent-installation-failure](../../_includes/backup/agent-installation-failure-win.md) %}

{% include [vm-list](../../_includes/backup/vm-list.md) %}

#### See also {#see-also}

* [{#T}](connect-vm-windows.md)
* [{#T}](connect-vm-linux.md)
* [Attaching a VM to a backup policy](./policy-vm/update.md#update-vm-list)
* [{#T}](./backup-vm/recover.md)
* [{#T}](./backup-vm/delete.md)
* [{#T}](./policy-vm/create.md)
