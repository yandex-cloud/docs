```yaml
name: vm-scale-scheduled-ig
service_account_id: <service_ account_ID>
allocation_policy:
   zones:
     - zone_id: {{ region-id }}-a
     - zone_id: {{ region-id }}-b
instance_template:
  platform_id: standard-v3
  resources_spec:
    memory: 2G
    cores: 2
    core_fraction: 20
  boot_disk_spec:
    mode: READ_WRITE
    disk_spec:
      type_id: network-hdd
      size: 15G
      image_id: <ID_of_Ubuntu_20.04_LTS_latest_version>
  network_interface_specs:
   - network_id: <network_ID>
     subnet_ids:
       - <subnet_ID_in_{{ region-id }}-a_zone>
       - <subnet_ID_in_{{ region-id }}-b_zone>
     primary_v4_address_spec: {}
scale_policy:
  fixed_scale:
    size: 2
deploy_policy:
  max_unavailable: 2
  max_creating: 2
  max_expansion: 2
  max_deleting: 2
```
