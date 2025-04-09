---
title: ObjectStorage integration step
description: This article describes the fields for the ObjectStorage integration step.
---


# ObjectStorage

Interacting with the {{ objstorage-full-name }} objects. The `put` and `get` fields are mutually exclusive: you can perform only one of these actions on an object.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No | No | Bucket name.
`object` | `string` | Yes | No | Yes | Object name.
`put` | [ObjectStoragePut](#ObjectStoragePut) | No | No | No | Configuring the `put` action to add the object to the bucket.
`get` | [ObjectStorageGet](#ObjectStorageGet) | No | No | No | Configuring the `get` action to get the object from the bucket.


## ObjectStoragePut object {#ObjectStoragePut}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`content` | `string` | Yes | No | Yes | Object contents.


## ObjectStorageGet object {#ObjectStorageGet}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`contentType` | `BINARY`\|<br/>`JSON`\|<br/>`TEXT` | No | `BINARY` | No | Determines how the object content will be interpreted. `BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.<br/>`JSON`: Text containing [JSON](https://en.wikipedia.org/wiki/JSON) will be converted to a JSON structure.<br/>`TEXT`: Text.