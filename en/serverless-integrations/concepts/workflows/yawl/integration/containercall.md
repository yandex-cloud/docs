---
title: ContainerCall integration step
description: This article describes the fields for the ContainerCall integration step.
---

# ContainerCall

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Invoking a container from [{{ serverless-containers-full-name }}](../../../../../serverless-containers/).

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Yes | None | None | Container ID.
`path` | `string` | None | `""` | Yes | Request path.
`method` | `enum` | None | `GET` | Yes | Request HTTP method.
`body` | `string` | None | `""` | Yes | Request body.
`headers` | `map<string, string>` | None | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | None | `{}` | Yes: in query parameter values | Request query parameters.