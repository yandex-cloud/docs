# {{ cdn-name }} returns only one IP address


## Issue description {#issue-description}

{{ cdn-name }} returns only one IP address when accessed from different regions of Russia or Belarus.

## Solution {#issue-resolution}

This is expected behavior. You can refer to [this article](../../../cdn/concepts/index.md#kak-rabotaet-cdn) to learn how {{ cdn-name }} works. 

In more detail, a subnet is announced in different data centers, with traffic geographically routed to the nearest caching servers. At the same time, users can see the same IP from different locations.

If you explore each of the nodes of interest, you will see different values in the `X-Node` header, which means {{ cdn-name }} is working properly, directing traffic to different nodes depending on the region.