### Get a {{ k8s }} service account token to authenticate with GitLab {#k8s-get-token}

To get a service token:

1. Save the service account creation specification to `gitlab-admin-service-account.yaml`:

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
1. Run the command:

    {% list tabs %}

    - Bash

        ```
        kubectl apply -f gitlab-admin-service-account.yaml
        ```

    {% endlist %}
1. Retrieve the token using the command `kubectl describe secret`. It will be specified in the **token** field:

    {% list tabs %}

    - Bash

        ```
        kubectl -n kube-system describe secret $(kubectl -n kube-system get secret \
        | grep gitlab-admin \
        | awk '{print $1}')
        ```

    {% endlist %}
1. Save the token: you need it for the next steps.

