---
title: GRPCCall integration step
description: This article describes the fields for the GRPCCall integration step.
---

# GRPCCall

Only for services with [gRPC reflection](https://grpc.io/docs/guides/reflection/) support.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Yes | No | Yes | Server address.
`method` | `string` | Yes | No | Yes | gRPC service and method.
`useServiceAccount` | `bool` | No | `false` | No | If `true`, the IAM token of the service account specified in the workflow settings will be added to request headers.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.