# Getting information about a VM

To get information about a virtual machine you created, go to the [management console]({{ link-console-main }}) and open the virtual machine page. To get detailed information with user-defined [metadata](../../concepts/vm-metadata.md) via the CLI or API.

You can also get the basic details and metadata from [inside a VM](#inside-instance).

## Getting information from outside a VM {#outside-instance}

{% list tabs %}

- Management console

   On the **Virtual machines** page in the **Compute Cloud** section, you can find a list of VMs in the folder and brief information for each of them.

   For more information about a certain VM, click its name.

   Tabs:

   * **Overview** shows general information about the VM, including the IP addresses assigned to it.
   * **Disks** provides information about the disks attached to the VM.
   {% if product == "yandex-cloud" %}* **File storages** provides information about the file storages attached.{% endif %}
   * **Operations** lists operations on the VM and resources attached to it, such as disks.
   * **Monitoring** shows information about resource consumption on the VM. You can only get this information from the management console or from inside the VM.
   * **Serial console** provides access to the serial console if enabled when creating the VM.
   * **Serial port** provides information that is output by the VM to the serial port. To get this information via the API or CLI, use the instructions [{#T}](get-serial-port-output.md).

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the command to get serial port output:

      ```
      yc compute instance get --help
      ```

   1. Select a VM, for example, `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Get basic information about a VM:

      ```
      yc compute instance get first-instance
      ```

      To get information about a VM with [metadata](../../concepts/vm-metadata.md) use the `--full` flag:

      ```
      yc compute instance get --full first-instance
      ```

- API

   To get basic information about a VM, use the [get](../../api-ref/Instance/get.md) method for the [Instance](../../api-ref/Instance/index.md) resource.

   The basic information does not include the user-defined metadata that was passed when creating or updating the VM. To get the information along with the metadata, specify `view=FULL` in the parameters.

{% endlist %}

## Getting information from inside a virtual machine {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### Google Compute Engine {#gce-metadata}

The {{ yandex-cloud }} metadata service lets you return metadata in Google Compute Engine format.

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

Where:

| Parameter | Description |
----- | -----
| `alt` | Response format (by default, `text`). |
| `recursive` | If `true`, it returns all values in the tree recursively. By default, `false`. |
| `wait_for_change` | If `true`, this response will be returned only when one of the metadata parameters is modified. By default, `false`. |
| `last_etag` | The ETag value from the previous response to a similar request. Use it when `wait_for_change="true"`. |
| `timeout_sec` | Maximum request timeout. Use it when `wait_for_change="true"`. |

#### Request examples {#request-examples}

Find out the ID of a VM from inside it:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/id
```

Get metadata in JSON format:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

Get metadata in an easy-to-read format. Use the [jq](https://stedolan.github.io/jq/) utility:

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/?recursive=true | jq -r '.'
```

#### List of returned elements {#list-of-returned-items}

List of elements that are available for this request.

| Element | Description |
----- | -----
| `attributes/` | User-defined metadata that was passed in the `metadata` field when creating or updating the VM. |
| `attributes/ssh-keys` | List of public SSH keys passed during VM creation in the `metadata` field through the `ssh-keys` value. |
| `description` | Text description passed when creating or updating the VM. |
| `disks/` | Disks attached to the VM. |
| `hostname` | The [FQDN](../../concepts/network.md#hostname) assigned to the VM. |
| `Id` | ID of the VM. The ID is generated automatically when the VM is being created and is unique within {{ yandex-cloud }}. |
| `name` | The name that was passed when creating or modifying the VM. |
| `networkInterfaces/` | Network interfaces connected to the VM. |
| `service-accounts` | [Service accounts](../../../iam/concepts/users/service-accounts.md) linked to the VM. |
| `service-accounts/default/token` | The [IAM token](../../../iam/concepts/authorization/iam-token.md) of the linked service account. |

Other elements, such as `project`, which are used for backward compatibility and remain empty.

### Amazon EC2 {#ec2-metadata}

The {{ yandex-cloud }} metadata service lets you return metadata in Amazon EC2 format.


This format has no support for user-defined metadata fields.

#### HTTP request {#ec2-http}

```
GET http://169.254.169.254/latest/meta-data/<element>
```

Where:

| Parameter | Description |
----- | -----
| `<element>` | Path to the element you want to get. If the element is omitted, the response returns a list of available elements. |

#### List of returned elements {#list-of-returned-items}

List of elements that are available for this request.

{% note info %}

The angle brackets contain parameters that need to be replaced with values. For example, instead of `<mac>`, you should insert the MAC address of the network interface.

{% endnote %}

| Element | Description |
----- | -----
| `hostname` | The hostname assigned to the VM. |
| `instance-id` | ID of the VM. |
| `local-ipv4` | Internal IPv4 address. |
| `local-hostname` | The hostname assigned to the VM. |
| `mac` | MAC address of the VM's network interface. |
| `network/interfaces/macs/<mac>/ipv6s` | Internal IPv6 addresses associated with the network interface. |
| `network/interfaces/macs/<mac>/local-hostname` | Hostname associated with the network interface. |
| `network/interfaces/macs/<mac>/local-ipv4s` | Internal IPv4 addresses associated with the network interface. |
| `network/interfaces/macs/<mac>/mac` | MAC address of the VM's network interface. |
| `public-ipv4` | External IPv4 address. |

#### Request examples {#request-examples}

Get an internal IP address from inside a VM:

```
curl http://169.254.169.254/latest/meta-data/local-ipv4
```

## Setting up metadata service parameters for a VM instance {#metadata-options}

You can set up metadata service parameters when [creating](../../operations/index.md#vm-create) or [updating](../../operations/vm-control/vm-update.md) VMs.

You can use the following settings:

* `aws-v1-http-endpoint` provides access to metadata using AWS format (IMDSv1). Acceptable values: `enabled`, `disabled`.
* `aws-v1-http-endpoint` provides access to {{ iam-short-name }} credentials using AWS format (IMDSv1). Acceptable values: `enabled`, `disabled`.

   {% note info %}

   The IMDSv1 format has certain drawbacks in terms of security, which is why the `aws-v1-http-token` parameter is `disabled` by default. The most severe drawback of IMDSv1 is its high risk of certain attacks, e.g., [SSRF](https://portswigger.net/web-security/ssrf). You can read more about it in the [AWS official blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). To change the default behavior of this parameter, contact [support]({{ link-console-support }}).

   The safest method to obtain the token in {{ yandex-cloud }} is to use [Google Compute Engine](#gce-metadata) format, which uses an extra header for protection against SSRF.

   {% endnote %}

* `gce-http-endpoint` provides access to metadata using Google Compute Engine format. Acceptable values: `enabled`, `disabled`.
* `gce-http-token` provides access to {{ iam-short-name }} credentials using Google Compute Engine format. Acceptable values: `enabled`, `disabled`.

To set up the metadata service parameters for an instance:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command for updating VM parameters:

      ```bash
      yc compute instance update --help
      ```

   1. Get a list of VMs in the default folder:

      ```bash
      yc compute instance list
      ```

   1. Select the `ID` or `NAME` of the relevant VM.
   1. Set the metadata service settings using the `--metadata-options` parameter:

      ```bash
      yc compute instance update <VM_instance_ID> \
        --metadata-options gce-http-endpoint=enabled
      ```

- {{ TF }}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   1. Open the {{ TF }} configuration file and change the `metadata_options` parameter in the VM description:

      ```hcl
      ...
      resource "yandex_compute_instance" "test-vm" {
        metadata_options {
          gce-http-endpoint = "enabled"
        }
      }
      ...
      ```

      For more information about the `yandex_compute_instance` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/compute_instance).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

- API

   To set up the metadata service, use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/) resource.

{% endlist %}
