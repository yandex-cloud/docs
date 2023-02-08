# Standard methods

Below is a list of standard API methods and corresponding HTTP methods:

| API method | HTTP method | Request body | Response body |
| ----- | ----- | ----- | ---- |
| [Get](#method-get) | GET | — | Resource view. |
| [List](#method-list) | GET | — | List of resources. |
| [Create](#method-create) | POST | Resource view. | [Operation](operation.md) object. |
| [Update](#method-update) | PATCH | Resource view. | [Operation](operation.md) object. |
| [Delete](#method-delete) | DELETE | — | [Operation](operation.md) object. |

Below are gRPC descriptions of standard methods and examples of corresponding REST requests.

## Get {#method-get}

Returns a view of the requested resource.

The corresponding HTTP method is `GET`.

Sample gRPC description of the [Get](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to get a disk:
```protobuf
 rpc Get (GetDiskRequest) returns (Disk) {
   // The Get method corresponds to the HTTP GET method.
   option (google.api.http) = {
     get: "/compute/v1/disks/{disk_id}"
   };
 }

 message GetDiskRequest {
   // ID of the requested disk.
   string disk_id = 1;
 }
```

Sample REST request used to get a disk:
```
GET https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03
```

## List {#method-list}

Returns a list of resources of a certain category. For example, a list of disks or VMs.

Currently, resource lists can only be obtained relative to their direct parent. For example, you can get a list of disks in a folder, but you can't view a list of disks in the entire cloud.

The `List` method corresponds to the HTTP `GET` method. The ID of the parent resource, such as the folder, should be passed in the request parameters.

The `List` method supports [result pagination](pagination.md).

Sample gRPC description of the [List](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to get a list of disks:
```protobuf
 rpc List (ListDisksRequest) returns (ListDisksResponse) {
   // The List method corresponds to the HTTP GET method.
   option (google.api.http) = {
     get: "/compute/v1/disks"
   };
 }
 message ListDisksRequest {
   // ID of the folder for which
   // the list of disks is requested.
   // Required field.
   string folder_id = 1;

   // Maximum number of results per response page.
   // If the number of results returned
   // exceeds the value set in page_size, the service returns the field
   // [ListDisksResponse.next_page_token]. Use it to
   // get the next page.
   int64 page_size = 2;

   // Token of the requested result page.
   // To get the next page,
   // insert in this field the value from
   // [ListDisksResponse.next_page_token]
   // returned by the previous List request.
   string page_token = 3;
 }

 message ListDisksResponse {
   // List of disks.
   repeated Disk disks = 1;
   // Token for the next result page.
   string next_page_token = 2;
 }
```

Example of getting a list of disks in the REST API:

```
GET https://compute.{{ api-host }}/compute/v1/disks?folderId=a3s17h9sbq5asdgss12
```


## Create {#method-create}

Creates a resource in the specified cloud, folder, network, etc.

The `Create` method corresponds to the HTTP `POST` method. As parameters, pass the ID of the parent resource to create the new resource in (for example, the folder ID).

`Create` is an asynchronous signature method. It returns the [Operation](operation.md) object with the operation status and the ID of the new resource.

If you try to create a resource that already exists, the method returns the `ALREADY_EXISTS` error. [Learn more about errors](errors.md)


Sample gRPC description of the [Create](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to create a disk in a specific folder:
```protobuf
 rpc Create (CreateDiskRequest) returns (operation.Operation) {
   // The Create method corresponds to the HTTP POST method.
   option (google.api.http) = {
     post: "/compute/v1/disks" body: "*"
   };
   // In the `metadata` field of the Operation object,
   // there is a `CreateDiskMetadata` view.
   // If the operation is successful,
   // the `response` field of the Operation object
   // contains a disk resource view.
   option (yandex.api.operation) = {
     metadata: "CreateDiskMetadata"
     response: "Disk"
   };
 }

 message CreateDiskRequest {
   // ID of the folder where the disk should be created.
   // Required field.
   string folder_id = 1;

   // Disk name.
   string name = 2;

   // Disk description.
   string description = 3;

   // Disk labels in 'key: value' format.
   map<string, string> labels = 4;

   // Disk type.
   string type_id = 5;

   // ID of the zone to create the disk in.
   string zone_id = 6;

   // Disk size in bytes.
   int64 size = 7;

   oneof source {
     // ID of the image to create the disk from.
     string image_id = 8;

     // or ID of the snapshot to create the disk from.
     string snapshot_id = 9;
   }
 }

 message CreateDiskMetadata {
   // ID of the disk being created.
   string disk_id = 1;
 }
```

Sample REST request used to create a disk:
```
 POST https://compute.{{ api-host }}/compute/v1/disks

 {
   "folderId": "a3s17h9sbq5asdgss12",
   "name": "disk-1",
   "description": "Test disk",
   "zoneId" : "{{ region-id }}-a",
   "typeId" : "network-nvme",
   "size" : 10737418240
 }
```

{% include [create-operation-response](../_includes/create-operation-response.md) %}


## Update {#method-update}

Updates a resource view. The method corresponds to the HTTP `PATCH` method.

The `Update` method supports partial resource updates. The fields to update are specified in the request's `update_mask` field ([learn more](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/field_mask.proto)). The fields not specified in the `update_mask` field will not be updated. If no `update_mask` is passed in the request, the values of all fields will be updated according to the following rule:

- The passed values will be used for the fields specified in the request.
- The values of the other fields will be reset to their defaults.

It is an asynchronous signature method. It returns the [Operation](operation.md) object that contains the operation status and the view of the updated resource.

Sample gRPC description of the [Update](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to update a disk resource:
```protobuf
 rpc Update (UpdateDiskRequest) returns (operation.Operation) {
   // The Update method corresponds to the HTTP PATCH method.
   option (google.api.http) = {
     patch: "/compute/v1/disks/{disk_id}" body: "*"
   };
   // In the `metadata` field of the Operation object,
   // there is an `UpdateDiskMetadata` view.
   // If the operation is successful,
   // the `response` field of the Operation object
   // contains a view of the updated disk resource.
   option (yandex.api.operation) = {
     metadata: "UpdateDiskMetadata"
     response: "Disk"
   };
 }
 message UpdateDiskRequest {
   // ID of the disk being updated.
   // Required field.
   string disk_id = 1;

   // Mask that sets the fields to update.
   google.protobuf.FieldMask update_mask = 2;

   // Disk name.
   string name = 3;

   // Disk description.
   string description = 4;

   // Disk labels in 'key: value' format.
   map<string, string> labels = 5;

   // Disk size in bytes.
   int64 size = 6;
 }

 message UpdateDiskMetadata {
   // ID of the disk being updated.
   string disk_id = 1;
 }
```

Sample REST request used to update a disk resource:
```
PATCH https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03

 {
   "name": "New name",
   "description": "New description",
   "size": "10737418240",
   "updateMask" : "name,description"
 }
```

In the example above, only the "name" and "description" fields will be updated.

## Delete {#method-delete}

Deletes the specified resource.

The `Delete` method corresponds to the HTTP `DELETE` method. In the request parameters, pass the ID of the resource to delete.

It is an asynchronous signature method. It returns the [Operation](operation.md) object with the status of the deletion operation.

Sample gRPC description of the [Delete](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/disk_service.proto) method used to delete a disk:
```protobuf
 rpc Delete (DeleteDiskRequest) returns (operation.Operation) {
   // The method corresponds to the HTTP DELETE method.
   option (google.api.http) = {
     delete: "/compute/v1/disks/{disk_id}"
   };
   // In the `metadata` field of the Operation object,
   // there is a `DeleteDiskMetadata` view.
   // If the operation is successful,
   // the `response` field of the Operation object
   // contains a view of the `google.protobuf.Empty` resource.
   option (yandex.api.operation) = {
     metadata: "DeleteDiskMetadata"
     response: "google.protobuf.Empty"
   };
 }
 message DeleteDiskRequest {
   // ID of the disk to delete.
   // Required field.
   string disk_id = 1;
 }

 message DeleteDiskMetadata {
   // ID of the disk to delete.
   string disk_id = 1;
 }
```

Sample REST request used to delete a disk:
```
 DELETE https://compute.{{ api-host }}/compute/v1/disks/e0m97h0gbq0foeuis03
```
