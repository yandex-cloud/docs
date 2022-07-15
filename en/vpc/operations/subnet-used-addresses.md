# Viewing a list of addresses used in a subnet

You can view internal IP addresses that are assigned to cloud resources in your folder.

To view a list of internal addresses used in a subnet:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder with the subnet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Go to the **Subnets** tab.
   1. Click on the subnet name.
   1. Go to the **IP addresses** tab.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to get a list of used addresses:

      ```bash
      yc vpc subnet list-used-addresses --help
      ```

   1. Get a list of addresses in the selected subnet:

      ```bash
      yc vpc subnet list-used-addresses --name <subnet_name>
      ```

      Output:

      ```bash
      +-----------+------------+---------------------------------------+
      |  ADDRESS  | IP VERSION |              REFERENCES               |
      +-----------+------------+---------------------------------------+
      | 10.1.2.1  | IPV4       | vpc.virtualGateway:                   |
      | 10.1.2.2  | IPV4       | vpc.virtualDns:                       |
      | 10.1.2.3  | IPV4       | compute.instance:epdf6lfsaki9p76hj7rf |
      | 10.1.2.15 | IPV4       | compute.instance:epdb2hmhj935jhjk98gd |
      | 10.1.2.28 | IPV4       | managedKubernetes.cluster:            |
      +-----------+------------+---------------------------------------+
      ```

{% endlist %}
