# Квоты и лимиты

В сервисе {{ managed-k8s-name }} действуют следующие ограничения:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

Сервис {{ managed-k8s-name }} учитывает указанный максимальный размер группы узлов как фактический, независимо от текущего размера.

{% include [limits-managed-kube](../../_includes/managed-kube-limits.md) %}