# Changing clusters {{ k8s }}

{% include [yc-cluster-list](../../../_includes/managed-kubernetes/cluster-list.md) %}

## Changing clusters {{ k8s }}

You can change the following parameters of a {{ k8s }} cluster:

- Name.
- Description.
- Service accounts.
- {{ k8s }} version.
- Update policy.

{% list tabs %}

- Management console

    To change a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster):
    1. Open **{{ managed-k8s-name }}** in the folder where you want to change the {{ k8s }} cluster.
    1. Click on the name of the {{ k8s }} cluster you.
    1. Click **Edit** in the upper-right corner.
    1. Change the necessary parameters in the window that opens.
    1. Click **Save changes**.

- CLI

    Get detailed information about the command to change a {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster update --help
    ```

    To change the {{ k8s }} cluster, use the following parameters:
    * `--new-name`: Change the name.
    * `--description`: Change the description.
    * `--service-account-id`, `--service-account-name`: Change the service account for the resources.
    * `--node-service-account-id`, `--node-service-account-name`: Change the service account for the nodes.
    * `--version`: Change the {{ k8s }} version.
    * `--latest-revision`: Get all available updates for the current version of the master.
    * `--auto-upgrade`: Manage automatic updates.
    * Managing the maintenance window:
        * `--anytime-maintenance-window`: Run the maintenance at any time.
        * `--daily-maintenance-window`: Perform maintenance daily at the selected time.
        * `--weekly-maintenance-window`: Perform maintenance on the selected days.

- API

  To change the parameters of a {{ k8s }} cluster, use the [update](../../api-ref/Cluster/update.md) method for the [Cluster](../../api-ref/Cluster/) resource.

{% endlist %}

## Managing cluster labels {{ k8s }} {#manage-label}

You can perform the following actions with {{ k8s }} cluster labels:

* [Add a label](#add-label)
* [Update a label](#update-label)
* [Delete a label](#remove-label)

### Adding a label {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Add a label to the {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster add-labels k8s-demo --labels new_label=test_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-11-20T11:26:36Z"
    name: k8s-demo
    description: My test Kubernetes cluster
    labels:
    new_label: test_label
    ...
    ```

{% endlist %}

### Updating a label {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Change the {{ k8s }} cluster label:

    {% note warning %}

    The existing set of `labels` is completely replaced by the set transmitted.

    {% endnote %}

    ```
    $ yc managed-kubernetes cluster update k8s-demo --labels test_label=my_k8s_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-11-20T11:26:36Z"
    name: k8s-demo
    description: My test Kubernetes cluster
    labels:
    test_label: my_k8s_label
    status: RUNNING
    health: HEALTHY
    ...
    ```

{% endlist %}

### Deleting a label {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Remove a label from a {{ k8s }} cluster:

    ```
    $ yc managed-kubernetes cluster remove-labels k8s-demo --labels test_label
    
    done (1s)
    id: cati493bu7ian006a4a8
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-11-20T11:26:36Z"
    name: k8s-demo
    description: My test Kubernetes cluster
    status: RUNNING
    health: HEALTHY
    ...
    ```

{% endlist %}

