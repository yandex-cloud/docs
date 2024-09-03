# User validation

{{ captcha-name }} checks user requests with its ML algorithms and only shows [challenges](./tasks.md) to those users whose requests it considers suspicious.

You do not have to place the **"I’m not a robot"** button on the page.

## Standard CAPTCHA {#usual-captcha}

Standard CAPTCHA is a way to connect the {{ captcha-name }} widget with the **"I’m not a robot"** button, which sends the user's request to {{ captcha-name }}. If the service finds the request suspicious, it will prompt the user to complete a [challenge](tasks.md).

## Invisible CAPTCHA {#invisible-captcha}

Invisible CAPTCHA is a way of connecting the {{ captcha-name }} widget without the **I’m not a robot** button on the page. Only users whose requests are considered suspicious by the service will see the challenge window.

It is the developer who decides which event should trigger the service to check the user.

## Validation result {#validation-result}

{% include [captcha-validation](../../_includes/smartcaptcha/captcha-validation.md) %}

## What's next {#whats-next}

* How to connect an [invisible CAPTCHA](./invisible-captcha.md).
* CAPTCHA in [React](./react.md).
