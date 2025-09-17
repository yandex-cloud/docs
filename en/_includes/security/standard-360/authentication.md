## Authentication and access management

### Number of organization administrators is minimal {#Y360-1}

**Y360-1**

[Organization 360](https://yandex.com/support/yandex-360/business/admin/ru/org-admin) is a logical container in the {{ yandex-360 }} infrastructure which consolidates a company’s employees, domains, groups, and services. You can manage the organization profile, change its owner, configure domains, and work with audit logs via the admin profile.

[Admins](https://yandex.com/support/yandex-360/business/admin/ru/admin) have the widest permissions within a {{ yandex-360 }} organization, including management of security settings, employee access, and integrations. With too many admins, the risk of compromising critical functions increases.

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  1. [Log in](https://admin.yandex.ru/) as the organization administrator.
  1. Go to the [Employees](https://admin.yandex.ru/users) page.
  1. The rows of users with admin permissions will indicate **Admin**, and their profile images will be marked with the relevant icon.

- Checking via the API {#API}

  To view a list of employees, use the [UserService_List](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_List) REST API method for the [UserService](https://yandex.ru/dev/api360/doc/ru/ref/UserService/) resource. To find users with admin permissions, filter the results by the `isAdmin: true` parameter.

{% endlist %}

**How to implement:**

* Limit the number of admins to one (or the minimum required number).
* For other users with administrative tasks, use roles with restricted permissions. For more information, see the [documentation](https://yandex.com/support/yandex-360/business/admin/ru/accounts).

### Second factor is used for domain users and Yandex ID users {#Y360-3}

**Y360-3**

To improve security of access to {{ yandex-360 }} corporate services, use two-factor authentication (2FA) for all domain users and Yandex ID users. This means, in addition to their password, a user will need a one-time code delivered by phone call or SMS to log in to their account. Such approach significantly reduces the risk of unauthorized access even if the password has been compromised.

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  1. [Log in](https://admin.yandex.ru/) as the organization administrator.
  1. Select **Login confirmation** in the **Security** menu.
  1. Specify the required settings:

      * **Enable for**: Specify `All employees` if you are enabling verification for the entire organization or `Selected employees` if you want to set it up individually.
      * **Warning period**: Time given to users to set up sign-in verification. After this period expires, employees will not be able to postpone its setup.

      {% note info %}

      The **Verification method** setting is non-editable. The priority method for code delivery is a phone call. SMS delivery is used only when phone calls are not available.

      {% endnote %}

  1. Click **Enable**.

  1. If you are enabling login confirmation for specific users, [select](https://yandex.ru/support/yandex-360/business/admin/ru/security/set-2fa#select-users) them.

  1. If you are enabling login confirmation for all organization users, you can forcibly terminate sessions of all user accounts.

- Checking via the API {#API}

  1. To get the 2FA setup status for an organization, use the [Domain2FAService_Get](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/Domain2FAService_Get) REST API method for the [Domain2FAService](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/) resource. Make sure 2FA is enabled for all domain users or selected employees according to your organization’s policy.

  1. To get the 2FA setup status for each domain user, use the [UserService_Get2fa](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_Get2fa) REST API method for the [UserService](https://yandex.ru/dev/api360/doc/ru/ref/UserService/) resource. Make sure the `twofaEnabled` parameter in the response body is set to `true`.

  1. To check that domain users are unable to postpone setting up a second factor, use the [Domain2FAService_Disable](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/Domain2FAService_Disable) REST API method for the [Domain2FAService](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/) resource. Make sure there are no users with active postponement of 2FA setup.

      {% note info %}

      For Yandex ID users, use the available verification options via Yandex ID.

      {% endnote %}

{% endlist %}

**How to implement:**

[Set up](https://yandex.ru/support/yandex-360/business/admin/ru/security/set-2fa#on) two-factor authentication for all employees using Yandex ID or {{ yandex-360 }} domain accounts. This is the minimum security standard to adopt in all organizations handling protected or critical information.

### Password policy is enabled in your organization {#Y360-6}

**Y360-6**

An organization must have an active password management policy which requires users to change their passwords at least every six months. This is an additional security measure in case 2FA is not implemented or is not enabled for all users.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To get password policy parameters, use the [DomainPasswordsService_Get](https://yandex.ru/dev/api360/doc/ru/ref/DomainPasswordsService/DomainPasswordsService_Get) REST API method for the [DomainPasswordsService](https://yandex.ru/dev/api360/doc/ru/ref/DomainPasswordsService/) resource. Make sure the `enabled` parameter in the response body is set to `true` and the `changeFrequency` parameter value does not exceed 180 days.
  
  **Response example:**

   ```json
   {"changeFrequency":180,"enabled":true}
   ```
  
  If `enabled: false` or `changeFrequency > 180`, the policy does not comply with Y360-6.

{% endlist %}

**How to implement:**

[Set](https://yandex.ru/dev/api360/doc/ru/ref/DomainPasswordsService/DomainPasswordsService_Update.html) the password policy parameters so that password expiration period does not exceed 180 days and check that users can actually change their passwords.

### Organization owner’s account has recovery tools {#Y360-9}

**Y360-9**

Make sure to set up access recovery options for the organization owner’s account:

  1. Associated phone number (secure phone) for recovery via SMS or phone call.
  1. Two-factor authentication (2FA) to enforce using a second factor.
  
      Specifics:
  
      * For domain users, you can check 2FA via the API.
      * For `@yandex.ru` accounts, you need to perfrom the check manually (the API is not available).

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  1. [Log in](https://admin.yandex.ru/) as the organization administrator.
  1. In the security settings, manually check that:
      * There is an associated phone number.
      * 2FA is activated.

- Checking via the API {#API}

  1. To make sure the organization owner’s account has access recovery options configured, use the [UserService_Get](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_Get) REST API method for the [UserService](https://yandex.ru/dev/api360/doc/ru/ref/UserService/) resource. Make sure the `has_security_phone` and `2fa_enabled` parameters in the response body are set to `true`.
  
  1. To check global 2FA settings in an organization, use the [Domain2FAService_Get](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/Domain2FAService_Get) REST API method for the [Domain2FAService](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/) resource. Make sure the `enabled` parameter in the response body is set to `true 2FA`.

{% endlist %}

**How to implement:**

{% list tabs group=instructions %}

- {{ yandex-360 }} console {#yandex-360-console}

  1. [Log in](https://admin.yandex.ru/) as the organization administrator.
  1. Select **Login confirmation** in the **Security** menu.
  1. Specify the required settings:
        
      * **Enable for**: Specify `All employees`.
    
  1. Click **Enable**.
  
  For Yandex accounts, transfer the organization ownership to a domain user.

- API {#API}

  To enable 2FA for a domain account, use the [Domain2FAService_Enable](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/Domain2FAService_Enable) REST API method for the [Domain2FAService](https://yandex.ru/dev/api360/doc/ru/ref/Domain2FAService/) resource.

{% endlist %}
