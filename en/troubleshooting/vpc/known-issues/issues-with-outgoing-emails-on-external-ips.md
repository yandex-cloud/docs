# Resolving issues with sending emails via SMTP from external IP addresses



## Issue description {#issue-description}

* Recipients are not receiving emails sent from a mail server deployed on Yandex Cloud.
   As a mail server, you use a VM instance with an external IP address, or SMTP traffic is routed via a NAT instance.

## Solution {#issue-resolution}

1. Check whether your external IP address assigned to either the VM instance or NAT instance, is missing from the Real-time Blackhole List and/or DNS Blacklist. For this, you can use specialized services, for instance, [MX toolbox](https://mxtoolbox.com/blacklists.aspx).

2. If the address is present on the block list, verify the configuration of your mail server.
   The most common reasons for adding an IP address to RBL/DNSBL are:
   * Mass distribution of emails, which were marked as spam by their recipients.
   * No PTR and DMARC records for the external IP address.
   * Mail server compromise.
       After resolving issues that led to blacklisting, you may request the RBL/DNSBL list operators to delist your IP address.

3. If the address is not on RBL/DNSBL lists, or the actions listed above did not help solve the issue, [create a request for technical support]({{ link-console-support }}).

When creating the request, provide the following information:

* ID of the problematic IP address (or the IP address itself).
* Results of the IP address check using specialized services and/or RBL provider interfaces.
