---
title: Additional API methods
description: In this article, you will learn about additional {{ yandex-cloud }} API methods and see an example of an additional method.
---

# Additional methods

Additional API methods allow you to perform operations that cannot be performed using standard methods. For example, start or stop a VM.

Each service has its own set of additional methods available. The methods are listed in the corresponding API references.

Additional methods are mapped to the `POST` HTTP method. The signature of additional methods differs from the standard signature of HTTP methods. The additional method's name is put in the resource URL after the <q>:</q> symbol.

Sample gRPC description of the [AttachDisk](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/compute/v1/instance_service.proto) method:

```protobuf
 rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
   option (google.api.http) = {
     post: "/compute/v1/instances/{instance_id}:attachDisk" body: "*"
   };
   // The Operation object's `metadata` field
   // contains the `AttachInstanceDiskMetadata` view.
   // If the operation is successful,
   // the Operation object's `response` field
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

   // Attached disk.
   AttachedDiskSpec attached_disk_spec = 2;
 }

 message AttachInstanceDiskMetadata {
   // ID of the VM
   // the disk is connected to.
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

