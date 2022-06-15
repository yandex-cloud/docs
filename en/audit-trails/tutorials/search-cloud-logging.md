# Searching a log group

## Who deleted a folder

Searching by ID:
```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_id="<folder ID>"
```
Searching by name:
```json
json_payload.event_type="yandex.cloud.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<folder name>"
```

## Who created/stopped/restarted/deleted a VM instance

Searching by VM ID:
```json
json_payload.details.instance_id="<<VM instance ID>>" and (json_payload.event_type="yandex.cloud.audit.compute.CreateInstance" or json_payload.event_type="yandex.cloud.audit.compute.UpdateInstance" or json_payload.event_type="yandex.cloud.audit.compute.DeleteInstance" or json_payload.event_type="yandex.cloud.audit.compute.StartInstance" or json_payload.event_type="yandex.cloud.audit.compute.StopInstance" or json_payload.event_type="yandex.cloud.audit.compute.RestartInstance")
```

## What actions did a specific user perform over a period of time

Searching by user ID:
```json
json_payload.authentication.subject_id="<user ID>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```
Searching by username:
```json
json_payload.authentication.subject_name="<username>" and json_payload.event_time>"2021-03-01" and json_payload.event_time<"2021-04-01"
```

## Searching for events that occurred to objects in a given folder

Searching by folder ID:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_id="<folder ID>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_id="<folder ID>"
```

Searching by folder name:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_name="<folder name>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_name="<folder name>"
```
