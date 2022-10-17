# User validation

{{ captcha-name }} checks user requests with its ML algorithms and only shows tasks to those users whose requests it considers suspicious.

You don't have to place the **"I’m not a robot"** button on the page.


## Standard CAPTCHA {#usual-captcha}

Standard CAPTCHA is a way of connecting the {{ captcha-name }} widget with the **"I’m not a robot"** button, which will send the user request to {{ captcha-name }}. If the service thinks the request is suspicious, it will ask the user to perform a task.


## Invisible CAPTCHA {#invisible-captcha}

Invisible CAPTCHA is a way of connecting the SmartCaptcha widget without the **"I’m not a robot"** button on the page. Only users whose requests are considered suspicious by the service will see the task window.

The developer selects the event when the service checks the user.


## Validation result {#validation-result}

After validating a request, {{ captcha-name }} assigns it an ID in the form of a token. You can use the token to retrieve the result of a user request validation from the service.

After validation, the token is inserted into the `<input type="hidden" name="smart-token" value="<token>" ...>` element on the user page. For example:

```HTML
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="dD0xNjYyNDU3NDMzO2k9MmEwMjo2Yjg6YjA4MTpiNTk3OjoxOjFiO0Q9MjVCREY1RDgzMDBERjQ3QjExNkUyMDJDNjJFNEI3Q0Y0QjYzRkRDNzJEMkVGQzQyRUNDNjMxODgzMUM0REZBNzI1QUE1QzUwO3U9MTY2MjQ1NzQzMzk5MTEwNjQxNTtoPTg4MWRjMDc2YzE3MjkxNGUwNDgwMTVkYzhlZjU3ODQ0">
    ...
</div>
```

Where:

* `<div id="captcha-container" class="smart-captcha" ...>`: `div` element with the widget.
* `value`: Token value.

To retrieve the validation result, send a GET request containing the token to `https://captcha-api.yandex.ru/validate`:

```TEXT
https://captcha-api.yandex.ru/validate?secret=<server_key>&ip=<user_IP>&token=<token>
```

Where:

* `secret`: [Server key](../operations/get-keys.md).
* `token`: Token.
* `ip`: User IP.


### Service response {#service-response}

In its response, the service will return a JSON object containing the `status` and the `message` fields. For example:

1. It's a person:

   ```json
   {
       "status": "ok",
       "message": ""
   }
   ```

1. It's a robot:

   ```json
   {
       "status": "failed",
       "message": ""
   }
   ```

1. Request with a fake or damaged token. It's a robot:

   ```json
   {
       "status": "failed",
       "message": "Token invalid or expired."
   }
   ```


### Request errors {#errors}

If a request to `https://captcha-api.yandex.ru/validate` is improperly formatted, the service will return an error. For example:

1. Request missing the server key:

   ```JSON
   {
       "status": "failed",
       "message": "Authentication failed. Secret has not provided."
   }
   ```

1. Request missing the IP address:

   ```JSON
   {
       "status": "failed",
       "message": "Invalid IP."
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

To avoid delays when processing user requests, we recommend processing HTTP errors (response codes other than 200) as the `"status": "ok"` server response.

{% endnote %}


## What's next {#whats-next}

* How to connect an [invisible CAPTCHA](./invisible-captcha.md).
