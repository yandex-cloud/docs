## Monitoring and audit

### Organization users who last logged in more than 30 days ago are blocked {#Y360-5}

**Y360-5**

To minimize the risks of unauthorized access, you should regularly audit user activity. We recommend blocking or deleting accounts that were inactive for more than 30 days. This especially concerns organizations with high turnover of staff, contractors, or temporary employees.

Before implementing this measure, make sure the session cookie lifetime in your organization is limited according to the **Y360-2** standard. This is required for accurate evaluation of user activity.

{% list tabs group=instructions %}

- Checking via the API {#API}

  To get a list of events in the organization’s audit log, use the [get-logs](https://yandex.ru/dev/api360/doc/ru/audit-logs/get-logs) REST API method for the [audit-logs](https://yandex.ru/dev/api360/doc/ru/audit-logs/) resource. Make sure the `occurred_at` parameter value in the response body does not exceed 30 days.

{% endlist %}

**How to implement:**

For added security, we recommend blocking or deleting user accounts that were inactive for more than 30 days, provided you comply with the **Y360-2** standard for session cookies.

[How to block or unblock an employee](https://yandex.com/support/yandex-360/business/admin/ru/users#block-user).

[How to delete an employee account](https://yandex.com/support/yandex-360/business/admin/ru/users#sec_delete).

### Monitoring of audit log events is set up {#Y360-11}

**Y360-11**

This recommendation mandates collection and analysis of audit log events in order to detect potentially dangerous actions and anomalies in the system. Such events may include information about access to files, user activity, system logins, and other actions.

Admins and managers can use audit logs to look into:

1. Events in services:

    * How employees log in to their accounts, e.g., the time and device of their login.
    * Actions employees take with emails and files in their Mail and Disk. For example, you can find out who has moved an email or file.

1. Events in the organization’s profile:

    * Changes in the organization’s profile. For example, you can view what changed in a user’s data and who made those changes.
    * Past searches of other admins in the [email archive](https://yandex.com/support/yandex-360/business/admin/ru/mail/email-archiving/) and how they set up [email rules](https://yandex.com/support/yandex-360/business/admin/ru/mail/rules).

{% list tabs group=instructions %}

- Checking from the {{ yandex-360 }} console {#yandex-360-console}

  1. [Log in](https://admin.yandex.ru/) as the organization administrator.
  1. In the left-hand menu, select **Audit logs**.
    
      If you see the **Connect** button, your configuration does not comply with Y360-11.

{% endlist %}

**How to implement:**

To ensure system security, [enable](https://yandex.com/support/yandex-360/business/admin/ru/admin-audit-log#turn-on) collection and analysis of audit log events. This will allow you to timely detect and respond to potential threats.
