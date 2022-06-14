# Создать или изменить ресурсы {{ alb-name }} по конфигурации для Ingress-контроллера в {{ managed-k8s-full-name }}

[Ingress-контроллер {{ alb-name }} для {{ managed-k8s-name }}](../tools/k8s-ingress-controller/index.md) управляет ресурсами {{ alb-name }} по вашей конфигурации — файлам в формате YAML с описаниями ресурсов {{ k8s }}: `Ingress`, `Service`, `HttpBackendGroup` и т. д. Подробнее о конфигурации см. в [справочнике Ingress-контроллера](../k8s-ref/index.md).

## Перед началом работы {#prerequisites}

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Установите Ingress-контроллер](k8s-ingress-controller-install.md).
1. Создайте конфигурацию. Подробнее см. в [описании](../tools/k8s-ingress-controller/index.md) и справочнике контроллера.

## Применить конфигурацию {#apply}

Чтобы применить конфигурацию:
1. Перейдите в папку с файлами конфигурации.
1. Выполните следующую команду:

   ```bash
   kubectl apply -f .
   ```

   На применение конфигурации может потребоваться несколько минут.

1. Если в конфигурацию добавлен новый ресурс `Ingress`, проверьте, что он создан и получил публичный IP-адрес:

   ```bash
   kubectl get ingress <имя ресурса Ingress>
   ```

   Результат:

   ```
   NAME           CLASS   HOSTS           ADDRESS     PORTS    AGE
   <имя Ingress>  <none>  <доменное имя>  <IP-адрес>  80, 443  15h
   ```

   В столбце `ADDRESS` должен появиться IP-адрес. В противном случае балансировщик не создался или создался некорректно — проверьте логи [пода](../../managed-kubernetes/concepts/index.md#pod) `yc-alb-ingress-controller-*` (не `yc-alb-ingress-controller-hc-*`).