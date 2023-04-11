1. [Generate](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a pair of SSH keys to connect to an agent over SSH.
1. Create an agent.

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create your agent.
      1. In the list of services, select **{{ load-testing-name }}**.
      1. On the left-hand panel, select ![image](../../_assets/load-testing/agent.svg) **Agents**. Click **Create agent**.
      1. Give your agent a name, e.g., `agent-008`.
      1. Specify the same availability zone where the test target is located.
      1. Under **Agent**:
         * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
         * Specify the subnet where the test target is located.
         * Specify the test agent's security group.
      1. Under **Access**, specify the information required to access the agent:
         * Select the `sa-loadtest` service account.
         * Enter the username in the **Login** field.

            {% note alert %}

            Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

            {% endnote %}

         * In the **SSH key** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.
      1. Click **Create**.
      1. Wait for the VM instance to create. Make sure the agent status changes to `READY_FOR_TEST`.

         {% note info %}

         The agent creation process may stop at the `INITIALIZING_CONNECTION` status unless the following conditions are met:
         * The agent has [access](../../load-testing/operations/security-groups-agent.md) to `loadtesting.{{ api-host }}:443` and is assigned a public IP address.
         * A NAT gateway is [set up](../../vpc/operations/create-nat-gateway.md) in the target subnet.
         * The service account assigned to the agent has the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

         {% endnote %}

   {% endlist %}

1. Assign a public IP to the agent to enable access over SSH:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the agent is located.
      1. Select **{{ compute-name }}**.
      1. Select the VM named `agent-008`.
      1. Under **Network interface**, in the top right-hand corner, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Add public IP**.
      1. In the window that opens:
         * In the **Public IP** field, choose **Auto** assignment of IP addresses.
         * Click **Add**.

   {% endlist %}