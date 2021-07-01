# Private data storage

{{ ml-platform-name }} provides a special tool called _Vault_ for the secure handling of private data (such as keys and passwords). You can find the Vault on the ![Secrets](../../_assets/datasphere/jupyterlab/secret.svg) tab.

_A secret_ is a key-value pair with the value stored in an encrypted format. After you create the secret, you will see `***` instead of the value.

Secrets are created in a project and associated with it. You can use secrets as environment variables in a cell.

{% note tip %}

The advantage of a vault is that it stores and transmits secrets only in encrypted form. Do not output the value of a secret to the screen or assign it to a regular variable.

{% endnote %}

## Scope of secrets {#scope}

_The scope_ of a secret defines where the secret will be available. Valid scope values are listed below:

* project: The secret is only available in its home [project](project.md).
* folder: The secret is available to all projects in the project folder.
* cloud: The secret is available to all projects in the cloud.

You cannot modify a secret created in a different project, but you can modify [a copy](#copy). A copied secret is separate from the original: you can edit and delete the copy without affecting the original.

You can't create secrets with identical names in the same project. Two secrets with identical names cannot exist in the same scope even if they were created in different projects. If secrets with identical names belonging to different scopes are visible to a project, then the secret with the <q>narrowest</q> scope will be the one available for coding. A secret with folder scope overrides a secret of the same name with cloud scope, and a secret with project scope overrides secrets of the same name with folder and cloud scopes.

## Using secrets

### Creating a secret {#create}

1. Open the project where you would like to create a secret.
1. Make sure that the [early access mode](../early-access/index.md) is enabled.
1. To create a secret, go to the ![Secrets](../../_assets/datasphere/jupyterlab/secret.svg) tab and click the ![plus](../../_assets/datasphere/jupyterlab/add.svg) icon.
1. In the dialog box, fill in the fields below:
    * **Name**: Assign the secret a name.
     The name may only contain upper and lowercase Latin letters, numbers, and underscores, and must begin with a letter or underscore.
    * **Content**: Enter a value to be stored in encrypted form.
    * **Scope**: Define the secret's scope.
1. After filling in all the fields, save the secret by clicking Save. The new secret will appear in the available list.
1. To make the secret available, restart the system kernel. To do this, select **Kernel ⟶ Restart kernel** from the {{ ml-platform-name }} interface menu.

### Editing a secret {#edit}

1. Select the secret you wish to edit from the list of visible secrets and click the ![pencil](../../_assets/pencil.svg) icon.
1. In the dialog box, enter a new value in the appropriate field.
    * To change the value of a secret, replace `***` with the new value.
    * To rename a secret, enter a new name in the **Name** field.
    * To modify the scope, select the desired value from the list.
     You do not have to re-enter the value of a secret if it does not need to be changed.
1. After entering all the values, save the secret by clicking **Save**.

### Copying a secret {#copy}

1. Select the secret you wish to copy to your project from the list of visible secrets and click ![copy](../../_assets/copy.svg).
1. In the dialog box, select the new secret's scope and click **Clone**. The copy's scope must be different from the scope of the original secret.

### Deleting a secret {#delete}

1. Select the secret you wish to delete from the list of visible secrets and click the ![pencil](../../_assets/pencil.svg) icon.
1. In the dialog box, click **Delete**. The secret will be deleted.