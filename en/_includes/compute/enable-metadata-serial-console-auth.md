Enable metadata authorization when connecting to the serial console:

```bash
yc compute instance update <VM_name_or_ID> \
  --serial-port-settings ssh-authorization=INSTANCE_METADATA \
  --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<username>:<public_SSH_key>'
```

Where:
* `<VM_name_or_ID>`: To learn how to find out the VM name or ID, see [{#T}](../../compute/operations/vm-info/get-info.md).
* `--metadata`: VM [metadata](../../compute/concepts/vm-metadata.md):

    * `ssh-keys`: Name of the local VM user and the contents of the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) that will allow this user to connect to the VM over SSH.

Result:

```yaml
done (6s)
id: fhm0b28lgfp4********
folder_id: b1g9d2k0itu4********
created_at: "2024-03-28T19:53:23Z"
name: first-instance
zone_id: {{ region-id }}-a
platform_id: standard-v3
resources:
  memory: "1073741824"
  cores: "2"
  core_fraction: "20"
status: RUNNING
metadata_options:
  gce_http_endpoint: ENABLED
  aws_v1_http_endpoint: ENABLED
  gce_http_token: ENABLED
  aws_v1_http_token: DISABLED
boot_disk:
  mode: READ_WRITE
  device_name: epdu3ce920e7********
  auto_delete: true
  disk_id: epdu3ce920e7********
network_interfaces:
  - index: "0"
    mac_address: d0:0d:5c:**:**:**
    subnet_id: e2luhnr3rhf8********
    primary_v4_address:
      address: 192.168.1.21
      one_to_one_nat:
        address: 51.250.***.***
        ip_version: IPV4
    security_group_ids:
      - enpjauvetqfb********
serial_port_settings:
  ssh_authorization: INSTANCE_METADATA
gpu_settings: {}
fqdn: sample-vm.{{ region-id }}.internal
scheduling_policy:
  preemptible: true
network_settings:
  type: STANDARD
placement_policy: {}
hardware_generation:
  legacy_features:
    pci_topology: PCI_TOPOLOGY_V1
```

For more information about the `yc compute instance update` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/instance/update.md).

{% note info %}

{% include [serial-port-settings-default](serial-port-settings-default.md) %}

{% endnote %}