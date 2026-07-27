# Updating a {{ PG }} user

If you have a {{ PG }} user in your [cluster](../../concepts/components/postgresql.md), you can update the user's permissions and parameters. Once created, the cluster name (`spec.cluster`) and role name (`spec.username`) cannot be changed.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `PostgresqlRole` resource, e.g., by running this command: `kubectl edit PostgresqlRole <resource_name> -n <project_name>`.
  1. Edit the parameters:

      * `spec.membership`: List of parent roles.
      * `spec.options.superuser`: Superuser permissions.
      * `spec.options.login`: Login permission.
      * `spec.options.createdb`: Permission to create databases.
      * `spec.options.createrole`: Permission to create roles.
      * `spec.options.inherit`: Permission inheritance from parent roles.
      * `spec.options.replication`: Permission to use replication.
      * `spec.options.bypassRLS`: Row-level security policy bypass.
      * `spec.options.connectionLimit`: Limit on simultaneous connections. If set to `-1`, there is no limit.
      * `spec.options.validUntil`: Password expiration date in RFC3339 format.

  1. To change the user password, update the `password` key value in the associated Kubernetes Secret. The name of the Secret is specified in the `spec.authentication.secretName` field of the `PostgresqlRole` resource.

- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **PostgreSQL Clusters**.
  1. Select a cluster.
  1. Navigate to the **Users** tab and select the user.
  1. Click **Edit**.
  1. Adjust the toggles and fields under **Additional parameters**:

      * **Superuser**
      * **Allow login**
      * **Parent roles**
      * **Creating databases**
      * **Creating roles**
      * **Inheriting permissions from roles**
      * **Replication mode**
      * **RLS policy bypass**
      * **Connection limit**
      * **Password valid until**

  1. Click **Save**.

  Done. The user settings have been updated.

{% endlist %}
