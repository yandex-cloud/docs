---
title: Запуск нового {{ k8s }}-проекта в {{ yandex-cloud }}
description: Из руководства вы узнаете, как создать новый {{ k8s }}-проект в {{ yandex-cloud }}.
---

# Создание нового {{ k8s }}-проекта в {{ managed-k8s-full-name }}


В этой статье описан запуск нового {{ k8s }}-проекта в {{ yandex-cloud }}. Приложение из [{{ container-registry-full-name }}](../../container-registry/) будет развернуто в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и опубликовано в интернете через Ingress-контроллер [{{ alb-full-name }}](../../application-load-balancer/).

Если вам нужно создать кластер {{ managed-k8s-name }} без доступа в интернет, обратитесь к разделу [{#T}](k8s-cluster-with-no-internet.md).

{% include notitle [new-kubernetes-project](../../_tutorials/k8s/new-kubernetes-project.md) %}