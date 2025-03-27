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
`get` | `{}` | No | No | No | Configuring the `get` action to get the object from the bucket.

## ObjectStoragePut object {#ObjectStoragePut}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`content` | `string` | Yes | No | Yes | Object contents.