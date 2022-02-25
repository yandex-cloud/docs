---
sourcePath: en/tracker/api-ref/concepts/access.md
---
# API access

Applications use the [OAuth 2.0 protocol](#section_about_OAauth) or an [IAM token](#iam-token) to access {{ api-name }}.

If your app is written in Python, you can use our [Python client](#section_about_python_client) with the API.

In requests to the {{ api-short-name }} API, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`: If [OAuth 2.0](#section_about_OAauth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](#iam-token) is used.

- `X-Org-ID: <organization ID>`

   To find out the organization ID, go to the [{{ tracker-name }} settings page]({{ link-settings }}). The ID is shown in **Organization ID for API**.

## Get access to the API over the OAuth 2.0 protocol {#section_about_OAauth}

OAuth 2.0 allows applications to access Yandex services on behalf of the user. For information about basic OAuth concepts and the Yandex implementation of the protocol, see the ["OAuth authorization. Developer's guide"]({{ link-OAuth-dev-guide }}).

To get access to the {{ api-name }}:

1. [Register]({{ link-register-application }}) your application and configure its read and write access rights in {{ tracker-name }}.

1. [Obtain]({{ link-get-token }}) an OAuth token for authorization.

1. To check if you have access to the API, [request information about the current user](../get-user-info.md).
If no access permission is granted, you'll get a response with code `401 Unauthorized`.

The token permissions correspond to the permissions for the {{ tracker-name }} account. For example, if the user isn't allowed to change queue settings, API requests to change queue settings won't be available using this token.


## Access the API with an IAM token {#iam-token}

An IAM token is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the {{ api-name }} and to access resources. Read more about this authentication method in the [documentation of the identification and access control service](../../iam/concepts/authorization/iam-token.md).

The IAM token is valid for no more than {{iam-token-lifetime}} and is limited by the cookie lifetime for the [federation](../../organization/add-federation.md). After the lifetime expires, the `401 Unauthorized` error is returned.

### Get an IAM token for a Yandex account {#iam-token-yandex-account}

{% list tabs %}

- CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}

  1. Get an IAM token:

     ```
     $ yc iam create-token
     ```

- API

  1. Get an OAuth token at the link [https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

  1. Exchange the received token for an IAM token. To do this, use an HTTP `POST` request:

     ```json
     POST https://iam.api.cloud.yandex.net/iam/v1/tokens
     
       {
          "yandexPassportOauthToken": "<OAUTH-token>"
       }
     ```

  1. The API returns a response. The response body contains information in JSON format. The value you need is in the **iamToken** attribute.

  > Sample response:
  >
  >```
  >{
  >  "iamToken": "t1.9euelZqYksrMiYrGiY-TmpGUnZPHz-3rnpWay4-SjJCKnp7KlouMjJ3Kncrl9PcSLTl0-e8rTxrv3fT3Uls2dPnvK08a7w.vqGV8pzV84HGSmX9eLmvKaIBpRx9HDbKWEwN6ryIQ",
  >  "expiresAt": "2021-10-22T05:54:53.035215444Z"
  >}
  >```

{% endlist %}

### Get an IAM token for a federated account {#iam-token-federation}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. To initiate a [federated account](../../iam/operations/iam-token/create-for-federation.md), run the command:

    ```
    yc init --federation-id=<federation ID>
    ```

1. Log in to the federated account on the browser page that opens.

1. To get an IAM token, run the command:

    ```
    yc iam create-token
    ```

## Python client {#section_about_python_client}

When developing applications in Python, you can use the [yandex_tracker_client](https://github.com/yandex/yandex_tracker_client) package that is a client designed to make it easier to work with the {{ api-short-name }}.

To start using the client:

1. Download and install the newest version of Python from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. Run the following command in your OS command line:

    
    ```
    pip install yandex_tracker_client
    ```


1. Receive your OAuth token and organization ID to access the API. To learn more, see the [API reference](../concepts/access.md).

1. Initialize the client in your program's code:

    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```

    Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

In the client, use the same data format as in the {{ tracker-name }} API.

For more information about how the client works and its terms of use, see its GitHub page: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

