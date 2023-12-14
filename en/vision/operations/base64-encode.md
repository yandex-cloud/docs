---
title: "Encoding a file in Base64 in {{ vision-full-name }}"
description: "Follow this guide to deliver an image file to the {{ vision-short-name }} API."
---

# Encoding a file as Base64

The {{ vision-short-name }} API and OCR API support images in [Base64](https://en.wikipedia.org/wiki/Base64) format. Encode your image or PDF file as `Base64`:

{% include [base64-encode-command](../../_includes/vision/base64-encode-command.md) %}

In the request body, provide the image or PDF file contents encoded as Base64:

```json
{
    "folderId": "b1gvmob95yys********",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        ...
    }]
}

```

Where:
* `folderId`: [ID of any folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
* `content`: `Base64`-encoded image or PDF file contents.
