1. [Generate](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair to connect to an agent over SSH.

1. Create an agent:

    {% list tabs %}

    - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to create an agent in.

      1. In the list of services, select **{{ load-testing-name }}**.

      1. In the left-hand panel, select ![image](../../_assets/load-testing/agent.svg) **Agents**. Click **Create agent**.

      1. Name the agent like `agent-008`.

      1. Specify the same availability zone where the test target is located.

      1. Under **Agent**:
          * Select the appropriate agent type. For more information, see [Agent performance](../../load-testing/concepts/agent.md#benchmark).
          * Specify the subnet where the test target is located.
          * Specify the agent's security group.

      1. Under **Access**, specify the information required to access the agent:

          * Select the `sa-loadtest` service account.

          * Enter the username in the **Login** field.

              {% note alert %}

              Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

              {% endnote %}

          * In the **SSH key** field, paste the contents of the [public key file](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

      1. Click **Create**.

      1. Wait for the VM creation process to complete. The agent status should change to `READY_FOR_TEST`.

          {% note info %}

          The agent creation process may end up with the `INITIALIZING_CONNECTION` status if the agent has no [permission](../../load-testing/operations/security-groups-agent.md) to access `loadtesting.api.cloud.yandex.net:443`, or the service account that is assigned to the agent doesn't have the required [roles](../../load-testing/operations/create-agent.md#infrastructure-prepare).

          {% endnote %}

    {% endlist %}

1. Link a public IP address to the agent for SSH access:

    {% list tabs %}

    - Management console
      1. In the [management console]({{ link-console-main }}), select the folder where the agent is located.
      1. Select **{{ compute-name }}**.
      1. Select the `agent-008` VM.
      1. Under **Network interface**, click ![image](../../_assets/horizontal-ellipsis.svg) in the upper-right corner and select **Add public IP address**.
      1. In the window that opens:
          * In the **Public address** field, select the **Auto** method for assigning an IP address.
          * Click **Add**.

    {% endlist %}

