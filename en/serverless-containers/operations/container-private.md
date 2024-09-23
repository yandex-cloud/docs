# Making a container private

For a container to be invoked only by users with the permission to do so, make the container private.

{% note info %}

If all unauthorized users (the `All users` [public group](../../iam/concepts/access-control/public-group.md)) of a cloud or folder are granted the permission to invoke a container, the container will be public regardless of its settings. See [how to revoke a role](../../iam/operations/roles/revoke.md) for more info.

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