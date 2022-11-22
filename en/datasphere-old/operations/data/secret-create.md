# Creating a secret

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

1. Open the project where you would like to create a [secret](../../concepts/secrets.md).
1. To create a secret, go to the ![Secrets](../../../_assets/datasphere/jupyterlab/secret.svg) tab, then click ![plus](../../../_assets/datasphere/jupyterlab/add.svg).
1. In the dialog box, fill in the fields below:
   * **Name**: Assign the secret a name.
      The name may only contain upper and lowercase Latin letters, numbers, and underscores, and must begin with a letter or underscore.
   * **Content**: Enter a value to be stored in encrypted form.
   * **Scope**: Define the secret's scope.
1. To save the secret, click **Save**. The new secret will appear in the available list.
1. To make the secret available, restart the system kernel. To do this, select **Kernel ⟶ Restart kernel** from the {{ ml-platform-name }} interface menu.