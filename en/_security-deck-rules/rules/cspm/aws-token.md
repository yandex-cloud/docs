### Getting an IAM token through the metadata service in AWS IMDSv1 format is disabled on the VM {#aws-token}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | aws-token ||
|#

#### Description

Yandex Compute Cloud features a [metadata service](https://yandex.cloud/en/docs/compute/concepts/vm-metadata) for VM instances that provides info on their operation in the following formats:

- Google Compute Engine (some fields are not supported).
- Amazon EC2 (some fields are not supported).

Amazon EC2 Instance Metadata Service version 1 (`IMDSv1`) has a number of drawbacks. The most critical of them is the risk of a service account token getting compromised through the metadata service by means of a server-side request forgery (SSRF) attack. For more information, see the [official AWS blog](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/).

#### Guides and solutions to use

To [get](https://yandex.cloud/en/docs/compute/operations/vm-metadata/get-vm-metadata#example5) a service account's IAM token from within the VM, we recommend using metadata in Google Compute Engine format.

Make sure to disable getting an IAM token through the metadata service in `IMDSv1` format.

**Guides and solutions to use**:

For the VMs found in the `metadata_options` section, set [aws_v1_http_token](https://yandex.cloud/en/docs/compute/api-ref/grpc/Instance/update#yandex.cloud.compute.v1.MetadataOptions) to `DISABLED`:

```bash
yc compute instance update <VM_instance_ID_or_name> \
  --metadata-options aws-v1-http-token=DISABLED