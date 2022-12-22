# Ingress-контроллер для {{ managed-k8s-name }}

{{ alb-name }} предоставляет инструмент для создания и управления балансировщиками нагрузки в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) — Ingress-контроллер {{ alb-name }}.

После установки контроллера вы сможете создать с его помощью ресурс [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), отвечающий за прием входящего трафика. По конфигурации `Ingress` будет автоматически развернут [L7-балансировщик](../../concepts/application-load-balancer.md) со всеми необходимыми ресурсами {{ alb-name }}.

## Пример конфигурации {#example}

Ниже приведен сокращенный пример конфигурации ресурса `Ingress`. По ней будет создан балансировщик, принимающий HTTPS-трафик и распределяющий его по двум сервисам в зависимости от пути в URI запроса.

{% cut "Пример" %}

```yaml
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: alb-demo-tls
spec:
  tls:
    - hosts:
        - <доменное имя>
      secretName: yc-certmgr-cert-id-<идентификатор сертификата из {{ certificate-manager-full-name }}>
  rules:
    - host: <доменное имя>
      http:
        paths:
          - path: /app1
            pathType: Prefix
            backend:
              service:
                name: alb-demo-1
                port:
                  number: 80
          - path: /app2
            pathType: Prefix
            backend:
              service:
                name: alb-demo-2
                port:
                  number: 80
          - pathType: Prefix
            path: "/"
            backend:
              service:
                name: alb-demo-2
                port:
                  name: http
```

{% endcut %}

## Установка и требования {#install}

Ingress-контроллер {{ alb-name }} поставляется в виде Helm-чарта. Для его установки требуются:
* Менеджер пакетов [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} версии не ниже {{ alb-ingress-helm-version }} с [включенной поддержкой OCI](https://helm.sh/docs/topics/registries/).
* Кластер {{ managed-k8s-name }}.
* Группа узлов в кластере.
* Пространство имен в кластере для хранения ключа [сервисного аккаунта](service-account.md).

Чарт скачивается и устанавливается с помощью следующих команд:

```bash
export HELM_EXPERIMENTAL_OCI=1
helm pull \
  --version v{{ alb-ingress-version }} \
  oci://{{ registry }}/yc/yc-alb-ingress-controller-chart
helm install \
  --namespace <имя пространства имен> \
  --set folderId=<идентификатор каталога> \
  --set clusterId=<идентификатор кластера> \
  --set-file saKeySecretKey=<путь к файлу с ключом сервисного аккаунта> \
  yc-alb-ingress-controller ./yc-alb-ingress-controller-chart-{{ alb-ingress-version }}.tgz
```

Подробнее см. в [полной инструкции по установке](../../operations/k8s-ingress-controller-install.md).

#### См. также {#see-also}

* [Принципы работы контроллера](principles.md).
* [Настройка групп безопасности](security-groups.md) для кластера {{ k8s }} и балансировщика.
* [Сервисный аккаунт](service-account.md) для работы контроллера.