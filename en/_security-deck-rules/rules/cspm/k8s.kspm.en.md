### The Kubernetes security policy is in place {#k8s-kspm}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | k8s.kspm ||
|#

#### Description

[Kubernetes Security Posture Management (KSPM)](https://yandex.cloud/en/docs/security-deck/concepts/kspm) ensures the security of containerized applications and images they use.

The KSPM module automatically identifies all Kubernetes clusters and containers in the specified [workspace](https://yandex.cloud/en/docs/security-deck/concepts/workspace), and deploys security components in them as defined in the configuration. New clusters automatically get security coverage, without requiring manual search or installation of any components.

The module continuously assesses workloads for misconfigurations and provides runtime security monitoring through sensors that detect attacks targeting nodes and containers.

The KSPM configuration is set when you [create](https://yandex.cloud/en/docs/security-deck/operations/workspaces/create) a workspace and may include checking clusters for compliance with the following standards:

* `Kubernetes Pod Security Standards (Restricted)`: This standard contains security controls based on the [Kubernetes Pod Security Standards (PSS) Restricted profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted). A restricted profile is the most secure and provides the highest detection efficiency for container-based attacks. It applies strict security policies that may require modifying applications to ensure compliance. A restricted profile is recommended for security-critical applications and environments where maximum security is required.

* `Kubernetes Pod Security Standards (Baseline)`: This standard contains security controls based on the [Kubernetes Pod Security Standards (PSS) Baseline profile](https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline). A baseline profile is designed for easy implementation and provides common best practices for container security. It prevents the most common security issues in containers while maintaining compatibility with most applications. The baseline profile is a good starting point for organizations just getting started with container security.

* `Microsoft Threat Matrix for Kubernetes`: This standard contains security controls based on the [Microsoft Threat Matrix for Kubernetes](https://www.microsoft.com/en-us/security/blog/2020/04/02/attack-matrix-kubernetes/), which is a framework that helps security teams understand and fend off threats specific to Kubernetes environments. It provides a comprehensive approach to attack methods and defensive strategies tailored for container orchestration platforms.

* `CIS Kubernetes Benchmark`: This standard includes recommendations from the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) for secure configuration of Kubernetes worker node components. Only automatic checks from section `4 Worker Nodes` are included.

#### Recommendations

**Guides and solutions to use:**

Use the KSPM module to protect Kubernetes clusters and containers in your workspace:

1. [Create](https://yandex.cloud/en/docs/iam/operations/sa/create) a service account KSPM will use to view Managed Service for Kubernetes cluster info, install the necessary components, and perform checks.
2. [Assign](https://yandex.cloud/en/docs/iam/operations/sa/assign-role-for-sa) to the service account the `security-deck.worker` [role](https://yandex.cloud/en/docs/security-deck/security/#security-deck-worker) for the organization, cloud, or folder.
3. [Create](https://yandex.cloud/en/docs/security-deck/operations/workspaces/create) a Security Deck workspace, specify the clouds and folders you want to control the security of clusters in, and select the industry standards and regulations the resources you have chosen will be benchmarked against.
4. On the new workspace page, click **Workspace Parameters** and navigate to the **KSPM** tab.
5. Under **Scope of control**, select the clouds, folders, or clusters within the workspace resources where compliance with the Kubernetes security rules will be enforced.
6. Click **Save** and confirm the action.

For more information, see [Activating KSPM](https://yandex.cloud/en/docs/security-deck/operations/kspm/enable-kspm).
