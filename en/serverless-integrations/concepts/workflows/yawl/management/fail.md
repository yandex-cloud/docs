---
title: Fail control step
description: Fail control step description.
---

# Fail

Terminates the workflow with an error. If placed inside [Foreach](foreach.md) or [Parallel](parallel.md), it will terminate the whole workflow, not just its current branch.

Field name | Type | Required | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | ---
`errorMessage` | `string` | Yes | Yes | Error message.
