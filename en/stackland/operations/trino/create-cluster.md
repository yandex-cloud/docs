# Creating a {{ mtr-name }} cluster

The [{{ TR }} cluster](../../concepts/components/trino.md) is created in a namespace within the [project](../projects/create-project.md). If you already have a project and a namespace within it, you can create a cluster in that namespace.

## Using the CLI {#cli}

1. Make sure there is a namespace in the project. If not, [create one](../projects/manage-namespaces.md#create-namespace).
1. Create the `TrinoCluster` resource file, e.g., using the `touch trinocluster.yaml` command.
1. Open the file and paste the configuration below into it:

    {% list tabs %}

    - Minimum configuration

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-cluster-min.md) %}

    - Configuration with settings and access rules

        An example with logging settings (`spec.config`) and access rules for catalogs, schemas, and tables (`spec.accessControl`). To learn more about access rules, see [Access management](../../concepts/components/trino.md#access-control).

        {% include notitle [YAML-file](../../_includes/yamls/operations/trino/create-cluster-full.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f trinocluster.yaml -n <namespace>`. Optionally, you can specify the namespace in the `metadata.namespace` resource property and skip it in the command.

## Using the management console {#console}

1. If you have not opened a project yet, select one.
1. Select the namespace you want to create the cluster in.
1. In the left-hand menu, select **Trino** → **Clusters**.
1. Click **Create cluster**.
1. Fill out the fields as follows:

    **Basic parameters**

    * **Name**: Cluster name. Written in `metadata.name`.
    * **Trino version**: {{ TR }} version. The list of values ​​is formed from the `TrinoImageCatalog` operator.
    * **Deletion protection**: Toggle for protection against accidental cluster deletion. Disabled by default.

    **Coordinator configuration**

    * **Requested CPUs**: Guaranteed number of CPUs for the coordinator pod.
    * **Requested RAM**: Guaranteed RAM for the coordinator pod.
    * **CPU limit**: Maximum number of CPUs for the coordinator pod.
    * **RAM limit**: Maximum RAM for the coordinator pod.

    **Worker configuration**

    * **Number of workers**: Number of worker pods. Minimum `1`.
    * **Requested CPUs**: Guaranteed number of CPUs for the worker pod.
    * **Requested RAM**: Guaranteed RAM for the worker pod.
    * **CPU limit**: Maximum number of CPUs for the worker pod.
    * **RAM limit**: Maximum RAM for the worker pod.

    **Additional settings** (optional)

    Section for adding {{ TR }} settings in the _key-value_ format. You can add each key only once.

    **Access settings** (optional)

    Section for access rules pertaining to {{ TR }} resources. Subsections:

    * **Catalog rules**: `user`, `catalog`, `privileges` (`all`, `read-only`, `none`).
    * **Schema rules**: `user`, `catalog`, `schema`, `owner`.
    * **Table rules**: `user`, `catalog`, `schema`, `table`, `privileges` (`SELECT`, `INSERT`, `DELETE`, `UPDATE`, `OWNERSHIP`, `GRANT_SELECT`), plus row filter and column restrictions.
    * **Function rules**: `user`, `catalog`, `schema`, `function`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`, `OWNERSHIP`).
    * **Procedure rules**: `user`, `catalog`, `schema`, `procedure`, `privileges` (`EXECUTE`, `GRANT_EXECUTE`).
    * **Query rules**: `user`, `queryOwner`, `privileges` (`execute`, `view`, `kill`). If `queryOwner` is specified, the `execute` privilege is not available.

    In the _User_ field, you can enter the value as a regular expression or select from {{ iam-name }}. If the mapping field (e.g., _Catalog_, _Schema_, or _Table_) is left blank, {{ TR }} substitutes `.*`.

1. Click **Create**.

Done. The cluster has now appeared in the **Clusters** list. Once created, the cluster status is displayed in the **Status** column. Go to the cluster card for detailed info.

## Connecting to a cluster {#connect}

Once the cluster enters the `Running` state, you can connect to it using the coordinator's address.

### Getting connection addresses {#get-connection-addresses}

{% list tabs %}

- CLI

    Run this command:

    ```bash
    kubectl get trinocluster <cluster_name> -n <namespace> -o jsonpath='{.status.fqdn}'
    ```

    Response structure:

    * `external`: FQDN of the coordinator for connection via {{ TR }} clients (CLI, JDBC).
    * `webUI`: {{ TR }} UI FQDN.

- Management console

    1. Open your project.
    1. In the left-hand menu, select **Trino** → **Clusters**.
    1. Select a cluster.
    1. On the **Overview** tab, find the addresses for connection. For detailed connection info, click **Connect**.

{% endlist %}

### {{ TR }} CLI {#trino-cli}

1. Install the {{ TR }} CLI as per the [official guide](https://trino.io/docs/current/client/cli.html).
1. Connect to the cluster using the coordinator address from `status.fqdn.external`:

    ```bash
    trino --server https://<coordinator_FQDN> --user <username>
    ```

### JDBC {#jdbc}

Use the {{ TR }} JDBC driver with a URL in this format:

```
jdbc:trino://<coordinator_FQDN>:443
```

Get the`<coordinator_FQDN>` value from `status.fqdn.external`.
