# API access

Applications use authorization over the [OAuth 2.0 protocol](#section_about_OAauth){% if audience == "external" %}or with an [IAM token](#iam-token){% endif %} to access {{ api-name }}.

If your app is written in Python, you can use our [Python client](#section_about_python_client) with the API.

In requests to the {{ api-short-name }} API, specify the following headers:

- `Host: {{ host }}`

- `Authorization: OAuth <your OAuth token>`{% if audience == "external" %}: If [OAuth 2.0](#section_about_OAauth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](#iam-token) is used.

- `X-Org-ID: <organization ID>`

   To find out the organization ID, go to the [settings page {{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.

{% endif %}

## Get access to the API over the OAuth 2.0 protocol {#section_about_OAauth}

OAuth 2.0 allows applications to access Yandex services on behalf of the user. For information about basic OAuth concepts and the Yandex implementation of the protocol, see the ["OAuth authorization. Developer's guide"]({{ link-OAuth-dev-guide }}).

To get access, register your application first. The application forwards the user to the access request page on the Yandex OAuth server. The user signs in to Yandex and authenticates the application to access their data.

To get access to {{ api-name }}:

{% if audience == "external" %}

1. [Register]({{ link-register-application }}) your application on the OAuth server:

   1. Go to [**Creating an application**]({{ link-get-token }}client/new) page. Name the application.

   1. Select the platform where your application runs and specify its [settings]({{ link-register-application-platforms }}#register-client__platform).

      For example, for the debug requests to the API, select **Web services**, and in the **Callback URL** field, enter the default value using the **Add the URL for developers** link.

   1. Under **What kind of data do you need?** open **Yandex Tracker (tracker)** and select the options:
      * **Write in tracker (tracker:write)**.
      * **Read from tracker (tracker:read)**.

   1. Click **Create app**.

1. Get an OAuth token for authorization:

   1. Select your app from the [list]({{ link-get-token }}).

   1. Copy the value to the **ClientID** field and create a link for the token request:
      `{{ link-get-token }}authorize?response_type=token&client_id=<app ID>`
      You can specify [additional parameters]({{ link-web-oauth }}) for the token request.

   1. Follow the link and copy the OAuth token. Use this token in your API requests {{ tracker-name }}.

   {% note info %}

   Yandex&#160;OAuth forwards the user to the URL from the **Callback URL** field on the app page. The URL is generated automatically based on the app settings and the platform parameters.
   If your app is still under development, to access {{ tracker-name }}, you can manually request a [debug token]({{ link-oauth-token }}) on behalf of a test user.

   {% endnote %}

{% else %}

1. Follow the [link]({{ link-get-token }}) and copy the OAuth token. Use this token in your API requests {{ tracker-name }}.

{% endif %}

1. To check if you have access to the API, [request information about the current user](../get-user-info.md).
   If no access permission is granted, you'll get a response with code `401 Unauthorized`.

The token permissions correspond to the permissions for the {{ tracker-name }} account. For example, if the user isn't allowed to change queue settings, API requests to change queue settings won't be available using this token.

{% if audience == "external" %}

## Access the API with an IAM token {#iam-token}

An IAM token is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the {{ api-name }} and to access resources. Read more about this authentication method in the [documentation of the identification and access control service](../../iam/concepts/authorization/iam-token.md).

The IAM token is valid for no more than {{ iam-token-lifetime }} and is limited by the cookie lifetime for the [federation](../../organization/add-federation.md). After the lifetime expires, the `401 Unauthorized` error is returned.

### Get an IAM token for a Yandex account {#iam-token-yandex-account}

{% list tabs %}

- CLI

   1. {% include [cli-install](../../_includes/cli-install.md) %}

   1. Get an IAM token:

   ```
   $ yc iam create-token
   ```

- API

   1. Get an OAuth token by the link [https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb).

   1. Exchange the received token for an IAM token. To do this, use an HTTP `POST` request:

      ```json
       POST https://iam.{{ api-host }}/iam/v1/tokens

        {
           "yandexPassportOauthToken": "<OAUTH-token>"
        }
      ```
   1. The API returns a response. The response body contains information in JSON format. The value you need is in the **iamToken** attribute.

   > Sample response:
   > ```
   >  {
   >    "iamToken": "t1.9euelZqYksrMiYrGiY-TmpGUnZPHz-3rnpWay4-SjJCKnp7KlouMjJ3Kncrl9PcSLTl0-e8rTxrv3fT3Uls2dPnvK08a7w.vqGV8pzV84HGSmX9eLmvKaIBpRx9HDbKWEwN6ryIQ",
   >    "expiresAt": "2021-10-22T05:54:53.035215444Z"
   >  }
   > ```

{% endlist %}

### Get an IAM token for a federated account {#iam-token-federation}

1. {% include [cli-install](../../_includes/cli-install.md) %}

1. To initiate a [federated account](../../iam/operations/iam-token/create-for-federation.md), run:

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

When developing applications in Python, you can use the {% if audience == "external" %}[yandex_tracker_client](https://github.com/yandex/yandex_tracker_client){% else %}[startrek_client](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/startrek_client/){% endif %} package, a client that makes it easier to work with {{ api-short-name }}.

To start using the client:

1. Download and install the latest Python version from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. From your OS command line, run:

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

1. Get an OAuth token and your organization ID to access the API. For more information about how to do this, see the [API reference](../concepts/access.md).

1. Initialize the client in your program code:
   ```
   from yandex_tracker_client import TrackerClient
   client = TrackerClient(token=<token>, org_id=<org_id>)
   ```
   Here, `<token>` is your OAuth token and `<org_id>` is your organization ID. To find out the organization ID, go to the [settings page{{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.

In the client, use the same data format as in the {{ tracker-name }} API.

For more information about how the client works and its terms of use, see its page on GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

{% else %}

1. Get an OAuth token. To do this, follow the link and log in: [https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b](https://oauth.yandex-team.ru/authorize?response_type=token&client_id=5f671d781aca402ab7460fde4050267b).

1. Initialize the client in your program code:
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


