---
title: GRPCCall integration step
description: This article describes the fields for the GRPCCall integration step.
---

# GRPCCall

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Only for services with [gRPC reflection](https://grpc.io/docs/guides/reflection/) support.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Yes | None | Yes | Server address.
`method` | `string` | Yes | None | Yes | gRPC service and method.
`useServiceAccount` | `bool` | None | `false` | None | If `true`, the IAM token of the service account specified in the workflow settings will be added to request headers.
`body` | `string` | None | `""` | Yes | Request body.
`headers` | `map<string, string>` | None | `{}` | Yes: in header values | Request headers.