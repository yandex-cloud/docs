{% note warning %}

To make sure KSPM works correctly: 
* Use Kubernetes version 1.28 or higher.
* Check these is no [admission control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) based on [Kyverno](https://yandex.cloud/en/marketplace/products/yc/kyverno) in the Kubernetes cluster. If you deployed Kyverno earlier, delete it along with all [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) resources it has created.

{% endnote %}