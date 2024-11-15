---
title: Создать или изменить ресурсы {{ alb-full-name }} по конфигурации для {{ managed-k8s-full-name }}
description: Следуя данной инструкции, вы сможете cоздать или изменить ресурсы {{ alb-name }} по конфигурации для {{ managed-k8s-name }}.
---

# Создать или изменить ресурсы {{ alb-name }} по конфигурации для {{ managed-k8s-name }}


Чтобы управлять ресурсами {{ alb-name }} с помощью [Ingress-контроллера](../tools/k8s-ingress-controller/index.md) и [Gateway API](../tools/k8s-gateway-api/index.md) для {{ managed-k8s-full-name }}, нужно создать конфигурации — файлы в формате YAML с описаниями ресурсов {{ k8s }}: `Ingress`, `HttpBackendGroup`, `Gateway`, `HTTPRoute` и т. д.

## Перед началом работы {#prerequisites}

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Установите Ingress-контроллер](k8s-ingress-controller-install.md) или [Gateway API](k8s-gateway-api-install.md).
1. Создайте ресурс. Конфигурации доступных ресурсов см. в разделе [{#T}](../tools/index.md).

## Применить конфигурацию {#apply}

Чтобы применить конфигурацию:
1. Перейдите в папку с файлами конфигурации.
1. Выполните следующую команду:

   ```bash
   kubectl apply -f .
   ```

   На применение конфигурации может потребоваться несколько минут.

1. Если вы работаете с Ingress-контроллером и добавили в конфигурацию новый ресурс `Ingress`, проверьте, что он создан и получил публичный IP-адрес:

   ```bash
   kubectl get ingress <имя_ресурса_Ingress>
   ```

   Результат:

   ```
   NAME           CLASS   HOSTS           ADDRESS     PORTS    AGE
   <имя_Ingress>  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
   ```

   В столбце `ADDRESS` должен появиться IP-адрес. В противном случае балансировщик не создался или создался некорректно — проверьте логи [пода](../../managed-kubernetes/concepts/index.md#pod) `yc-alb-ingress-controller-*` (не `yc-alb-ingress-controller-hc-*`).