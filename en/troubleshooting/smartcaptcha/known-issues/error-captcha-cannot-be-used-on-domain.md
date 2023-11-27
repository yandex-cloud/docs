# Resolving the "Key cannot be used on the domain captcha-api.yandex.ru" error



## Issue description {#issue-description}

When testing or setting up the captcha locally, you see this error:
```
Error: Key cannot be used on the captcha-api.yandex.ru domain
```

## Solution {#issue-resolution}

Check the list of addresses and names you use when debugging SmartCaptcha. Typically, such an error indicates an invalid resource configuration.

If `localhost` and `127.0.0.1` are missing from the list of sites in the SmartCaptcha settings, add them there.
