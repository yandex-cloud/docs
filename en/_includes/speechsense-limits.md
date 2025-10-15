#### Quotas {#speechsense-quotas}

Type of limit | Value
----- | -----
**General quotas** |
Maximum number of [projects](../speechsense/concepts/resources-hierarchy.md#project) per [space](../speechsense/concepts/resources-hierarchy.md#space) | 100
Maximum number of [tags](../speechsense/concepts/tags.md) per project | 1,000
Maximum number of [metadata](../speechsense/concepts/resources-hierarchy.md#connection) entries per connection | 200
Maximum number of [dictionaries](../speechsense/concepts/dictionaries) per space | 100
Maximum line size in dialog metadata, bytes | 1,024
Maximum number of files per [knowledge base](../speechsense/concepts/assistants.md#tools) per assistant | 10
Maximum file size per knowledge base per [assistant](../speechsense/concepts/assistants.md) | 30 MB
Maximum total characters for the assistant instruction, including characters in the transcript | 120,000
Maximum total characters in the [result fields]((../speechsense/concepts/assistants.md)) | 4,000
**Quotas for a project** |
Total number of requests for dialogs via API and for viewing in the {{ speechsense-name }} interface, per second | 20
Total number of requests for dialogs via API and for viewing in the {{ speechsense-name }} interface, per minute | 200
Total number of requests for dialogs via API and for viewing in the {{ speechsense-name }} interface, per hour | 2,000
Total number of requests for dialogs via API and for viewing in the {{ speechsense-name }} interface, per day | 20,000

#### Limits {#speechsense-limits}

Type of limit | Value
----- | -----
User data storage period | 3 months
Recalculation of modified and newly created [dictionary and semantic tags](../speechsense/concepts/tags.md) per month | Once per night
Number of returned search results | 10,000
