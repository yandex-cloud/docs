# Connecting to component interfaces

You can connect to {{ dataproc-name }} component interfaces either using [UI Proxy](#ui-proxy) or an [intermediate virtual machine](#routing). For more information, see [{#T}](../concepts/interfaces.md).

## UI Proxy {#ui-proxy}

{% note warning %}

You may need to additionally [set up security groups](connect.md#configuring-security-groups) to use UI Proxy (this feature is in the [Preview](../../overview/concepts/launch-stages.md) stage).

{% endnote %}

### Enabling component interfaces {#ui-proxy-enable}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Select a cluster and click ![pencil](../../_assets/pencil.svg) **Edit cluster** on the top panel.
   1. Under **Settings**, enable **UI Proxy**.
   1. Click **Save changes**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To enable access to cluster component web interfaces, select `true` for the `--ui-proxy` parameter:

   ```bash
   {{ yc-dp }} cluster update <cluster name or ID> \
       --ui-proxy=<enable UI Proxy: true or false>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list).

- API

   Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:

   * Cluster ID in the `clusterID` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list).
   * `True` as the value for the `uiProxy` parameter.
   * List of cluster configuration fields to update in the `updateMask` parameter (`uiProxy` in this case).

   {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

### Retrieving a list of connection URLs {#ui-proxy-list}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the desired cluster.
   1. Connection links for the component web interfaces can be found under **UI Proxy**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To retrieve a list of URLs to connect to {{ dataproc-name }} cluster component web interfaces, run the following command:

   ```bash
   {{ yc-dp }} cluster list-ui-links <cluster name or ID>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](cluster-list.md#list).

- API

   Use the [listUILinks](../api-ref/Cluster/listUILinks.md) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list).

{% endlist %}

## Port forwarding {#routing}

To access a component's network interface from the internet, [create](../../compute/operations/vm-create/create-linux-vm.md) an intermediate virtual machine in {{compute-full-name}}.

Requirements for an intermediate VM:

* An assigned public IP address.
* Hosted in the same network as the required {{ dataproc-name }} cluster.
* [Security group settings](../concepts/network.md#security-groups) that allow traffic exchange with the cluster via the corresponding components' ports.

For step-by-step instructions on how to configure security groups for port forwarding, see [{#T}](connect.md#configuring-security-groups).

To connect to the desired {{ dataproc-name }} host port, run the following command:


```bash
ssh -A \
    -J <VM public IP> \
    -L <port>:<Data Proc host FQDN>:<port> <username>@<Data Proc host FQDN>
```



Where:

* `-A`: Activates connection redirects from the authentication agent on the jump host VM to the {{ dataproc-name }} cluster host.
* `-J`: Use jump host VM to connect to target host. Connect over SSH to the jump host VM that will redirect packages to the target host in the {{ dataproc-name }} cluster.
* `-L`: Redirect the local port to the {{ dataproc-name }} cluster host.

   
   To connect to cluster hosts with 1.x as the [image version](../concepts/environment.md), use `root` as your username, for version 2.x, use `ubuntu`.


You can find the FQDN of the {{ dataproc-name }} host on the {{ dataproc-name }} cluster page, in the **Hosts** tab, under the **Hostname** column.

Port numbers for {{ dataproc-name }} components are shown under [Component interfaces and ports](../concepts/interfaces.md#port-numbers).
