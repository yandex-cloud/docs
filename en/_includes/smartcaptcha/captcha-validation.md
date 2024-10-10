After validating a request, {{ captcha-name }} assigns it an ID: a one-time token. You can use the token to retrieve the result of a user request validation from the service. The token is valid for five minutes. After this time expires, it becomes invalid and the user has to go through the validation process again.

After validation, the token is loaded into the `<input type="hidden" name="smart-token" value="<token>" ...>` element on the user's page. For example:

```HTML
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="dD0xNjYyNDU3NDMzO2k9MmEwMjo2Yjg6YjA4MTpiNTk3OjoxOjFiO0Q9MjVCREY1RDgzMDBERjQ3QjExNkUyMDJDNjJFNEI3Q0Y0QjYzRkRDNzJEMkV********DNjMxODgzMUM0REZBNzI1QUE1QzUwO3U9MTY2MjQ1NzQzMzk5MTEwNjQxNTtoPTg4MWRjMDc2YzE3MjkxNGUwNDgwMTVkYzhl********">
    ...
</div>
```

Where:

* `<div id="captcha-container" class="smart-captcha" ...>`: `div` element with a widget.
* `value`: Token value.

To find out the result of the validation, send a POST request to `https://smartcaptcha.yandexcloud.net/validate`:

```HTML
response = requests.post(
"https://smartcaptcha.yandexcloud.net/validate",
    {
    "secret": SMARTCAPTCHA_SERVER_KEY,
    "token": token,
    "ip": "<user_IP_address>"
    }
)
```

Where:

{% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

## Service response {#service-response}

In its response, the service will return a JSON object containing the `status` and `message` fields. If the `status` field value is `ok`, the `host` field is added to the JSON object. It shows on what website the validation was passed. For example:

1. It is a human. User validation was passed on the `example.com` website:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com"
    }
    ```

1. It is a human. User validation was passed on the `example.com` website via port `8080`:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com:8080"
    }
    ```

1. Empty `host` field. This may indicate that the cloud is blocked or an internal service failure occurred:

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

1. Request with a fake or damaged token. It is a robot:

    ```json
    {
        "status": "failed",
        "message": "Token invalid or expired."
    }
    ```

## Request errors {#errors}

If your request to `https://smartcaptcha.yandexcloud.net/validate` is incorrect, the service will return an error. For example:

1. Request missing the server key:

    ```JSON
    {
        "status": "failed",
        "message": "Authentication failed. Secret has not provided."
    }
    ```

1. Request with a missing or damaged token:

    ```JSON
    {
        "status": "failed",
        "message": "Token invalid or expired."
    }
    ```

{% note info %}

To avoid delays in user request processing, we recommend processing HTTP errors (response codes other than 200) as the `"status": "ok"` service response.

{% endnote %}