# Resolving issues with sending emails via SMTP from external IP addresses



## Issue description {#issue-description}

Recipients are not receiving emails sent from a mail server deployed on {{ yandex-cloud }}. As a mail server, you use a VM with an external IP address, or SMTP traffic is routed via a NAT instance.

## Solution {#issue-resolution}

1. Check whether your external IP address assigned to either the VM or NAT instance is missing from the Real-time Blackhole List and/or DNS Blacklist. For this, you can use specialized services, such as [MX toolbox](https://mxtoolbox.com/blacklists.aspx).

1. If the address is in the black list, verify the configuration of your mail server. The most common reasons for adding an IP address to RBL/DNSBL are:
    * Mass distribution of emails, which were marked as spam by their recipients.
    * No PTR and DMARC records for the external IP address.
    * Mail server being compromised.

After resolving the issues that led to blacklisting, you may request the RBL/DNSBL list providers to delist your IP address.

 ## If the issue persists {#if-issue-still-persists}

If the address is not on RBL/DNSBL lists, or the actions listed above did not help you solve the issue, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the problematic IP address (or the IP address itself).
1. Results of the IP address check using specialized tools or RBL provider interfaces. 