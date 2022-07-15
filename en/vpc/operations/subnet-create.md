# Creating a subnet

[Subnets](../concepts/network.md#subnet) are created in cloud networks. A new subnet is located in one of the availability zones. Resources can be connected to a subnet if they reside in the same availability zone as the subnet itself.

{% list tabs %}

- Management console

   To create a subnet:
   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a subnet.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click on the name of the cloud network.
   1. Click **Add subnet**.
   1. Enter the subnet name.

      {% include [name-format](../../_includes/name-format.md) %}

   1. (optional) Enter a description.
   1. Select an availability zone from the drop-down list.
   1. Enter the subnet CIDR: the IP address and mask. For more information about subnet IP address ranges, see [Cloud networks and subnets](../concepts/network.md).
      If you need to enter more CIDRs, click **Add CIDR**.
   1. (optional) Select **NAT for internet access** so that your subnet can access the internet without reserving an external IP address.
   1. (optional) Specify **DHCP settings**. To do this:
      1. Specify a [DNS domain](../concepts/dhcp-options.md) to search for unqualified names.
      1. In the **DNS servers** field, click **Add DNS server** and enter the address of your DNS server. You can specify multiple DNS servers.
      1. In the **NTP servers** field, click **Add NTP server** and specify the address of your NTP server. You can specify multiple NTP servers.

         {% if product == "yandex-cloud" %}
     
         {% note info %}

         NTP settings are not applied to a Windows VM. For more information, see [NTP settings in Windows](../concepts/dhcp-options.md#ntp-windows).

         {% endnote %}
 
         {% endif %}

   1. Click **Create subnet**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a subnet:

   1. See the description of the CLI command for creating a subnet:

      ```
      yc vpc subnet create --help
      ```

   1. Get a list of cloud networks in the required folder:

      ```
      yc vpc network list --folder-id b1g6ci08ma55klukmdjs
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapumnl7cqin8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

   1. Select the `NAME` or `ID` of the cloud network you need. Create a subnet in the default folder by specifying the cloud network ID via the `--network-id` flag:

      ```
      yc vpc subnet create --name test-subnet-1 \
        --description "My test subnet" \
        --network-id enplom7a98s1t0lhass8 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      You can also select a cloud network by specifying its name via the `--network-name` flag. Specify the name of the cloud network to create the subnet in and the CIDR. The `--zone` flag indicates the availability zone where the subnet will be created. If this flag is omitted, the subnet is created in the default availability zone.

      {% include [name-format](../../_includes/name-format.md) %}

      ```
      yc vpc subnet create --name test-subnet-1 \
        --description "My test subnet" \
        --network-name test-network-1 \
        --zone {{ region-id }}-a \
        --range 192.168.0.0/24
      ```

      The `--name` and `--description` flags are optional: you can create a subnet without any name or description and access it by ID.

   1. Get a list of all subnets in the default folder:

      ```
      yc vpc subnet list
      +----------------------+-----------------------+------------------------+
      |          ID          |         NAME          | ... |       RANGE      |
      +----------------------+-----------------------+------------------------+
      ...
      | e2l0psbfoloefpjb1rau | test-subnet-1         | ... | [192.168.0.0/24] |
      ...
      +----------------------+-----------------------+-----+------------------+
      ```

      Get the same list with more details in YAML format:

      ```
      yc vpc subnet list --format yaml

      ...

      - id: e2l0psbfoloefpjb1rau
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-24T12:25:58Z"
        name: test-subnet-1
        description: My test subnet
        network_id: enplom7a98s1t0lhass8
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.0.0/24

      ...
      ```

{% endlist %}

## Examples {#examples}

{% list tabs %}

- CLI

   Create a subnet with a name and description in the selected folder:

    ```
    $ yc vpc subnet create --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55klukmdjs \
      --network-id enplom7a98s1t0lhass8 \
      --zone ru-central1-b \
      --range 192.168.0.0/24
    ```

    Create a subnet with DHCP settings:

    ```
    $ yc vpc subnet create --name test-subnet-1 \
      --description "My test subnet" \
      --folder-id b1g6ci08ma55klukmdjs \
      --network-id enplom7a98s1t0lhass8 \
      --zone {{ region-id }}-a \
      --range 192.168.0.0/24 \
      --domain-name test.domain \
      --domain-name-server 192.168.0.100 \
      --ntp-server 192.168.0.101
    ```

{% endlist %}
