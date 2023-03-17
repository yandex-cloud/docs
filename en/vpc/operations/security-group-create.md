# Create a security group

{% include [Preview](../../_includes/vpc/preview.md) %}

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

To create a new [security group](../concepts/security-groups.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Click **Create group**.
   1. Enter a name for the security group.
   1. In the **Network** field, select the network to assign the security group to.
   1. Under **Rules**, create traffic management rules:
      1. Select the **Outgoing traffic** or **Incoming traffic** tab.
      1. Click **Add rule**.
      1. In the **Port range** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **Protocol** field, specify the desired protocol or leave **Any** to allow traffic transmission over any protocol.
      1. In the **Purpose** or **Source** field, select the purpose of the rule:
         1. **CIDR**: The rule will apply to the range of IP addresses. In the **CIDR blocks** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **Add CIDR**.
         1. **Security group**: The rule will apply to the VMs from the current group or the selected security group.
         1. **Load balancer's health checks**.
   1. Click **Save**. If necessary, add other rules.
   1. Click **Save**.

- CLI

   To create a group with an IPv4 CIDR rule, run the command:

   ```
   yc vpc security-group create \
     --name test-sg-cli \
     --rule direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24] \
     --network-id c645mh47vscba1d64tbs
   ```

   Where:

   * `--name`: Security group name.
   * `--rule`: Rule description:
      * `direction`: Traffic direction. `ingress`: incoming traffic, `egress`: outgoing traffic.
      * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
      * `protocol`: Data transfer protocol. Possible values: `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets that traffic will come from or to.

- API

   Use the [create](../api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../api-ref/grpc/security_group_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a security group with multiple rules:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Security group name.
      * `description`: Optional description of the security group.
      * `network_id`: ID of the network that the security group will be assigned to.
      * `ingress` and `egress`: Rule parameters for incoming and outgoing traffic:
         * `protocol`: Traffic transfer protocol.
         * `description`: Optional description of the rule. Possible values: `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
         * `v4_cidr_blocks`: List of CIDRs and masks of subnets that traffic will come from or to.
         * `port`: Port for traffic.
         * `from-port`: The first port in the range of ports for traffic.
         * `to-port`: The last port in the range of ports for traffic.

      Example of the configuration file structure:

      
      ```
      provider "yandex" {
        token     = "<OAuth or static key of service account>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_vpc_security_group" "test-sg" {
        name        = "Test security group"
        description = "Description for security group"
        network_id  = "<Network ID>"

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



      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   2. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      2. Run the check using this command:
         ```
         terraform plan
         ```
      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   3. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:
         ```
         terraform apply
         ```
      2. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check whether the resources are there, as well as verify their settings, using the [management console]({{ link-console-main }}).

{% endlist %}

