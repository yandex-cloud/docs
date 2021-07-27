---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Yandex DDoS Protection

{{ ddos-protection-full-name }} is the {{ vpc-short-name }} component that safeguards cloud resources from DDoS attacks. DDoS Protection is provided in partnership with Qrator Labs.

By activating {{ ddos-protection-full-name }} for VM instances or network load balancers, you can efficiently counteract attacks attempting to overwhelm the channel capacity and computing resources of your VM instances. Such attacks utilize a broad bandwidth and produce a large number of packets per second. These are relatively easy to set up: attackers typically send a flood of TCP SYN (SYN Flood) packets or traffic of UDP-based application protocols (DNS, NTP, SSDP, CLDAP, and many others).

To prevent such attacks, {{ ddos-protection-name }}:

* Constantly analyzes all incoming traffic.
* Detects the above anomalies in the network and transport layers.
* Automatically diverts unwanted traffic when its intensity threatens the health of your app in {{ yandex-cloud }}.

Please note that this service is not intended to protect websites and mobile apps from higher-level DDoS attacks that:

* Use valid TCP connections.
* Use HTTP and HTTPS requests.
* Exploit bottlenecks in the attacked apps.

DDoS protection is available for the public IP addresses of virtual machines, network balancers, and database hosts. You can enable protection only when you create a cloud resource or reserve a static IP address for it. However, there are no restrictions on working with protected IP addresses. You can make them static or reserve them. If you stop a virtual machine with a protected dynamic address, the address will change the next time it is started, but it will remain under DDoS protection.

The bandwidth for abusive and legitimate traffic is not restricted. You pay for every gigabyte of legitimate traffic passed to the resource.

Please note that when you enable DDoS Protection, you should reduce [MTU and TCP MSS](../concepts/mtu-mss.md).

### See also {#see-also}

* [Enable protection from DDoS attacks](../operations/enable-ddos-protection.md)

