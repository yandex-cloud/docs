```yaml
name: group-for-load # The instance group name that must be unique within the folder.
service_account_id: ajeab0cnib1p******** # Service account ID.
allocation_policy: # VM allocation policy in the group.
   zones:
     - zone_id: {{ region-id }}-a
     - zone_id: {{ region-id }}-b
instance_template:
  service_account_id: ajeab0cnib1p******** # ID of the service account for access to private Docker images.
  platform_id: standard-v1 # Platform ID.
  resources_spec:
    memory: 2G # Amount of memory (RAM).
    cores: 2 # Number of processor cores (vCPUs).
  boot_disk_spec:
    mode: READ_WRITE # Disk access mode (read and write).
    disk_spec:
      image_id: <ID_of_the_latest_COI_version>
    type_id: network-ssd # Disk type.
    size: 30G # Disk size.
  network_interface_specs:
   - network_id: enplhg4nncc7******** # Network ID.
     subnet_ids:
       - e1lnabc23r1c******** # Subnet ID.
       - b1csa2b3clid********
     primary_v4_address_spec: {
       one_to_one_nat_spec: {
         ip_version: IPV4 # IPv4 specification for public access to the VM.
       }
     }
  metadata: # Values to be delivered to the VM metadata.
    docker-container-declaration: |- # Key in the VM metadata that is used with the Docker Container specification.
      spec:
        containers:
          - image: {{ registry }}/yc/demo/autoscaling-example-app:v1
            name: nginx
            securityContext:
              privileged: false
            restartPolicy: Always
            tty: false
            stdin: false
    ssh-keys: | # Parameter for sending an SSH key to the VM.
      yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Username for the VM connection.
deploy_policy: # Deployment policy for instances in the group.
  max_unavailable: 4
scale_policy: # Scaling policy for instances in the group.
  fixed_scale:
    size: 6
load_balancer_spec: # Network load balancer.
  target_group_spec:
    name: load-generator
```
