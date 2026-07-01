# Making a container private

For a container to be invoked only by users with the permission to do so, make the container private.

{% note info %}

If all unauthorized users (the `All users` [public group](../../iam/concepts/access-control/public-group.md)) of a cloud or folder are granted permissions to invoke a container, the container will be public regardless of its settings. [How to revoke a role](../../iam/operations/roles/revoke.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    To make a container private, run this command:

    ```bash
    yc serverless container deny-unauthenticated-invoke <container_name>
    ```

    Result:

    ```text
    done (1s)
    ```

{% endlist %}