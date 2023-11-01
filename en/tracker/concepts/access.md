---
sourcePath: en/tracker/api-ref/concepts/access.md
---
# API access

Applications use the OAuth 2.0 protocol to access {{ api-name }}.

If your app is written in Python, you can use our [Python client](#section_about_python_client) with the API.

In requests to the {{ api-short-name }} API, specify the following headers:

* `Host: {{ host }}`

* `Authorization: OAuth <your OAuth token>`: If [OAuth 2.0](#section_about_OAuth) is used.

   `Authorization: Bearer <your IAM token>`: If an [IAM token](#iam-token) is used.

* `X-Org-ID or X-Cloud-Org-ID: <organization ID>`

   If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.


   You can copy the organization ID from the [{{ tracker-name }} organization page]({{ link-tracker }}admin/orgs).


## Getting access to the API via OAuth 2.0 {#section_about_OAuth}

OAuth 2.0 allows applications to access Yandex services on behalf of the user. For information about basic OAuth concepts and the Yandex implementation of the protocol, see the [OAuth for Yandex ID documentation]({{ link-OAuth-dev-guide }}).

To get access to {{ api-name }}:


1. [Register]({{ link-OAuth-register }}/#access-note) the application in [Yandex OAuth]({{ link-OAuth }}):

   1. Follow this direct link: [{{ link-OAuth }}client/new/]({{ link-OAuth }}client/new/).

   1. Under **Platforms**, select the platform you need and specify its parameters.

      If you are developing or testing an application, use a [debug token]({{ link-OAuth-debug-token }}). To get it, select **Web services** and, in the **Redirect URI** field, enter the default value from the **Enter URL for debugging** prompt: `{{ link-OAuth }}verification_code`.

   1. Under **Data access**, select {{ tracker-name }} access permissions that your application needs:

      * **Write in tracker (tracker:write)** to allow any operations with data, such as creating, deleting, and editing.

      * **Read from tracker (tracker:read)** to only allow data reads.

1. Get an OAuth token:

   1. In your [Yandex OAuth]({{ link-OAuth }}) account, select the previously created application and copy its ID from the **ClientID** field. Next, generate a link to request a token:

      ```
      {{ link-OAuth }}authorize?response_type=token&client_id=<application ID>
      ```

   1. Follow the link and copy the OAuth token.

   {% note tip %}

   If you need a confirmation code from a user to get an OAuth token, follow the guide in the [Requesting an OAuth token using a confirmation code]({{ link-OAuth-codes }}) section.

   {% endnote %}


1. Use the obtained token in the `Authorization` header when making requests to the {{ tracker-name }} API. The OAuth token grants the same permissions as those of the user account in {{ tracker-name }}. For example, if the user is not allowed to change queue settings, API requests to change queue settings will not be available using this token.

1. To check if you have access to the API, [request information about the current user](../get-user-info.md).

   If no access permission is granted, you will get a response with the `401 Unauthorized` code.


## Access the API with an IAM token {#iam-token}

An IAM token is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the {{ api-name }} and to access resources. Read more about this authentication method in the [documentation of the identification and access control service](../../iam/concepts/authorization/iam-token.md).

* [Getting an IAM token for a Yandex account](../../iam/operations/iam-token/create.md)

* [Getting an IAM token for a federated account](../../iam/operations/iam-token/create-for-federation.md)

{% note info %}

The IAM token is valid for no more than {{ iam-token-lifetime }} and is limited by the cookie lifetime for the [federation](../../organization/concepts/add-federation.md). After the lifetime expires, the `401 Unauthorized` error is returned.

{% endnote %}


## Python client {#section_about_python_client}

When developing applications in Python, you can use the [yandex_tracker_client](https://github.com/yandex/yandex_tracker_client) package, a client that makes it easier to work with {{ api-short-name }}.

To start using the client:

1. Download and install the latest Python version from [https://www.python.org/downloads/](https://www.python.org/downloads/).

1. From your OS command line, run:

   
   ```
   pip install yandex_tracker_client
   ```



1. [Get an OAuth token](#section_about_OAuth) and your organization ID to access the API.

   To find out the organization ID, go to the [settings page {{ tracker-name }}]({{ link-settings }}). The ID is shown in **Organization ID for API**.

1. Initialize the client in your program code:

   ```
   from yandex_tracker_client import TrackerClient
   client = TrackerClient(token=<token>, org_id=<org_id>)
   ```

   Here, `<token>` is your OAuth token and `<org_id>` is your organization ID.

In the client, use the same data format as in the {{ tracker-name }} API.

For more information about how the client works and its terms of use, see its page on GitHub: [https://github.com/yandex/yandex_tracker_client](https://github.com/yandex/yandex_tracker_client).

