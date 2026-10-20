{#ai-audit1-id}

Requirement ID: `AI-AUDIT1`

{#ai-audit1-requirement}

**Requirement**

The system owner must list the significant operations involving models, keys, secrets, storages, indexes, MCP Gateway, and runtime, as well as specify the event source for each operation. For RAG, creation, ingestion, update, deletion, and search operations are mapped separately; for {{ lockbox-short-name }}, secret management and value retrieval are mapped separately. {{ at-name }} is only used for events published by the relevant service. Operations not covered by the cloud event reference must be logged by the application or the storage itself.

The mapping must follow this structure: `operation → service → event level (management, data, application) → specific event → source scope and filter → destination → correlation field`. The term _all operations_ must not be used. The application must separately add events for model requests, searches, tool calls, and effects in the target system.

{#ai-audit1-implementation}

**Implementation**

When configuring a trail, verify the resource scope, selected services, management and data events, filters, and destination. A single train can have only one destination; for details, see the [trail description](../../../../audit-trails/concepts/trail) and [event reference](../../../../audit-trails/concepts/events). The preset should not be treated as an exhaustive configuration; verify the actual configuration using [this {{ at-name }} guide](../../../../audit-trails/quickstart.md).

Only events listed in the [{{ at-name }} reference for {{ lockbox-short-name }}](../../../../lockbox/at-ref.md) must be used for accessing values and managing secrets. {{ ai-search-name }} and MCP only use published [{{ ai-studio-name }} events]({{ link-docs-ai }}ai-studio/at-ref.html); application tracing must be used to cover any missing documented search event. A trail that lacks the required service scope or filter does not provide sufficient evidence of operation auditing.

{#ai-audit1-check}

**Check**

1. For each significant operation, perform a safe test action and find the associated record.
1. Record the resource, subject, timestamp, event type, and correlation ID, if available.
1. If the cloud event is not documented, provide the application record and evidence of its delivery.
1. Perform a separate coverage test: intentionally omit a service or event filter, and verify that the test reports incomplete coverage rather than _met_.

The event must appear at the destination within the expected delivery time.

{#ai-audit1-artifacts}

**Artifact**

* Trail configuration.
* Safe test action and found record.
* Event map.
* Trail specification.
* Missing event test.
