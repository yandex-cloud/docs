# API access

Applications use the [OAuth 2.0 protocol](#section_about_OAauth) {% if audience == "external" %}or an [IAM token](#iam-token){% endif %} to access {{ api-name }}.

If your app is written in Python, you can use our [Python client](#section_about_python_client) with the API.

In requests to the {{ api-short-name }} API, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`{% if audience == "external" %}: If [OAuth 2.0](#section_about_OAauth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](#iam-token) is used.

- `X-Org-ID: <organization ID>`

   To find out the organization ID, go to the [{{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.

{% endif %}

## Get access to the API over the OAuth 2.0 protocol {#section_about_OAauth}

OAuth 2.0 allows applications to access Yandex services on behalf of the user. For information about basic OAuth concepts and the Yandex implementation of the protocol, see the ["OAuth authorization. Developer's guide"]({{ link-OAuth-dev-guide }}).

To get access, register the application. The application redirects the user to the Yandex OAuth Server access request page.  The user logs in to Yandex and gives the application permission to access their data.

To get access to {{ api-name }}:

{% if audience == "external" %}

1. [Register]({{ link-register-application }}) application on the OAuth server:

   1. Go to [**New client**]({{ link-get-token }}client/new). Name the application.

   1. Select the platform the application is installed on and specify its [settings]({{ link-register-application }}#register-client__platform).

   1. Go to the **Permissions** field, open **Tracker**, and select the following options:
      * **Writing information to tracker (tracker:write)**.
      * **Reading information from tracker (tracker:read)**.

   1. Click **Create app**.

1. Get an OAuth token for authorization:

   1. Select your application from the [list]({{ link-get-token }}).

   1. Copy the value from the **ID** and generate a token request link:
      `{{ link-get-token }}authorize?response_type=token&client_id=<application ID>`
      You can specify [additional parameters]({{ link-web-oauth }}) of the token request.

   1. Follow the link and copy the OAuth token. The token you received must be used in requests to the {{ tracker-name }} API.

     {% note info %}

     Yandex.OAuth redirects the user to the address specified in the **Callback URL** field on the application page. The address is generated automatically based on the application settings and the parameters of the selected platform.
     If your application is still in development, you can access {{ tracker-name }} by receiving the [debug token]({{ link-oauth-token }}) manually as a test user.

     {% endnote %}

{% else %}

1. Open the [link]({{ link-get-token }}) and copy the OAuth token. The token you received must be used in requests to the {{ tracker-name }} API.

{% endif %}

1. To check if you have access to the API, [request information about the current user](../get-user-info.md).
If no access permission is granted, you'll get a response with code `401 Unauthorized`.

The token permissions correspond to the permissions for the {{ tracker-name }} account. For example, if the user isn't allowed to change queue settings, API requests to change queue settings won't be available using this token.

{% if audience == "external" %}

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
      POST https://iam.{{ api-host }}/iam/v1/tokens
     
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

{% endif %}

## Python client {#section_about_python_client}

When developing applications in Python, you can use the {% if audience == "external" %}[yandex_tracker_client](https://github.com/yandex/yandex_tracker_client){% else %}[startrek_client](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/){% endif %} package that is a client designed to make it easier to work with the {{ api-short-name }}.

To start using the client:

1. Download and install the latest Python version from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. Run the following command in your OS command line:

    {% if audience == "external" %}

    ```
    pip install yandex_tracker_client
    ```

    {% else %}

    ```
    pip install -i https://pypi.yandex-team.ru/simple/ startrek_client
    ```

    or

    ```
    pip install git+git://github.yandex-team.ru/tools/startrek-python-client.git
    ```

    {% endif %}

{% if audience == "external" %}

1. Receive your OAuth token and organization ID to access the API. For more information about how to do this, see the [API reference](../concepts/access.md).

1. Initialize the client in your program's code:

    ```
    from yandex_tracker_client import TrackerClient
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```

    Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

In the client, use the same data format as in the {{ tracker-name }} API.

For more information about how the client works and its terms of use, see its GitHub page: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

{% else %}

1. Get an OAuth token. To do this, follow the link and log in: [https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b).

1. Initialize the client in your program's code:

    ```
    from startrek_client import Startrek
    client = Startrek(token=<token>)
    ```

    Here, `<token>` is your OAuth token.

In the client, use the same data format as in the {{ tracker-name }} API.

Additional information:

- [https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client](https://a.yandex-team.ru/arc/trunk/arcadia/library/python/startrek_python_client)

- [https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/)

{% endif %}

