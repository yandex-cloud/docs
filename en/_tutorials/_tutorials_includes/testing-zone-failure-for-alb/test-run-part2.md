You can use this command to disable several availability zones at once if you list them separated by commas.

If you run the command again, the blocking period will be reset to 30 minutes from the current time.

If you do not specify the `--duration` parameter in the command, traffic balancing to the selected zones will be blocked indefinitely.

{% note warning %}

The `disable-zones` command only disables traffic balancing to the selected availability zone and only for the specified load balancer. This command does not impact network traffic within the zone or between the availability zones in any other cloud services. If you need to block traffic on such a broad scale, you can use [VPC security groups](../../../vpc/concepts/security-groups.md) on the corresponding cloud resource network interfaces.

{% endnote %}