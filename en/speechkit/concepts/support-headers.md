---
title: Troubleshooting in {{ speechkit-full-name }}
description: If something went wrong while sending API requests and you need help, contact technical support. The support team will solve your issue faster if you use advanced HTTP request and response headers.
---

# Request headers for troubleshooting in {{ speechkit-full-name }}


If you get an error sending requests to the API and need help, use [these guidelines](./response.md) or contact [support](../../support/overview.md).

The support team will solve your issue faster if you use advanced HTTP request and response headers.

## Request headers {#request-headers}

{% include [request-headers](../../_includes/ai-common/request-headers.md) %}

### Examples {#examples}

For example, the following headers will help you find your request and use the provided audio to refine your recognition model.

{% include [example-headers-speech](../../_includes/ai-common/example-headers-speech.md) %}

## Response headers {#response-headers}

{% include [response-headers](../../_includes/ai-common/response-headers.md) %}
