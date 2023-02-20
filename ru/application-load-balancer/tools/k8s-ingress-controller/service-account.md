# Сервисный аккаунт для инструментов {{ alb-name }} для {{ managed-k8s-name }}

{% if product == "yandex-cloud" %}Инструменты {{ alb-name }} для {{ managed-k8s-name }} — [Ingress-контроллер](index.md) и [Gateway API](../k8s-gateway-api/index.md) — разворачивают{% endif %}{% if product == "cloud-il" %}[Ingress-контроллер](index.md) {{ alb-name }} для {{ managed-k8s-name }} разворачивает{% endif %} инфраструктуру от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Этому аккаунту требуются следующие разрешения:

{% if product == "yandex-cloud" %}

{% list tabs %}

- Ingress-контроллер

{% endif %}

  | Сервис | На что нужно разрешение | Минимальная роль |
  | ----- | ----- | ----- |
  | {{ alb-name }}<br/>([роли](../../security/index.md)) | Управление ресурсами сервиса | `alb.editor` |
  | {{ vpc-name }}<br/>([роли](../../../vpc/security/index.md)) | Управление внешней или внутренней связностью, в зависимости от типа балансировщика | `vpc.publicAdmin` (внешняя)<br/>`vpc.privateAdmin` (внутренняя) |
  | {{ certificate-manager-name }}<br/>([роли](../../../certificate-manager/security/index.md)) | Получение сертификатов (для HTTPS-балансировщиков) | `certificate-manager.certificates.downloader` |
  | {{ compute-name }}<br/>([роли](../../../compute/security/index.md)) | Получение информации о ВМ, созданных как узлы кластера {{ managed-k8s-name }} | `compute.viewer` |

{% if product == "yandex-cloud" %}

- Gateway API

  | Сервис | На что нужно разрешение | Минимальная роль |
  | ----- | ----- | ----- |
  | {{ alb-name }}<br/>([роли](../../security/index.md)) | Управление ресурсами сервиса | `alb.editor` |
  | {{ vpc-name }}<br/>([роли](../../../vpc/security/index.md)) | Управление внешней или внутренней связностью, в зависимости от типа балансировщика | `vpc.publicAdmin` (внешняя)<br/>`vpc.privateAdmin` (внутренняя) |
  | {{ certificate-manager-name }}<br/>([роли](../../../certificate-manager/security/index.md)) | Управление сертификатами (для HTTPS-балансировщиков) | `certificate-manager.certificates.admin` |
  | {{ compute-name }}<br/>([роли](../../../compute/security/index.md)) | Получение информации о ВМ, созданных как узлы кластера {{ managed-k8s-name }} | `compute.viewer` |
  
{% endlist %}

{% endif %}

Для аутентификации сервисного аккаунта используется [авторизованный ключ](../../../iam/concepts/authorization/key.md). Ключ нужно указать при установке Helm-чарта с Ingress-контроллером или Gateway API в значении `saKeySecretKey`. Например, если вы создали ключ с помощью [команды CLI `yc iam key create`](../../../cli/cli-ref/managed-services/iam/key/create.md) и сохранили его в файл `sa-key.json`, то команда для установки чарта может выглядеть так:

```bash
helm install \
  --namespace yc-alb \
  --set-file saKeySecretKey=sa-key.json \
  ...
```

Ключ будет храниться в секрете `yc-alb-ingress-controller-sa-key` {% if product == "yandex-cloud" %}или `yc-alb-gateway-api-controller-sa-key` {% endif %}в пространстве имен, указанном при установке чарта (в примере выше — `yc-alb`).