# Updating {{ mtr-name }} cluster settings

If you have a [{{ TR }} cluster](../../concepts/components/trino.md) in your [project](../projects/create-project.md), you can update its settings.

{% note info %}

When you partially update settings, {{ mtr-name }} recreates the cluster. While the new configuration is being applied, the cluster switches to `Updating`, and active queries get interrupted. For more information, see [Updating a cluster](../../concepts/components/trino.md#cluster-update).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Open the `TrinoCluster` resource file, e.g., using the `open trinocluster.yaml` command.
  1. Edit the following properties:

      * `spec.version`: {{ TR }} version. Use the value indicated in `TrinoImageCatalog`.
      * `spec.deletionProtection`: Deletion protection. The possible values are `true` and `false`.
      * `spec.coordinator.resources.requests.cpu`: Guaranteed number of CPUs for the coordinator pod.
      * `spec.coordinator.resources.requests.memory`: Guaranteed RAM for the coordinator pod.
      * `spec.coordinator.resources.limits.cpu`: Maximum number of CPUs for the coordinator pod.
      * `spec.coordinator.resources.limits.memory`: Maximum RAM for the coordinator pod.
      * `spec.worker.replicas`: Number of workers Minimum `1`.
      * `spec.worker.resources.requests.cpu`: Guaranteed number of CPUs for the worker pod.
      * `spec.worker.resources.requests.memory`: Guaranteed RAM for the worker pod.
      * `spec.worker.resources.limits.cpu`: Maximum number of CPUs for the worker pod.
      * `spec.worker.resources.limits.memory`: Maximum RAM for the worker pod.
      * `spec.config`: Additional {{ TR }} settings. The available keys and values are defined in the validation schema for the relevant {{ TR }} version. The operator publishes the schema in `ConfigMap` `trino-omdb-operator-<version>` within its namespace. For example, the `io.trino` key specifies a logging level (the possible values are `DEBUG`, `INFO`, `WARN`, and `ERROR`).
      * `spec.accessControl`: Access rules for catalogs, schemas, tables, functions, procedures, and queries. See [Access management](../../concepts/components/trino.md#access-control).

  1. Apply the manifest: `kubectl apply -f trinocluster.yaml -n <namespace>`. Optionally, you can specify the namespace in the `metadata.namespace` resource property and skip it in the command.


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. Select the namespace the cluster was created in.
  1. In the left-hand menu, select **Trino** → **Clusters**.
  1. Select a cluster.
  1. Click **Edit**.
  1. Edit the following fields:

      **Basic properties**

      * **Trino version**: {{ TR }} version from `TrinoImageCatalog`.
      * **Deletion protection**: Toggle for protection against accidental deletion.

      The **Name** field is read-only.

      **Coordinator configuration**

      * **Requested CPU**, **Requested RAM**: Requested resources for the coordinator pod.
      * **CPU limit**, **RAM limit**: Maximum resources for the coordinator pod.

      **Worker configuration**

      * **Number of workers**: Number of worker pods.
      * **Requested CPU**, **Requested RAM**: Requested resources for the worker pod.
      * **CPU limit**, **RAM limit**: Maximum resources for the worker pod.

      **Additional settings**

      This is a section for adding, updating, and removing {{ TR }} settings. The key is read-only for existing rows; you can only change the value.

      **Access settings**

      This section configures access rules for the **Catalog rules**, **Schema rules**, **Table rules**, **Function rules**, **Procedure rules**, and **Query rules** subsections. The list of fields and privileges matches the cluster creation form.

  1. Click **Save**.

{% endlist %}

This is it, your cluster settings have been updated.
