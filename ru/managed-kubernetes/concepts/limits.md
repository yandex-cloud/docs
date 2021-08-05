---
title: Квоты и лимиты в Managed Service for Kubernetes
description: 'В Managed Service for Kubernetes действуют лимиты и квоты на суммарное количество vCPU для всех узлов, суммарный объем RAM, суммарный объем дисков, максимальное количество кластеров Kubernetes в одном облаке. Более подробно об ограничениях в сервисе вы узнаете из данной статьи.'

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Квоты и лимиты в {{ managed-k8s-name }}

В сервисе {{ managed-k8s-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

Сервис {{ managed-k8s-name }} учитывает указанный максимальный размер группы узлов как фактический, независимо от текущего размера.

{% include [limits-managed-kube](../../_includes/managed-kube-limits.md) %}