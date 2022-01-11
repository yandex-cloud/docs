---
sourcePath: en/tracker/api-ref/concepts/access.md
---
# API access

Applications use the OAuth 2.0 protocol to access {{ api-name }}.

If your app is written in Python, you can use our Python client with the API.

## Get access to the API {#section_about_OAauth}

OAuth 2.0 allows applications to access Yandex services on behalf of the user. For information about basic OAuth concepts and the Yandex implementation of the protocol, see the ["OAuth authorization. Developer's guide"]({{ link-OAuth-dev-guide }}).

To get access to {{ api-name }}:

1. [Register]({{ link-register-application }}) your application and configure its read and write access rights in {{ tracker-name }}.

1. [Obtain]({{ link-get-token }}) an OAuth token for authorization.

1. In requests to the {{ api-short-name }} API, specify the following headers:

    - `Host: https://api.tracker.yandex.net`

    - `Authorization: OAuth <your OAuth token>`

    - `X-Org-Id: <your organization ID>`
To find your organization's ID, go to the [{{ tracker-name }} settings]({{ link-get-token }}) page. The ID is shown in **Organization ID for API**.

1. To check if you have access to the API, make a [request for information about the current user](../get-user-info.md).
If no access permission is granted, you'll get a response with code `401 Unauthorized`.

The token permissions correspond to the permissions for the {{ tracker-name }} account. For example, if the user isn't allowed to change queue settings, API requests to change queue settings won't be available using this token.

## Python client {#section_about_python_client}

When developing applications in Python, you can use the [yandex_tracker_client]({{ link-yandex_tracker_client }}) package, a client that makes it easier to work with {{ api-short-name }}.

To start using the client:

1. Download and install the latest version of Python from the [official site]({{ link-python-official }}).
1. Run the following command in your OS command line:

    ```
    pip install yandex_tracker_client
    ```
1. Receive your OAuth token and organization ID to access the API. For more information about how to do this, see the {{ api-short-name }} documentation.
1. Initialize the client in your program's code:

    ```
    from yandex_tracker_client import TrackerClient
    ```

    ```
    client = TrackerClient(token=<token>, org_id=<org_id>)
    ```

    Here `<token>` is your OAuth token, and `<org_id>` is your organization ID.

For more information about how the client works and its terms of use, see its page on GitHub: [https://github.com/yandex/yandex_tracker_client]({{ link-yandex_tracker_client }}).
