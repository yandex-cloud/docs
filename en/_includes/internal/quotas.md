# Quotas and resources

In general, a single quota for all MDB services is allocated for a particular ABC service. Each ABC service corresponds to a separate cloud in MDB.

## View available resources

To see your cloud's quotas:

1. Open the [management console](https://yc.yandex-team.com).
1. In the upper-right corner, select the desired cloud.
1. Go to [Quotas](https://yc.yandex-team.com/?section=quotas).

You can also find information about quotas and their use, depending on the hierarchy of ABC projects, in [Dispenser](https://dispenser.yandex-team.com/db/projects/yandex).

{% note important %}

Quotas and their usage details are displayed in the management console for a specific ABC service, excluding child services. Whereas quotas displayed in Dispenser factor in child services by default.

{% endnote %}

{% note warning %}

In Sandy Bridge host classes (`db1.*`) the RAM limit is twice as high as the guaranteed amount. For example, the limit for `db1.small` is 16 GB, while the guaranteed amount is 8 GB. In a quota, consumption is accounted for as per guarantee, while the management console displays limits. In subsequent generations, this problem is eliminated, since guarantees and limits are equal there.

{% endnote %}

## Request a quota change

 You can request a quota change in the Dispenser interface by following the [instructions](https://wiki.yandex-team.ru/dispenser/ui/#quota-request).

Dispenser sends information about allocated quotas to MDB every 5 minutes.

