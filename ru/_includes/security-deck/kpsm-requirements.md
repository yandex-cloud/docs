{% note warning %}

Для корректной работы модуля KSPM: 
* Требуется Kubernetes версии 1.28 или выше.
* В кластере Kubernetes должен отсутствовать [Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) на базе [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno). Если Kyverno был развернут ранее, его необходимо удалить вместе со всеми созданными им ресурсами [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/).

{% endnote %}