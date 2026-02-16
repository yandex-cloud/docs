# Lifetime of the token returned by the `check` method in {{ captcha-name }}



## Case description {#case-description}

You need to know the lifetime of the token returned by the [`check` method](https://captcha-api.yandex.ru/check) in {{ captcha-name }}.

## Solution {#case-resolution}

This token is valid for the next five minutes. If you call `execute` multiple times within five minutes after successful user validation, the system will perform no checks and return the first successful token. 

After five minutes, the token will expire, and calling `window.smartCaptcha.execute` will trigger user verification.