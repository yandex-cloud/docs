# Authentication in the API

Authentication is validating the authenticity of a user. Below is a description of authentication steps in
Yandex.Cloud.

## Step 1. Authorization in Yandex {#auth-at-yandex}

Log in to Yandex using your account. For more information, see [Your Yandex account](https://yandex.com/support/passport/auth.html).

## Step 2. Getting an OAuth token {#get-oauth-token}

To start working with the Yandex.Cloud API, you need to get an OAuth token. It allows accessing Yandex services on behalf of the user.

You can get the OAuth token in the Yandex.OAuth service. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) and click
**Allow**.

Save the received OAuth token.

## Step 3. Changing the OAuth token for an IAM token {#change-oauth-to-iam}

To work with the APIs of other Yandex.Cloud services, you need to get an IAM token. To do this, use the method [create](../iam/api-ref/IamToken/create.md). In the request body, pass the OAuth token (in the field `yandexPassportOauthToken`).
The received IAM token is valid for 12 hours. After that period expires, get a new IAM token.

## Step 4. Using the IAM token {#request-with-iam}

The received IAM token allows you to make requests to Yandex.Cloud services. The IAM token
must be passed in the `Authorization` header of each API request.
The full format of the header record is as follows:

```
Authorization: Bearer [your IAM token]
```

Before executing a request, Yandex.Cloud checks if the token is valid and the request can be executed. If the user does not have the necessary permissions, the request will not be
executed.

#### See also

- [the IAM User Guide](../iam/index.yaml)

