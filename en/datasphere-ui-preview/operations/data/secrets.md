# Using secrets

[Secrets](../../concepts/secrets.md) let you store sensitive data in encrypted form and use it safely in your project code.

## Creating secrets {#create}

1. Open the project page where you would like to create a secret.
1. Under **Resources**, click ![secret](../../../_assets/datasphere/jupyterlab/secret.svg) **Secret**.
1. Click **Create**.
1. In the **Name** field, enter a name for the secret.

   The name may contain uppercase and lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen or underscore. The allowed length is 3 to 63 characters.

1. In the **Content** field, enter a value to be stored in encrypted form.
1. Click **Create**. This will display the created secret's info page.

To make the secret available, restart the system kernel. {% include [restart-kernel](../../../_includes/datasphere/restart-kernel.md) %}

## Sharing secrets {#share}

Only a community admin can share a secret in the community. To learn more about roles that apply in {{ ml-platform-name }}, see [{#T}](../../security/index.md).

1. Open the project page with the secret to share.
1. Under **Resources**, click ![secret](../../../_assets/datasphere/jupyterlab/secret.svg) **Secret**.
1. Select the appropriate secret from the list.
1. Go to the **Access** tab.
1. Enable the visibility option next to the name of the community to share the secret in.

## Invoking a secret in a project cell {#call}

Once you create a secret, you can use it in project cells as an environment variable.

{% list tabs %}

- Python

   ```python
   import os
   os.environ # Get a list of all environment variables
   os.environ['<secret_name>'] # Reference the <secret_name> secret from environment variables
   ```

- bash

   ```bash
   #!:bash
   printenv <secret_name>
   ```

{% endlist %}

## Copying secrets {#copy}

1. In the list of secrets, select the one you want to copy to your project, click ![options](../../../_assets/options.svg), and select **Clone**.
1. Edit the name and contents of the secret to copy.
1. Click **Create**. This will display the created secret's info page.

{% include [context-copy-and-original-secret](../../../_includes/datasphere/context-copy-and-original-secret.md) %}

## Updating secrets {#change}

1. In the list of secrets, select the one you want to update, click ![options](../../../_assets/options.svg), and select **Edit**.
1. Update the secret: edit its name and contents.
1. Click **Save**.

{% include [other-project-secret-edit-rule](../../../_includes/datasphere/other-project-secret-edit-rule.md) %}

## Deleting secrets {#delete}

In the list of secrets, select the one you want to delete, click ![options](../../../_assets/options.svg), and select **Delete**.

You'll see a message saying `Secret destroyed`.