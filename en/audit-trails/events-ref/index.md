---
title: '{{ at-full-name }} event reference'
description: Audit event JSON structure, field types and descriptions. {{ at-full-name }} event reference navigation.
---

# Audit log reference

This reference contains the JSON structure and field descriptions for events collected by {{ at-name }}. Use it to analyze audit logs, build search queries, and [configure filtering](../concepts/trail.md#field-filters). Management and data events are provided together.

Each event page has two sections:

* **Event JSON schema**: Event record structure, including nested objects and arrays.
* **Field description**: Description of fields, their types, and possible values.

This reference lists the possible fields for each event. The fields available in an actual log depend on the event and resource parameters.

## Field names in the reference and logs {#field-names}

The reference uses [camelCase](https://en.wikipedia.org/wiki/Camel_case) for compound field names, while audit logs generally use [snake_case](https://{{ lang }}.wikipedia.org/wiki/Snake_case), with lowercase letters and `_` as separators. When matching paths, pay attention to the naming convention and casing of each nested field.

Here is an example for a [BucketUpdate](../audit/storage/events-ref/BucketUpdate.md) event:

#|
|| **In the reference** | **In the log** ||
|| `eventType` | `event_type` ||
|| `requestMetadata.remoteAddress` | `request_metadata.remote_address` ||
|| `details.bucketId` | `details.bucket_id` ||
|| `details.maxSize` | `details.max_size` ||
|| `details.settingsReadAccess` | `details.settings_read_access` ||
|#

Single-word names, such as `details`, remain unchanged. This rule applies to field names, not field values: the event type remains `yandex.cloud.audit.storage.BucketUpdate`.

Nested data may retain the format used by the source service. When building queries and configuring [filters](../concepts/trail.md#field-filters), use the exact key names and casing from the actual JSON log.
