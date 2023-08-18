# Private data storage

To safely store keys, passwords, and other private information, {{ ml-platform-name }} provides a special type of resource called _secrets_.

A _secret_ is a key-value pair with the value stored in an encrypted format. After you create the secret, you will see `***` instead of the value.

Secrets are created in a project and associated with it. You can use created secrets in a cell code as environment variables to securely connect to [data sources](../operations/index.md#connections-to-data-sources) and [version control systems](../operations/projects/work-with-git.md); you can also use secrets to store keys required to create other resources, such as [S3 connectors](s3-connector.md).

{% include [other-project-secret-edit-rule](../../_includes/datasphere/other-project-secret-edit-rule.md) %}

{% include [context-copy-and-original-secret](../../_includes/datasphere/context-copy-and-original-secret.md) %}

{% note tip %}

The advantage of secrets is that their values are stored and transferred in encrypted form only and can't be used when publishing the code and in project logs. Do not output the value of a secret to the screen or assign it to a regular variable.

{% endnote %}

## Information about secrets as a resource {#info}

The following information is stored about each secret:
* Unique resource ID.
* Resource creator.
* Date when the resource was created and last modified, in [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) format, such as `July 18, 2022, 14:23`.

The secret page also contains sample bash and Python code for running the resource in a project cell.

## Scope of secrets {#scope}

Once created, a secret is available for a project. A community admin can [share](../operations/data/secrets.md#share) the secret with other community projects by granting access to it in the **{{ ui-key.yc-ui-datasphere.common.access }}** tab on the secret viewing page. Secrets available to the community appear on the community page under **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

#### What's next? {#what-is-next}

* [How to create, edit, copy, and delete a secret](../operations/data/secrets.md).