# What is the lifespan of the token returned by the check method in SmartCaptcha


## Scenario description {#case-description}

What is the lifespan of the token returned by the [check method](https://captcha-api.yandex.ru/check) in {{ captcha-full-name }}?

## Solution {#case-resolution}

The received token is valid for the next 5 minutes. If you call `execute` several times within 5 minutes after successful user validation, no check is performed, and the first successful token is returned.

After 5 minutes, the token is reset, and calling `window.smartCaptcha.execute` will trigger user verification.
