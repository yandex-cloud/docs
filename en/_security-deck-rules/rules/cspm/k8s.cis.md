### Kubernetes clusters are checked for CIS compliance {#cis}
#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | k8s.cis ||
|#

#### Description

**How the rule works**: The rule checks whether the CIS Benchmark for Kubernetes ruleset is enabled and whether [Kubernetes Security Posture Management (KSPM)](https://yandex.cloud/en/docs/security-deck/concepts/kspm) has clusters and nodes.

The CIS Benchmark for Kubernetes ruleset is one of the KSPM standards that can be enabled for a Security Deck [workspace](https://yandex.cloud/en/docs/security-deck/concepts/workspace). It follows the guidelines of the [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes), which is an international standard, and comprises rules for checking whether the kubelets on the cluster's worker nodes have a secure configuration.

Kubelet has broad permissions, including pod management, access to secrets and logs, and exec into containers. Therefore, if its configuration is vulnerable, it is one of the most dangerous attack vectors for privilege escalation in a cluster.

The benchmark's rules help detect key types of threats:
* Unauthorized access to the kubelet API.
* Authentication by certificate between the apiserver and kubelet.
* Certificate rotation.
* Access permissions to the configuration files (`kubelet.conf`, `config.yaml`, service file).
* Authentication mode and the kubelet's permission to manage `iptables`.

Whenever the rule is triggered, you get an [alert](https://yandex.cloud/en/docs/security-deck/concepts/alerts) with details on the violation, a list of facts and affected resources, and guidelines to fix the issue.

#### Instructions and solutions

Enable the CIS Benchmark for Kubernetes check:
1. Navigate to [Security Deck](https://center.yandex.cloud/security/).
2. In the left-hand panel, select **Workspace** and in the window that opens, select your Security Deck [workspace](https://yandex.cloud/en/docs/security-deck/concepts/workspace).
3. Click **Workspace parameters**.
4. Navigate to the **Control modules** tab.
5. Expand the list of **KSPM** standards.
6. Enable **CIS Benchmark™ requirements for Kubernetes**.
