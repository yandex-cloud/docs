---
title: VectorStore integration step
description: This article describes the fields for the VectorStore integration step.
---

# VectorStore

Interacting with a vector store.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`uploadFile` | [UploadFile](#uploadfile) | Yes | No | No | Description of how you upload a file to a vector store.

## UploadFile {#uploadfile}

The `textFile`, `urlFile`, and `objectStorage` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`vectorStoreId` | `string` | Yes | No | No | Vector store ID
`textFile` | [TextFile](#textfile) | No | No | No | Text file contents
`urlFile` | [UrlFile](#urlfile) | No | No | No | Public URL file contents
`objectStorage` | [ObjectStorage](#objectstorage) | No | No | No | {{ objstorage-name }} [bucket](../../../../../storage/concepts/bucket.md) file contents
`attributes` | `map<string,string>` | No | No | Yes | Additional file attributes (metadata) in key-value format

## TextFile {#textfile}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | `string` | Yes | No | Yes | File text contents
`fileName` | `string` | Yes | No | Yes | File name to save it under.

## UrlFile {#urlfile}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`url` | `string` | Yes | No | Yes | Public URL to access the file.
`fileName` | `string` | Yes | No | Yes | File name to save it under.

## ObjectStorage {#objectstorage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`bucket` | `string` | Yes | No | No | Name of the {{ objstorage-name }} bucket the file resides in.
`object` | `string` | Yes | No | Yes | Object name, e.g., `prefix/subprefix/data.json`
