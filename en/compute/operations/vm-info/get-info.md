# Getting information about a VM

To get basic details of each virtual machine you created, open the virtual machine page in [console]({{ link-console-main }}). To get detailed information with user-defined [metadata](../../concepts/vm-metadata.md), use the CLI or API.

You can also get the basic details and metadata [from inside a VM](#inside-instance).

## Get information from outside a VM {#outside-instance}

{% list tabs %}

- Management console

  On the **Virtual machines** page in the **Compute Cloud** section, you can find a list of VMs in the folder and brief information for each of them.

  For more information about a certain VM, click its name.

  Tabs:
  - **Overview** shows general information about the VM, including the IP addresses assigned to it.
  - **Disks** provides information about the disks attached to the VM.
  - **Operations** lists operations on the VM and resources attached to it, such as disks.
  - **Monitoring** shows information about resource consumption on the VM. You can only get this information from the management console or from inside the VM.
  - **Serial port** provides information that is output by the VM to the serial port. To get this information via the API or CLI, use the instructions [{#T}](get-serial-port-output.md).

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command to get serial port output:

      ```
      $ yc compute instance get --help
      ```

  1. Select a VM, for example, `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Get basic information about a VM:

      ```
      $ yc compute instance get first-instance
      ```

      To get information about a VM with [metadata](../../concepts/vm-metadata.md), use the `--full` flag:

      ```
      $ yc compute instance get --full first-instance
      ```

- API

  To get basic information about a VM, use the [get](../../api-ref/Instance/get.md) method for the [Instance](../../api-ref/Instance/index.md) resource.

  The basic information does not include the user-defined metadata that was passed when creating or updating the VM. To get the information along with the metadata, specify `view=FULL` in the parameters.

{% endlist %}

## Get information from inside a virtual machine {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### Google Compute Engine {#gce-metadata}

The Yandex.Cloud metadata service lets you return metadata in the Google Compute Engine format.

#### HTTP request {#gce-http}

```
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

| Parameter | Description |
| ----- | ----- |
| `alt` | Response format (by default, `text`). |
| `recursive` | If `true`, it returns all values in the tree recursively. By default, `false`. |
| `wait_for_change` | If `true`, this response will be returned only when one of the metadata parameters is modified. By default, `false`. |
| `last_etag` | The ETag value from the previous response to a similar request. Use it when `wait_for_change="true"`. |
| `timeout_sec` | Maximum request timeout. Use it when `wait_for_change="true"`. |

#### Request examples {#request-examples}

Find out the ID of a VM from inside it:

```
$ curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/id
```

Get metadata in JSON format:

```
$ curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

Get metadata in an easy-to-read format. Use the [jq](https://stedolan.github.io/jq/) utility:

```
$ curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true | jq -r '.'
```

#### List of returned elements {#list-of-returned-elements}

List of elements that are available for this request.

| Element | Description |
| ----- | ----- |
| `attributes/` | User-defined metadata that was passed in the `metadata` field when creating or updating the VM. |
| `attributes/ssh-keys` | List of public SSH keys passed during VM creation in the `metadata` field through the `ssh-keys` value. |
| `description` | Text description passed when creating or updating the VM. |
| `disks/` | Disks attached to the VM. |
| `hostname` | [FQDN](../../concepts/network.md#hostname) assigned to the VM. |
| `id` | ID of the VM. The ID is generated automatically when the VM is being created and is unique within Yandex.Cloud. |
| `name` | Name that was passed when creating or updating the VM. |
| `networkInterfaces/` | Network interfaces connected to the VM. |
| `service-accounts` | [Service accounts](../../../iam/concepts/users/service-accounts.md) linked to the VM. |
| `service-accounts/default/token` | [IAM token](../../../iam/concepts/authorization/iam-token.md) of the linked service account. |

Other elements, such as `project`, which are used for backward compatibility and remain empty.

### Amazon EC2 {#ec2-metadata}

The Yandex.Cloud metadata service lets you return metadata in the Amazon EC2 format.

#### HTTP request {#ec2-http}

```
GET http://169.254.169.254/latest/meta-data/<element>
```

| Parameter | Description |
| ----- | ----- |
| `<element>` | Path to the element you want to get. If the element is omitted, the response returns a list of available elements. |

#### List of returned elements {#list-of-returned-elements}

List of elements that are available for this request.

{% note info %}

The angle brackets contain parameters that need to be replaced with values. For example, instead of `<mac>`, you should insert the MAC address of the network interface.

{% endnote %}

| Element | Description |
| ----- | ----- |
| `hostname` | Hostname assigned to the VM. |
| `instance-id` | ID of the VM. |
| `local-ipv4` | Internal IPv4 address. |
| `local-hostname` | Hostname assigned to the VM. |
| `mac` | MAC address of the VM's network interface. |
| `network/interfaces/macs/<mac>/ipv6s` | Internal IPv6 addresses associated with the network interface. |
| `network/interfaces/macs/<mac>/local-hostname` | Hostname associated with the network interface. |
| `network/interfaces/macs/<mac>/local-ipv4s` | Internal IPv4 addresses associated with the network interface. |
| `network/interfaces/macs/<mac>/mac` | MAC address of the VM's network interface. |
| `public-ipv4` | External IPv4 address. |
| `iam/security-credentials/default/` | [IAM token](../../../iam/concepts/authorization/iam-token.md) of the linked service account. |

#### Request examples {#request-examples}

Get an internal IP address from inside a VM:

```
$ curl http://169.254.169.254/latest/meta-data/local-ipv4
```

