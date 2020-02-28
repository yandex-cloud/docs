### Получите токен сервисного аккаунта {{ k8s }} для аутентификации в GitLab {#k8s-get-token}

{% note info %}

Обратите внимание, что [сервисный аккаунт {{ k8s }}](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) — это не сервисный аккаунт IAM.

{% endnote %}

Чтобы получить токен сервисного аккаунта {{ k8s }}:
1. Настройте локальное окружение на работу с созданным кластером {{ k8s }}. Для этого выполните команду:

    {% list tabs %}
    
    - Bash
    
        ```
        $ yc managed-kubernetes cluster get-credentials <cluster-id> --external
        ```
       
    {% endlist %}

1. Сохраните спецификацию для создания сервисного аккаунта {{ k8s }} в YAML-файл `gitlab-admin-service-account.yaml`:

    ```
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: gitlab-admin
      namespace: kube-system
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
      name: gitlab-admin
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: cluster-admin
    subjects:
    - kind: ServiceAccount
      name: gitlab-admin
      namespace: kube-system
    ```
1. Выполните команду: 

    {% list tabs %}
    
    - Bash
    
        ```
        $ kubectl apply -f gitlab-admin-service-account.yaml
        ```
       
    {% endlist %}
1. Узнайте токен с помощью команды `kubectl get secrets`:

    {% list tabs %}
    
    - Bash
    
        ```
        $ kubectl -n kube-system get secrets -o json | \
        jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | \
        base64 --decode
        ``` 

    {% endlist %}
1. Сохраните полученный токен — он понадобится для следующих шагов.
