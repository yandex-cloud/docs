---
title: HTTPCall integration step
description: This article describes the fields for the HTTPCall integration step.
---

# HTTPCall

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

HTTP call to a specified endpoint.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | Yes | None | Yes | Request URL.
`method` | `enum` | None | `GET` | None | Request method.
`body` | `string` | None | `""` | Yes | Request body.
`headers` | `map<string, string>` | None | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | None | `{}` | Yes: in query parameter values | Request query parameters.