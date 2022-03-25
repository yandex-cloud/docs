# Сервисный аккаунт для Ingress-контроллера {{ alb-name }}

[Ingress-контроллер {{ alb-name }} для {{ managed-k8s-name }}](index.md) разворачивает инфраструктуру от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Этому аккаунту требуются следующие разрешения:

| Сервис | На что нужно разрешение | Минимальная роль |
| ----- | ----- | ----- |
| {{ alb-name }}<br/>([роли](../../security/index.md)) | Управление ресурсами сервиса | `alb.editor` |
| {{ vpc-name }}<br/>([роли](../../../vpc/security/index.md)) | Управление внешней или внутренней связностью, в зависимости от типа балансировщика | `vpc.publicAdmin` (внешняя)<br/>`vpc.privateAdmin` (внутренняя) |
| {{ certificate-manager-name }}<br/>([роли](../../../certificate-manager/security/index.md)) | Получение сертификатов (для HTTPS-балансировщиков) | `certificate-manager.certificates.downloader` |
| {{ compute-name }}<br/>([роли](../../../compute/security/index.md)) | Получение информации о ВМ, созданных как узлы кластера {{ managed-k8s-name }} | `compute.viewer` |

Для аутентификации сервисного аккаунта используется [авторизованный ключ](../../../iam/concepts/authorization/key.md). Ключ нужно указать при установке Helm-чарта с Ingress-контроллером в значении `saKeySecretKey`. Например, если вы создали ключ с помощью [команды CLI `yc iam key create`](../../../cli/cli-ref/managed-services/iam/key/create.md) и сохранили его в файл `sa-key.json`, то команда для установки чарта может выглядеть так:

```bash
helm install \
  --namespace yc-alb-ingress \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

Ключ будет храниться в секрете `yc-alb-ingress-controller-sa-key` в пространстве имен, указанном при установке чарта (в примере выше — `yc-alb-ingress`).