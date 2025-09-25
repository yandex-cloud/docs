# Connecting to component interfaces

You can connect to {{ dataproc-name }} component interfaces either using [UI Proxy](#ui-proxy) or a [jump host VM](#routing). For more information, see [Component interfaces and ports](../concepts/interfaces.md).

## UI Proxy {#ui-proxy}

{% include [ui-proxy-sg-warning](../../_includes/data-processing/ui-proxy-sg-warning.md) %}

### Enabling component interfaces {#ui-proxy-enable}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Select the cluster and click ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_configuration }}**, enable **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable access to cluster component web interfaces, set the `--ui-proxy` parameter to `true`:

    ```bash
    {{ yc-dp }} cluster update <cluster_name_or_ID> \
       --ui-proxy=true
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list).

- API {#api}

    Use the [update](../api-ref/Cluster/update.md) API method and include the following in the request:

    * Cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list).
    * `true` in the `uiProxy` parameter.
    * List of cluster configuration fields to update, in the `updateMask` parameter (in this case, `uiProxy`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Retrieving a list of connection URLs {#ui-proxy-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the cluster name.
    1. You can find links for connecting to component web interfaces under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of URLs for connecting to the web interfacess of the {{ dataproc-name }} cluster components, run the following command:

    ```bash
    {{ yc-dp }} cluster list-ui-links <cluster_name_or_ID>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list).

- API {#api}

    Use the [listUILinks](../api-ref/Cluster/listUILinks.md) API method and include the cluster ID in the `clusterId` request parameter.

    You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list).

{% endlist %}

## Port forwarding {#routing}

To access a component's network interface from the internet, [create](../../compute/operations/vm-create/create-linux-vm.md) an intermediate virtual machine in {{ compute-full-name }}.

Requirements for a jump host VM:

* It must have an assigned public IP address.
* It must be hosted in the same network as the required {{ dataproc-name }} cluster.
* [Security group settings](../concepts/network.md#security-groups) must allow traffic exchange with the cluster via the ports of the appropriate components.

Learn more about configuring security groups for connections with port forwarding [here](security-groups.md).

To connect to the {{ dataproc-name }} host port you need, run the following command:

```bash
ssh -A \
    -J <VM_user_name>@<VM_public_IP_address> \
    -L <port_number>:<Yandex_Data_Processing_host_FQDN>:<port_number> <username>@<Yandex_Data_Processing_host_FQDN>
```

Where:

* `-A`: Activates connection redirects from the authentication agent with the jump host VM to the target host of the {{ dataproc-name }} cluster.
* `-J`: Connection to the target host via a jump host VM. Establishes a connection over SSH to the jump host VM that will redirect packages to the target host in the {{ dataproc-name }} cluster.
* `-L`: Local port redirection to the {{ dataproc-name }} cluster host.

    To connect to cluster hosts with [image version](../concepts/environment.md) 1.x, use `root` as the username; for version 2.x, use `ubuntu`.

You can find the {{ dataproc-name }} host’s FQDN on the {{ dataproc-name }} cluster page, in the **{{ ui-key.yacloud.mdb.cluster.switch_hosts }}** column of the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** tab.

You can find port numbers for {{ dataproc-name }} components under [Component interfaces and ports](../concepts/interfaces.md#port-numbers).
