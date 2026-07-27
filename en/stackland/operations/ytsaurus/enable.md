# Activate {{ yt-name }}

[{{ yt-name }}](../../concepts/components/ytsaurus.md) deploys a single shared {{ YT }} cluster on the platform. The cluster is described by a `YTsaurusConfig` resource named `main`. By default, the component is disabled (`spec.enabled: false`); to deploy the cluster, set the resource to `spec.enabled: true`.

{% note warning %}

The platform supports only one {{ YT }} cluster. The `YTsaurusConfig` resource must be named `main`.

{% endnote %}

## Using the CLI {#cli}

1. Open the current `YTsaurusConfig main` resource to edit it: `kubectl edit ytsaurusconfig main`. If you prefer to apply the configuration from a file, upload the resource `kubectl get ytsaurusconfig main -o yaml > ytsaurusconfig.yaml`.
1. Replace the content with one of the configurations below:

    {% list tabs %}

    - Minimum configuration

        Includes a minimal set of subcomponents: cluster core, web interface, and HTTP proxy. Suitable for a test environment.

        {% include notitle [YAML-file](../../_includes/yamls/operations/ytsaurus/enable-min.md) %}

    - Extended configuration

        A full set of subcomponents with explicitly specified resources and storage: tablet nodes, Strawberry, CHYT, SPYT, Task Proxy, Cron. Suitable for a production environment.

        {% include notitle [YAML-file](../../_includes/yamls/operations/ytsaurus/enable-full.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f ytsaurusconfig.yaml`. The resource operates at the cluster level; you do not need to specify a namespace.

1. Wait for the component to enter the ready state. To check the installatioln status, run this command:

    ```bash
    kubectl get componentinstallation ytsaurus-main -o jsonpath='{.status.phase}'
    ```

    The possible values are:

    * `Installing`: Installing the component.
    * `Updating`: Applying the new configuration.
    * `Ready`: Component installed and ready for operation.
    * `Error`: Error. For details, refer to the `status.message` field.

1. You can check the {{ YT }} cluster status using the following command:

    ```bash
    kubectl -n stackland-ytsaurus get ytsaurus cluster
    ```

    The resource name corresponds to `spec.clusterName` in `YTsaurusConfig`. Wait until the cluster turns `Running`. Its initial start may take 10–20 minutes.

## Next steps {#next-steps}

After you enable the component:

* [Get your administrator password and token](get-admin-credentials.md).
* [Open the {{ YT }} web interface](connect-ui.md).
* [Connect to the {{ YT }} HTTP proxy](connect-api.md).
* [Update](edit-cluster.md) the cluster settings if you need to edit the resources, node group composition, or subcomponents.
