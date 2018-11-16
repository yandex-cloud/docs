# IAM token

The IAM token (or just token) is a unique sequence of characters issued to a user after authentication. Using this token, the user authenticates with the Yandex Cloud API and performs operations with resources.

The IAM token must be specified in every HTTP request other than the IAM token request. The IAM token is passed in the `Authorization` header in the following format:

```
Authorization: Bearer [IAM-token]
```

> [!NOTE]
>
> IAM token lifetime is limited. At the moment, the IAM token is valid for 12 hours. After the IAM token has expired, you must request a new one.

In the management console and the command line interface (CLI), the token is obtained and used without the user needing to do anything.

#### See also

- [[!TITLE]](authorization.md)

