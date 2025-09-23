В {{ managed-k8s-name }} реализована интеграция с _федерациями сервисных аккаунтов_ {{ iam-name }}.

{% include [move-groups-api](../iam/wlif-instructions-intro.md) %}

При включении опции {{ managed-k8s-name }} автоматически создает для конкретного кластера OIDC-провайдер и предоставляет следующие параметры для интеграции с федерациями сервисных аккаунтов:
* `{{ ui-key.yacloud.k8s.cluster.overview.label_ident-and-access-management-issuer }}`.
* `{{ ui-key.yacloud.k8s.cluster.overview.label_ident-and-access-management-jwks-uri }}`.