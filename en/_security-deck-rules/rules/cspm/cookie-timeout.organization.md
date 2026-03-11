### The cookie lifetime timeout in the federation is less than 6 hours {#cookie-timeout-organization}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | cookie-timeout.organization ||
|#

#### Description

Limiting the validity period of cookies is a key security measure for web applications, as it significantly reduces the risks associated with the compromise of user sessions. A short timeout minimizes the potential damage in the event of cookie theft (e.g., through XSS or MITM attacks) and limits the time during which an attacker can use the intercepted data.

In addition, automatic session termination after a predetermined period (e.g., 6 hours) prevents unauthorized access if a user forgets to log out of their account on a foreign device or if their device has been compromised.

#### Guides and solutions to use

In your [identity federation](https://yandex.cloud/en/docs/organization/concepts/add-federation) settings make sure the **Cookie lifetime** value is less or equal to 6 hours. This would help minimize the risk of compromising cloud users' workstations.

Set the **Cookie lifetime** to 6 hours (21,600 seconds) or less.