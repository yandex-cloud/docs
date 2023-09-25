---
title: "Шифрование секретов в {{ managed-k8s-full-name }}"
description: "Используйте ключ {{ kms-short-name }} для шифрования секретов — конфиденциальной информации, такой как пароли, OAuth-токены и SSH-ключи, в {{ managed-k8s-full-name }}. Для этого при создании кластера укажите ключ {{ kms-short-name }}, который будет использоваться при шифровании и расшифровании."
---

# Шифрование секретов в {{ managed-k8s-full-name }}

{% include [kms-k8s](../../_includes/kms/kms-k8s.md) %}

## См. также {#see-also}

* [Начало работы с {{ managed-k8s-name }}](../../managed-kubernetes/quickstart.md).
* [{#T}](../concepts/envelope.md).
* [Создание секретов в Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).