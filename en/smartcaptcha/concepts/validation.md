# User validation

{{ captcha-name }} checks user requests with its ML algorithms and only shows tasks to those users whose requests it considers suspicious.

You don't have to place the **"I’m not a robot"** button on the page.


## Standard CAPTCHA {#usual-captcha}

Standard CAPTCHA is a way of connecting the {{ captcha-name }} widget with the **"I’m not a robot"** button, which will send the user request to {{ captcha-name }}. If the service thinks the request is suspicious, it will ask the user to perform a task.


## Invisible CAPTCHA {#invisible-captcha}

Invisible CAPTCHA is a way of connecting the SmartCaptcha widget without the **"I’m not a robot"** button on the page. Only users whose requests are considered suspicious by the service will see the task window.

The developer selects the event when the service checks the user.


## What's next {#whats-next}

* How to connect an [invisible CAPTCHA](./invisible-captcha.md).
