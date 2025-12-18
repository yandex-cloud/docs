# How to use IPv6 addresses


## Case description {#case-description}

You need to use IPv6 addresses in {{ yandex-cloud }}.

## Solution {#case-resolution}

{{ yandex-cloud }} does not currently support IPv6 at the {{ vpc-name }} level, i.e., at the network level for all cloud services. You can upvote this feature request on the [Yandex Cloud community portal](https://cloud.yandex.ru/features/212).

​Currently, as a workaround, you can implement your application's backend outside {{ yandex-cloud }}, allowing the server to handle IPv4/IPv6 dual-stack client connections and send data for processing to {{ sf-name }} over IPv4.

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). In your ticket, describe your use case that requires using IPv6 addresses.