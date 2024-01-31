# Making a container private

For a container to be invoked only by users with the permission to do so, make the container private.

{% note info %}

If all unauthorized users (the `allUsers` system group) of a cloud or folder are granted the permission to invoke a container, the container will be public regardless of the settings. [How to revoke a role](../../iam/operations/roles/revoke.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

   To make a container private, run this command:

   ```
   yc serverless container deny-unauthenticated-invoke <container_name>
   ```

   Result:

   ```
   done (1s)
   ```

{% endlist %}