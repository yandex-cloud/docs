# Working with secrets

[Secrets](../../concepts/secrets.md) enable storing sensitive data in encrypted form and using it securely within your project code.

## Creating a secret {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter a name for the secret.

   The name may contain uppercase and lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen or underscore. The name must be 2 to 63 characters long.

1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, enter a value to store in encrypted form.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed info on the secret you created.

## Sharing a secret {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

To share a secret within a community, you need the `Editor` role in the project and the `Developer` role in the community. To learn more about roles in {{ ml-platform-name }}, see [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Select the secret from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the secret in.

To make a secret available for use in a different project, the project editor needs to [add](../projects/use-shared-resource.md) that secret on the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Accessing a secret from a project cell {#call}

Once you create a secret, you can use it in project cells as an environment variable.

{% list tabs group=programming_language %}

- Python {#python}

   ```python
   import os
   os.environ # Getting a list of all environment variables
   os.environ['<secret_name>'] # Accessing <secret_name> from environment variables
   ```

- Bash {#bash}

   ```bash
   #!:bash
   printenv <secret_name>
   ```

{% endlist %}

## Copying a secret {#copy}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. In the list of secrets, choose the one you want to copy to your project, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yc-ui-datasphere.common.clone }}**.
1. Edit the name and contents of the secret to copy.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**. You will see a page with detailed info on the secret you created.

{% include [context-copy-and-original-secret](../../../_includes/datasphere/context-copy-and-original-secret.md) %}

## Updating a secret {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. In the list of secrets, choose the one you want to update, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Update the secret by editing its name and contents.
1. Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

{% include [other-project-secret-edit-rule](../../../_includes/datasphere/other-project-secret-edit-rule.md) %}

## Deleting a secret {#delete}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/shield-check.svg) **{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. In the list of secrets, choose the one you want to delete, click ![options](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the secret has been deleted.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}
