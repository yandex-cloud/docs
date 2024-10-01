To export an OS Login user certificate from an organization to your local computer:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for exporting an OS Login certificate to a local directory:

      ```bash
      yc compute ssh certificate export --help
      ```

  1. If you have multiple organizations, get the ID of the organization you want to export the certificate from. If you have a single organization, skip this step.

      ```bash
      yc organization-manager organization list
      ```

      Result:

      ```text
      +----------------------+-------------------------+-------------------------+
      |          ID          |          NAME           |          TITLE          |
      +----------------------+-------------------------+-------------------------+
      | bpf1smsil5q0******** | sample-organization1    | Organization 1          |
      | bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
      | bpf6dne49ue8******** | sample-organization3    | Organization 3          |
      +----------------------+-------------------------+-------------------------+
      ```

  1. Export the certificate:

      ```bash
      yc compute ssh certificate export \
          --organization-id <organization_ID> \
          --directory <path_to_directory>
      ```

      Where:
      * `--organization-id`: Previously obtained ID of the organization to export the OS Login certificate from. This is an optional parameter. If omitted, the certificate will be exported from the organization the default folder belongs to.
      * `--directory`: Path to the local directory to save the exported OS Login certificate to. This is an optional parameter. If not specified, the certificate will be saved by default to the `.ssh` home directory of the current PC user (`~/.ssh/`).

      Result:

      ```text
      Identity: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername
      Certificate: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername-cert.pub
      ```

      If you save the exported certificate to a directory different from the default one, make sure that only the current user can access the certificate files saved. If you need to, update the user permissions using the `chmod` command on Linux and macOS or on the **Security** tab in Windows Explorer's file properties.

{% endlist %}