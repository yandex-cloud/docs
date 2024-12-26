Включите для ВМ авторизацию по {{ oslogin }} при подключении к серийной консоли, указав имя ВМ:

```bash
yc compute instance update \
  --name <имя_ВМ> \
  --serial-port-settings ssh-authorization=OS_LOGIN
```

Результат:

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
  ssh_authorization: OS_LOGIN
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

{% note info %}

{% include [serial-port-settings-default](serial-port-settings-default.md) %}

{% endnote %}