## Install and configure {{ TF }} {#prepare-terraform}

### Install {{ TF }} {#install-terraform}

{% include [terraform-install.md](../_tutorials_includes/terraform-install-os.md) %}

### Get the authentication credentials {#get-credentials}

Use a [service account](../../iam/concepts/users/service-accounts.md) to manage the {{ yandex-cloud }} infrastructure via {{ TF }}. It will help you flexibly configure access permissions to resources.

You can also use {{ TF }} under your [Yandex account](../../iam/concepts/users/accounts.md#passport), as well as a [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) user account, but this method is less secure. For more information, see the end of this section.

1. If you do not have the {{ yandex-cloud }} CLI yet, [install it](../../cli/quickstart.md#install).

1. Set up the CLI profile to run operations under the service account:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for your service account and save it to the file:

          ```bash
          yc iam key create \
            --service-account-id <service_account_ID> \
            --folder-name <service_account_folder_name> \
            --output key.json
          ```

          Where:
          * `service-account-id`: Service account ID.
          * `folder-name`: Name of the folder in which the service account was created.
          * `output`: Name of the file with the authorized key.

          Result:

          ```text
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8b********
          created_at: "2022-09-14T09:11:43.479156798Z"
          key_algorithm: RSA_2048
          ```

      1. Create a CLI profile to run operations on behalf of the service account. Name the profile:

          ```bash
          yc config profile create <profile_name>
          ```

          Result:

          ```text
          Profile 'sa-terraform' created and activated
          ```

      1. Configure the profile:

          ```bash
          yc config set service-account-key key.json
          yc config set cloud-id <cloud_ID>
          yc config set folder-id <folder_ID>
          ```

          Where:
          * `service-account-key`: Service account authorized key file.
          * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
          * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

    {% endlist %}

1. Add your credentials to the environment variables:

    {% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}

{% cut "Managing resources under a Yandex account, local account, or federated account" %}

{% include [terraform-credentials-user](../_tutorials_includes/terraform-credentials-user.md) %}

{% endcut %}

### Create a {{ TF }} configuration file {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

### Configure your provider {#configure-provider}

{% include [terraform-configure-provider](../_tutorials_includes//terraform-configure-provider.md) %}
