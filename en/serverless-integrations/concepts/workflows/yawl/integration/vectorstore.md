---
title: VectorStore integration step
description: This article describes the fields for the VectorStore integration step.
---

# VectorStore

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Interacting with a vector store.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`uploadFile` | [UploadFile](#uploadfile) | Yes | None | None | Description of how you upload a file to a vector store.

## UploadFile {#uploadfile}

The `textFile`, `urlFile`, and `objectStorage` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`vectorStoreId` | `string` | Yes | None | None | Vector store ID
`textFile` | [TextFile](#textfile) | None | None | None | Text file contents
`urlFile` | [UrlFile](#urlfile) | None | None | None | Public URL file contents
`objectStorage` | [ObjectStorage](#objectstorage) | None | None | None | {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md) file contents
`attributes` | `map<string,string>` | None | None | Yes | Additional file attributes (metadata) in key-value format

## TextFile {#textfile}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | None | Yes | File text contents
`fileName` | `string` | Yes | None | Yes | File name to save it under.

## UrlFile {#urlfile}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | Yes | None | Yes | Public URL to access the file.
`fileName` | `string` | Yes | None | Yes | File name to save it under.

## ObjectStorage {#objectstorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | None | None | Name of the {{ objstorage-name }} bucket the file resides in.
`object` | `string` | Yes | None | Yes | Object name, e.g., `prefix/subprefix/data.json`
