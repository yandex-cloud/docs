# Resolving Issues when creating OAuth tokens on behalf of Yandex ID accounts



## Issue description {#issue-description}

* When trying to create an OAuth token on behalf of a Yandex ID user, you see the error message: `Forbidden to get tokens with these rights for this application`.

## Solution  {#issue-resolution}

Try visiting this [page](https://passport.yandex.ru/passport?mode=userapprove): it may provide details on what you need to do to get the token.

Also note that for most Yandex Cloud service scenarios, you can use [service accounts](../../../iam/concepts/users/service-accounts.md).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help solve the issue, seek assistance from [our colleagues at Yandex ID](https://yandex.ru/support/id/authorization/app-passwords.html) (the button opening the feedback form is at the bottom of this page).
