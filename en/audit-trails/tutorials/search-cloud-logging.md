# Searching for {{ yandex-cloud }} events in {{ cloud-logging-name }}

## Who deleted a folder

Searching by ID:
```json
json_payload.event_type="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_id="<folder_ID>"
```
Searching by name:
```json
json_payload.event_type="{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder" and json_payload.details.folder_name="<folder_name>"
```

## Who created/stopped/restarted/deleted a VM instance

Searching by VM ID:
```json
json_payload.details.instance_id="<<virtual_machine_ID>>" and (json_payload.event_type="{{ at-event-prefix }}.audit.compute.CreateInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.UpdateInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.DeleteInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.StartInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.StopInstance" or json_payload.event_type="{{ at-event-prefix }}.audit.compute.RestartInstance")
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
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_id="<folder_ID>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_id="<folder_ID>"
```

Searching by folder name:
```json
json_payload.resource_metadata.path[1].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[1].resource_name="<folder_name>") or (json_payload.resource_metadata.path[2].resource_type="resource-manager.folder" and json_payload.resource_metadata.path[2].resource_name="<folder_name>"
```

{% if product == "yandex-cloud" %}

## What's next {#whats-next}

Review event examples in the [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/_use_cases_and_searches/Use-casesANDsearches_RU.pdf).

{% include [Yc-solution-library-for-security](../../_includes/security-solution-library.md) %}

{% endif %}
