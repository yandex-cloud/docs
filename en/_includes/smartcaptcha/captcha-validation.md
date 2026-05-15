After verifying the request, {{ captcha-name }} assigns it a unique identifier: a one-time token with a limited TTL. You can use this token to get the request’s verification result from the service.

{% note warning %}

* The token remains valid for five minutes. After this time expires, the token becomes invalid, and the user needs to go through verification again.
* The token can only be used once to request the verification result. If you try to validate this token again, you will get a `"status": "failed"` response with the following message: `Invalid or expired Token`.

{% endnote %}

After validation, the token is placed into an `<input type="hidden" name="smart-token" value="<token>" ...>` tag on the user’s page. For example:

```HTML
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="dD0xNjYyNDU3NDMzO2k9MmEwMjo2Yjg6YjA4MTpiNTk3OjoxOjFiO0Q9MjVCREY1RDgzMDBERjQ3QjExNkUyMDJDNjJFNEI3Q0Y0QjYzRkRDNzJEMkV********DNjMxODgzMUM0REZBNzI1QUE1QzUwO3U9MTY2MjQ1NzQzMzk5MTEwNjQxNTtoPTg4MWRjMDc2YzE3MjkxNGUwNDgwMTVkYzhl********">
    ...
</div>
```

Where:

* `<div id="captcha-container" class="smart-captcha" ...>`: `div` tag containing the widget.
* `value`: Token value.

To obtain the verification result, send a POST request to `https://{{ captcha-domain }}/validate` providing the following variables in `x-www-form-urlencoded` format:

```
secret=<server_key>&token=<token>&ip=<user_IP_address>
```

Where:

{% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

## Service response {#service-response}

The service will respond with a JSON object containing the `status` and `message` fields. If the `status` field is set to `ok`, the system adds the `host` field to the JSON object. This field indicates the website where the verification has been completed. For example:

1. It is a human. Verification has been completed on the `example.com` website:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com"
    }
    ```

1. It is a human. Verification has been completed on `example.com` via port `8080`:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com:8080"
    }
    ```

1. Empty `host` field. This may indicate that access to the cloud is blocked or that an internal service failure has occurred:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": ""
    }
    ```

1. It is a robot:

    ```json
    {
        "status": "failed",
        "message": ""
    }
    ```

1. Request with a fake or corrupted token. It is a robot:

    ```json
    {
        "status": "failed",
        "message": "Invalid or expired Token."
    }
    ```

### Response processing {#response-handling}

To process responses correctly, refer to their `status` field:

* `ok`: Request processed successfully.
* `failed`: An error occurred.

There are two types of errors:

* **This is a robot**: `"status": "failed"`, the `message` field is empty.
* **Error in request**: `"status": "failed"`, the `message` field contains a description of the error.

Errors in the request may be due to an invalid token or a missing server key. We recommend that you detect and fix such errors during the development and testing step.

The `message` field is not for processing in code using conditions or comparisons. Use it for diagnostic purposes only.

## Request errors {#errors}

If your request to `https://{{ captcha-domain }}/validate` is malformed, it will return an error. For example:

1. Request with no server key:

    ```JSON
    {
        "status": "failed",
        "message": "Authentication failed. Secret has not provided."
    }
    ```

1. Request with a missing or corrupted token:

    ```JSON
    {
        "status": "failed",
        "message": "Invalid or expired Token."
    }
    ```

{% note info %}

To avoid delays when processing user requests, we recommend that you handle HTTP errors, i.e., non-200 response codes, as the `"status": "ok"` service response.

{% endnote %}