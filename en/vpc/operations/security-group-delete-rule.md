# Deleting a rule from a security group

{% include [Preview](../../_includes/vpc/preview.md) %}

{% list tabs %}

- Management console

   To delete a rule from a security group:

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to change the security group.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **Security groups**.
   1. Select the group to update.
   1. Under **Rules**, click ![image](../../_assets/options.svg) in the row of the rule to delete.
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- CLI

   To delete a rule from a group:

   1. Get the name or ID of the group to edit:

      ```
      yc vpc security-groups list
      ```
      Result:
      ```
      +----------------------+---------------------------------+------------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      | enp9bmjge93bvnlb4061 | default-sg-enp509crtqufsu9m9kbr | Default security group for network | enp509crtqufsuhm9kbr |
      | enp9rs9u4h6juk9rq3k5 | sg-1                            |                                    | enp509crtqufsuhm9kbr |
      | enp9d8m73d1cgh2rm179 | sg-2                            |                                    | enp509crtqufsuhm9kbr |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      ```
   1. Get a list of security group rules by specifying the group name or ID:

      ```
      yc vpc security-groups get <group name or ID>
      ```
      Result:
      ```
      id: enp8rs9i4h6juk9rl3k5
      folder_id: b1gaus8l79li5979eabd
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9qufsuhm9kbr
      status: ACTIVE
      rules:
        - id: enpbbmv8icie959gcm84
          description: SSH
          direction: INGRESS
          ports:
            from_port: "22"
            to_port: "22"
          protocol_name: TCP
          protocol_number: "6"
          cidr_blocks:
            v4_cidr_blocks:
              - 0.0.0.0/0
      ...
      ```

   1. To delete a rule, specify its ID in the command:

      ```
      yc vpc security-group update-rules <group name or ID> --delete-rule-id <rule ID>
      ```
      Result:
      ```
      done (12s)
      id: enp8rs9i4h6juk9rq3k5
      folder_id: b1gaus8l79li5n96eabd
      created_at: "2022-06-24T15:46:31Z"
      name: sg-1
      network_id: enp559cr9qufsuhm9kbr
      status: ACTIVE
      rules:
      ...
      ```

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about the {{ TF }}, [see the documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To delete a rule created with {{ TF }} from a security group:

   1. Open the {{ TF }} configuration file and delete the `ingress` or `egress` section from the security group description:

      {% cut "Sample description of a security group with rules in a {{ TF }}configuration" %}

      ```hcl
      ...
      resource "yandex_vpc_security_group" "test-sg" {
        name        = "Test security group"
        description = "Description for security group"
        network_id  = "${yandex_vpc_network.lab-net.id}"

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
      ...
      ```

      {% endcut %}

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the following command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes to the security group using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```
      yc vpc security-group get <security group name>
      ```

{% endlist %}
