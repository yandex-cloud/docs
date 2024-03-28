---
editable: false
---

# yc compute

Manage Yandex Compute Cloud resources

#### Command Usage

Syntax: 

`yc compute <group|command>`

#### Command Tree

- [yc compute connect-to-serial-port](connect-to-serial-port.md) — Connect to serial port
- [yc compute instance](instance/index.md) — Manage virtual machine instances
	- [yc compute instance get](instance/get.md) — Show information about the specified virtual machine instance
	- [yc compute instance list](instance/list.md) — List virtual machine instances
	- [yc compute instance create](instance/create.md) — Create a virtual machine instance
	- [yc compute instance create-with-container](instance/create-with-container.md) — Create a virtual machine instance running Docker container
	- [yc compute instance update](instance/update.md) — Update the specified virtual machine instance
	- [yc compute instance update-container](instance/update-container.md) — Update the specified virtual machine instance running Docker container
	- [yc compute instance add-metadata](instance/add-metadata.md) — Add or update metadata for the specified virtual machine instance
	- [yc compute instance remove-metadata](instance/remove-metadata.md) — Remove keys from metadata for the specified virtual machine instance
	- [yc compute instance add-labels](instance/add-labels.md) — Add labels to specified virtual machine instance
	- [yc compute instance remove-labels](instance/remove-labels.md) — Remove labels from specified virtual machine instance
	- [yc compute instance delete](instance/delete.md) — Delete the specified virtual machine instance
	- [yc compute instance get-serial-port-output](instance/get-serial-port-output.md) — Return the serial port output of the specified virtual machine instance
	- [yc compute instance stop](instance/stop.md) — Stop the specified virtual machine instance
	- [yc compute instance start](instance/start.md) — Start the specified virtual machine instance
	- [yc compute instance restart](instance/restart.md) — Restart the specified virtual machine instance
	- [yc compute instance simulate-maintenance-event](instance/simulate-maintenance-event.md) — Simulate a maintenance event (maintenance policy must be set)
	- [yc compute instance attach-disk](instance/attach-disk.md) — Attach existing disk to the specified virtual machine instance
	- [yc compute instance detach-disk](instance/detach-disk.md) — Detach disk from the specified virtual machine instance
	- [yc compute instance attach-filesystem](instance/attach-filesystem.md) — Attach existing filesystem to the specified virtual machine instance
	- [yc compute instance detach-filesystem](instance/detach-filesystem.md) — Detach filesystem from the specified virtual machine instance
	- [yc compute instance update-network-interface](instance/update-network-interface.md) — Update the specified network interface of virtual machine instance
	- [yc compute instance attach-network-interface](instance/attach-network-interface.md) — Attach the specified network interface to the virtual machine instance
	- [yc compute instance detach-network-interface](instance/detach-network-interface.md) — Detach the specified network interface from the virtual machine instance
	- [yc compute instance add-one-to-one-nat](instance/add-one-to-one-nat.md) — Add one-to-one NAT to the specified network interface of virtual machine instance
	- [yc compute instance remove-one-to-one-nat](instance/remove-one-to-one-nat.md) — Remove one-to-one NAT to the specified network interface of virtual machine instance
	- [yc compute instance move](instance/move.md) — Move the specified virtual machine instance into the folder
	- [yc compute instance relocate](instance/relocate.md) — Relocate the specified virtual machine instance to the zone
	- [yc compute instance list-operations](instance/list-operations.md) — List operations for the specified instance
	- [yc compute instance list-access-bindings](instance/list-access-bindings.md) — List access bindings for the specified instance
	- [yc compute instance set-access-bindings](instance/set-access-bindings.md) — Set access bindings for the specified instance and delete all existing access bindings if there were any
	- [yc compute instance add-access-binding](instance/add-access-binding.md) — Add access binding for the specified instance
	- [yc compute instance remove-access-binding](instance/remove-access-binding.md) — Remove access binding for the specified instance
- [yc compute disk](disk/index.md) — Manage disks
	- [yc compute disk get](disk/get.md) — Show information about the specified disk
	- [yc compute disk list](disk/list.md) — List disks
	- [yc compute disk create](disk/create.md) — Create a disk
	- [yc compute disk update](disk/update.md) — Update the specified disk
	- [yc compute disk add-labels](disk/add-labels.md) — Add labels to specified disk
	- [yc compute disk remove-labels](disk/remove-labels.md) — Remove labels from specified disk
	- [yc compute disk resize](disk/resize.md) — Resize the specified disk
	- [yc compute disk delete](disk/delete.md) — Delete the specified disk
	- [yc compute disk move](disk/move.md) — Move the specified disk into the folder
	- [yc compute disk relocate](disk/relocate.md) — Relocate the specified disk to the zone
	- [yc compute disk list-operations](disk/list-operations.md) — List operations for the specified disk
	- [yc compute disk list-access-bindings](disk/list-access-bindings.md) — List access bindings for the specified disk
	- [yc compute disk set-access-bindings](disk/set-access-bindings.md) — Set access bindings for the specified disk and delete all existing access bindings if there were any
	- [yc compute disk add-access-binding](disk/add-access-binding.md) — Add access binding for the specified disk
	- [yc compute disk remove-access-binding](disk/remove-access-binding.md) — Remove access binding for the specified disk
- [yc compute disk-type](disk-type/index.md) — Show available disk types
	- [yc compute disk-type get](disk-type/get.md) — Show information about the specified disk type
	- [yc compute disk-type list](disk-type/list.md) — List disk types
- [yc compute image](image/index.md) — Manage images
	- [yc compute image get](image/get.md) — Show information about the specified image
	- [yc compute image list](image/list.md) — List images
	- [yc compute image get-latest-from-family](image/get-latest-from-family.md) — Show information about the latest image that is part of an image family
	- [yc compute image create](image/create.md) — Create an image
	- [yc compute image update](image/update.md) — Update the specified image
	- [yc compute image add-labels](image/add-labels.md) — Add labels to specified image
	- [yc compute image remove-labels](image/remove-labels.md) — Remove labels from specified image
	- [yc compute image delete](image/delete.md) — Delete the specified image
	- [yc compute image list-operations](image/list-operations.md) — List operations for the specified image
	- [yc compute image list-access-bindings](image/list-access-bindings.md) — List access bindings for the specified image
	- [yc compute image set-access-bindings](image/set-access-bindings.md) — Set access bindings for the specified image and delete all existing access bindings if there were any
	- [yc compute image add-access-binding](image/add-access-binding.md) — Add access binding for the specified image
	- [yc compute image remove-access-binding](image/remove-access-binding.md) — Remove access binding for the specified image
- [yc compute snapshot](snapshot/index.md) — Manage snapshots
	- [yc compute snapshot get](snapshot/get.md) — Show information about the specified snapshot
	- [yc compute snapshot list](snapshot/list.md) — List snapshots
	- [yc compute snapshot create](snapshot/create.md) — Create a snapshot of the specified disk
	- [yc compute snapshot update](snapshot/update.md) — Update the specified snapshot
	- [yc compute snapshot add-labels](snapshot/add-labels.md) — Add labels to specified snapshot
	- [yc compute snapshot remove-labels](snapshot/remove-labels.md) — Remove labels from specified snapshot
	- [yc compute snapshot delete](snapshot/delete.md) — Delete the specified snapshot
	- [yc compute snapshot list-operations](snapshot/list-operations.md) — List operations for the specified snapshot
	- [yc compute snapshot list-access-bindings](snapshot/list-access-bindings.md) — List access bindings for the specified snapshot
	- [yc compute snapshot set-access-bindings](snapshot/set-access-bindings.md) — Set access bindings for the specified snapshot and delete all existing access bindings if there were any
	- [yc compute snapshot add-access-binding](snapshot/add-access-binding.md) — Add access binding for the specified snapshot
	- [yc compute snapshot remove-access-binding](snapshot/remove-access-binding.md) — Remove access binding for the specified snapshot
- [yc compute snapshot-schedule](snapshot-schedule/index.md) — Manage snapshot schedules
	- [yc compute snapshot-schedule get](snapshot-schedule/get.md) — Show information about the specified snapshot schedule
	- [yc compute snapshot-schedule list](snapshot-schedule/list.md) — List snapshot schedules
	- [yc compute snapshot-schedule create](snapshot-schedule/create.md) — Create a snapshot schedule
	- [yc compute snapshot-schedule disable](snapshot-schedule/disable.md) — Disable the specified snapshot schedule
	- [yc compute snapshot-schedule enable](snapshot-schedule/enable.md) — Enable the specified snapshot schedule
	- [yc compute snapshot-schedule update](snapshot-schedule/update.md) — Update the specified snapshot schedule
	- [yc compute snapshot-schedule add-disks](snapshot-schedule/add-disks.md) — Add disks to the specified snapshot schedule
	- [yc compute snapshot-schedule remove-disks](snapshot-schedule/remove-disks.md) — Remove disks from the specified snapshot schedule
	- [yc compute snapshot-schedule add-labels](snapshot-schedule/add-labels.md) — Add labels to specified snapshot schedule
	- [yc compute snapshot-schedule remove-labels](snapshot-schedule/remove-labels.md) — Remove labels from specified snapshot schedule
	- [yc compute snapshot-schedule delete](snapshot-schedule/delete.md) — Delete the specified snapshot schedule
	- [yc compute snapshot-schedule list-operations](snapshot-schedule/list-operations.md) — List operations for the specified snapshot schedule
	- [yc compute snapshot-schedule list-disks](snapshot-schedule/list-disks.md) — List disks attached to the specified snapshot schedule
	- [yc compute snapshot-schedule list-snapshots](snapshot-schedule/list-snapshots.md) — List snapshots created by specified snapshot schedule
	- [yc compute snapshot-schedule list-access-bindings](snapshot-schedule/list-access-bindings.md) — List access bindings for the specified snapshot schedule
	- [yc compute snapshot-schedule set-access-bindings](snapshot-schedule/set-access-bindings.md) — Set access bindings for the specified snapshot schedule and delete all existing access bindings if there were any
	- [yc compute snapshot-schedule add-access-binding](snapshot-schedule/add-access-binding.md) — Add access binding for the specified snapshot schedule
	- [yc compute snapshot-schedule remove-access-binding](snapshot-schedule/remove-access-binding.md) — Remove access binding for the specified snapshot schedule
- [yc compute zone](zone/index.md) — Show availability zones
	- [yc compute zone get](zone/get.md) — Show information about the specified availability zone.
	- [yc compute zone list](zone/list.md) — List availability zones
- [yc compute instance-group](instance-group/index.md) — Manage instance groups
	- [yc compute instance-group get](instance-group/get.md) — Show information about the specified instance group
	- [yc compute instance-group list](instance-group/list.md) — List instance groups
	- [yc compute instance-group create](instance-group/create.md) — Create an instance group
	- [yc compute instance-group update](instance-group/update.md) — Update the specified instance group
	- [yc compute instance-group stop](instance-group/stop.md) — Stop the specified instance group
	- [yc compute instance-group start](instance-group/start.md) — Start the specified instance group
	- [yc compute instance-group add-metadata](instance-group/add-metadata.md) — Add or update metadata for instance template of the specified instance group
	- [yc compute instance-group remove-metadata](instance-group/remove-metadata.md) — Remove keys from metadata for instance template of the specified instance group
	- [yc compute instance-group add-labels](instance-group/add-labels.md) — Add labels to specified instance group
	- [yc compute instance-group remove-labels](instance-group/remove-labels.md) — Remove labels from specified instance group
	- [yc compute instance-group delete](instance-group/delete.md) — Delete the specified instance group
	- [yc compute instance-group list-instances](instance-group/list-instances.md) — List instances of the specified instance group
	- [yc compute instance-group stop-instances](instance-group/stop-instances.md) — Stop instances of the specified instance group
	- [yc compute instance-group delete-instances](instance-group/delete-instances.md) — Delete instances of the specified instance group
	- [yc compute instance-group list-operations](instance-group/list-operations.md) — List operations for the specified instance group
	- [yc compute instance-group list-logs](instance-group/list-logs.md) — List logs for the specified instance group
	- [yc compute instance-group list-access-bindings](instance-group/list-access-bindings.md) — List access bindings for the specified instance group
	- [yc compute instance-group set-access-bindings](instance-group/set-access-bindings.md) — Set access bindings for the specified instance group and delete all existing access bindings if there were any
	- [yc compute instance-group add-access-binding](instance-group/add-access-binding.md) — Add access binding for the specified instance group
	- [yc compute instance-group remove-access-binding](instance-group/remove-access-binding.md) — Remove access binding for the specified instance group
	- [yc compute instance-group rolling-restart](instance-group/rolling-restart.md) — Restart instances of the specified instance group respecting policies
	- [yc compute instance-group rolling-recreate](instance-group/rolling-recreate.md) — Recreate instances of the specified instance group respecting policies
- [yc compute placement-group](placement-group/index.md) — Manage placement groups
	- [yc compute placement-group get](placement-group/get.md) — Show information about the specified placement group
	- [yc compute placement-group list](placement-group/list.md) — List placement groups
	- [yc compute placement-group create](placement-group/create.md) — Create a placement group
	- [yc compute placement-group update](placement-group/update.md) — Update the specified placement group
	- [yc compute placement-group add-labels](placement-group/add-labels.md) — Add labels to the specified placement group
	- [yc compute placement-group remove-labels](placement-group/remove-labels.md) — Remove labels from the specified placement group
	- [yc compute placement-group delete](placement-group/delete.md) — Delete the specified placement group
	- [yc compute placement-group list-instances](placement-group/list-instances.md) — List instances of the specified placement group
	- [yc compute placement-group list-operations](placement-group/list-operations.md) — List operations for the specified placement group
	- [yc compute placement-group list-access-bindings](placement-group/list-access-bindings.md) — List access bindings for the specified placement group
	- [yc compute placement-group set-access-bindings](placement-group/set-access-bindings.md) — Set access bindings for the specified placement group and delete all existing access bindings if there were any
	- [yc compute placement-group add-access-binding](placement-group/add-access-binding.md) — Add access binding for the specified placement group
	- [yc compute placement-group remove-access-binding](placement-group/remove-access-binding.md) — Remove access binding for the specified placement group
- [yc compute host-type](host-type/index.md) — Show available host types
	- [yc compute host-type get](host-type/get.md) — Show information about the specified host type
	- [yc compute host-type list](host-type/list.md) — List host types
- [yc compute host-group](host-group/index.md) — Manage host groups
	- [yc compute host-group get](host-group/get.md) — Show information about the specified host group
	- [yc compute host-group list](host-group/list.md) — List host groups
	- [yc compute host-group create](host-group/create.md) — Create a host group
	- [yc compute host-group update](host-group/update.md) — Update the specified host group
	- [yc compute host-group add-labels](host-group/add-labels.md) — Add labels to the specified host group
	- [yc compute host-group remove-labels](host-group/remove-labels.md) — Remove labels from the specified host group
	- [yc compute host-group delete](host-group/delete.md) — Delete the specified host group
	- [yc compute host-group list-hosts](host-group/list-hosts.md) — List hosts of the specified host group
	- [yc compute host-group update-host](host-group/update-host.md) — Update host of the specified host group
	- [yc compute host-group list-instances](host-group/list-instances.md) — List instances of the specified host group
	- [yc compute host-group list-operations](host-group/list-operations.md) — List operations for the specified host group
	- [yc compute host-group list-access-bindings](host-group/list-access-bindings.md) — List access bindings for the specified host group
	- [yc compute host-group set-access-bindings](host-group/set-access-bindings.md) — Set access bindings for the specified host group and delete all existing access bindings if there were any
	- [yc compute host-group add-access-binding](host-group/add-access-binding.md) — Add access binding for the specified host group
	- [yc compute host-group remove-access-binding](host-group/remove-access-binding.md) — Remove access binding for the specified host group
- [yc compute disk-placement-group](disk-placement-group/index.md) — Manage disk placement groups
	- [yc compute disk-placement-group get](disk-placement-group/get.md) — Show information about the specified disk placement group
	- [yc compute disk-placement-group list](disk-placement-group/list.md) — List disk placement groups
	- [yc compute disk-placement-group create](disk-placement-group/create.md) — Create a disk placement group
	- [yc compute disk-placement-group update](disk-placement-group/update.md) — Update the specified disk placement group
	- [yc compute disk-placement-group add-labels](disk-placement-group/add-labels.md) — Add labels to the specified disk placement group
	- [yc compute disk-placement-group remove-labels](disk-placement-group/remove-labels.md) — Remove labels from the specified disk placement group
	- [yc compute disk-placement-group delete](disk-placement-group/delete.md) — Delete the specified disk placement group
	- [yc compute disk-placement-group list-disks](disk-placement-group/list-disks.md) — List disks of the specified disk placement group
	- [yc compute disk-placement-group list-operations](disk-placement-group/list-operations.md) — List operations for the specified disk placement group
	- [yc compute disk-placement-group list-access-bindings](disk-placement-group/list-access-bindings.md) — List access bindings for the specified disk placement group
	- [yc compute disk-placement-group set-access-bindings](disk-placement-group/set-access-bindings.md) — Set access bindings for the specified disk placement group and delete all existing access bindings if there were any
	- [yc compute disk-placement-group add-access-binding](disk-placement-group/add-access-binding.md) — Add access binding for the specified disk placement group
	- [yc compute disk-placement-group remove-access-binding](disk-placement-group/remove-access-binding.md) — Remove access binding for the specified disk placement group
- [yc compute filesystem](filesystem/index.md) — Manage filesystems
	- [yc compute filesystem get](filesystem/get.md) — Show information about the specified filesystem
	- [yc compute filesystem list](filesystem/list.md) — List filesystems
	- [yc compute filesystem list-operations](filesystem/list-operations.md) — List operations for the specified filesystem
	- [yc compute filesystem create](filesystem/create.md) — Create a filesystem
	- [yc compute filesystem delete](filesystem/delete.md) — Delete the specified filesystem
	- [yc compute filesystem update](filesystem/update.md) — Update the specified filesystem
	- [yc compute filesystem resize](filesystem/resize.md) — Resize the specified filesystem
	- [yc compute filesystem add-labels](filesystem/add-labels.md) — Add labels to specified filesystem
	- [yc compute filesystem remove-labels](filesystem/remove-labels.md) — Remove labels from specified filesystem
	- [yc compute filesystem list-access-bindings](filesystem/list-access-bindings.md) — List access bindings for the specified filesystem
	- [yc compute filesystem set-access-bindings](filesystem/set-access-bindings.md) — Set access bindings for the specified filesystem and delete all existing access bindings if there were any
	- [yc compute filesystem add-access-binding](filesystem/add-access-binding.md) — Add access binding for the specified filesystem
	- [yc compute filesystem remove-access-binding](filesystem/remove-access-binding.md) — Remove access binding for the specified filesystem
- [yc compute gpu-cluster](gpu-cluster/index.md) — Manage GPU clusters
	- [yc compute gpu-cluster get](gpu-cluster/get.md) — Show information about the specified GPU cluster
	- [yc compute gpu-cluster list](gpu-cluster/list.md) — List GPU clusters
	- [yc compute gpu-cluster create](gpu-cluster/create.md) — Create a GPU cluster
	- [yc compute gpu-cluster update](gpu-cluster/update.md) — Update the specified GPU cluster
	- [yc compute gpu-cluster add-labels](gpu-cluster/add-labels.md) — Add labels to specified GPU cluster
	- [yc compute gpu-cluster remove-labels](gpu-cluster/remove-labels.md) — Remove labels from specified GPU cluster
	- [yc compute gpu-cluster delete](gpu-cluster/delete.md) — Delete the specified GPU cluster
	- [yc compute gpu-cluster list-operations](gpu-cluster/list-operations.md) — List operations for the specified GPU cluster
	- [yc compute gpu-cluster list-instances](gpu-cluster/list-instances.md) — List instances created in the specified GPU cluster
	- [yc compute gpu-cluster list-access-bindings](gpu-cluster/list-access-bindings.md) — List access bindings for the specified GPU cluster
	- [yc compute gpu-cluster set-access-bindings](gpu-cluster/set-access-bindings.md) — Set access bindings for the specified GPU cluster and delete all existing access bindings if there were any
	- [yc compute gpu-cluster add-access-binding](gpu-cluster/add-access-binding.md) — Add access binding for the specified GPU cluster
	- [yc compute gpu-cluster remove-access-binding](gpu-cluster/remove-access-binding.md) — Remove access binding for the specified GPU cluster
- [yc compute ssh](ssh/index.md) — Connect to instance

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
