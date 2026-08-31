# Scaling a cluster

You can change the node composition of your {{ stackland-name }} cluster by adding or removing nodes. Each cluster node is described by a custom `StacklandHostConfig` resource in the `stackland-install` namespace. Creating a resource initiates the connection of a new node, and deleting a resource initiates the removal of an existing one.

The service supports nodes with the `control-plane`, `worker`, and `combined` roles. You cannot change a node's role directly. To change a role, delete the node and add it again with a new role.

## Getting started {#before-you-begin}

1. Make sure you have admin access to the cluster.
1. Make sure the license does not prohibit adding a new node. You can look up the current license status in `PlatformConfig.status.licensing` and in the `LicenseSynced` condition. For more information, see [{#T}](../../concepts/licensing.md).

    ```bash
    kubectl get platformconfig default -o jsonpath='{.status.licensing.state}'
    ```

1. If the cluster is being updated to a new version, scaling will begin automatically once the update is complete. Check what phase the update is currently in if you need to:

    ```bash
    kubectl get targetinstallationstate main -o jsonpath='{.status.phase}'
    ```

1. View the cluster's current node composition using one of these methods:

    * In the management console, select **Node management** from the left-hand menu. You will see a list of nodes with their names, statuses, and roles.
    * Use the CLI to run this command:

        ```bash
        kubectl get stacklandhostconfig -n stackland-install
        ```

        Here is an example of the command output:

        ```text
        NAME              ROLE            PHASE       AGE
        192.168.23.2      control-plane   Installed   7d
        192.168.23.3      control-plane   Installed   7d
        192.168.23.4      control-plane   Installed   7d
        192.168.23.10     worker          Installed   3d
        ```

        The abbreviated resource name is `shc`.

## Adding a node {#add-node}

### Preparing a new node {#prepare-node}

Boot the new node into Maintenance mode, same as during the initial cluster installation. Without this, the node connection will not work. For more information, see [{#T}](../../quickstart.md).

After uploading, make sure you have the following:

* Hostname or IP address of the node.
* List and parameters of network interfaces.
* Path to the installation disk.

### Creating a StacklandHostConfig resource {#create-shc}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create the manifest file, e.g., using the `touch host.yaml` command.
  1. Open the file and paste this minimum configuration:

      ```yaml
      apiVersion: stackland.yandex.cloud/v1alpha1
      kind: StacklandHostConfig
      metadata:
        name: <node_name>
        namespace: stackland-install
      spec:
        role: worker
        disksConfig:
          - installDisk:
              name: "/dev/sda"
        networkConfig:
          interfaces:
            - name: eth0
              mac: "<mac_address>"
          addresses:
            - iface: eth0
              ip: "<IP_address>/<prefix>"
          routes:
            - iface: eth0
              to: "0.0.0.0/0"
              via: "<gateway>"
      ```

      Where:

      * `metadata.name`: Node hostname. Used as a resource ID in the cluster.
      * `spec.role`: Node role: `control-plane`, `worker`, or `combined`.
      * `spec.disksConfig[].installDisk.name`: Path to the OS installation disk.
      * `spec.networkConfig`: Network connection parameters of the node.

      Fields not specified in the manifest are inherited from the `StacklandClusterConfig` template specified during cluster installation.

  1. Optionally, add the `spec.features` section to enable additional node features. For example, GPU support:

      ```yaml
      spec:
        features:
          - gpu
      ```

  1. Apply the manifest:

      ```bash
      kubectl apply -f host.yaml
      ```

  1. Save the `host.yaml` file to the Git repository where the cluster configurations are stored. This will allow you to restore the node composition if you have to.


- Management console{#console}

  1. In the left-hand menu, select **Node management**.
  1. Click **Create node**.
  1. Under **Node configuration**, fill out the main fields:

      * **Node name**: Node hostname.
      * **Role**: `control-plane`, `worker`, and `combined`.
      * **Installation disk**: Path to the installation disk, e.g., `/dev/sda`.

      To set a node configuration in YAML format, enable the **Edit YAML** toggle.

  1. Under **Interfaces**, add node network interfaces. For each interface, click **Add interface** and specify:

      * **Name**: Interface name, e.g., `eth0`.
      * **MAC address**: MAC address of the interface.
      * **Routes**: List of routes. Click **Add route** to set up a route.
      * **Addresses**: Prefixed IP address, e.g., `192.168.1.1/24`.

  1. Under **Network configuration**, override the node's general network settings as needed:

      * **Resolvers**: List of DNS servers.
      * **Timeservers**: List of NTP servers.

      If the fields are left empty, the default values ​​from the `StacklandClusterConfig` template will be used.

  1. Under **Advanced features**, enable the features you want, e.g., **GPU**.
  1. Click **Create**.

{% endlist %}

## Deleting a node {#remove-node}

When you delete a node, the cluster performs the following actions:

1. Shields the node from new load (cordon).
1. Evacuates existing pods from the node (drain).
1. Deletes the node from the Kubernetes cluster.
1. Resets the operating system to Maintenance mode. The node becomes available for reconnection to the cluster.

{% list tabs group=instructions %}

- CLI {#cli}

  Delete the `StacklandHostConfig` resource:

  ```bash
  kubectl delete stacklandhostconfig <node_name> -n stackland-install
  ```

  The command does not return control until the node removal operation is complete. This behavior is contributed by the finalizer. You can safely interrupt the wait using the `Ctrl+C` key combination; the operation will continue in the background.


- Management console{#console}

  1. In the left-hand menu, select **Node management**.
  1. In the node row, click **⋯**.
  1. Click **Delete**.
  1. Confirm the deletion.

{% endlist %}

## Checking the status of an operation {#check-status}

To view the current status of the `StacklandHostConfig` resource, run this command:

```bash
kubectl get stacklandhostconfig <node_name> -n stackland-install
```

Here is an example of the command output:

```text
NAME            ROLE     PHASE        AGE
node-05         worker   Installing   2m
```

The `PHASE` field displays the node's lifecycle phase:

* `Pending`: Resource created, operation pending.
* `Installing`: Connecting node to the cluster.
* `Installed`: Node connected and running in the cluster.
* `Removing`: Removing node from the cluster.
* `Failed`: Operation failed with an error.

## Getting detailed information {#get-details}

To view the detailed status of a node, run this command:

```bash
kubectl describe stacklandhostconfig <node_name> -n stackland-install
```

The `Status` field displays:

* `phase`: Current phase of the lifecycle.
* `message`: Message about the current status of the operation.
* `lastUpdated`: Status last update time.
