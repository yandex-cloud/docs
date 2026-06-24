


Where:

* `id`: Routing instance ID.
* `name`: RI name.
* `description`: RI description.
* `folder_id`: ID of the cloud folder the RI was created in.
* `region_id`: ID of the region the RI was created in.
* `vpc_info`: Information about virtual networks and their IP prefixes with the prefixes grouped by [availability zone](../../overview/concepts/geo-scope.md). A routing instance may have one or more connected [virtual networks](../../vpc/concepts/network.md).
* `cic_private_connection_info`: Information about [private connections](../../interconnect/concepts/priv-con.md) to the RI.
* `status`: RI state. It may take the following values: 
  * `ACTIVE`: RI is active.
  * `CREATING`: RI is being created.
  * `UPDATING`: RI is being updated.
  * `DELETING`: RI is being deleted.