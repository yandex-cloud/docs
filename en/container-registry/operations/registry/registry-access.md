# Configuring access to a registry

You can set up policies for accessing a [registry](../../concepts/registry.md) from specific [IP addresses](../../../vpc/concepts/address.md).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry was created.
  1. In the list of services, select **{{ container-registry-name }}**.
  1. Select the registry to configure access to.
  1. In the panel on the left, click ![IP address](../../../_assets/container-registry/ip-access.svg) **Access for IP addresses**.
  1. Click **Configure**.
  1. Enter the IP and specify an action. PULL to allow pulling and PUSH to allow pushing images.
  1. To configure access for multiple IPs, click **Add**.
  1. Click **Save**.

- CLI

  1. View the list of available registries, their names and IDs:

     ```bash
     yc container registry list
     ```

     Result:

     ```bash
     +-----------------+-----------------+---------------+
     |        ID       |      NAME       |   FOLDER ID   |
     +-----------------+-----------------+---------------+
     |  <Registry ID>  | <Registry name> |  <Folder ID>  |
     +-----------------+-----------------+---------------+
     ```

  1. Specify registry access settings.

     ```bash
     yc container registry set-ip-permissions <registry_name> --pull <IP address> --push <IP address>
     ```

     Where:
     * `--pull` is a flag that allows pulling [Docker images](../../concepts/docker-image.md) from the registry.
     * `--push` is a flag that allows pushing Docker images to the registry.

     To learn more about the command, see the [CLI reference](../../../cli/cli-ref/managed-services/container/registry/set-ip-permissions).

     As a result of executing this command, all the permissions set for IP addresses will be deleted. To continue, type `yes` and press **Enter**.

     Result:

     ```text
     WARN: All current ip permissions will be deleted. Are you sure?[y/N]
     ```

  1. Check the current permissions:

     ```bash
     yc container registry list-ip-permissions -- <registry_name>
     ```

     Result:

     ```bash
     +--------+--------------+
     | ACTION |      IP      |
     +--------+--------------+
     | PULL   | <IP address> |
     | PUSH   | <IP address> |
      +--------+--------------+
     ```

{% endlist %}