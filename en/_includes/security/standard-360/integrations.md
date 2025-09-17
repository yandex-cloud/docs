## Integrations and third-party services

### The organization does not use portal accounts {#Y360-7}

**Y360-7**

The organization does not allow personal accounts with `@yandex.ru` email addresses, as it is not possible to centrally manage security policies for such accounts. Organization ownership must be delegated exclusively to domain users.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To get a list of employees, use the [UserService_List](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_List) REST API method for the [UserService](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_List) resource. Make sure the `email` parameter in the response body does not end with `@yandex.ru`. Personal accounts do not pass the **Y360-7** check.

{% endlist %}

**Guides and solutions to use:**

We recommend avoiding the use of personal `@yandex.ru` portal accounts in the corporate environment. Instead, delegate organization ownership to domain users to enable centralized security policy management and controlled access to corporate resources.

### The organization uses SSO based on a SAML-compatible IdP {#Y360-8}

**Y360-8**

The organization use single sign-on (SSO) access implemented through an external SAML-compatible identity provider (IdP). Domain users must not coexist with SSO accounts. If you do not have a dedicated IdP, you can use {{ org-full-name }}. To do so, create a SAML application in {{ org-name }} and configure it both on the {{ org-name }} side and the service provider side.

For more information, see [Creating a SAML application in {{ org-full-name }}](../../../organization/operations/applications/saml-create.md).

**How to implement:**

We recommend using single sign-on (SSO) through a SAML-compatible IdP for centralized access management and enhanced security. This will simplify the authentication process for users and streamline the management of access to the organization's resources.

### Checking issued OAuth tokens and their permissions available when setting up the application {#Y360-10}

**Y360-10**

This control involves checking that all issued OAuth tokens comply with the principle of least privilege, there are no tokens with excessive permissions, and that only trusted applications and users get to own the tokens. You do this to maintain security and manage access to the services, in particular to:
  * Ensure compliance with the principle of least privilege.
  * Make sure there are no tokens with excessive permissions (e.g., `mail:full_access` or `cloud:admin`).

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  To check the list of connected applications:

    1. [Log in](https://admin.yandex.ru/) as the organization administrator.
    1. Go to **Security** → **Service applications**.
    1. View the list of all registered applications.
    1. Cross-reference each application with your internal registry of trusted integrations, check for mismatches and suspicious integrations.

  To check scopes:

    1. For each application, copy its Client ID.
    1. Navigate to `https://oauth.yandex.com/client/<client_id>/info`, where `client_id` is the application ID.

    1. Check the page for:
        * Scopes requested by the application.
        * Whether the application has access to sensitive data (mail, calendar, contacts, etc.).
        
    1. Compare the requested permissions against the application's actual needs, check for excessive or suspicious permissions.

  To check authentication:

    1. [Log in](https://admin.yandex.ru/) as the organization administrator.
    1. Go to **Security** → **Devices and activity**.
    1. View the list of active user sessions looking for:
        * Employees with third-party apps connected.
        * Inactive or suspicious sessions.

    1. Optionally, you can:
        * Terminate unnecessary or outdated sessions.
        * Notify users they need to revise their accesses.

  To disconnect applications you do not need:

    1. [Log in](https://admin.yandex.ru/) as the organization administrator.
    1. Go to **Security** → **Service applications**.
    1. Deactivate or remove all unapproved, outdated, or unused applications.
    1. Make sure you leave only applications that:
        * Are officially approved.
        * Satisfy the principle of least privilege.
        * Have no excessive permissions.

- Checking via the API {#API}

  1. To get a list of service applications and their scopes, use the [ServiceApplicationsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/ServiceApplicationsService_Get) REST API method for the [ServiceApplicationsService](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/) resource.

  1. To shorten the list of service applications, use the [ServiceApplicationsService_Create](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/ServiceApplicationsService_Create) method for the [ServiceApplicationsService](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/) resource.

  1. To test actual access using a short-lived token, do the following:

      Issue a temporary token for a particular user and check that the operations succeed only within the granted permissions:
      
      ```bash
      curl --location \
      --request POST 'https://oauth.yandex.ru/token' \
      --header 'Content-Type: application/x-www-form-urlencoded' \
      --data-urlencode 'grant_type=urn:ietf:params:oauth:grant-type:token-exchange' \
      --data-urlencode 'client_id=<OAuth_service_app_client_id>' \
      --data-urlencode 'client_secret=<OAuth_service_app_client_secret>' \
      --data-urlencode 'subject_token=<user_id>' \
      --data-urlencode 'subject_token_type=urn:yandex:params:oauth:token-type:uid'
      ```

      Where:
        * `OAuth_service_app_client_id`: Client ID of the service app.
        * `OAuth_service_app_client_secret`: Client secret of the service app.
        * `user_id`: User ID.
        * `user_email`: User email in `username@domain.ru` format.

      The response will contain a token for use in {{ yandex-360 }} API requests.

{% endlist %}

**How to implement:**

Apply the principle of least privilege to each service app. Maintain a registry (owner, purpose, minimal scopes). Revise at least once per quarter. Use short-lived tokens for one-off tasks, promptly revoke tokens you no longer need. For Disk, use narrow scope permissions where possible (e.g., `cloud_api:disk.app_folder` or `cloud_api:disk.read`).

### Authentication in external OAuth services is banned {#Y360-12}

**Y360-12**

To strengthen information security, we recommend you to ban your employees from authenticating in third-party OAuth services using their corporate accounts. This will prevent corporate OAuth tokens being forwarded to external apps, thus minimizing the risk of phishing, account compromise, and corporate data leaks through external services.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To get the ban status, use the [OauthAccessRestrictionsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/OauthAccessRestrictionsService/OauthAccessRestrictionsService_Get) REST API method for the [OauthAccessRestrictionsService](https://yandex.ru/dev/api360/doc/ru/ref/OauthAccessRestrictionsService/) resource.
  
  Analyze the response:

    * `"restricted": true`: Employees cannot authenticate in third-party services via {{ yandex-360 }}.
    * `"restricted": false`: The ban needs to be set.

      To set the ban on authentication in external OAuth services, use the [OauthAccessRestrictionsService_Enable](https://yandex.ru/dev/api360/doc/ru/ref/OauthAccessRestrictionsService/OauthAccessRestrictionsService_Enable) REST API method for the [OauthAccessRestrictionsService](https://yandex.ru/dev/api360/doc/ru/ref/OauthAccessRestrictionsService/) resource.

{% endlist %}

**How to implement:**

* [Set](https://yandex.ru/dev/api360/doc/ru/ref/OauthAccessRestrictionsService/OauthAccessRestrictionsService_Get) the ban (`restricted = true`) for all employees with accounts in the corporate domain.
* Revisit this policy from time to time, especially after updates in the organization's management structure or bulk third-party app integrations.

### New service app connections are banned or limited to a list of trusted applications {#Y360-13}

**Y360-13**

To make your organization more protected, service app connections must be limited as much as possible: 
  * Either banned completely (default), or
  * Limited exclusively to a list of pre-approved, trusted applications authorized by your security or IT team. All unauthorized, unknown, or suspicious app must be off the list.

Service apps can request various scopes and interact with corporate resources. Uncontrolled service app integrations greatly increase the risks of data theft, unauthorized access, malware injection, and circumvention of perimeter security policies.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To get the current list of service apps, use the [ServiceApplicationsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/ServiceApplicationsService_Get) REST API method for the [ServiceApplicationsService](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/) resource. In the response body, find the `applications` array with objects formatted as follows:

  ```json
  {
    "id": "some_id",
    "scopes": [
      "scope1",
      "scope2"
    ]
  }
  ```

  Analyze the response:
    * Check if the apps are on your organization's internal whitelist of approved service apps.
    * Make sure there are no unknown, unused, or suspicious apps on the list.
    * Review the granted scopes and minimize excessive permissions.

  If no service apps are allowed, the list must be empty.

{% endlist %}

**Guides and solutions to use:**

* By default, [prohibit](https://yandex.ru/dev/api360/doc/ru/ref/ServiceApplicationsService/ServiceApplicationsService_Deactivate) users from connecting any service apps (whitelist only). Audit the list of connected service applications and their scopes on a regular basis.
* Have new connections approved by your information security team and tighten up access control.
* Promptly remove unknown or suspicious apps.
