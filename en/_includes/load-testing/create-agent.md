


1. If you do not have an SSH key pair yet, [create one](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create an agent:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create the [agent](../../load-testing/concepts/agent.md).
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
     1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
     1. Enter a name for the agent, e.g., `agent-008`.
     1. Specify the same [availability zone](../../overview/concepts/geo-scope.md) as the one hosting your test target.
     1. Under **{{ ui-key.yacloud.load-testing.section_agent }}**:
        * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
        * Specify the [subnet](../../vpc/concepts/network.md#subnet) hosting your test target. Make sure you created and [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in that subnet.
        * If you have access to [security groups](../../vpc/concepts/security-groups.md), select a preset agent security group.
     1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the agent access credentials:
        * Select the `sa-loadtest` [service account](../../iam/concepts/users/service-accounts.md).
        * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username.

          {% note alert %}

          Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

          {% endnote %}
              
        * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
     1. Click **{{ ui-key.yacloud.common.create }}**.
     1. Wait for the [VM](../../compute/concepts/vm.md) to create. Make sure the agent status has changed to `Ready for test`.

        {% note info %}

        If the agent creation process has stopped at `Initializing connection`, make sure the following conditions are met:
        * The agent has a [public IP address](../../vpc/concepts/address.md#public-addresses) and [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443`.
        * The target subnet has a configured NAT gateway.
        * The service account assigned to the agent has the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

        {% endnote %}

   - CLI {#cli}

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. See the description of the [CLI](../../cli/) command for creating an [agent](../../load-testing/concepts/agent.md):
   
        ```bash
        yc loadtesting agent create --help
        ```

     1. Select the same [availability zone](../../overview/concepts/geo-scope.md) as the one hosting your test target.

     1. Select the [subnet](../../vpc/concepts/network.md#subnet) hosting your test target. Make sure you [created and set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in that subnet.
   
        To get a list of available subnets using the CLI, run this command:
      
        ```bash
        yc vpc subnet list
        ```

        Result:

        ```text
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        | e2lfkhps7bol******** |   default-{{ region-id }}-b   | enpnf7hajqmd******** |                |   {{ region-id }}-b   | [10.129.0.0/24] |
        | e9bgnq1bggfa******** |   default-{{ region-id }}-a   | enpnf7hajqmd******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
        | fl841n5ilklr******** |   default-{{ region-id }}-d   | enpnf7hajqmd******** |                |   {{ region-id }}-d   | [10.130.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1. Select the [security group](../../vpc/concepts/security-groups.md). Make sure to [configure](../../load-testing/operations/security-groups-agent.md) the security group in advance.

        To get a list of available security groups using the CLI, run this command:

        ```bash
        yc vpc security-group list
        ```
   
        Result:
   
        ```text
        +----------------------+---------------------------------+--------------------------------+----------------------+
        |          ID          |              NAME               |          DESCRIPTION           |      NETWORK-ID      |
        +----------------------+---------------------------------+--------------------------------+----------------------+
        | enp414a2tnnp******** | default-sg-enpnf7hajqmd******** | Default security group for     | enpnf7hajqmd******** |
        |                      |                                 | network                        |                      |
        | enpctpve7951******** | sg-load-testing-agents          |                                | enpnf7hajqmd******** |
        | enpufo9ms0gi******** | sg-load-testing-targets         |                                | enpnf7hajqmd******** |
        +----------------------+---------------------------------+--------------------------------+----------------------+
        ```

     1. Get the ID of `sa-loadtest` [service account](../../iam/concepts/users/service-accounts.md), specifying its name:

        ```bash
        yc iam service-account get sa-loadtest
        ```

        Result:
   
        ```text
        id: ajespasg04oc********
        folder_id: b1g85uk96h3f********
        created_at: "2024-12-04T17:38:57Z"
        name: sa-loadtest
        last_authenticated_at: "2024-12-12T19:10:00Z"
        ```

     1. Create an agent in the [default](../../resource-manager/concepts/resources-hierarchy.md#folder) folder:
   
        ```bash
        yc loadtesting agent create \
          --name agent-008 \
          --labels origin=default,label-key=label-value \
          --zone default-{{ region-id }}-a \
          --network-interface subnet-id=e9bgnq1bggfa********,security-group-ids=enpctpve7951******** \
          --cores 2 \
          --memory 2G \
          --service-account-id ajespasg04oc********
          --metadata-from-file user-data=metadata.yaml
        ```
   
        Where:
        * `--name`: Agent name.
        * `--labels`: Agent [labels](../../resource-manager/concepts/labels.md).
        * `--zone`: Availability zone to host the agent.
        * `--network-interface`: Agent [network interface](../../compute/concepts/network.md) settings:
            * `subnet-name`: ID of the selected subnet.
            * `security-group-ids`: Security group IDs.
        * `--cores`: Number of CPU cores the agent can use.
        * `--memory`: Amount of RAM allocated to the agent.
        * `--service-account-id`: Service account ID.
        * `--metadata-from-file`: `<key>=<value>` pair with the name of the file containing the public SSH key path. For an example of the `metadata.yaml` configuration file, see [VM metadata](../../compute/concepts/vm-metadata.md#how-to-send-metadata).

        For more information on how to create an agent with the CLI, see the [Yandex Cloud Examples repository](https://github.com/yandex-cloud-examples/yc-load-testing-create-agent).

   {% endlist %}

1. Assign a public IP address to your agent to enable access over SSH:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder with the agent.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. Select the `agent-008` VM.
     1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, in the top-right corner, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
     1. In the window that opens:
        * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}**.
        * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

   - CLI {#cli}
   
     To assign a public IP address to an agent, run the following [CLI](../../cli/) command:
   
     ```bash
     yc compute instance add-one-to-one-nat \
       --id=<VM_ID> \
       --network-interface-index=<VM_network_interface_number> \
       --nat-address=<IP_address>
     ```
   
     Where:
     * `--id`: VM ID. You can get a list of available VM IDs in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) using the `yc compute instance list` [CLI command](../../cli/cli-ref/compute/cli-ref/instance/list.md).
     * `--network-interface-index`: VM network interface number. The default value is `0`. To get a list of VM network interfaces and their numbers, run `yc compute instance get <VM_ID>`.
     * `--nat-address`: Public IP address to assign to the VM. This is an optional setting. If you skip it, the VM will get a public IP address automatically.
   
       You can get a list of reserved public IP addresses available in the folder using the `yc vpc address list` [CLI command](../../cli/cli-ref/vpc/cli-ref/address/list.md). The IP address and the VM must be in the same availability zone.
   
     Here is a possible use case:
   
     ```bash
     yc compute instance add-one-to-one-nat \
       --id=fhmsbag62taf******** \
       --network-interface-index=0 \
       --nat-address=51.250.*.***
     ```
   
     Result:
   
     ```text
     id: fhmsbag62taf********
     folder_id: b1gv87ssvu49********
     created_at: "2022-05-06T10:41:56Z"
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```
   
     For more information about the `yc compute instance add-one-to-one-nat` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/add-one-to-one-nat.md).

   {% endlist %}