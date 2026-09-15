### Audit log collection is set up for incident investigation {#network-policy}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.network-policy ||
|#

#### Description

**How this rule works:** this rule requires manual verification of audit log collection setting.

Events available to the user in the Managed Service for Kubernetes service can be classified as levels:

* Kubernetes API events (Kubernetes audit logging)
* Kubernetes node events
* Kubernetes pod events
* Kubernetes metrics
* Kubernetes flow logs

For more information about setting up audit event logging at various levels, see [Collecting, monitoring, and analyzing Managed Service for Kubernetes audit logs](https://yandex.cloud/en/docs/security/domains/kubernetes#collection-monitoring-analysis-audit-logs).

**Risks if the rule is not followed:** Without audit log collection at all levels, security incidents in the Kubernetes cluster cannot be detected or investigated. An attacker who escalates privileges, modifies workloads, or exfiltrates data leaves no trace that can be reviewed after the fact, making incident response and forensic analysis impossible.

#### Instructions and solutions

In Managed Service for Kubernetes, you can audit the current role model used in the service. To do this, open the Kubernetes cluster page in the [management console](https://console.yandex.cloud/), and go to the **Access management** tab.

You can also use:

* [KubiScan](https://github.com/cyberark/KubiScan)
* [Krane](https://github.com/appvia/krane)
* Yandex Audit Trails [audit logs](https://yandex.cloud/en/docs/managed-kubernetes/at-ref)
