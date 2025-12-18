# Zone appears as both public and private



## Issue description {#issue-description}

When you create a {{ dns-name }} zone, it appears as both public and private.

## Solution {#issue-resolution}

The {{ TF }} provider creates a public-private zone so you can make it accessible from private networks without recreating it. As long as the `private_visibility.network_ids` list is empty, such a zone behaves like a regular public zone.

This is to make sure that most of the zones can be [updated without recreation](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone).