# Getting information about a VM


To get basic information about each [VM](../../concepts/vm.md) you created, go to the [management console]({{ link-console-main }}) and open the VM page. To get detailed information with custom [metadata](../../concepts/vm-metadata.md), use the [CLI](../../../cli/) or API.

You can also get basic information and metadata [from inside a VM](#inside-instance).

## Getting information from outside a VM {#outside-instance}

{% list tabs group=instructions %}

- Management console {#console}

  On the **{{ ui-key.yacloud.compute.instances.label_title }}** page in the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** service, you can find a list of VMs in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) and brief information for each of them.

  For more information about a certain VM, click the line with its name.

  Tabs:
  * **{{ ui-key.yacloud.common.overview }}** shows general information about the VM, including the [IP addresses](../../../vpc/concepts/address.md) assigned to it.
  * **{{ ui-key.yacloud.compute.instance.switch_disks }}** provides information about the [disks](../../concepts/disk.md) attached to the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_file-storages }}** provides information about the [file storage](../../concepts/filesystem.md) attached.
  * **{{ ui-key.yacloud.common.operations-key-value }}** lists operations on the VM and resources attached to it, such as disks.
  * **{{ ui-key.yacloud.common.monitoring }}** shows information about resource consumption on the VM. You can only get this information from the management console or from inside the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_console }}** provides access to the [serial console](../../operations/serial-console/index.md) if enabled when [creating](../../operations/index.md#vm-create) the VM.
  * **{{ ui-key.yacloud.compute.instance.switch_service-console }}** provides information that the VM outputs to the serial port. To get this information via the API or CLI, use the [{#T}](get-serial-port-output.md) guide.

- CLI {#cli}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command for getting [serial port output](get-serial-port-output.md):

     ```bash
     yc compute instance get --help
     ```

  1. Select a VM, e.g., `first-instance`:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Get basic information about the VM:

     ```bash
     yc compute instance get first-instance
     ```

     To get VM information with metadata, use the `--full` flag:

     ```bash
     yc compute instance get --full first-instance
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

     ```hcl
     data "yandex_compute_instance" "my_instance" {
       instance_id = "<VM_ID>"
     }

     output "instance_external_ip" {
       value = "${data.yandex_compute_instance.my_instance.network_interface.0.nat_ip_address}"
     }
     ```

     Where:
     * `data "yandex_compute_instance"`: Description of the data source to get VM information from:
       * `instance_id`: VM ID.
     * `output "instance_external_ip"`: [Public IP address](../../../vpc/concepts/address.md#public-addresses) of the VM to output:
       * `value`: Returned value.

     For more information about the `yandex_compute_instance` data source parameters, see the [provider documentation]({{ tf-provider-datasources-link }}/datasource_compute_instance).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

     ```bash
     terraform output instance_external_ip
     ```

     Result:

     ```text
     instance_external_ip = "158.160.50.228"
     ```

- API {#api}

  To get basic information about a VM, use the [get](../../api-ref/Instance/get.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Get](../../api-ref/grpc/Instance/get.md) gRPC API call.

  The basic information does not include the user-defined metadata provided when creating or [updating](../../operations/vm-control/vm-update.md) the VM. To get the information along with the metadata, specify `view=FULL` in the parameters.

{% endlist %}

## Getting information from inside a VM {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### Google Compute Engine {#gce-metadata}

The {{ yandex-cloud }} metadata service allows you to return metadata in Google Compute Engine format.

#### HTTP request {#gce-http}

```http request
GET http://169.254.169.254/computeMetadata/v1/instance/
  ? alt=<json|text>
  & recursive=<true|false>
  & wait_for_change=<true|false>
  & last_etag=<string>
  & timeout_sec=<int>
Metadata-Flavor: Google
```

Where:
* `alt`: Response format (by default, `text`).
* `recursive`: If `true`, it returns all values in the tree recursively. The default value is `false`.
* `wait_for_change`: If `true`, this response will be returned only when one of the metadata parameters is modified. The default value is `false`.
* `last_etag`: The ETag value from the previous response to a similar request. Use if `wait_for_change="true"`.
* `timeout_sec`: Maximum request timeout. Use if `wait_for_change="true"`.

#### Request examples {#request-examples}

Find out the ID of a VM from inside it:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/id
```

Get metadata in JSON format:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/?recursive=true
```

Get metadata in an easy-to-read format. Use the [jq](https://stedolan.github.io/jq/) utility:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/?recursive=true | \
  jq -r '.'
```

Getting an [identity document](../../concepts/vm-metadata.md#identity-document):

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### List of returned elements {#list-of-returned-items}

List of elements available for this request:
* `attributes/`: User-defined metadata provided in the `metadata` field when creating or updating the VM.
* `attributes/ssh-keys`: List of public SSH keys provided in the `metadata` field through the `ssh-keys` value when creating the VM.
* `description`: Text description provided when creating or updating the VM.
* `disks/`: Disks attached to the VM.
* `hostname`: [FQDN](../../concepts/network.md#hostname) assigned to the VM.
* `id`: VM ID. The ID is generated automatically when the VM is being created and is unique within {{ yandex-cloud }}.
* `name`: Name provided when creating or updating the VM.
* `networkInterfaces/`: Network interfaces connected to the VM.
* `service-accounts`: [Service accounts](../../../iam/concepts/users/service-accounts.md) linked to the VM.
* `service-accounts/default/token`: [{{ iam-full-name }} token](../../../iam/concepts/authorization/iam-token.md) of the linked service account.

Other elements, such as `project`, which are used for backward compatibility and remain empty.

### Amazon EC2 {#ec2-metadata}

The {{ yandex-cloud }} metadata service allows you to return metadata in Amazon EC2 format. This format has no support for user-defined metadata fields.

#### HTTP request {#ec2-http}

```http request
GET http://169.254.169.254/latest/meta-data/<element>
```

Where `<element>` is the path to the element you want to get. If the element is omitted, the response returns a list of available elements.

#### List of returned elements {#list-of-returned-items}

List of elements that are available for this request.

{% note info %}

The angle brackets contain parameters to replace with values. For example, instead of `<MAC_address>`, you should specify the MAC address of the network interface.

{% endnote %}

* `hostname`: Host name assigned to VM.
* `instance-id`: VM ID.
* `local-ipv4`: [Internal IPv4 address](../../../vpc/concepts/address.md#internal-addresses).
* `local-hostname`: Host name assigned to VM.
* `mac`: MAC address of VM network interface.
* `network/interfaces/macs/<MAC_address>/ipv6s`: Internal IPv6 addresses associated with the network interface.
* `network/interfaces/macs/<MAC_address>/local-hostname`: Host name associated with the network interface.
* `network/interfaces/macs/<MAC_address>/local-ipv4s`: Internal IPv4 addresses associated with the network interface.
* `network/interfaces/macs/<MAC_address>/mac`: MAC address of the VM network interface.
* `public-ipv4`: [Public IPv4 address](../../../vpc/concepts/address.md#public-addresses).

#### Request examples {#request-examples}

Getting an internal IP address from inside a VM:

```bash
curl http://169.254.169.254/latest/meta-data/local-ipv4
```

Getting an [identity document](../../concepts/vm-metadata.md#identity-document):

```bash
curl http://169.254.169.254/latest/vendor/instance-identity/document
```

## Setting up metadata service parameters for a VM instance {#metadata-options}

You can set up metadata service parameters when creating or updating VMs.

You can use the following settings:
* `aws-v1-http-endpoint`: Provides access to metadata using AWS format (IMDSv1). Possible values: `enabled`, `disabled`.
* `aws-v1-http-token`: Provides access to [{{ iam-name }}](../../../iam/) credentials using AWS format (IMDSv1). Possible values: `enabled`, `disabled`.

  {% note info %}

  The IMDSv1 format has a number of security flaws; therefore, the `aws-v1-http-token` parameter is `disabled` by default. The most severe drawback of IMDSv1 is its high risk of certain attacks, e.g., [SSRF](https://portswigger.net/web-security/ssrf). You can read more about it in the [AWS official blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). To change the default behavior of this parameter, contact [support]({{ link-console-support }}).

  The safest method to obtain the token in {{ yandex-cloud }} is to use [Google Compute Engine](#gce-metadata) format, which uses an extra header for protection against SSRF.

  {% endnote %}

* `gce-http-endpoint`: Provides access to metadata using Google Compute Engine format. Possible values: `enabled`, `disabled`.
* `gce-http-token`: Provides access to {{ iam-name }} credentials using Google Compute Engine format. Possible values: `enabled`, `disabled`.

To set up metadata service parameters for a VM instance:

{% list tabs group=instructions %}

- CLI {#cli}

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

  1. Select the `ID` or `NAME` of the VM.
  1. Set the metadata service settings using the `--metadata-options` parameter:

     ```bash
     yc compute instance update <VM_ID> \
       --metadata-options gce-http-endpoint=enabled
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  1. Open the {{ TF }} configuration file and change the `metadata_options` parameter in the VM description:

     ```hcl
     ...
     resource "yandex_compute_instance" "test-vm" {
       ...
       metadata_options {
         aws_v1_http_endpoint = 2
         aws_v1_http_token    = 2
         gce_http_endpoint    = 0
         gce_http_token       = 0
       }
       ...
     }
     ...
     ```

     Where:
     * `yandex_compute_instance`: VM description.
       * `metadata_options`: Metadata parameters:
         * `aws_v1_http_endpoint`: Provides access to metadata using AWS format (IMDSv1). Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
         * `aws_v1_http_token`: Provides access to {{ iam-name }} credentials using AWS format (IMDSv1). Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
         * `gce_http_endpoint`: Provides access to metadata using Google Compute Engine format. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.
         * `gce_http_token`: Provides access to {{ iam-name }} credentials using Google Compute Engine format. Possible values: `0`, `1` for `enabled` and `2` for `disabled`.

     For more information about the `yandex_compute_instance` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).
  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     All the resources you need will then be created in the specified folder with the settings you defined. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc compute instance get <VM_name>
     ```

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call.

{% endlist %}

### Removing SSH keys from metadata {#delete-keys-from-metadata}

{% include [delete-keys-from-metadata](../../../_includes/compute/delete-keys-from-metadata.md) %}