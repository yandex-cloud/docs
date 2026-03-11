### Audit log collection is set up for incident investigation {#network-policy}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.network-policy ||
|#

#### Description

{% note warning "**Manual check**" %}

This rule requires manual verification of audit log collection setting.

{% endnote %}

Events available to the user in the Managed Service for Kubernetes service can be classified as levels:

* Kubernetes API events (Kubernetes audit logging)
* Kubernetes node events
* Kubernetes pod events
* Kubernetes metrics
* Kubernetes flow logs

For more information about setting up audit event logging at various levels, see [Collecting, monitoring, and analyzing Managed Service for Kubernetes audit logs](https://yandex.cloud/en/docs/security/domains/kubernetes#collection-monitoring-analysis-audit-logs).

#### Guides and solutions to use

In Managed Service for Kubernetes, you can audit the current role model used in the service. To do this, open the Kubernetes cluster page in the [management console](https://console.yandex.cloud/), and go to the **Access management** tab.

You can also use:

* [KubiScan](https://github.com/cyberark/KubiScan)
* [Krane](https://github.com/appvia/krane)
* Yandex Audit Trails [audit logs](https://yandex.cloud/en/docs/managed-kubernetes/at-ref)