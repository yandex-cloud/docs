# Resolving Issues when creating OAuth tokens on behalf of Yandex ID accounts



## Issue description {#issue-description}

When trying to create an OAuth token on behalf of a Yandex ID user, you get this error message:

```
Forbidden to get tokens with these permissions for this application.
```

## Solution {#issue-resolution}

Check out [this page](https://passport.yandex.com/passport?mode=userapprove): you may find out in detail how to get a token.

Note that in most {{ yandex-cloud }} use cases, you can use [service accounts](../../../iam/concepts/users/service-accounts.md).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the issue, contact the [Yandex ID support](https://yandex.com/support/id/en/authorization/app-passwords.html). You can find the button expanding the feedback form at the bottom of the page.