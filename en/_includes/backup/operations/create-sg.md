{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to connect a VM.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. Enter a name for the [security group](../../../vpc/concepts/security-groups.md), e.g., `backup-sg`.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select the [network](../../../vpc/concepts/network.md) the VM resides in.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, navigate to the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** tab and click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
  1. Add the following outgoing traffic rules one by one:

      {% include [outgoing traffic](../outgoing-rules.md) %}

  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. View the description of the command for creating a [security group](../../../vpc/concepts/security-groups.md):

      ```bash
      yc vpc security-group create --help
      ```

  1. Create a security group with [rules](../../../vpc/concepts/network.md#security-groups-rules) by running this command:

      ```bash
      yc vpc security-group create \
        --name <security_group_name> \
        --network-id <network_ID> \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=80,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[84.201.181.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[178.176.128.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.193.0/24]" \
        --rule "direction=egress,port=443,protocol=tcp,v4-cidrs=[213.180.204.0/24]" \
        --rule "direction=egress,from-port=7770,to-port=7800,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=8443,protocol=tcp,v4-cidrs=[84.47.172.0/24]" \
        --rule "direction=egress,port=44445,protocol=tcp,v4-cidrs=[51.250.1.0/24]"
      ```

      Where:

      * `name`: Security group name.
      * `network-id`: ID of the [network](../../../vpc/concepts/network.md) the VM resides in.
      * `rule`: Rule description:

          * `direction`: Traffic direction, where `egress` stands for outgoing traffic.
          * `port`: Port for receiving traffic.
          * `from-port`: First port in the traffic port range.
          * `to-port`: Last port in the traffic port range.
          * `protocol`: Data transfer protocol.
          * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets the traffic will come to.

      Result:

      ```bash
      id: enp0v73fe8fs********
      folder_id: b1g86q4m5vej********
      created_at: "2024-07-22T20:17:43Z"
      name: backup-sg
      network_id: enp3srbi9u49********
      status: ACTIVE
      rules:
        - id: enpdadptjl77********
          direction: EGRESS
          ports:
            from_port: "80"
            to_port: "80"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 213.180.193.0/24
      ...
        - id: enpji0640a0f********
          direction: EGRESS
          ports:
            from_port: "44445"
            to_port: "44445"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 51.250.1.0/24
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      resource "yandex_vpc_security_group" "test_sg_outgoing" {
        name        = "<security_group_name>"
        network_id  = "<network_ID>"

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 80
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.201.181.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["178.176.128.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.193.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["213.180.204.0/24"]
          port           = 443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          from_port      = 7770
          to_port        = 7800
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["84.47.172.0/24"]
          port           = 8443
        }

        egress {
          protocol       = "TCP"
          v4_cidr_blocks = ["51.250.1.0/24"]
          port           = 44445
        }
      }
      ```

      Where:

      * `name`: [Security group](../../../vpc/concepts/security-groups.md) name.
      * `network_id`: ID of the [network](../../../vpc/concepts/network.md) the VM resides in.
      * `egress`: Description of the outgoing traffic [rule](../../../vpc/concepts/network.md#security-groups-rules):

          * `protocol`: Data transfer protocol.
          * `v4-cidrs`: List of IPv4 CIDRs and masks of subnets the traffic will come to.
          * `port`: Port for receiving traffic.
          * `from_port`: First port in the traffic port range.
          * `to_port`: Last port in the traffic port range.

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources. You can check the new resources using the [management console]({{ link-console-main }}).

    For more information about `yandex_vpc_security_group` properties, see [this {{ TF }} article]({{ tf-provider-datasources-link }}/vpc_security_group).

- API {#api}

  To create a [security group](../../../vpc/concepts/security-groups.md), use the [create](../../../vpc/api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../../../vpc/api-ref/grpc/SecurityGroup/create.md) gRPC API call.

{% endlist %}

For more information, see [{#T}](../../../vpc/operations/security-group-create.md).