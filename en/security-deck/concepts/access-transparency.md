---
title: Access Transparency in {{ sd-full-name }}
description: Access Transparency is an automated tool within {{ sd-name }} designed to ensure transparency of {{ yandex-cloud }} operations.
---

# Access Transparency

[Access Transparency]({{ link-sd-main }}transparency/) is an automated tool providing analytical information about the actions {{ yandex-cloud }} engineers take with your organization's resources during maintenance, when handling [support requests](../../support/overview.md), or for security purposes. With this tool, you can gain visibility and control over the actions of {{ yandex-cloud }} engineers.

{% include [access-transparency-attach-ba-notice](../../_includes/security-deck/access-transparency-attach-ba-notice.md) %}

Main features of Access Transparency:

* Collects and analyzes data on the actions taken by {{ yandex-cloud }} engineers with the organization's resources.
* Provides access to security verdicts of specific user sessions.
* Automatically alerts you to suspicious activity or security breaches:

    * A specialized model based on {{ yagpt-name }} analyzes the logs of {{ yandex-cloud }} personnel activity with your organization's resources.
    * If the model detects security risks in a {{ yandex-cloud }} employee’s actions, a request is automatically created to verify these actions.
    * If you do not agree with the analysis or assessment, you can escalate the request to have the session reviewed by {{ yandex-cloud }} information security team.
