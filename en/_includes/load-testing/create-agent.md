1. If you do not have an SSH key pair yet, [create one](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create an agent.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your [agent](../../load-testing/concepts/agent.md).
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. In the **{{ ui-key.yacloud.load-testing.label_agents-list }}** tab, click **{{ ui-key.yacloud.load-testing.button_create-agent }}**.
      1. Give your agent a name, e.g., `agent-008`.
      1. Specify the same [availability zone](../../overview/concepts/geo-scope.md) where the test target is located.
      1. Under **{{ ui-key.yacloud.load-testing.section_agent }}**:
         * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
         * Specify the [subnet](../../vpc/concepts/network.md#subnet) where the test target is located. Make sure you created and [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet.
         * If [security groups](../../vpc/concepts/security-groups.md) are available to you, select a security group preset for the agent.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the agent:
         * Select the `sa-loadtest` [service account](../../iam/concepts/users/service-accounts.md).
         * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.

            {% note alert %}

            Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

            {% endnote %}

         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
      1. Click **{{ ui-key.yacloud.common.create }}**.
      1. Wait for the [VM](../../compute/concepts/vm.md) instance to create. Make sure the agent status changes to `Ready for test`.

         {% note info %}

         The agent creation process may stop at the `Initializing connection` status unless the following conditions are met:
         * The agent has [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443` and is assigned a [public IP address](../../vpc/concepts/address.md#public-addresses).
         * A NAT gateway is set up in the target subnet.
         * The service account assigned to the agent has the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

         {% endnote %}

   {% endlist %}

1. Assign a public IP to the agent to enable access over SSH:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the agent is located.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the VM named `agent-008`.
      1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, in the top-right corner, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_add-public-ip }}**.
      1. In the window that opens:
         * In the **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.field_external-type }}** field, select obtaining a **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.switch_auto }}** address.
         * Click **{{ ui-key.yacloud.component.compute.one-to-one-nat-form.button_submit }}**.

   {% endlist %}