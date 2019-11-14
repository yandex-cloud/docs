### Получите токен сервисного аккаунта {{ k8s }} для аутентификации в GitLab {#k8s-get-token}
Чтобы получить сервисный токен:
1. Сохраните спецификацию для создания сервисного аккаунта в YAML-файл `gitlab-admin-service-account.yaml`:

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
        kubectl apply -f gitlab-admin-service-account.yaml
        ```
       
    {% endlist %}

1. Узнайте токен с помощью команды `kubectl describe secret`. Он будет указан в поле **token**:

    {% list tabs %}
    
    - Bash
    
        ```
        kubectl -n kube-system describe secret $(kubectl -n kube-system get secret \
       | grep gitlab-admin \
       | awk '{print $1}')
        ``` 

    {% endlist %}
    
1. Сохраните полученный токен – он понадобится для следующих шагов.