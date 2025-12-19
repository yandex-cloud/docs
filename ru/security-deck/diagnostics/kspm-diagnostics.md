---
title: Какие возникают ошибки при работе с модулем Контроль {{ k8s }} (KSPM) в {{ sd-full-name }}
description: Из статьи вы узнаете, какие бывают ошибки в работе модуля Контроль {{ k8s }} (KSPM).
---

# Диагностика ошибок в работе модуля Контроль {{ k8s }} (KSPM)

## Existing Kyverno installation detected and has to be removed manually {#existing-kyverno-installation}

В кластере ранее был установлен Admission Controller на базе Kyverno. Для корректной работы KSPM Admission Controller требуется отсутствие Kyverno при установке. При удалении версии Kyverno также нужно удалить все [CustomResourceDefinitions](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions), созданные Kyverno:

```bash
kubectl delete crd $(kubectl get crd -o name | grep kyverno.io)
```