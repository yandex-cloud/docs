# Resolving the "Incorrect format expected an integer" error when creating an MX record



## Issue description {#issue-description}

When creating an MX record, you see this error: `Incorrect format: expected an integer`.

## Solution {#issue-resolution}

The `Incorrect format: expected an integer` error indicates that when creating an MX record, one of its fields includes text instead of a number.

The `MX` record consists of two parts:
- `PREFERENCE`: A 16-bit integer that specifies the host priority. The lower the value, the higher the host preference.
- `EXCHANGE`: The FQDN of the host that processes emails in the specified zone. This field value must point to an A or AAAA record.

{% note alert %}

In the `Value` field, you need to specify a number (record priority) followed by text. For example, `10 mx.yandex.net.`

{% endnote %}

More details [here](../../../dns/concepts/resource-record#mx).

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).

When creating a request, please attach a screenshot of the record settings.