# Fixing the `Incorrect format: expected an integer` error when creating an MX record



## Issue description {#issue-description}

When creating an MX record, you get the `Incorrect format: expected an integer` error.

## Solution {#issue-resolution}

The `Incorrect format: expected an integer` error means that when creating an MX record, one of its fields includes text instead of a number. 

An MX record consists of two parts:

* `PREFERENCE`: 16-bit integer setting the host priority. A lower the value means higher priority.
* `EXCHANGE`: FQDN of the email processing host in the specified zone. This field value must point to an A or AAAA record.

{% note alert %}

In the `Value` field, you need to specify a number, i.e., record priority, followed by text, e.g., `10 mx.yandex.net.`.

{% endnote %}

For more information, see [this article](../../../dns/concepts/resource-record.md#mx).

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). When creating it, please attach a screenshot of the record settings.