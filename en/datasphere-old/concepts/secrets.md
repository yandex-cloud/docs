# Private data storage

{{ ml-platform-name }} provides a special tool called _Vault_ for the secure handling of private data (such as keys and passwords). You can find the Vault on the ![Secrets](../../_assets/datasphere/jupyterlab/secret.svg) tab.

A _secret_ is a key-value pair with the value stored in an encrypted format. After you create the secret, you will see `***` instead of the value.

Secrets are created in a project and associated with it. You can use secrets as environment variables in a cell.

{% note tip %}

The advantage of a vault is that it stores and transmits secrets only in encrypted form. Do not output the value of a secret to the screen or assign it to a regular variable.

{% endnote %}

## Scope of secrets {#scope}

The _scope_ of a secret defines where the secret will be available. Valid scope values are listed below:
* project: The secret is only available in its home [project](project.md).
* folder: The secret is available to all projects in the project folder.
* cloud: The secret is available to all projects in the cloud.

You can't modify a secret created in a different project, but you can modify its [copy](../operations/data/secret-copy.md). A copied secret is separate from the original: you can edit and delete the copy without affecting the original.

You can't create secrets with identical names in the same project. Two secrets with identical names cannot exist in the same scope even if they were created in different projects. If secrets with identical names belonging to different scopes are visible to a project, then the secret with the <q>narrowest</q> scope will be the one available for coding. A secret with folder scope overrides a secret of the same name with cloud scope, and a secret with project scope overrides secrets of the same name with folder and cloud scopes.

#### See also {#see-also}

* [{#T}](../operations/data/secret-create.md)
* [{#T}](../operations/data/secret-call.md)
* [{#T}](../operations/data/secret-copy.md)
* [{#T}](../operations/data/secret-change.md)
* [{#T}](../operations/data/secret-delete.md)
