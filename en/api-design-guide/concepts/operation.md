# Operation object


Each operation that changes the state of a resource results in the creation of the object [Operation](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation.proto). This object contains information about the operation: its status, ID, call time, and so on.

Using the `Operation` object, you can:

- [Monitor the status of operations](#monitoring) with indefinite duration. For example, starting a VM or attaching a disk.
- [Cancel operations](#cancel).
- [View a list of operations](#operation-listing) that were performed on the specified resource.

## Operation object format {#operation-format}

The `Operation` object contains the following fields:

| Field | Description |
----- | -----
| `id`* | <b>string</b><br/>Operation ID. Generated on the service side. |
| `created_at`* | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)<br/>Operation start time. Specified in [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format. |
| `created_by`* | <b>string</b><br/>ID of the user who started the operation. |
| `modified_at`* | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)<br/>The time when the resource was last updated. Specified in [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt) format. |
| `done`* | <b>bool</b><br/>Operation status. Can take one of the following two values:<br/><q>true</q> — the operation is completed. Note that the operation is considered completed even if an error occurred during its execution.<br/><q>false</q> — the operation is not completed. |
| `response` | [google.protobuf.Any](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/any.proto)<br/>This field is present only if the operation completed successfully.<br/><br/> For the `Create` and `Update` methods, the `response` field contains a view of the created or updated resource. For other operations, the field may contain an empty message [google.protobuf.Empty](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/empty.proto) (for example, when deleting a resource).<br/></br>The `response` and `error` fields are mutually exclusive, which means a response cannot contain both fields at the same time. |
| `error` | [google.rpc.Status](https://github.com/grpc/grpc/blob/master/src/proto/grpc/status/status.proto)<br/>Error message. This field is present if an error occurrs during the operation.<br/><br/><br/>The `error` field may appear in the response before the operation is completed: when an error occurs, the service immediately adds the `error` field to the `Operation` object. At the same time, the service starts rolling back to the previous state: it aborts all running procedures and deletes the resources created during the operation. Only when the service returns to the previous state will the operation be considered completed and the value of its `done` field will be set to <q>true</q>.<br/><br/>The `response` and `error` fields are mutually exclusive, which means a response cannot contain both fields at the same time. |
| `metadata` | [google.protobuf.Any](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/any.proto)<br/>Operation metadata. This field usually contains the ID of the resource the operation is being performed on. If the method returns the `Operation` object, the method description contains the structure of the corresponding `metadata` field. |
| `description` | <b>string</b><br/>Operation description. The maximum length is 256 characters. |

\* Required field.

## Operation status monitoring {#monitoring}

To find out the operation status, use the [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation_service.proto) method:
```protobuf
 // Returns the Operation object by the specified ID.
 rpc Get (GetOperationRequest) returns (operation.Operation) {
   option (google.api.http) = {
     get: "/operations/{operation_id}"
   };
 }
 message GetOperationRequest {
   // Operation ID.
   string operation_id = 1;
 }
```

Sample REST request used to get the operation status:
```
GET https://operation.{{ api-host }}/operations/fcmq0j5033e516c56ctq
```

## Canceling an operation {#cancel}

To cancel an operation, use the [Cancel](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/operation/operation_service.proto) method:

```protobuf
 // Cancels the specified operation.
 rpc Cancel (CancelOperationRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/operations/{operation_id}:cancel"
   };
 }
 message CancelOperationRequest {
   // ID of the operation to cancel.
   string operation_id = 1;
 }
```

Example of canceling an operation in the REST API:
```
POST https://operation.{{ api-host }}/operations/a3s17h9sbq5asdgss12:cancel
```
In response, the server returns the `Operation` object with the current status of the operation being canceled.

You can only cancel operations that change the state of a resource. In the references, all operations that can be canceled are marked explicitly.

{% note info %}

The `Cancel` works on the Best Effort basis. Calling the method does not guarantee that the operation will be canceled. The operation may be at a stage when cancellation is no longer possible.

{% endnote %}

## Viewing a list of operations {#operation-listing}

To view a list of operations that were performed on the specified resource, use the `ListOperations` method. The method supports [result pagination](pagination.md).

Note that the `ListOperations` method returns a list of operations only for a specific resource, but not for a category of resources. For example, you cannot view the history of operations performed on all disks in your cloud.

Sample gRPC description of the [ListOperations](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method for viewing a list of operations performed on a disk:
```protobuf
 // Returns a list of operations performed on the specified disk.
 rpc ListOperations (ListDiskOperationsRequest)
   returns (ListDiskOperationsResponse) {
     option (google.api.http) = {
       get: "/compute/v1/disks/{disk_id}/operations"
     };
   }
 message ListDiskOperationsRequest {
   // Disk ID.
   string disk_id = 1;
   // Maximum number of results per response page.
   int64 page_size = 2;
   // Token of the requested result page.
   string page_token = 3;
 }

 message ListDiskOperationsResponse {
   // List of operations performed on the specified disk.
   repeated operation.Operation operations = 1;
   // Token for the next result page.
   string next_page_token = 2;
 }
```

{% include [page-size-field](../_includes/page-size-field.md) %}

Sample REST request for a list of operations:
```
GET https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03/operations
```
Server response:
```json
 {
   "operations": [
     {
       "id": "fcmq0j5033e516c56ctq",
       "createdAt": "2018-08-29T18:31:15.311Z",
       "createdBy": "v1swrh5sbqs5sdgss15",
       "done": true,
       "metadata": {
         "@type": "type.googleapis.com/yandex.cloud.compute.v1.CreateDiskMetadata",
         "diskId": "sfg36d6sbq5asdgfs01"
       },
      "response": {
        "@type": "type.googleapis.com/yandex.cloud.compute.v1.Disk",
        "id": "sfg36d6sbq5asdgfs01",
        "folderId": "a3s17h9sbq5asdgss12",
        "name": "disk-1",
        "description": "Test disk",
        "zoneId" : "{{ region-id }}-a",
        "typeId" : "network-nvme",
        "size" : 10737418240
      }
    },
    ...
   ]
 }
```
