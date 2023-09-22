# Moving a security group to a different folder

{% list tabs %}

- Management console

   To move a [security group](../concepts/security-groups.md) to a different folder:

   1. In the [management console]({{ link-console-main }}), go to the folder where the security group is located.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
   1. Click ![image](../../_assets/options.svg) in the row of the security group to be moved and select **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.
   1. Select the destination folder from the drop-down list.
   1. Click **{{ ui-key.yacloud.vpc.button_move-vpc-object }}**.

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To move a [security group](../concepts/security-groups.md) to a different folder:

   1. View a description of the CLI move security group command:

      ```bash
      yc vpc security-group move --help
      ```

   1. Get the name or ID of the security group to move:

      ```bash
      yc vpc security-group list
      ```
      Result:
      ```text
      +----------------------+---------------------------------+------------------------------------+----------------------+
      |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
      +----------------------+---------------------------------+------------------------------------+----------------------+
      | enc2ta63h3q2jsri70ll | default-sg-enc39op1vq9m8tjr3udp | Default security group for network | enc39op1vq9m8tjr3udp |
      | enc612keceq8u2ioa2h6 | default-sg-encb4ubvmief09h6qg5e | Default security group for network | encb4ubvmief09h6qg5e |
      | encnn4l7b3lpm0095epd | default-sg-enc772aa2rgqiqq67ehu | Default security group for network | enc772aa2rgqiqq67ehu |
      | encemkpqg8fhu8em3uc0 | my-sg-1                         | Custom security group              | encb4ubvmief09h6qg5e |
      +----------------------+---------------------------------+------------------------------------+----------------------+
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

   1. Move the security group by specifying the name or ID of the group and destination folder:

      ```bash
      yc vpc security-group move <group_name_or_ID> \
        --destination-folder-name <name_of_destination_folder> \
        --destination-folder-id <ID_of_destination_folder>
      ```
      Use either the `--destination-folder-name` parameter or the `--destination-folder-id` parameter.

      If the security group is not in the current folder (default folder), specify the source folder using the `--folder-name` or `--folder-id` option.

      Result:
      ```text
      id: encemkpqg8fhu8em3uc0
      folder_id: b1chgf288nvg541tgu73
      created_at: "2022-10-10T13:24:59Z"
      name: my-sg-1
      network_id: encb4ubvmief09h6qg5e
      status: ACTIVE
      ```
      For more information about the `yc vpc security-group move` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/security-group/move.md).

- API

   To move a [security group](../concepts/security-groups.md) to a different folder, use the [move](../api-ref/SecurityGroup/move.md) REST API method for the [SecurityGroup](../api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Move](../api-ref/grpc/security_group_service.md#Move) gRPC API call.

{% endlist %}

## Examples {#examples}

### Security group in the current folder {#from-default-folder}

Move a security group from the current folder by specifying the group name and destination folder name:

{% list tabs %}

- CLI

   ```bash
   yc vpc security-group move my-sg-1 \
     --destination-folder-name my-folder-1
   ```

{% endlist %}

### Security group in a different folder {#from-another-folder}

Move a security group from a different folder. Specify the group ID and the source and destination folder IDs:

{% list tabs %}

- CLI

   ```bash
   yc vpc security-group move encemkpqg8fhu8em3uc0 \
     --folder-id b1chgf288nvg541tgu73 \
     --destination-folder-id b1cs8ie21pk10aurd2c3
   ```

{% endlist %}

#### See also {#see-also}

* [{#T}](network-move.md)

