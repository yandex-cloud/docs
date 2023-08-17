# Additional methods

Additional API methods allow you to perform operations that cannot be performed using standard methods. For example, start or stop a VM.

Each service has its own set of additional methods available. The methods are listed in the corresponding API references.

The `POST` HTTP method is mapped to additional methods. The signature of additional methods differs from the standard signature of HTTP methods. The name of an additional method is specified in the resource URL after a colon (<q>:</q>).

Sample gRPC description of the [AttachDisk](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instance_service.proto) method:

```protobuf
 rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/compute/v1/instances/{instance_id}:attachDisk" body: "*"
   };
   // In the `metadata` field of the Operation object
   // there is an `AttachInstanceDiskMetadata` view.
   // If the operation is successful,
   // the `response` field of the Operation object
   // contains a view of the updated VM.
   option (yandex.api.operation) = {
     metadata: "AttachInstanceDiskMetadata"
     response: "Instance"
   };
 }
 message AttachInstanceDiskRequest {
   // ID of the VM to which
   // the disk should be attached.
   string instance_id = 1;

   // The disk to attach.
   AttachedDiskSpec attached_disk_spec = 2;
 }

 message AttachInstanceDiskMetadata {
   // ID of the VM
   // the disk is attached to.
   string instance_id = 1;

   // ID of the attached disk.
   string disk_id = 2;
 }
```

Example of attaching a disk in the REST API:
```json
POST https://compute.{{ api-host }}/compute/v1/instances/e0m97h0gbq0foeuis03:attachDisk

 {
   "attachedDiskSpec": {
     ...
   }
 }
```

