# Troubleshooting time synchronization on {{ managed-k8s-name }} cluster nodes


## Issue description {#issue-description}

System time displayed incorrectly in the Linux console, as well as in container and {{ managed-k8s-name }} cluster pod logs.

## Solution {#issue-resolution}

You can specify your own NTP server in the subnet settings using the YC CLI or [with {{ TF }}]({{ tf-provider-resources-link }}/vpc_subnet). This will configure the cloud DHCP server to include your NTP server information and propagate it to all nodes in the cloud subnet.

{% note info %}

This operation does not automatically delete or recreate nodes in your {{ managed-k8s-name }} cluster. To apply these NTP settings within the {{ managed-k8s-name }} cluster itself, use one of these two options:

* Renew the DHCP configuration on each node by running `sudo dhclient -v -r && sudo dhclient`.
* Reboot the cluster's worker nodes at a time convenient for you.

Either option may cause brief (up to a few minutes) network unavailability for services within the cluster while the nodes re-acquire their network configuration.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. {{ managed-k8s-name }} cluster event log: `kubectl get events` output.