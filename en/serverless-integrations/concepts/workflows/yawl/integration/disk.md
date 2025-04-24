---
title: Disk integration step
description: This article describes the fields for the Disk integration step.
---

# Disk

Interacting with files on Yandex Disk. The `upload` and `download` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`oauthToken` | `string` | Yes | No | Yes | [OAuth token](../../../../../iam/concepts/authorization/oauth-token.md) for authorization when accessing Yandex Disk
`path` | `string` | No | `""` | Yes | Path to the file to upload or download
`upload` | [DiskUpload](#DiskUpload) | No | No | No | `upload` configuration: uploading a file to Yandex Disk
`download` | [DiskDownload](#DiskDownload) | No | No | No | `download` configuration: downloading a file from Yandex Disk


## DiskUpload object {#DiskUpload}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`contentType` | `TEXT`\| <br/>`BINARY`\| <br/>`JSON` | No | `BINARY` | No | Defines how to interpret the content:<ul><li>`TEXT`: Text.</li><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li></ul>
`content` | `TEXT`\|<br/>`JSON`\|<br/>`BINARY` | Yes | No | Yes | Content to upload


## DiskDownload object {#DiskDownload}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`contentType` | `TEXT`\| <br/>`BINARY`\| <br/>`JSON`\| <br/>`CSV`\| <br/>`EXCEL` | No | `BINARY` | No | Defines how to interpret the content:<ul><li>`TEXT`: Text.</li><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li><li>`CSV `: Text will be converted into an array of string arrays by dividing the string at these characters: comma (`,`) and line break.</li><li>`EXCEL`: Text will be converted into an array of pages where each page is an array of string arrays. Supported formats: `XLAM`, `XLSM`, `XLSX`, `XLTM`, and `XLTX`.</li></ul>