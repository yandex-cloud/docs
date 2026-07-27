# Creating a {{ PG }} user

If you have a [{{ PG }} cluster](../../concepts/components/postgresql.md) in your [project](../projects/create-project.md), you can create a user in it, i.e., a {{ PG }} role with login permissions. Use a `PostgresqlRole` resource to define the user. The user password is stored in a {{ k8s }} Secret: the operator can generate it automatically or you can provide a custom Secret with credentials.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create the `PostgresqlRole` resource file, e.g., using the `touch postgresqlrole.yaml` command.
  1. Open the file and paste the configuration below into it:

      The naming requirements are as follows:

      * The {{ PG }} role name (`spec.username`) must start with a Latin letter or underscore and can only contain Latin letters, numbers, and underscores.
      * The `PostgresqlRole` resource name (`metadata.name`) must follow this pattern: `<cluster_name>-<username_with_hyphens_instead_of_underscores>.

      {% list tabs %}

      - Minimum configuration

          {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-user-min.md) %}

          The manifest defines only the required fields, such as the cluster name and the {{ PG }} role name. The password will be automatically generated and stored in a Kubernetes Secret with the same name as the `PostgresqlRole` resource.

      - Configuration with an explicit password

          {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-user-password.md) %}

          The manifest defines a Secret with credentials and a `PostgresqlRole` resource that references this Secret via `spec.authentication.secretName`. The Secret must contain the `username` key with the username and the `password` key with the user password.

      - Full configuration

          {% include notitle [YAML-file](../../_includes/yamls/operations/postgresql/create-user-max.md) %}

          `spec.options` defines role permissions, such as `superuser`, `login`, `createdb`, `createrole`, `inherit`, `replication`, `bypassRLS`, `connectionLimit`, or `validUntil`. `spec.membership` lists parent roles to include the user in.

      {% endlist %}

  1. Apply the manifest: `kubectl apply -f postgresqlrole.yaml -n <project_name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **PostgreSQL Clusters**.
  1. Select the cluster.
  1. Go to the **Users** tab.
  1. Click **Create**.
  1. Fill out the fields as follows:

      * **Name**: Role name in {{ PG }}. The name must start with a Latin letter or `_` and can only contain Latin letters, numbers, and `_`. It may be up to 63 characters long.
      * **Password**: User password. Its value is stored in a Kubernetes Secret and not available in plain text once saved.
      * **Superuser**: Toggle for superuser privileges. Disabled by default.

  1. Expand the **Advanced parameters** section and change the values as needed:

      * **Allow login**: Allows the role to connect to {{ PG }}. This parameter is enabled by default.
      * **Parent roles**: List of roles the user will be included in.
      * **Creating databases**: Permission to create new databases. Disabled by default.
      * **Create roles**: Permission to create, modify, and delete roles. Disabled by default.
      * **Inherit role privileges**: Permission inheritance from parent roles. This parameter is enabled by default.
      * **Replication mode**: Permission to use replication and WAL shipping operations. Disabled by default.
      * **Bypass RLS**: Permission to bypass row-level security policies. Disabled by default.
      * **Connection limit**: Maximum number of simultaneous connections. If set to `-1`, there is no limit. `0` disables new connections. The default value is `-1`.
      * **Password valid until**: Password expiration date in RFC3339 format.

  1. Click **Create**.

  Done. The new user now appears in the cluster’s **Users** tab.

{% endlist %}
