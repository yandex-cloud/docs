# Yandex DDoS Protection

Yandex DDoS Protection is a component of VPC that you can use to protect cloud resources from DDoS attacks. This service is provided in partnership with Qrator Labs.

DDoS Protection filters traffic on layers 2 and 3 in the OSI network model and protects against SYN flood attacks. All internet traffic to the protected IP address is fully scanned, even if a DDoS attack is not underway.

DDoS protection is available for the public IP addresses of virtual machines, network balancers, and database hosts. Protection is enabled during creation of a cloud resource. It can't be applied to existing resources. However, there are no restrictions on working with protected IP addresses. You can make them static or reserve them. If you stop a virtual machine with a protected dynamic address, the address will change the next time it is started, but it will remain under DDoS protection.

The bandwidth is not restricted for both abusive and legitimate traffic. Every gigabyte of traffic passed to the resource is charged.

### See also {#see-also}

* [Enable protection from DDoS attacks](../operations/enable-ddos-protection.md)

