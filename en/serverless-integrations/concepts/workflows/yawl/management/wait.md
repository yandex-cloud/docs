---
title: Wait control step
description: Wait control step description.
---

# Wait

Waits for a certain period of time or up to a timestamp. If the waiting period is negative or zero, or the timestamp has already expired, the step will end right away.

Field name | Type | Required | Templating is supported | Description
--- | --- | --- | --- | ---
`duration` | `string` | No | Yes | Waiting time in seconds.
`until` | `string` | No | Yes | Timestamp in [ISO 8601](https://{{ lang }}.wikipedia.org/wiki/ISO_8601) format, e.g., `2024-12-23T18:25:43.511Z`.
`next` | `string` | No | No | ID of the next step.
