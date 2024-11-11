To export a SSH certificate of a user of the {{ org-name }} organization or a [service account](../../iam/concepts/users/service-accounts.md) to a local PC:

{% list tabs group=instructions %}


- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for exporting an SSH certificate to a local directory:

      ```bash
      yc compute ssh certificate export --help
      ```
  1. {% include [os-login-cli-organization-list](../../_includes/organization/os-login-cli-organization-list.md) %}
  1. {% include [os-login-cli-profile-list](../../_includes/organization/os-login-cli-profile-list.md) %}
  1. Export the certificate:

      ```bash
      yc compute ssh certificate export \
          --login <user_or_service_account_login>
          --organization-id <organization_ID> \
          --directory <path_to_directory>
      ```

      Where:
      * `--login`: Previously obtained login for the user or service account, as set in the OS Login profile. This is an optional parameter. If this parameter is not specified, the SSH certificate will be downloaded for the user or service account currently authorized in the YC CLI profile.
      * `--organization-id`: Previously obtained [ID](../../organization/operations/organization-get-id.md) of the organization to export the SSH certificate from. This is an optional parameter. If the parameter is not set, the certificate will be exported from the organization the default folder belongs to.
      * `--directory`: Path to the local directory to save the exported SSH certificate to. This is an optional parameter. If not specified, the certificate will be saved by default to the `.ssh` home directory of the current PC user (`~/.ssh/`).

      Result:

      ```text
      Identity: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername
      Certificate: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername-cert.pub
      ```

      If you save the exported certificate to a directory different from the default one, make sure that only the current user can access the certificate files saved. If you need to, update the user permissions using the `chmod` command on Linux and macOS or on the **Security** tab in Windows Explorer's file properties.

{% endlist %}