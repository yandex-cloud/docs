### Network DDoS protection is enabled (L3) {#l3}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | appsec.ddos-protection.l3 ||
|#

#### Description

**How this rule works:** The rule verifies that Yandex DDoS Protection is enabled on public IPs. If you use a third-party DDoS protection product, mark the rule as completed manually.

{% note tip %}

The check verifies that Yandex DDoS Protection is enabled. If you use a third-party DDoS protection product, mark the rule as completed manually.

{% endnote %}

Without L3/L4 DDoS protection, a public IP of a VM or a Network Load Balancer is fully exposed to volumetric attacks: an attacker can saturate the channel or exhaust the workload's capacity simply by sending enough traffic.

[Yandex DDoS Protection](https://yandex.cloud/en/docs/vpc/ddos-protection/) is a Virtual Private Cloud feature that protects cloud resources from such attacks at OSI layers 3 and 4. With it enabled, Yandex Cloud continuously analyses incoming traffic to the protected IP, detects anomalies, and drops unwanted traffic when its volume threatens the workload.

There is also [advanced DDoS protection](https://yandex.cloud/en/services/ddos-protection) that covers OSI layers 3, 4, and 7 and gives access to detailed attack and load metrics.

**Risks if the rule is not followed:** Without L3/L4 DDoS protection, a volumetric attack can saturate the network channel or exhaust the workload's resources, causing complete service unavailability and potential financial losses.

#### Instructions and solutions

Enable basic DDoS protection on every public IP that should not be exposed to volumetric attacks:

1. When creating a VM or reserving a public IP, select **DDoS protection** — see [Enabling DDoS Protection](https://yandex.cloud/en/docs/vpc/operations/enable-ddos-protection).
2. For workloads with strict availability requirements, request [advanced protection](https://yandex.cloud/en/services/ddos-protection#contact-form) or contact [technical support](https://center.yandex.cloud/support/tickets).
