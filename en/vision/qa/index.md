---
title: "{{ vision-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ vision-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ vision-name }}

{% include [logs](../../_qa/logs.md) %}

#### Why are element coordinates determined incorrectly? {#coordinate-definition-issue}

Your image processor has incorrectly processed metadata from the `exif` section. For more information, see [Errors determining coordinates](../concepts/ocr/index.md#coordinate-definition-issue).

Do one of the following:

* Enable support for `exif` metadata in your image viewing tool.
* Remove the `Orientation` attribute from the image `exif` section during transfer to the service or set it to `0`.
