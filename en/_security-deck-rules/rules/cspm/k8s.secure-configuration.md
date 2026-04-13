### Managed Service for Kubernetes® uses secure configuration {#secure-configuration}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | k8s.secure-configuration ||
|#

#### Description

{% note warning "**Manual Check**" %}

Please check if you have implemented controls for node group settings.

{% endnote %}

In Managed Service for Kubernetes, the user is fully in control of all node group settings but only partially in control of the [master](https://yandex.cloud/en/docs/managed-kubernetes/concepts/#master) settings. The user is responsible for the whole cluster's security.

The [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) standard is designed to build a secure Kubernetes configuration, including node configurations. In Yandex Cloud, the Kubernetes node groups are deployed by default with the configuration that complies with CIS Kubernetes Benchmark.

#### Guides and solutions to use

**Guides and solutions to use:**

* Using the [kube-bench](https://github.com/aquasecurity/kube-bench) tool, check whether the node group configuration is compliant with CIS Kubernetes Benchmark. The tool officially supports the Yandex Cloud node groups.
* [Starboard Operator](https://blog.aquasec.com/automate-kubernetes-compliance) is a free tool that helps you automate scanning of images for vulnerabilities and checking that the configuration is compliant with CIS Kubernetes Benchmark. Starboard Operator supports integration with kube-bench and is used for its automatic startup.
