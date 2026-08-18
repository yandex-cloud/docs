---
title: ObjectStorage integration step
description: This article describes the fields for the ObjectStorage integration step.
---


# ObjectStorage

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Interacting with the {{ objstorage-full-name }} objects. The `put` and `get` fields are mutually exclusive: you can perform only one of these actions on an object.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | None | None | Bucket name.
`object` | `string` | Yes | None | Yes | Object name.
`put` | [ObjectStoragePut](#ObjectStoragePut) | None | None | None | Configuring the `put` action to add the object to the bucket.
`get` | [ObjectStorageGet](#ObjectStorageGet) | None | None | None | Configuring the `get` action to get the object from the bucket.

## ObjectStoragePut object {#ObjectStoragePut}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`content` | `string` | Yes | None | Yes | Object contents.
`contentType` | `BINARY`\|<br/>`JSON`\|<br/>`TEXT` | None | `TEXT` | None | Sets how to interpret the data delivered to `content`:<ul><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://en.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li><li>`TEXT`: UTF-8 encoded text. If the file has a different encoding, {{ sw-name }} will return an error, or the workflow will run incorrectly.</li></ul>

## ObjectStorageGet object {#ObjectStorageGet}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`contentType` | `BINARY`\|<br/>`JSON`\|<br/>`TEXT`\| <br/>`EXCEL`\| <br/>`CSV` | None | `BINARY` | None | Defines how the object contents will be interpreted:<ul><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://en.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li><li>`TEXT`: UTF-8 encoded text. If the file has a different encoding, {{ sw-name }} will return an error, or the workflow will run incorrectly.</li><li>`EXCEL`: Text will be converted into an array of pages where each page is an array of string arrays. Supported formats: `XLAM`, `XLSM`, `XLSX`, `XLTM`, and `XLTX`.</li><li>`CSV`: Text will be converted into an array of string arrays by dividing the string at these characters: comma (`,`) and line break.</li></ul>