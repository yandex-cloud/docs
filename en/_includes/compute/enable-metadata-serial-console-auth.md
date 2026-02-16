Specify the VM name and enable metadata authorization when connecting to the serial console:

```bash
yc compute instance update \
  --name <VM_name> \
  --serial-port-settings ssh-authorization=INSTANCE_METADATA
```

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

{% include [serial-port-settings-default](serial-port-settings-default.md) %}