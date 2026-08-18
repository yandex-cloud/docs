---
title: Disk integration step
description: This article describes the fields for the Disk integration step.
---

# Disk

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Interacting with files on Yandex Disk. The `upload` and `download` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`oauthToken` | `string` | Yes | None | Yes | [OAuth token]({{ link-yadisk-doc }}concepts/quickstart#oauth) for authentication when accessing Yandex Disk
`path` | `string` | Yes | None | Yes | Path to the file to upload or download
`upload` | [DiskUpload](#DiskUpload) | None | None | None | `upload` configuration: uploading a file to Yandex Disk
`download` | [DiskDownload](#DiskDownload) | None | None | None | `download` configuration: downloading a file from Yandex Disk


## DiskUpload object {#DiskUpload}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`content` | `string` | Yes | None | Yes | Content to upload
`contentType` | `BINARY`\|<br/>`JSON`\|<br/>`TEXT` | None | `TEXT` | None | Sets how to interpret the data delivered to `content`:<ul><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://en.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li><li>`TEXT`: Text.</li></ul>


## DiskDownload object {#DiskDownload}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`contentType` | `TEXT`\| <br/>`BINARY`\| <br/>`JSON`\| <br/>`CSV`\| <br/>`EXCEL` | None | `BINARY` | None | Defines how to interpret the content:<ul><li>`TEXT`: Text.</li><li>`BINARY`: Set of bytes as a [base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded string.</li><li>`JSON`: Text containing [JSON](https://{{ lang }}.wikipedia.org/wiki/JSON) will be converted to a JSON structure.</li><li>`CSV`: Text will be converted into an array of string arrays by dividing the string at these characters: comma (`,`) and line break.</li><li>`EXCEL`: Text will be converted into an array of pages where each page is an array of string arrays. Supported formats: `XLAM`, `XLSM`, `XLSX`, `XLTM`, and `XLTX`.</li></ul>