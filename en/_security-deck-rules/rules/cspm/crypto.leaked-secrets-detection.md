### The cloud administrator receives a notification in case their cloud's secret gets compromised {#leaked-secrets-detection}
#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | crypto.leaked-secrets-detection ||
|#

#### Description

**How the rule works**: The rule checks whether the [workspace](https://yandex.cloud/en/docs/security-deck/concepts/workspace) has **Basic Threat Detector rules** enabled and the **Cloud secret was exposed** rule is not among the exceptions.

[Threat Detector (TD)](https://yandex.cloud/en/docs/security-deck/concepts/threat-detector) analyzes audit events found in the client's infrastructure and registered using [Yandex Audit Trails](https://yandex.cloud/en/docs/audit-trails/). This module automatically identifies suspicious activity and notifies the user on any threats discovered.

The module's requirements include the **Cloud secret was exposed** check. This check aims at detecting leaks of cloud credentials, including [API keys](https://yandex.cloud/en/docs/iam/concepts/authorization/api-key), tokens, access keys, OAuth tokens, and other secrets associated with [Identity and Access Management](https://yandex.cloud/en/docs/iam/) (IAM).

Credentials, such as access keys or tokens, provide direct access to the cloud's resources. If they end up in public or unreliable sources, such as code repositories, logs, or third-party websites, this may result in security compromises, unauthorized access, and loss of control over the infrastructure.

This rule is triggered when a secret leak is detected by the monitoring system. It identifies the type of the leaked secret (whether it be an [IAM token](https://yandex.cloud/en/docs/iam/concepts/authorization/iam-token), API key, service account [access key](https://yandex.cloud/en/docs/iam/concepts/authorization/access-key), Lockbox [secret](https://yandex.cloud/en/docs/lockbox/concepts/secret), or other) and points to the [service account](https://yandex.cloud/en/docs/iam/concepts/users/service-accounts) which it is associated with. Also recorded is the URL where the secret was found.

#### Instructions and solutions

Enable the **Basic Threat Detector rules** check:
1. Navigate to [Security Deck](https://center.yandex.cloud/security/).
2. In the left-hand panel, select **Workspace** and in the window that opens, select your Security Deck [workspace](https://yandex.cloud/en/docs/security-deck/concepts/workspace).
3. Click **Workspace parameters**.
4. Navigate to the **Control modules** tab.
5. Expand the **Threat Detection** standard list.

    {% note tip %}

    If the module is not on the list, contact a manager to gain access.

    {% endnote %}

6. Enable **Basic Threat Detector rules**.