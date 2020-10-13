# Create a security group

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

To create a new [security group](../concepts/security-groups.md):

{% list tabs %}

- Management console
  1. Open the **Virtual Private Cloud** section in the folder to create a security group in.
  1. Open the **Security groups** tab.
  1. Click **Create group**.
  1. Enter a name for the security group.
  1. In the **Network** field, select the network to assign the security group to.
  1. Under **Rules**, create traffic management rules:
     1. Select the **Outgoing traffic** or **Incoming traffic** tab.
     1. Click **Add rule**.
     1. In the **Port** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
     1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
     1. In the **Purpose** field, select the purpose of the rule:
        1. **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
        1. **Security group**: The rule will apply to the VMs from the current group or the selected security group.
  1. Click **Save**. If necessary, add other rules.
  1. Click **Save**.

- СLI

  When creating a security group, you can use the following parameters:
  * `--name`: Security group name.
  * `--rule`: Rule description:
    * `direction`: Traffic direction (`ingress` is incoming traffic and `egress` is outgoing traffic).
    * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
    * `protocol`: Data transfer protocol. Possible values: `tcp`, `udp`, `icmp`, or `any`.
    * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets that traffic will come from or to.

  To create a group with an IPv4 CIDR rule, run the command:

  ```
  $ yc vpc security-group create --name test-sg-cli \
  "--rule" "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24]" \
  --network-id c645mh47vscba1d64tbs
  ```

- Terraform

  If you don't have Terraform, [install it and configure the Yandex.Cloud provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a security group with multiple rules:

  1. In the configuration file, describe the parameters of resources that you want to create:
     * `name`: Security group name.
     * `description`: Optional description of the security group.
     * `network_id`: ID of the network that the security group will be assigned to.
     * `ingress` and `egress`: Rule parameters for incoming and outgoing traffic:
       * `protocol`: Traffic transfer protocol.
       * `description`: Optional description of the rule. Possible values: `tcp`, `udp`, `icmp`, or `any`.
       * `v4_cidr_blocks`: List of CIDRs and masks of subnets that traffic will come from or to.
       * `port`: Port for traffic.
       * `from-port`: The first port in the range of ports for traffic.
       * `to-port`: The last port in the range of ports for traffic.

     Example configuration file structure:

     ```
     provider "yandex" {
       token = "<OAuth or static key of service account>"
       folder_id = "<folder ID>"
       zone      = "ru-central1-a"
     }
     
     resource "yandex_vpc_security_group" "test-sg" {
       name        = "Test security group"
       description = "Description for security group"
       network_id = "<network ID>"
     
       ingress {
         protocol       = "TCP"
         description    = "Rule description 1"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         port           = 8080
       }
     
       egress {
         protocol       = "ANY"
         description    = "Rule description 2"
         v4_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
         from_port      = 8090
         to_port        = 8099
       }
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.
     1. In the command line, go to the directory where you created the configuration file.
     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```
     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}

