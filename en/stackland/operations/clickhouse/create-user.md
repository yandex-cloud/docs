# Creating a user

If you have a [{{ CH }}](../../concepts/components/clickhouse.md) [cluster](create-cluster.md), you can create a user in it using a custom `ClickhouseUser` resource.

The user's password is stored in a Kubernetes Secret with the `password` key. The `ClickhouseUser` resource name and the Secret name must follow this pattern: `<cluster_name>-<user_name>`. If the `spec.authentication.secretName` field is not specified, the operator uses a Secret with the same name by default.

The `ClickhouseUser` and Secret resources must reside in the same namespace as the `ClickhouseCluster` cluster.

## Using the CLI {#cli}

1. Create a file for the `ClickhouseUser` and Secret resources, e.g., using the `touch clickhouseuser.yaml` command.
1. Open the file and paste the configuration below into it:

    {% include notitle [YAML-file](../../_includes/yamls/operations/clickhouse/clickhouseuser.md) %}

    Where:

    * `spec.cluster`: `ClickhouseCluster` cluster name.
    * `spec.name`: {{ CH }} user name.
    * `spec.roles`: List of roles assigned to the user. In each item, specify `name`, i.e., `ClickhouseRole` resource name in the same namespace.
    * `spec.authentication.secretName`: Name of the Secret with the password. This is an optional field. If not specified, the Secret named `<cluster_name>-<user_name>` is used.
    * In the `stringData.password` field of the Secret, set the user password.

1. Apply the manifest: `kubectl apply -f clickhouseuser.yaml -n <project_name>`.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **{{ CH }} Clusters**.
1. Select a cluster.
1. Go to the **Users** tab.
1. Click **Create**.
1. Fill out the fields as follows:

    * **Name**: {{ CH }} user name.
    * **Password**: User password. The management console automatically creates a Kubernetes Secret with the password.
    * **Roles**: List of roles assigned to the user. You can select multiple roles from those created in this cluster.

1. Click **Create**.

Done. The user will now appear in the list on the **Users** tab.
