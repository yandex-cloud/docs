* `id`: Routing instance ID.
* `name`: Routing instance name.
* `description`: Routing instance description.
* `folder_id`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the routing instance was created in.
* `region_id`: Region of the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) the routing instance was created in.
* `vpc_info`: List of IP prefixes by [availability zone](../../overview/concepts/geo-scope.md). Prefixes are shown separately for each availability zone.
* `cic_private_connection_info`: List of private connections connected to the routing instance.
* `status`: Resource state. The target state is `ACTIVE`. When being updated, it may be in the `UPDATING` state.
* `created_at`: Date and time of resource creation.