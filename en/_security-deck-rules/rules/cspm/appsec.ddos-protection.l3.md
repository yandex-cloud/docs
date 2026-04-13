### Network DDoS protection is enabled (L3) {#appsec-ddos-protection-l3}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.ddos-protection.l3 ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks Yandex DDoS Protection security profiles. If an external DDoS protection software is used, please change the status manually.

{% endnote %}

Yandex Cloud provides basic and advanced DDoS protection. Make sure to use at least basic protection.

Yandex DDoS Protection is a VPC component that safeguards cloud resources from DDoS attacks. DDoS Protection is provided in partnership with Qrator Labs. Supported up to OSI L4.

Activating Yandex DDoS Protection for VM instances or network load balancers allows you to efficiently respond to attacks aiming to overwhelm the channel capacity and computing resources of your VM instances. 

To prevent such attacks, DDoS Protection:

* Constantly analyzes all incoming traffic.
* Detects the above issues in the network and transport layers.
* Automatically diverts unwanted traffic when its intensity threatens the health of your service in Yandex Cloud.

[Advanced DDoS protection](https://yandex.cloud/en/services/ddos-protection) is available at OSI layers 3, 4, and 7. You can also track load and attack metrics and enable Solidwall WAF in your Curator account.

#### Recommendations

**Guides and solutions to use:**

Use [Yandex DDoS Protection](https://yandex.cloud/en/services/ddos-protection) to protect your cloud resources against DDoS attacks on basic level. You can [enable DDoS Protection](https://yandex.cloud/en/docs/vpc/operations/enable-ddos-protection) with a single click: just select the **DDoS protection** checkbox when creating your VM and reserving public IP addresses.

Enable and set up advanced DDoS protection at OSI layers 3, 4, and 7. To enable advanced protection, [contact support](https://center.yandex.cloud/support/tickets) or fill out [this form](https://yandex.cloud/en/services/ddos-protection#contact-form).
