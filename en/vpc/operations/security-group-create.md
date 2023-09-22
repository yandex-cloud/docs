# Create a security group

{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

To create a new [security group](../concepts/security-groups.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a security group.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. Enter a name for the security group.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the network to assign the security group to.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create traffic management rules:
      1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
      1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the desired protocol or leave `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` to allow traffic transmission over any protocol.
      1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the purpose of the rule:
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`: Rule will apply to the range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify the CIDR and masks of subnets that traffic will come to or from. To add multiple CIDRs, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_add-cidr }}**.
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`: Rule will apply to the VMs from the current group or the selected security group.
         1. `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
   1. Click **{{ ui-key.yacloud.common.save }}**. Add other rules, if required.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

   To create a group with an IPv4 CIDR rule, run the command:

   ```
   yc vpc security-group create \
     --name test-sg-cli \
     --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[10.0.0.0/24]" \
     --network-id c645mh47vscba1d64tbs
   ```

   Where:

   * `--name`: Security group name.
   * `--rule`: Rule description:
      * `direction`: Traffic direction. `ingress`: incoming traffic, `egress`: outgoing traffic.
      * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
      * `protocol`: Data transfer protocol. Possible values: `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets that traffic will come from or to.
      * `network-id`: ID of the network the security group will be connected to.

   To create a group with a rule that allows traffic from all resources of a different security group, run this command:

   ```bash
   yc vpc security-group create \
     --name allow-connection-from-app \
     --rule "direction=ingress,port=5642,protocol=tcp,security-group-id=enp099cqehlfvabec36d" \
     --network-name infra2
   ```

   Where:

   * `name`: Security group name.
   * `rule`: Rule description:
      * `direction`: Traffic direction. `ingress`: incoming traffic, `egress`: outgoing traffic.
      * `port`: Port for receiving or transmitting traffic. You can also specify a range of ports using the `from-port` and `to-port` parameters.
      * `protocol`: Data transfer protocol. Possible values: `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
      * `security-group-id`: ID of the security group for which traffic is allowed to the new security group through port 443.
   * `network-name`: Name of the network the security group will be connected to.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a security group with multiple rules:

   1. In the configuration file, describe the parameters of the resources you want to create:

      * `name`: Security group name.
      * `description`: Optional description of the security group.
      * `network_id`: ID of the network that the security group will be assigned to.
      * `ingress` and `egress`: Rule parameters for incoming and outgoing traffic:
         * `protocol`: Traffic transfer protocol. Possible values: `tcp`, `udp`, `icmp`, `esp`, `ah`, or `any`.
         * `description`: Optional description of the rule.
         * `v4_cidr_blocks`: List of CIDRs and masks of subnets that traffic will come from or to.
         * `port`: Port for traffic.
         * `from-port`: The first port in the range of ports for traffic.
         * `to-port`: The last port in the range of ports for traffic.

      Example of the configuration file structure:

      
      ```
      provider "yandex" {
        token     = "<service account OAuth or static key>"
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

         ingress {
           protocol          = "ANY"
           description       = "Enables interaction between resources of the current security group"
           predefined_target = "self_security_group"
           from_port         = 0
           to_port           = 65535
         }

         ingress {
           protocol           = "TCP"
           description        = "Allows connections through port 27017 from the resources to the sg-frontend security group"
           security_group_id  = yandex_vpc_security_group.sg-frontend.id
           port               = 27017
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



      For more information on resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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

      All the resources you need will then be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

- API

   Use the [create](../api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../api-ref/grpc/security_group_service.md#Create) gRPC API call.

{% endlist %}

