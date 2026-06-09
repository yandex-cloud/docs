# Сервисный аккаунт для инструментов Application Load Balancer в Yandex Managed Service for Kubernetes

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](gwin-index.md).

{% endnote %}

Инструменты Application Load Balancer для Managed Service for Kubernetes — [Ingress-контроллер](ingress-controller/index.md) и [Gateway API](gateway-api/index.md) — разворачивают инфраструктуру от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Этому аккаунту требуются следующие разрешения:

{% list tabs %}

- Ingress-контроллер

  | Сервис | На что нужно разрешение | Минимальная роль |
  | ----- | ----- | ----- |
  | Application Load Balancer<br/>([роли](../../application-load-balancer/security/index.md)) | Управление ресурсами сервиса | `alb.editor` |
  | Virtual Private Cloud<br/>([роли](../../vpc/security/index.md)) | Управление внешней или внутренней связностью, в зависимости от типа балансировщика | `vpc.publicAdmin` (внешняя)<br/>`vpc.privateAdmin` (внутренняя) |
  | Certificate Manager<br/>([роли](../../certificate-manager/security/index.md)) | Получение сертификатов (для HTTPS-балансировщиков) | `certificate-manager.certificates.downloader` |
  | Compute Cloud<br/>([роли](../../compute/security/index.md)) | Получение информации о ВМ, созданных как узлы кластера Managed Service for Kubernetes | `compute.viewer` |

- Gateway API

  | Сервис | На что нужно разрешение | Минимальная роль |
  | ----- | ----- | ----- |
  | Application Load Balancer<br/>([роли](../../application-load-balancer/security/index.md)) | Управление ресурсами сервиса | `alb.editor` |
  | Virtual Private Cloud<br/>([роли](../../vpc/security/index.md)) | Управление внешней или внутренней связностью, в зависимости от типа балансировщика | `vpc.publicAdmin` (внешняя)<br/>`vpc.privateAdmin` (внутренняя) |
  | Certificate Manager<br/>([роли](../../certificate-manager/security/index.md)) | Управление сертификатами (для HTTPS-балансировщиков) | `certificate-manager.certificates.admin` |
  | Compute Cloud<br/>([роли](../../compute/security/index.md)) | Получение информации о ВМ, созданных как узлы кластера Managed Service for Kubernetes | `compute.viewer` |
  
{% endlist %}

Для аутентификации сервисного аккаунта используется [авторизованный ключ](../../iam/concepts/authorization/key.md). Ключ нужно указать при установке Helm-чарта с Ingress-контроллером или Gateway API в значении `saKeySecretKey`. Например, если вы создали ключ с помощью [команды CLI `yc iam key create`](../../iam/operations/iam-token/create-for-sa.md) и сохранили его в файл `sa-key.json`, то команда для установки чарта может выглядеть так:

```bash
helm install \
  --namespace yc-alb \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

Ключ будет храниться в секрете `yc-alb-ingress-controller-sa-key` или `yc-alb-gateway-api-controller-sa-key` в пространстве имен, указанном при установке чарта (в примере выше — `yc-alb`).