## Data encryption and protection

### Every domain user has a linked phone number (secure phone) {#Y360-4}

**Y360-4**

For added security, domain users must have a mobile phone number (**secure phone**) linked to each account. In addition to reliable authentication and account recovery, this will also enable two-factor authentication (2FA).

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  1. Go to the [Phones](https://id.yandex.ru/profile/phones) page.
   
      The page will display several numbers if a phone number different from main one was specified in a different Yandex service.

- Checking via the API {#API}

  To get the 2FA setup status for each domain user, use the [UserService_Get2fa](https://yandex.ru/dev/api360/doc/ru/ref/UserService/UserService_Get2fa) REST API method for the [UserService](https://yandex.ru/dev/api360/doc/ru/ref/UserService/) resource. In the response, check that the `hasSecurityPhone` field is set to `true`.
  
  {% note info %}

  For users with a Yandex ID account, this verification mechanism will be implemented at a later stage.

  {% endnote %}

{% endlist %}

**How to implement:**

It is the administrator's duty to have the users' phone numbers [linked](https://yandex.com/support/id/ru/authorization/phone.html) to their domain accounts. This is done to strengthen security and prevent unauthorized access.

### If there is an existing DLP system in place, configure it for {{ yandex-360 }} services {#Y360-14}

**Y360-14**

To protect corporate information and minimize the risk of data leaks, we recommend setting up the DLP (Data Loss Prevention) system in {{ yandex-360 }} services. DLP automatically detects sensitive information, such as passwords, tokens, secret keys, personal data, etc., and prevents it getting in the hands of unauthorized recipients.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To check if there is a rule for incoming and outgoing mail to be forwarded to a DLP address, use the [RoutingService_GetRules](https://yandex.ru/dev/api360/doc/ru/ref/RoutingService/RoutingService_GetRules) REST API method for the [RoutingService](https://yandex.ru/dev/api360/doc/ru/ref/RoutingService/) resource. Make sure that one of the rules (the first or required one) has the `forward` action to forward emails to a dedicated DLP address (`dlp@domain.ru` or similar).

  **Response example:**

  ```bash
  {
    "terminal": false,
    "condition": {},
    "actions": [
      {
        "data": {"email": "dlp@domain.ru"},
        "action": "forward"
      }
    ],
    "scope": {"direction": "outbound"}
  }
  ```

  Also check the `incoming mail forwarding` setting: we recommend forwarding all correspondence for extended control.

  **How to implement:**

  1. Consider setting up forwarding of outgoing (and, optionally, incoming) mail to a dedicated _DLP mailbox_ for automated analysis:
      * Check if there is a forwarding rule with the help of the `GET https://api360.yandex.net/admin/v1/org/{ORGANIZATION}/mail/routing/rules` API request.
      * Make sure that one of the rules has the `forward` action to forward emails to a dedicated DLP address, e.g., `dlp@domain.ru`.
  1. Make sure the DLP mailbox can be accessed externally:
      * Create a dedicated user for integration of the DLP platform with the mailbox.
      * Set up an app-specific password or OAuth access for this user.
  1. Check if email scans are on for:
      * Passwords and password reset requests.
      * Access tokens.
      * SSH, PKI, or VPN private keys.
      * Personal or confidential data (if this is part of the policy).

{% endlist %}
