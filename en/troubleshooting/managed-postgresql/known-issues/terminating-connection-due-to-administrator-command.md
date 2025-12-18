# Fixing these errors: `terminating connection due to administrator command` and `ERROR: odyssey: remote server read/write error`


## Issue description {#issue-description}

A {{ mpg-name }} cluster transaction ends with one of these errors: `terminating connection due to administrator command` or `"ERROR: odyssey: remote server read/write error sefc96761678e: (null) SSL SYSCALL error: EOF detected"`.

## Solution {#issue-resolution}

You may get such errors when the transaction failed to complete over 12 hours. {{ yandex-cloud }} has certain [limits for session timeout](../../../managed-postgresql/concepts/limits.md#mpg-quotas).

To increase it, change the `Session duration timeout` in the cluster settings. For more information on it, see [this guide](../../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout). Please note the time is specified in milliseconds.

Changing this value will not affect the cluster operation in any way.

{% note info %}

When restoring a cluster from backup, the `Session duration timeout` value is reset to the default value, i.e., 12 hours.

{% endnote %}
