---
title: "Authenticating in {{ yandex-cloud }} and managing {{ ydb-short-name }} databases using {{ TF }}"
description: "Follow this guide to authenticate {{ TF }} in {{ yandex-cloud }} using a service account or a federated account."
---

# Getting authentication credentials

To authenticate in {{ yandex-cloud }} and manage {{ ydb-short-name }} databases using {{ TF }}, you can use a [service account](../../iam/concepts/users/service-accounts.md), a [Yandex account](../../iam/concepts/users/accounts.md#passport), or a [federated account](../../iam/concepts/users/accounts.md#saml-federation). To authenticate and work in {{ TF }} with {{ ydb-short-name }}, you will also need the {{ yandex-cloud }} CLI. If you do not have it yet, follow [this guide](../../cli/quickstart.md#install) to install it.

You can create and set up a service account by following these steps:
1. In the management console, select the folder to create a service account in.

1. In the **Service accounts** tab, click `Create service account`.

1. Enter a name for the service account.
    * The name must be 3 to 63 characters long.
    * The name may contain lowercase Latin letters, numbers, and hyphens.
    * The first character of the name must be a letter, the last one cannot be a hyphen.
1. Assign the service account the roles required to manage {{ ydb-short-name }} resources: `admin`, `ydb.admin`.

1. Click **Create**.

Go to **Service account** and create an authorized key for {{ TF }} authentication in {{ yandex-cloud }}:
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

Add the credentials to the environment variables:

{% list tabs group=programming_language %}

- Bash {#bash}

   ```bash
   export YC_TOKEN=$(yc iam create-token)
   export YC_CLOUD_ID=$(yc config get cloud-id)
   export YC_FOLDER_ID=$(yc config get folder-id)
   ```

- PowerShell {#powershell}

   ```powershell
   $Env:YC_TOKEN=$(yc iam create-token)
   $Env:YC_CLOUD_ID=$(yc config get cloud-id)
   $Env:YC_FOLDER_ID=$(yc config get folder-id)
   ```
{% endlist %}

{{ TF }} will use the defined environment variables for authentication, so keep in mind that the `IAM token` lifetime cannot exceed 12 hours. After the token expires, {{ TF }} will be returning an authentication error. In that case, update the environment variable: re-run the `export YC_TOKEN=$(yc iam create-token)` command.

You can automate the process of obtaining a new token using `crontab`: enter `crontab -e`, and then enter `0 * * * * export YC_TOKEN=$(yc iam create-token)`. Now, `crontab` will independently update the token every hour within the current session. To update the token when opening a new session, run one of the following commands:
```bash
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.bashrc # Command for bash shell
echo "export YC_TOKEN=$(yc iam create-token)" >> ~/.zshrc # Command for zsh shell
```

This completes the authentication setup. You can [install and configure](./install.md) {{ TF }}.