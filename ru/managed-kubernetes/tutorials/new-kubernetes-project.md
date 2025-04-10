---
title: Создание нового {{ k8s }}-проекта в {{ yandex-cloud }}
description: Следуя данному руководству, вы сможете создать новый {{ k8s }}-проект в {{ yandex-cloud }}.
canonical: '{{ link-docs }}/tutorials/container-infrastructure/new-kubernetes-project'
---

# Создание нового {{ k8s }}-проекта в {{ yandex-cloud }}


В этой статье описан запуск нового {{ k8s }}-проекта в {{ yandex-cloud }}. Приложение из [{{ container-registry-full-name }}](../../container-registry/) будет развернуто в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) и опубликовано в интернете через Ingress-контроллер [{{ alb-full-name }}](../../application-load-balancer/).

Если вам нужно создать кластер {{ managed-k8s-name }} без доступа в интернет, обратитесь к разделу [{#T}](k8s-cluster-with-no-internet.md).

{% include [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}