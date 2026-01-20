# Audit logs and login logs


In {{ org-full-name }}, you can view user login and audit logs. Logs are generated based on [{{ at-full-name }}](../../audit-trails/) events and linked to them via IDs but only include certain event types with a limited amount of data per event.

For convenience, the log view pages have the following filters:

* Time.
* IP address.
* Operation or login type and status.
* User or operation login or ID.

{% include [roles-for-view-logs](../../_includes/organization/roles-for-view-logs.md) %}

## Login logs {#auth-logs}

_Login logs_ display authentication events in apps connected to your organization ({{ yandex-cloud }} console, [{{ src-full-name }}]({{ link-src-docs }})) as well as [external apps](applications.md) with SSO authentication.

## Audit logs {#audit-logs}

_Audit logs_ are generated based on events related to user actions in the organization.

You can [view](../operations/user-pools/user-get-logs.md) the full list of events supported by audit logs on the user page in the **{{ ui-key.yacloud_org.organization.users.Filters.placeholder_eu3h7 }}** filter.
