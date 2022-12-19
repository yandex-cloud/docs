# Moving a public IP address to a different folder

You can move cloud resources between folders within a single [cloud](../../resource-manager/concepts/resources-hierarchy.md).

{% list tabs %}

- Management console

   To move a [public IP address](../concepts/address.md) to a different folder:

   1. In the [management console]({{ link-console-main }}), go to the folder where the address is located.
   1. In the list of services, select **{{ vpc-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/vpc/ip-addresses.svg) **IP addresses**.
   1. Click ![image](../../_assets/options.svg) in the row of the address to be moved and select **Move**.
   1. Select the destination folder from the drop-down list.
   1. Click **Move**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [public IP address](../concepts/address.md) to a different folder:

   1. View a description of the CLI move address command:

      ```bash
      yc vpc address move --help
      ```

   1. Get the name or ID of the address to move:

      ```bash
      yc vpc address list
      ```
      Result:
      ```text
      +----------------------+------+---------------+----------+-------+
      |          ID          | NAME |    ADDRESS    | RESERVED | USED  |
      +----------------------+------+---------------+----------+-------+
      | e2l50m7qo8gp35c6c58i |      | 84.252.137.20 | true     | false |
      | e9b0qnmuh2cbglk265oi |      | 51.250.65.244 | true     | false |
      | e9br252il3ceakc3rk94 |      | 51.250.68.195 | false    | true  |
      +----------------------+------+---------------+----------+-------+
      ```

   1. Get a list of available folders:

      ```bash
      yc resource-manager folder list
      ```

      Result:
      ```text
      +----------------------+------------------------+--------+--------+
      |          ID          |          NAME          | LABELS | STATUS |
      +----------------------+------------------------+--------+--------+
      | b1cs8ie21pk10aurd2c3 | default                |        | ACTIVE |
      | b1chgf288nvg541tgu73 | my-folder-1            |        | ACTIVE |
      | b1cu6g9ielh690at5bm7 | my-folder-2            |        | ACTIVE |
      +----------------------+------------------------+--------+--------+
      ```

   1. Move the address by specifying the name or ID of the address and destination folder:

      ```bash
      yc vpc address move <address_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the address is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
       id: e9br252il3ceakc3rk94
       folder_id: b1chgf288nvg541tgu73
       created_at: "2022-10-10T05:38:43Z"
       external_ipv4_address:
         address: 51.250.68.195
         zone_id: {{ region-id }}-a
         requirements: {}
       used: true
       type: EXTERNAL
       ip_version: IPV4
      ```
      For more information about the `yc vpc address move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/address/move.md).

{% endlist %}

## Examples {#examples}

### Address in the current folder {#from-default-folder}

Move an address from the current folder by specifying the address name and destination folder name:

{% list tabs %}

- CLI

   ```bash
   yc vpc address move site-1 \
     --destination-folder-name my-folder-1
   ```

{% endlist %}

### Address in a different folder {#from-another-folder}

Move an address from a different folder. Specify the address ID and the source and destination folder IDs:

{% list tabs %}

- CLI

   ```bash
   yc vpc address move e9br252il3ceakc3rk94 \
     --folder-id b1chgf288nvg541tgu73 \
     --destination-folder-id b1cs8ie21pk10aurd2c3
   ```

{% endlist %}
