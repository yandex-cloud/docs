---
title: Troubleshooting in {{ foundation-models-full-name }}
description: If you get an error sending requests to the API and need help, contact support. The support team will solve your issue faster if you use additional HTTP request and response headers.
---

# Request headers for troubleshooting in {{ foundation-models-full-name }}

{% include [support-with-headers](../../_includes/ai-common/support-with-headers.md) %}

## Request headers {#request-headers}

When sending HTTP requests, use the following headers:

* {% include [x-client-request-id](../../_includes/ai-common/x-client-request-id.md) %}
* `x-data-logging-enabled`: Flag that allows saving the data provided by the user in the request.

    By default, all requests to {{ foundation-models-name }} are logged. Logging will help resolve your issue if you also specify the request ID when contacting support. You can [disable](../operations/disable-logging.md) logging if you need to include sensitive information in your request.

### Examples {#examples}

You can use the headers below to locate your asynchronous query to a model:

{% include [example-headers-fm](../../_includes/ai-common/example-headers-fm.md) %}

## Response headers {#response-headers}

{% include [response-headers](../../_includes/ai-common/response-headers.md) %}