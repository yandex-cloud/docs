# Linking a {{ backup-full-name }} policy to a VM automatically using the management console, CLI, or API


To create a virtual machine with automatic linking to a {{ backup-name }} policy:

1. [Prepare your cloud environment](#before-begin).
1. [Activate the service](#service-activate).
1. [Create a service account](#create-sa).
1. [Create a cloud network and subnets](#create-network).
1. [Create and configure a security group](#create-sg).
1. [Create a backup policy](#create-policy).
1. [Create a VM](#create-vm).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud environment {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-with-backup-policy/paid-resources.md) %}

## Activate the service {#service-activate}

{% include [service-activate](../_tutorials_includes/vm-with-backup-policy/service-activate.md) %}

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the service is activated in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for [the service account](../../iam/concepts/users/service-accounts.md): `backup-sa`.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `backup.editor` [role](../../backup/security/index.md#backup-editor).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `backup-sa`:

      ```bash
      yc iam service-account create --name backup-sa
      ```

      Result:

      ```bash
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T16:05:14.237381531Z"
      name: backup-sa
      ```

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Assign the `backup.editor` role for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role backup.editor \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```bash
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: backup.editor
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `backup.editor` role for the folder to the service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}

## Create a cloud network and subnets {#create-network}

Create a [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) in the [availability zone](../../overview/concepts/geo-scope.md) that will host your VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a cloud network in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `cloud-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a cloud network named `cloud-network`:

      ```bash
      yc vpc network create cloud-network
      ```

      Result:

      ```bash
      id: enptrcle5q3d********
      folder_id: b1g9hv2loamq********
      created_at: "2024-06-08T09:25:03Z"
      name: cloud-network
      default_security_group_id: enpbsnnop4ak********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create a subnet named `cloud-network-{{ region-id }}-d` in the `{{ region-id }}-d` availability zone:

      ```bash
      yc vpc subnet create cloud-network-{{ region-id }}-d \
        --zone {{ region-id }}-d \
        --network-name cloud-network \
        --range 10.1.0.0/16
      ```

      Result:

      ```bash
      id: e9bnnssj8sc8********
      folder_id: b1g9hv2loamq********
      created_at: "2024-06-08T09:27:00Z"
      name: cloud-network-{{ region-id }}-d
      network_id: enptrcle5q3d********
      zone_id: {{ region-id }}-d
      v4_cidr_blocks:
      - 10.1.0.0/16
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Create a network named `cloud-network` using the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
  1. Create the `cloud-network-{{ region-id }}-d` subnet using the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}

## Create and configure a security group {#create-sg}

For the {{ backup-name }} agent to exchange data with the [backup provider](../../backup/concepts/index.md#providers) servers, the security group must contain the rules that allow network access to the IP addresses of the {{ backup-name }} resources.

A rule to enable VM access over SSH will also be added to the security group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder you want to create a VM with a {{ backup-name }} connection in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify `backup-sg`.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `cloud-network`.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, go to the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** tab and click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Add the following outgoing traffic rules one by one:

      {% include [outgoing-traffic](../../_includes/backup/outgoing-rules.md) %}

  1. Add a rule for incoming traffic to enable VM access over SSH:

      {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
      --- | --- | --- | ---
      `22` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc vpc security-group create backup-sg \
    --network-name network-1 \
    --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
    --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.201.181.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[178.176.128.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
    --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
    --rule "direction=egress,from-port=7770,to-port=7800,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=8443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
    --rule "direction=egress,port=44445,protocol=tcp,v4-cidrs=[51.250.1.0/24]" \
    --rule "direction=ingress,port=22,protocol=any,v4-cidrs=[0.0.0.0/0]"
  ```

  Result:

  ```bash
  id: enp0v73fe8fs********
  folder_id: b1g86q4m5vej********
  created_at: "2024-07-22T20:17:43Z"
  name: backup-sgg
  network_id: enp3srbi9u49********
  status: ACTIVE
  rules:
  - id: enpporsovuhj********
      direction: EGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 213.180.193.0/24
  - id: enp7p6asol5i********
      direction: EGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 213.180.204.0/24
  ...
  - id: enp36mip5nhe********
      direction: INGRESS
      ports:
        from_port: "22"
        to_port: "22"
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
  ```

  For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- API {#api}

  To create a security group, use the [create](../../vpc/api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) gRPC API call.

{% endlist %}

## Create a backup policy{#create-policy}

You can create a new policy or use one of those automatically generated upon service activation.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a backup policy in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_backup }}**.
  1. Go to the ![policies](../../_assets/console-icons/calendar.svg) **{{ ui-key.yacloud.backup.label_policies }}** tab.
  1. Click **{{ ui-key.yacloud.backup.button_create-policy }}**.
  1. Specify the policy properties:

      * **{{ ui-key.yacloud.common.name }}**: `weekly-backup`
      * **{{ ui-key.yacloud.backup.field_repeat-period-type }}**: `{{ ui-key.yacloud.backup.value_period-time-weekly }}`
      * **{{ ui-key.yacloud.backup.field_days-of-week }}**: `{{ ui-key.yacloud.backup.value_day-fri }}`
      * **{{ ui-key.yacloud.backup.field_time }}**: `03:00`
      * **{{ ui-key.yacloud.backup.field_backup-scheme }}**: `{{ ui-key.yacloud.backup.value_type-incremental }}`
      * **{{ ui-key.yacloud.backup.field_auto-delete }}**: `{{ ui-key.yacloud.backup.value_retention-save-all }}`

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Describe the configuration of the backup policy you are creating in the `backup-policy-scheme.json` file.

      ```json
      {
        "compression": "NORMAL",
        "format": "AUTO",
        "multiVolumeSnapshottingEnabled": true,
        "preserveFileSecuritySettings": true,
        "reattempts": {
          "enabled": true,
          "interval": {
            "type": "SECONDS",
            "count": "30"
          },
          "maxAttempts": "30"
        },
        "silentModeEnabled": true,
        "splitting": {
          "size": "1099511627776"
        },
        "vmSnapshotReattempts": {
          "enabled": true,
          "interval": {
            "type": "MINUTES",
            "count": "5"
          },
          "maxAttempts": "3"
        },
        "vss": {
          "enabled": true,
          "provider": "TARGET_SYSTEM_DEFINED"
        },
        "archive": {
          "name": "'[Machine Name]-[Plan ID]-[Unique ID]A'"
        },
        "performanceWindow": {
          "enabled": true
        },
        "scheduling": {
          "backupSets": [
            {
              "time": {
                "weekdays": [
                  "FRIDAY"
                ],
                "repeatAt": [
                  {
                    "hour": "3"
                  }
                ],
                "type": "WEEKLY"
              }
            }
          ],
          "enabled": true,
          "maxParallelBackups": "2",
          "randMaxDelay": {
            "type": "MINUTES",
            "count": "30"
          },
          "scheme": "ALWAYS_INCREMENTAL",
          "weeklyBackupDay": "MONDAY"
        },
        "cbt": "ENABLE_AND_USE",
        "fastBackupEnabled": true,
        "quiesceSnapshottingEnabled": true
      }
      ```

  1. Create a backup policy:

      ```bash
      yc backup policy create \
        --name weekly-backup \
        --settings-from-file ./backup-policy-scheme.json
      ```

      Result:

      ```text
      id: cdgo5vytuw57********
      name: weekly-backup
      created_at: "2024-07-23T20:34:37Z"
      updated_at: "2024-07-23T20:34:37Z"
      enabled: true
      settings:
        compression: NORMAL
        format: AUTO
        multi_volume_snapshotting_enabled: true
        preserve_file_security_settings: true
        reattempts:
          enabled: true
          interval:
            type: SECONDS
            count: "30"
          max_attempts: "30"
        silent_mode_enabled: true
        splitting:
          size: "1099511627776"
        vm_snapshot_reattempts:
          enabled: true
          interval:
            type: MINUTES
            count: "5"
          max_attempts: "3"
        vss:
          enabled: true
          provider: TARGET_SYSTEM_DEFINED
        archive:
          name: '''[Machine Name]-[Plan ID]-[Unique ID]A'''
        performance_window:
          enabled: true
        retention: {}
        scheduling:
          backup_sets:
            - time:
                weekdays:
                  - FRIDAY
                repeat_at:
                  - hour: "3"
                type: WEEKLY
              type: TYPE_AUTO
          enabled: true
          max_parallel_backups: "2"
          rand_max_delay:
            type: MINUTES
            count: "30"
          scheme: ALWAYS_INCREMENTAL
          weekly_backup_day: MONDAY
        cbt: ENABLE_AND_USE
        fast_backup_enabled: true
        quiesce_snapshotting_enabled: true
      folder_id: b1g86q4m5vej********
      ```

      Save the policy `id`.

      For more information about the `yc backup policy create` command, see the [CLI reference](../../cli/cli-ref/backup/cli-ref/policy/create.md).

- API {#api}

  To create a [backup policy](../../backup/concepts/policy.md), use the [create](../../backup/backup/api-ref/Policy/create.md) REST API method for the [Policy](../../backup/backup/api-ref/Policy/index.md) resource or the [PolicyService/Create](../../backup/backup/api-ref/grpc/Policy/create.md) gRPC API call.

{% endlist %}

## Create a VM {#create-vm}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Ubuntu 22.04 LTS` and select a public [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network named `cloud-network` and the subnet named `cloud-network-{{ region-id }}-d`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` value to assign a random external IP address from the {{ yandex-cloud }} pool.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `backup-sg` security group.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify a username: `vm-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `backup-instance`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**:

      * Select the `backup-sa` service account.
      * Enable **{{ ui-key.yacloud.compute.instances.create.section_backup }}**.
      * Select the backup policy [created earlier](#create-policy).

  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Describe the custom metadata configuration in the `user-data.yaml` file:

      ```yaml
      #cloud-config
      datasource:
        Ec2:
        strict_id: false
      ssh_pwauth: no
      users:
      - name: vm-user
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - <public_SSH_key>
      packages:
        - curl
        - perl
        - jq
      runcmd:
        - curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash
      ```

  1. Specify the `weekly-backup` policy ID in the `cloudbackup.json` file:

      ```json
      {"initialPolicies": ["<weekly_backup_policy_ID>"]}
      ```

      To learn more about getting the policy ID, see [{#T}](../../backup/operations/policy-vm/get-info.md).

  1. Run the following command:

      ```bash
      yc compute instance create \
        --name backup-instance \
        --zone {{ region-id }}-d \
        --network-interface subnet-name=cloud-network-{{ region-id }}-d,security-group-ids=<backup-sg_security_group_ID>,ipv4-address=auto,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,size=15 \
        --metadata-from-file user-data=./user-data.yaml,cloudbackup=./cloudbackup.json \
        --service-account-name backup-sa
      ```

      For more information about the `yc compute instance create` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  To create a VM, use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

  In the request body, specify:

  * In the `metadata` field, the `user-data` object containing the custom metadata configuration with a script to install a backup agent.
  * In the `cloudbackup` field, the backup policy ID. To learn more about getting the policy ID, see [{#T}](../../backup/operations/policy-vm/get-info.md).

  Use `\n` as a line separator.

  {% cut "Request body example" %}

  ```json
  {
    "folderId": "<folder_ID>",
    "name": "backup-instance",
    "zoneId": "{{ region-id }}-d",
    "platformId": "standard-v3",
    "resourcesSpec": {
      "memory": "2147483648",
      "cores": "2"
    },
    "metadata": {
      "user-data": "#cloud-config\ndatasource:\nEc2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: vm-user\n  shell: /bin/bash\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  ssh_authorized_keys:\n  - <public_SSH_key>\npackages:\n  - curl\n  - perl\n  - jq\nruncmd:\n  - curl https://storage.yandexcloud.net/backup-distributions/agent_installer.sh | sudo bash",
      "cloudbackup": "{\"initialPolicies\": [\"<policy_ID>\"]}"
    },
    "bootDiskSpec": {
      "diskSpec": {
        "size": "16106127360",
        "imageId": "fd8ljvsrm3l1********"
      }
    },
    "networkInterfaceSpecs": [
      {
        "subnetId": "<subnet_ID>",
        "primaryV4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "IPV4"
          }
        },
        "securityGroupIds": [
          "<security_group_ID>"
        ]
      }
    ],
    "serviceAccountId": "<service_account_ID>"
  }
  ```

  {% endcut %}

{% endlist %}

{% include [installation-note](../_tutorials_includes/vm-with-backup-policy/installation-note.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../backup/operations/delete-vm.md) the VM from {{ backup-name }}.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM from {{ compute-name }}.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
1. [Delete](../../backup/operations/backup-vm/delete.md) VM backups, if any. 