---
title: ContainerCall integration step
description: This article describes the fields for the ContainerCall integration step.
---

# ContainerCall

Invoking the [{{ serverless-containers-full-name }}](../../../../../serverless-containers/) container.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Yes | No | No | Container ID.
`path` | `string` | No | `""` | Yes | Request path.
`method` | `enum` | No | `GET` | Yes | HTTP method of the request.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | No | `{}` | Yes: in query parameter values | Request query parameters.