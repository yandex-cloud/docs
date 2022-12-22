---
editable: false
---

# IoT Core Service, gRPC: DeviceService

A set of methods for managing devices.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified device. |
| [GetByName](#GetByName) |  |
| [List](#List) | Retrieves the list of devices in the specified registry. |
| [Create](#Create) | Creates a device in the specified registry. |
| [Update](#Update) | Updates the specified device. |
| [Delete](#Delete) | Deletes the specified device. |
| [ListCertificates](#ListCertificates) | Retrieves the list of device certificates for the specified device. |
| [AddCertificate](#AddCertificate) | Adds a certificate. |
| [DeleteCertificate](#DeleteCertificate) | Deletes the specified device certificate. |
| [ListPasswords](#ListPasswords) | Retrieves the list of passwords for the specified device. |
| [AddPassword](#AddPassword) | Adds password for the specified device. |
| [DeletePassword](#DeletePassword) | Deletes the specified password. |
| [ListOperations](#ListOperations) | Lists operations for the specified device. |

## Calls DeviceService {#calls}

## Get {#Get}

Returns the specified device. <br>To get the list of available devices, make a [List](#List) request.

**rpc Get ([GetDeviceRequest](#GetDeviceRequest)) returns ([Device](#Device))**

### GetDeviceRequest {#GetDeviceRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to return. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
device_view | enum **DeviceView**<br>Specifies which parts of the device resource should be returned in the response. <ul><li>`BASIC`: Server responses without monitoring data. The default value.</li><li>`FULL`: Server responses with monitoring data.</li></ul>


### Device {#Device}

Field | Description
--- | ---
id | **string**<br>ID of the device. 
registry_id | **string**<br>ID of the registry that the device belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the device. The name is unique within the registry. 
description | **string**<br>Description of the device. 0-256 characters long. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. 
status | enum **Status**<br>Status of the device. <ul><li>`CREATING`: Device is being created.</li><li>`ACTIVE`: Device is ready to use.</li><li>`DELETING`: Device is being deleted.</li></ul>
monitoring_data | **[DeviceMonitoringData](#DeviceMonitoringData)**<br>Device monitoring data, returns if FULL view specified. 


### DeviceMonitoringData {#DeviceMonitoringData}

Field | Description
--- | ---
last_auth_ip | **string**<br> 
last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## GetByName {#GetByName}



**rpc GetByName ([GetByNameDeviceRequest](#GetByNameDeviceRequest)) returns ([Device](#Device1))**

### GetByNameDeviceRequest {#GetByNameDeviceRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to get device. <br>To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/registry_service#List) request. The maximum string length in characters is 50.
device_name | **string**<br>Required. Name of the device to return. <br>To get a device name make a [DeviceService.List](#List) request. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
device_view | enum **DeviceView**<br>Specifies which parts of the device resource should be returned in the response. <ul><li>`BASIC`: Server responses without monitoring data. The default value.</li><li>`FULL`: Server responses with monitoring data.</li></ul>


### Device {#Device1}

Field | Description
--- | ---
id | **string**<br>ID of the device. 
registry_id | **string**<br>ID of the registry that the device belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the device. The name is unique within the registry. 
description | **string**<br>Description of the device. 0-256 characters long. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. 
status | enum **Status**<br>Status of the device. <ul><li>`CREATING`: Device is being created.</li><li>`ACTIVE`: Device is ready to use.</li><li>`DELETING`: Device is being deleted.</li></ul>
monitoring_data | **[DeviceMonitoringData](#DeviceMonitoringData1)**<br>Device monitoring data, returns if FULL view specified. 


### DeviceMonitoringData {#DeviceMonitoringData1}

Field | Description
--- | ---
last_auth_ip | **string**<br> 
last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

Retrieves the list of devices in the specified registry.

**rpc List ([ListDevicesRequest](#ListDevicesRequest)) returns ([ListDevicesResponse](#ListDevicesResponse))**

### ListDevicesRequest {#ListDevicesRequest}

Field | Description
--- | ---
id | **oneof:** `registry_id` or `folder_id`<br>
&nbsp;&nbsp;registry_id | **string**<br>ID of the registry to list devices in. <br>To get a registry ID make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/registry_service#List) request. The maximum string length in characters is 50.
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list devices in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDevicesResponse.next_page_token](#ListDevicesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDevicesResponse.next_page_token](#ListDevicesResponse) returned by a previous list request. The maximum string length in characters is 100.
device_view | enum **DeviceView**<br>Specifies which parts of the device resource should be returned in the response. <ul><li>`BASIC`: Server responses without monitoring data. The default value.</li><li>`FULL`: Server responses with monitoring data.</li></ul>


### ListDevicesResponse {#ListDevicesResponse}

Field | Description
--- | ---
devices[] | **[Device](#Device2)**<br>List of devices. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDevicesRequest.page_size](#ListDevicesRequest), use `next_page_token` as the value for the [ListDevicesRequest.page_token](#ListDevicesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Device {#Device2}

Field | Description
--- | ---
id | **string**<br>ID of the device. 
registry_id | **string**<br>ID of the registry that the device belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the device. The name is unique within the registry. 
description | **string**<br>Description of the device. 0-256 characters long. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. 
status | enum **Status**<br>Status of the device. <ul><li>`CREATING`: Device is being created.</li><li>`ACTIVE`: Device is ready to use.</li><li>`DELETING`: Device is being deleted.</li></ul>
monitoring_data | **[DeviceMonitoringData](#DeviceMonitoringData2)**<br>Device monitoring data, returns if FULL view specified. 


### DeviceMonitoringData {#DeviceMonitoringData2}

Field | Description
--- | ---
last_auth_ip | **string**<br> 
last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Creates a device in the specified registry.

**rpc Create ([CreateDeviceRequest](#CreateDeviceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDeviceMetadata](#CreateDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Device](#Device3)<br>

### CreateDeviceRequest {#CreateDeviceRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry to create a device in. <br>To get a registry ID, make a [yandex.cloud.iot.devices.v1.RegistryService.List](/docs/iot-core/api-ref/grpc/registry_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the device. The name must be unique within the registry. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the device. The maximum string length in characters is 256.
certificates[] | **[Certificate](#Certificate)**<br>Device certificate. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/{id}/events`. 
password | **string**<br>Device password. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. 


### Certificate {#Certificate}

Field | Description
--- | ---
certificate_data | **string**<br>Public part of the device certificate. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDeviceMetadata](#CreateDeviceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Device](#Device3)>**<br>if operation finished successfully. 


### CreateDeviceMetadata {#CreateDeviceMetadata}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that is being created. 


### Device {#Device3}

Field | Description
--- | ---
id | **string**<br>ID of the device. 
registry_id | **string**<br>ID of the registry that the device belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the device. The name is unique within the registry. 
description | **string**<br>Description of the device. 0-256 characters long. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. 
status | enum **Status**<br>Status of the device. <ul><li>`CREATING`: Device is being created.</li><li>`ACTIVE`: Device is ready to use.</li><li>`DELETING`: Device is being deleted.</li></ul>
monitoring_data | **[DeviceMonitoringData](#DeviceMonitoringData3)**<br>Device monitoring data, returns if FULL view specified. 


### DeviceMonitoringData {#DeviceMonitoringData3}

Field | Description
--- | ---
last_auth_ip | **string**<br> 
last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Update {#Update}

Updates the specified device.

**rpc Update ([UpdateDeviceRequest](#UpdateDeviceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDeviceMetadata](#UpdateDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Device](#Device4)<br>

### UpdateDeviceRequest {#UpdateDeviceRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to update. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the device are going to be updated. 
name | **string**<br>Name of the device. The name must be unique within the registry. The maximum string length in characters is 50. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
description | **string**<br>Description of the device. The maximum string length in characters is 256.
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/{id}/events`. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDeviceMetadata](#UpdateDeviceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Device](#Device4)>**<br>if operation finished successfully. 


### UpdateDeviceMetadata {#UpdateDeviceMetadata}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that is being updated. 


### Device {#Device4}

Field | Description
--- | ---
id | **string**<br>ID of the device. 
registry_id | **string**<br>ID of the registry that the device belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the device. The name is unique within the registry. 
description | **string**<br>Description of the device. 0-256 characters long. 
topic_aliases | **map<string,string>**<br>Alias of a device topic. <br>Alias is an alternate name of a device topic assigned by the user. Map alias to canonical topic name prefix, e.g. `my/custom/alias` match to `$device/abcdef/events`. 
status | enum **Status**<br>Status of the device. <ul><li>`CREATING`: Device is being created.</li><li>`ACTIVE`: Device is ready to use.</li><li>`DELETING`: Device is being deleted.</li></ul>
monitoring_data | **[DeviceMonitoringData](#DeviceMonitoringData4)**<br>Device monitoring data, returns if FULL view specified. 


### DeviceMonitoringData {#DeviceMonitoringData4}

Field | Description
--- | ---
last_auth_ip | **string**<br> 
last_auth_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_pub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_sub_activity_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
last_online_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Delete {#Delete}

Deletes the specified device.

**rpc Delete ([DeleteDeviceRequest](#DeleteDeviceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDeviceMetadata](#DeleteDeviceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDeviceRequest {#DeleteDeviceRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to delete. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDeviceMetadata](#DeleteDeviceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDeviceMetadata {#DeleteDeviceMetadata}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that is being deleted. 


## ListCertificates {#ListCertificates}

Retrieves the list of device certificates for the specified device.

**rpc ListCertificates ([ListDeviceCertificatesRequest](#ListDeviceCertificatesRequest)) returns ([ListDeviceCertificatesResponse](#ListDeviceCertificatesResponse))**

### ListDeviceCertificatesRequest {#ListDeviceCertificatesRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to list certificates for. The maximum string length in characters is 50.


### ListDeviceCertificatesResponse {#ListDeviceCertificatesResponse}

Field | Description
--- | ---
certificates[] | **[DeviceCertificate](#DeviceCertificate)**<br>List of certificates for the specified device. 


### DeviceCertificate {#DeviceCertificate}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificate. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddCertificate {#AddCertificate}

Adds a certificate.

**rpc AddCertificate ([AddDeviceCertificateRequest](#AddDeviceCertificateRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddDeviceCertificateMetadata](#AddDeviceCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DeviceCertificate](#DeviceCertificate1)<br>

### AddDeviceCertificateRequest {#AddDeviceCertificateRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device for which the certificate is being added. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
certificate_data | **string**<br>Public part of the certificate. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddDeviceCertificateMetadata](#AddDeviceCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeviceCertificate](#DeviceCertificate1)>**<br>if operation finished successfully. 


### AddDeviceCertificateMetadata {#AddDeviceCertificateMetadata}

Field | Description
--- | ---
device_id | **string**<br>ID of the device certificate that is being added. 
fingerprint | **string**<br>Fingerprint of the certificate that is being added. 


### DeviceCertificate {#DeviceCertificate1}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that the certificate belongs to. 
fingerprint | **string**<br>SHA256 hash of the certificate. 
certificate_data | **string**<br>Public part of the certificate. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeleteCertificate {#DeleteCertificate}

Deletes the specified device certificate.

**rpc DeleteCertificate ([DeleteDeviceCertificateRequest](#DeleteDeviceCertificateRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDeviceCertificateMetadata](#DeleteDeviceCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDeviceCertificateRequest {#DeleteDeviceCertificateRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to delete a certificate for. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
fingerprint | **string**<br>Required. Fingerprint of the certificate to delete. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDeviceCertificateMetadata](#DeleteDeviceCertificateMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDeviceCertificateMetadata {#DeleteDeviceCertificateMetadata}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device certificate that is being deleted. The maximum string length in characters is 50.
fingerprint | **string**<br>Required. Fingerprint of the certificate that is being deleted. The maximum string length in characters is 50.


## ListPasswords {#ListPasswords}

Retrieves the list of passwords for the specified device.

**rpc ListPasswords ([ListDevicePasswordsRequest](#ListDevicePasswordsRequest)) returns ([ListDevicePasswordsResponse](#ListDevicePasswordsResponse))**

### ListDevicePasswordsRequest {#ListDevicePasswordsRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the registry to list passwords in. <br>To get a registry ID make a [RegistryService.List](./registry_service#List) request. The maximum string length in characters is 50.


### ListDevicePasswordsResponse {#ListDevicePasswordsResponse}

Field | Description
--- | ---
passwords[] | **[DevicePassword](#DevicePassword)**<br>List of passwords for the specified device. 


### DevicePassword {#DevicePassword}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## AddPassword {#AddPassword}

Adds password for the specified device.

**rpc AddPassword ([AddDevicePasswordRequest](#AddDevicePasswordRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddDevicePasswordMetadata](#AddDevicePasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DevicePassword](#DevicePassword1)<br>

### AddDevicePasswordRequest {#AddDevicePasswordRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to add a password for. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
password | **string**<br>Passwords for the device. <br>The password must contain at least three character categories among the following: upper case latin, lower case latin, numbers and special symbols. The minimum string length in characters is 14.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddDevicePasswordMetadata](#AddDevicePasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DevicePassword](#DevicePassword1)>**<br>if operation finished successfully. 


### AddDevicePasswordMetadata {#AddDevicePasswordMetadata}

Field | Description
--- | ---
device_id | **string**<br>ID of the device for which the password is being added. 
password_id | **string**<br>ID of the password that is being added. 


### DevicePassword {#DevicePassword1}

Field | Description
--- | ---
device_id | **string**<br>ID of the device that the password belongs to. 
id | **string**<br>ID of the password. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## DeletePassword {#DeletePassword}

Deletes the specified password.

**rpc DeletePassword ([DeleteDevicePasswordRequest](#DeleteDevicePasswordRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDevicePasswordMetadata](#DeleteDevicePasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDevicePasswordRequest {#DeleteDevicePasswordRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to delete a password for. <br>To get a device ID make a [DeviceService.List](#List) request. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password to delete. <br>To get a password ID make a [DeviceService.ListPasswords](#ListPasswords) request. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDevicePasswordMetadata](#DeleteDevicePasswordMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDevicePasswordMetadata {#DeleteDevicePasswordMetadata}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device for which the password is being deleted. The maximum string length in characters is 50.
password_id | **string**<br>Required. ID of the password that is being deleted. The maximum string length in characters is 50.


## ListOperations {#ListOperations}

Lists operations for the specified device.

**rpc ListOperations ([ListDeviceOperationsRequest](#ListDeviceOperationsRequest)) returns ([ListDeviceOperationsResponse](#ListDeviceOperationsResponse))**

### ListDeviceOperationsRequest {#ListDeviceOperationsRequest}

Field | Description
--- | ---
device_id | **string**<br>Required. ID of the device to list operations for. <br>To get a device ID make a [DeviceService.List](#List) request. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListDeviceOperationsResponse.next_page_token](#ListDeviceOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDeviceOperationsResponse.next_page_token](#ListDeviceOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on [Device.name](#Device5) field. The maximum string length in characters is 1000.


### ListDeviceOperationsResponse {#ListDeviceOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified device certificate. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDeviceOperationsRequest.page_size](#ListDeviceOperationsRequest), use `next_page_token` as the value for the [ListDeviceOperationsRequest.page_token](#ListDeviceOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


