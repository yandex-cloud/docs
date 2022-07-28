```yaml
name: vm-scale-scheduled-ig
service_account_id: <идентификатор_сервисного_аккаунта>
allocation_policy:
   zones:
     - zone_id: ru-central1-a
     - zone_id: ru-central1-b
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
      image_id: <идентификатор_последней_версии_Ubuntu_20.04_LTS>
  network_interface_specs:
   - network_id: <идентификатор_сети>
     subnet_ids:
       - <идентификатор_подсети_в_зоне_ru-central1-a>
       - <идентификатор_подсети_в_зоне_ru-central1-b>
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