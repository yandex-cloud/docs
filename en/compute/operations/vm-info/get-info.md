# Getting information about a VM

To get basic information about each [VM](../../concepts/vm.md) you created, go to the [management console]({{ link-console-main }}) and open the VM page. To get detailed information with user-defined [metadata](../../concepts/vm-metadata.md), use the CLI or API.

You can also get basic information and metadata from [inside a VM](#inside-instance).

## Getting information from outside a VM {#outside-instance}

{% list tabs %}

- Management console

   On the **{{ ui-key.yacloud.compute.instances.label_title }}** page in the **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** service, you can find a list of VMs in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) and brief information for each of them.

   For more information about a certain VM, click the line with its name.

   Tabs:
   * **{{ ui-key.yacloud.compute.instance.switch_overview }}** shows general information about the VM, including the [IP addresses](../../../vpc/concepts/address.md) assigned to it.
   * **{{ ui-key.yacloud.compute.instance.switch_disks }}** provides information about the [disks](../../concepts/disk.md) attached to the VM.

   
   * **{{ ui-key.yacloud.compute.instance.switch_file-storages }}** provides information about the [file storage](../../concepts/filesystem.md) attached.


   * **{{ ui-key.yacloud.compute.instance.switch_operations }}** lists operations on the VM and resources attached to it, such as disks.
   * **{{ ui-key.yacloud.compute.instance.switch_monitoring }}** shows information about resource consumption on the VM. You can only get this information from the management console or from inside the VM.
   * **{{ ui-key.yacloud.compute.instance.switch_console }}** provides access to the [serial console](../../operations/serial-console/index.md) if enabled when [creating](../../operations/index.md#vm-create) the VM.
   * **{{ ui-key.yacloud.compute.instance.switch_service-console }}** provides information that the VM outputs to the serial port. To get this information via the API or CLI, follow the [{#T}](get-serial-port-output.md) guide.

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the command to get [serial port output](get-serial-port-output.md):

      ```bash
      yc compute instance get --help
      ```

   1. Select a VM, such as `first-instance`:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Get basic information about the VM:

      ```bash
      yc compute instance get first-instance
      ```

      To get VM information with metadata, use the `--full` flag:

      ```bash
      yc compute instance get --full first-instance
      ```

- API

   To get basic information about a VM, use the [get](../../api-ref/Instance/get.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Get](../../api-ref/grpc/instance_service.md#Get) gRPC API call.

   The basic information does not include the user-defined metadata provided when creating or [updating](../../operations/vm-control/vm-update.md) the VM. To get the information along with the metadata, specify `view=FULL` in the parameters.

{% endlist %}

## Getting information from inside a VM {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### Google Compute Engine {#gce-metadata}

The {{ yandex-cloud }} metadata service lets you return metadata in Google Compute Engine format.

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
* `recursive`: If `true`, it returns all values in the tree recursively. By default, `false`.
* `wait_for_change`: If `true`, this response is only returned when one of the metadata parameters is modified. By default, `false`.
* `last_etag`: The ETag value from the previous response to a similar request. Use it when `wait_for_change="true"`.
* `timeout_sec`: Maximum request timeout. Use it when `wait_for_change="true"`.

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

Getting an [identity document](../../concepts/vm-metadata.md#identity-document):

```
curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### List of returned elements {#list-of-returned-items}

List of elements available for this request:
* `attributes/`: User-defined metadata provided in the `metadata` field when creating or updating the VM.
* `attributes/ssh-keys`: List of public SSH keys provided in the `metadata` field through the `ssh-keys` value when creating the VM.
* `description`: Text description provided when creating or updating the VM.
* `disks/`: Disks attached to the VM.
* `hostname`: [FQDN](../../concepts/network.md#hostname) assigned to the VM.
* `id`: VM ID. The ID is generated automatically when the VM is being created and is unique within {{ yandex-cloud }}.
* `name`: Name that was provided when creating or updating the VM.
* `networkInterfaces/`: Network interfaces connected to the VM.
* `service-accounts`: [Service accounts](../../../iam/concepts/users/service-accounts.md) linked to the VM.
* `service-accounts/default/token`: [{{ iam-full-name }} token](../../../iam/concepts/authorization/iam-token.md) of the linked service account.

Other elements, such as `project`, which are used for backward compatibility and remain empty.

### Amazon EC2 {#ec2-metadata}

The {{ yandex-cloud }} metadata service lets you return metadata in Amazon EC2 format.

 This format has no support for user-defined metadata fields.

#### HTTP request {#ec2-http}

```http request
GET http://169.254.169.254/latest/meta-data/<element>
```

Where `<element>` stands for the path to the element you want to get. If the element is omitted, the response returns a list of available elements.

#### List of returned elements {#list-of-returned-items}

List of elements that are available for this request.

{% note info %}

The angle brackets contain parameters that need to be replaced with values. For example, instead of `<mac>`, you should insert the MAC address of the network interface.

{% endnote %}

* `hostname`: VM's hostname.
* `instance-id`: VM ID.
* `local-ipv4`: [Internal IPv4 address](../../../vpc/concepts/address.md#internal-addresses).
* `local-hostname`: VM's hostname.
* `mac`: MAC address of the VM's network interface.
* `network/interfaces/macs/<mac>/ipv6s`: Internal IPv6 addresses associated with the network interface.
* `network/interfaces/macs/<mac>/local-hostname`: Hostname associated with the network interface.
* `network/interfaces/macs/<mac>/local-ipv4s`: Internal IPv4 addresses associated with the network interface.
* `network/interfaces/macs/<mac>/mac`: MAC address of the VM's network interface.
* `public-ipv4`: [External IPv4 address](../../../vpc/concepts/address.md#public-addresses).

#### Request examples {#request-examples}

Getting an internal IP address from inside a VM:

```
curl http://169.254.169.254/latest/meta-data/local-ipv4
```

Getting an [identity document](../../concepts/vm-metadata.md#identity-document):

```
curl http://169.254.169.254/latest/vendor/instance-identity/document
```

## Setting up metadata service parameters for a VM instance {#metadata-options}

You can set up metadata service parameters when creating or updating VMs.

You can use the following settings:
* `aws-v1-http-endpoint` provides access to metadata using AWS format (IMDSv1). Acceptable values: `enabled`, `disabled`.
* `aws-v1-http-endpoint` provides access to {{ iam-name }} credentials using AWS format (IMDSv1). Acceptable values: `enabled`, `disabled`.

   {% note info %}

   The IMDSv1 format has certain drawbacks in terms of security, which is why the `aws-v1-http-token` parameter is `disabled` by default. The most severe drawback of IMDSv1 is its high risk of certain attacks, e.g., [SSRF](https://portswigger.net/web-security/ssrf). You can read more about it in the [AWS official blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/). To change the default behavior of this parameter, contact [support]({{ link-console-support }}).

   The safest method to obtain the token in {{ yandex-cloud }} is to use [Google Compute Engine](#gce-metadata) format, which uses an extra header for protection against SSRF.

   {% endnote %}

* `gce-http-endpoint` provides access to metadata using Google Compute Engine format. Acceptable values: `enabled`, `disabled`.
* `gce-http-token` provides access to {{ iam-name }} credentials using Google Compute Engine format. Acceptable values: `enabled`, `disabled`.

To set up metadata service parameters for a VM instance:

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

   1. Select the `ID` or `NAME` of the relevant VM instance.
   1. Set the metadata service settings using the `--metadata-options` parameter:

      ```bash
      yc compute instance update <VM instance ID> \
        --metadata-options gce-http-endpoint=enabled
      ```

- API

   Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/instance_service.md#Update) gRPC API call.

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

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
      * `yandex_compute_instance`: Description of the VM:
         * `metadata_options`: Metadata parameters:
            * `aws_v1_http_endpoint` provides access to metadata using AWS format (IMDSv1). Possible values: `0` and `1`: `enabled`, `2`: `disabled`.
            * `aws_v1_http_token` provides access to {{ iam-name }} credentials using AWS format (IMDSv1). Possible values: `0` and `1`: `enabled`, `2`: `disabled`.
            * `gce_http_endpoint` provides access to metadata using Google Compute Engine format. Possible values: `0` and `1`: `enabled`, `2`: `disabled`.
            * `gce_http_token` provides access to {{ iam-name }} credentials using Google Compute Engine format. Possible values: `0` and `1`: `enabled`, `2`: `disabled`.

      For more information about the `yandex_compute_instance` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/compute_instance).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder with the settings you defined. You can check the new resources and their configuration using the [management console]({{ link-console-main }}) or this CLI command:

      ```bash
      yc compute instance get <VM_name>
      ```

{% endlist %}