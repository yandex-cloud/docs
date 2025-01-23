---
title: '{{ ddos-protection-full-name }} in {{ vpc-full-name }}'
description: In this tutorial, you will learn about {{ ddos-protection-name }} and extended protection.
---

# {{ ddos-protection-full-name }} in {{ vpc-name }}


{{ ddos-protection-full-name }} is a {{ vpc-short-name }} component that safeguards cloud resources from DDoS attacks. {{ ddos-protection-short-name }} is provided in partnership with Qrator Labs.

Activating {{ ddos-protection-full-name }} for VM instances or network load balancers allows you to efficiently respond to attacks aiming to overwhelm the channel capacity and computing resources of your VM instances. Such attacks utilize broad bandwidth and produce a large number of packets per second. They are relatively easy to set up: attackers typically send a flood of TCP SYN (SYN Flood) packets or traffic of UDP-based application protocols, such as DNS, NTP, SSDP, CLDAP, and many more.

To prevent such attacks, {{ ddos-protection-name }}:

* Constantly analyzes all incoming traffic.
* Detects the issues described above in the network and transport layers.
* Automatically diverts unwanted traffic when its intensity threatens the health of your app in {{ yandex-cloud }}.

DDoS protection is available for the public IP addresses of VMs, network balancers, and database hosts. It can only be enabled when you create a cloud resource or reserve a static IP address. However, there are no restrictions on working with protected IP addresses: you can both convert them to static and reserve them. If you stop a virtual machine with a protected dynamic address, the address will change the next time it is started, but the DDoS protection will remain.

The bandwidth for abusive and legitimate traffic is not restricted. You pay for every gigabyte of the incoming legitimate traffic.

When enabling {{ ddos-protection-short-name }}, you may want to reduce [MTU and TCP MSS](../concepts/mtu-mss.md).

Note that {{ ddos-protection-name }} is not designed to protect websites and mobile apps from higher-level DDoS attacks which:

* Use valid TCP connections.
* Use HTTP and HTTPS requests.
* Exploit bottlenecks in the apps under attack.

When connecting basic protection ({{ ddos-protection-full-name }}), you must configure a trigger threshold for the L3-L4 protection mechanisms. This threshold is aligned with the amount of legitimate traffic to the protected resource. To configure the threshold, contact support.

You can request protection at the application level by contacting our tech support.


## Advanced protection {#advanced-protection}

Advanced protection operates at levels 3 and 7 of the OSI model. You can also track load and attack metrics and enable Soundwall WAF in your Qrator Labs account.

When enabling advanced protection ({{ adv-ddos-protection }}), you should disable basic protection ({{ ddos-protection-full-name }}). After you disable the protection, the VM's public IP address will change.

To enable advanced protection, contact [support]({{ link-console-support }}) or fill out [this form](/services/ddos-protection#contact-form). In your request, specify the details of the service and legitimate traffic:

Service details:

* Number of resources (websites, domains, and services) to protect.
* Whether you need to enable Web Application Firewall (WAF).
* Whether you need to enable encryption (SSL/TLS/HTTPS).
* Business-critical downtime.
* Whether you need a dedicated channel to increase SLA.

Legitimate traffic details:

* Maximum incoming and outgoing application traffic.
* Maximum packet rate (PPS).
* Maximum request rate (RPS).

It will be helpful if you also attach:

* Network infrastructure diagram with site locations, uplinks, and internal architecture from the boundary router to the application.
* Example traffic stats (chart images) for a 24-hour period.


### See also {#see-also}

* [Enabling DDoS protection](../operations/enable-ddos-protection.md)
