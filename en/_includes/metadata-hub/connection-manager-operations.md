{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** and click the name of the connection you need.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}**.

     In the list of operations, you can view all the operations for the selected connection since its creation:

     * `Create`: Connection created.
     * `Update`: Connection updated.
     * `Delete`: Connection deleted.
     * `Set access bindings`: Connection user roles assigned.
     * `Update access bindings`: Connection user roles updated.

     You can also view the technical operations:

     * `Bump version`: Secret version for MDB connections updated.
     * `Update references`: Connection references updated.
     * `Update version references`: Updated the connection version references used when creating or deleting an MDB cluster backup.
     * `Delete version`: Connection version deleted after removing the most recent MDB cluster backup.

- API {#api}
  
  To get information about operations performed for a specific {{ connection-manager-name }} connection, use the [Connection.ListOperations](../../metadata-hub/api-ref/Connection/listOperations.md) REST API method or the [ConnectionService.ListOperations](../../metadata-hub/api-ref/grpc/Connection/listOperations.md) gRPC API method and provide the connection ID in the request.

  You can get the connection ID from the [list of connections](../../metadata-hub/operations/view-connection.md#connection-list) in the folder.

{% endlist %}