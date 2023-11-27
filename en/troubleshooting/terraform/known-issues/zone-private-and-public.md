# Zone is set as public and private at the same time



## Issue description {#issue-description}

When you create a DNS zone, it is created both as public and private.

## Solution {#issue-resolution}

The Terraform provider creates a public-private zone so you can make it accessible from private networks without recreation. As long as the `private_visibility.network_ids` list is empty, the zone behaves like a regular public zone.

This is to make sure that most of the zones can be [updated without recreation](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone).
