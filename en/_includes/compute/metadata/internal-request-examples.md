#### Getting an FQDN {#example1}

To get the full name of the VM ([FQDN](../../../compute/concepts/network.md#hostname)) from the [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute) folder, [connect](../../../compute/operations/vm-connect/ssh.md) to the VM and send the following request:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/hostname
```

#### Getting VM metadata in an easy-to-read format {#example2}

To get metadata in an easy-to-read format, [connect](../../../compute/operations/vm-connect/ssh.md) to the VM and send the following request using the [jq](https://stedolan.github.io/jq/) utility:

```bash
  curl \
    --header Metadata-Flavor:Google \
    169.254.169.254/computeMetadata/v1/instance/?recursive=true | \
    jq -r '.'
```

#### Getting an identity document {#example3}

To get an [identity document](../../../compute/concepts/metadata/identity-document.md) from the [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute) folder, [connect](../../../compute/operations/vm-connect/ssh.md) to the VM and send the following request:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
```

#### Getting data from the user-data folder {#example4}

To get the metadata from the [user-data](../../../compute/concepts/metadata/directories.md#dir-user) folder, [connect](../../../compute/operations/vm-connect/ssh.md) to the VM and send the following request:

```bash
curl \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data
```

The metadata service will return the response in YAML format:

```yaml
#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: no
users:
- name: admin
  sudo: ALL=(ALL) NOPASSWD:ALL
  shell: /bin/bash
  ssh_authorized_keys:
  - ssh-ed25519 AAAAC3Nza******l0pTWGO
```

If you want to get only a particular key (e.g., user name) in the output, use the [yq](https://github.com/mikefarah/yq) tool.

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/latest/user-data | \
  yq .users[].name
```

#### Getting an IAM token for a service account {#example5}

When sending [{{ yandex-cloud }} API](../../../api-design-guide/index.yaml) requests, you need an [IAM token](../../../iam/concepts/authorization/iam-token.md) issued for the [service account](../../../iam/concepts/users/service-accounts.md). You can obtain such an IAM token using the metadata service from within your VM. To do this, a service account must be [linked](../../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to the VM.

To get the IAM token from the [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute) folder, [connect](../../../compute/operations/vm-connect/ssh.md) to the VM and send the following request:

```bash
curl \
  --silent \
  --fail \
  --header Metadata-Flavor:Google \
  169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
  jq -r .access_token
```

#### Getting data from the user-data folder from outside the VM {#example6}

To get metadata from outside a VM, use the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) tool:

```bash
yc compute instance get my-vm --full --jq .metadata
```

The metadata service will return the response in JSON format:

```json
{
  "install-unified-agent": "0",
  "serial-port-enable": "0",
  "ssh-keys": "admin:ssh-ed25519 AAAAC3N******l0pTWGO admin@my.domain\n",
  "user-data": "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: admin\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-ed25519 AAAAC3N******l0pTWGO"
}
```

For more information on how to get the values of variables and [{{ lockbox-full-name }} secrets](../../../lockbox/concepts/secret.md) provided through metadata, see [{#T}](../../../compute/operations/vm-create/create-with-env-variables.md) and [{#T}](../../../compute/operations/vm-create/create-with-lockbox-secret.md).