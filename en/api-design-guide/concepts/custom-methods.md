# Custom methods

Custom API methods allow you to perform operations that cannot be performed using standard methods. For example, start or stop a VM instance.

Each service has its own set of custom methods available. The methods are listed in the corresponding API references.

[!INCLUDE [grpc-api-ref-note](../_includes/grpc-api-ref-note.md)]

The custom methods are mapped to HTTP `POST` method. The semantics of custom methods differs from that of HTTP methods. The name of an custom method is specified in the resource URL after a colon (<q>:</q>).

Sample gRPC description of the `AttachDisk` method:

```protobuf
 rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/compute/v1/instances/{instance_id}:attachDisk" body: "*"
   };
   // In the `metadata` field of the Operation object 
   // there is an `AttachInstanceDiskMetadata` view.
   // If the operation is successful, 
   // the `response` field of the Operation object 
   // contains a view of the updated VM instance.
   option (yandex.api.operation) = {
     metadata: "AttachInstanceDiskMetadata"
     response: "Instance"
   };
 }
 message AttachInstanceDiskRequest {
   // ID of the VM instance to which
   // the disk should be attached.
   string instance_id = 1;
 
   // Attached disk.
   AttachedDiskSpec attached_disk_spec = 2;
 }
 
 message AttachInstanceDiskMetadata {
   // ID of the VM instance 
   // the disk is attached to.
   string instance_id = 1;

   // ID of the attached disk.
   string disk_id = 2;
 }
```

Example of attaching a disk in the REST API:

```
POST https://compute.api.cloud.yandex.net/compute/v1/instances/e0m97h0gbq0foeuis03:attachDisk

 {
   "attachedDiskSpec": {
     ...
   }
 }
```

