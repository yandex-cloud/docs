# Disabling {{ yt-name }}

To disable the [{{ yt-name }} component](../../concepts/components/ytsaurus.md), switch the `YTsaurusConfig` resource to `spec.enabled: false`.

{% note alert %}

When you disable the component, the controller deletes Helm releases and the `stackland-ytsaurus` namespace. All {{ YT }} cluster resources, including PVCs and data stored in them, will be deleted together with the namespace. Once the component is disabled, you cannot recover this data.

Before disabling this component, make sure you no longer need the {{ YT }} cluster data or save it to an external storage.

{% endnote %}

## Using the CLI {#cli}

1. Open the `YTsaurusConfig main` resource to edit it: `kubectl edit ytsaurusconfig main`. Install `spec.enabled: false`. You can leave the `spec.cluster` fields unchanged.

    Alternatively, apply a ready-to-use manifest:

    {% include notitle [YAML-file](../../_includes/yamls/operations/ytsaurus/disable.md) %}

    ```bash
    kubectl apply -f ytsaurusconfig-disable.yaml
    ```

1. Wait for the deletion to complete. You can check the current removal status in the `ComponentInstallation ytsaurus-main` resource:

    ```bash
    kubectl get componentinstallation ytsaurus-main -o jsonpath='{.status.phase}'
    ```

    During the deletion, the status remains `Uninstalling`. Once the deletion succeeds, the `ComponentInstallation ytsaurus-main` resource will be removed from the cluster.

1. Make sure the `stackland-ytsaurus` namespace has been deleted:

    ```bash
    kubectl get namespace stackland-ytsaurus
    ```

    The command should return the `NotFound` error.

## Re-enabling the component {#re-enable}

To redeploy your {{ YT }} cluster, set `spec.enabled` back to `true`. Re-enabling the component provisions a new {{ YT }} cluster with empty storage. No data from the previous cluster is restored. For more information, see [Enabling {{ yt-name }}](enable.md).
