# Yandex DDoS Protection in {{ vpc-name }}

{{ ddos-protection-full-name }} is the {{ vpc-short-name }} component that safeguards cloud resources from DDoS attacks. DDoS Protection is provided in partnership with Qrator Labs.

By activating {{ ddos-protection-full-name }} for VM instances or network load balancers, you can efficiently counteract attacks attempting to overwhelm the channel capacity and computing resources of your VM instances. Such attacks utilize a broad bandwidth and produce a large number of packets per second. These are relatively easy to set up: attackers typically send a flood of TCP SYN (SYN Flood) packets or traffic of UDP-based application protocols (DNS, NTP, SSDP, CLDAP, and many others).

To prevent such attacks, {{ ddos-protection-name }}:
* Constantly analyzes all incoming traffic.
* Detects the above anomalies in the network and transport layers.
* Automatically diverts unwanted traffic when its intensity threatens the health of your app in {{ yandex-cloud }}.

DDoS protection is available for the public IP addresses of virtual machines, network balancers, and database hosts. You can only activate protection when you create a cloud resource or reserve a static IP address. However, there are no restrictions on working with protected IP addresses. You can make them static or reserve them. If you stop a virtual machine with a protected dynamic address, the address will change the next time it is started, but it will remain under DDoS protection.

The bandwidth for abusive and legitimate traffic is not restricted. You pay for every gigabyte of legitimate traffic passed to the resource.

Please note that when you enable DDoS Protection, you should reduce [MTU and TCP MSS](../concepts/mtu-mss.md).

Please note that this service is not intended to protect websites and mobile apps from higher-level DDoS attacks that:
* Use valid TCP connections.
* Use HTTP and HTTPS requests.
* Exploit bottlenecks in the attacked apps.

If you need protection at the application level, you can request extended protection by contacting technical support.

## Extended protection {#advanced-protection}

Extended protection operates at levels 3 and 7 of the OSI model. You can also track loads and attack properties, as well as enable Soundwall WAF in your Qrator Labs account.

When requesting the service, please provide the following information:

Service properties:
* Number of resources (sites, domains, and services) to protect.
* Enable WAF (Web Application Firewall): yes or no.
* Enable encrypted (SSL/TLS/HTTPS) service protection: with or without decryption.
* Business-critical downtime.
* Enable dedicated channel to increase SLA: yes or no.

Legitimate traffic properties:
* Maximum incoming and outgoing application traffic bandwidth.
* Maximum packet rate (PPS).
* Maximum request rate (RPS).

We also recommend providing:
* A network infrastructure diagram: site locations, uplinks, internal architecture from the boundary router to the application.
* Example traffic stats (chart screenshots) for a 24-hour period.

### For details, see also {#see-also}

* [Enable protection from DDoS attacks](../operations/enable-ddos-protection.md)
* [Enable advanced protection from DDoS attacks](/services/ddos-protection#contact-form)
