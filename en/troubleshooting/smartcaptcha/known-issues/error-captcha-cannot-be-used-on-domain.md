# Fixing the `Key cannot be used on the captcha-api.yandex.ru domain` error



## Issue description {#issue-description}

When testing or setting up {{ captcha-name }} locally, you get this error:
```
Error: Key cannot be used on the captcha-api.yandex.ru domain
```

## Solution {#issue-resolution}

Check the list of addresses and names you use when debugging {{ captcha-name }}. Typically, such an error means there are now local addresses in the host list.

Add `localhost` and `127.0.0.1` to the host list in the {{ captcha-name }} settings.
