# Getting authentication credentials

To authenticate in {{ yandex-cloud }} and manage YDB databases via Terraform, you can use a [service account,](../../iam/concepts/users/service-accounts.md) [Yandex account](../../iam/concepts/index.md#passport), or [federated account](../../iam/concepts/index.md#saml-federation). For Terraform authentication and access to YDB, you will also need the {{ yandex-cloud }} CLI. If you do not have it yet, follow [this guide](../../cli/quickstart.md#install) to install it.

You can create and set up a service account by following this guide:
1. In the management console, select the folder to create a service account in.
1. In the **Service accounts** tab, click `Create service account`.
1. Enter a name for the service account:
   * 3 to 63 characters long.
   * The name may contain lowercase Latin letters, numbers, and hyphens.
   * The first character of the name must be a letter, the last one cannot be a hyphen.
1. Assign the service account the roles required to manage YDB resources: `admin`, `ydb.admin`.
1. Click **Create**.
 
Go to **Service account** and create an authorized key for Terraform authentication in {{ yandex-cloud }}:
1. Click `Create new key` and select `Create authorized key`.
1. Enter the **Key description** (optional) and click **Create**.
1. Click **Download key file** to download the key file locally.

Now to the final step in authentication setup: create a special profile for connecting to {{ yandex-cloud }} on the local machine using yc CLI.

Run the following commands:
1. Create a `yc` profile to perform operations on behalf of the service account. Specify the profile name: `yc config profile create <profile_name>`. The terminal will display the following message: `Profile '<profile_name>' created and activated.`
1. Configure the profile with the following commands:
   ```bash
   yc config set service-account-key <uploaded_key>
   yc config set cloud-id <cloud_ID>
   yc config set folder-id <folder_ID>
   ```

Where:
* `service-account-key`: JSON file containing the authorized key of the service account.
* `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
* `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

Add authentication data to environment variables:
{% list tabs %}
- Bash
   ```bash
   export YC_TOKEN=$(yc iam create-token)
   export YC_CLOUD_ID=$(yc config get cloud-id)
   export YC_FOLDER_ID=$(yc config get folder-id)
   ```

- PowerShell
   ```powershell
   $Env:YC_TOKEN=$(yc iam create-token)
   $Env:YC_CLOUD_ID=$(yc config get cloud-id)
   $Env:YC_FOLDER_ID=$(yc config get folder-id)
   ```
{% endlist %}

Terraform will use the defined environment variables for authentication, so keep in mind that the `IAM token` lifetime cannot exceed 12 hours. After the token expires, Terraform will issue an authentication error. In that case, update the environment variable: re-run the `export YC_TOKEN=$(yc iam create-token)` command.

You can automate the process of obtaining a new token using `crontab`: enter `crontab -e`, and then enter `0 * * * * export YC_TOKEN=$(yc iam create-token)`. Now, `crontab` will independently update the token every hour within the current session. To update the token when opening a new session, run one of the following commands:
```bash
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.bashrc # Command for bash shell
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.zshrc # Command for zsh shell
```

This completes the authentication setup. You can now [install and configure](./install.md) Terraform.
