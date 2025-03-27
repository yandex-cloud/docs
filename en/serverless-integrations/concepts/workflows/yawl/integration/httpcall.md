---
title: HTTPCall integration step
description: This article describes the fields for the HTTPCall integration step.
---

# HTTPCall

HTTP call to a specified endpoint.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | Yes | No | Yes | Request URL.
`method` | `enum` | No | `GET` | No | Request method.
`body` | `string` | No | `""` | Yes | Request body.
`headers` | `map<string, string>` | No | `{}` | Yes: in header values | Request headers.
`query` | `map<string, string>` | No | `{}` | Yes: in query parameter values | Request query parameters.