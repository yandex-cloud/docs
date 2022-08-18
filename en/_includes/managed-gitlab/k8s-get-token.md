### Get a {{ k8s }} service account token to authenticate with GitLab {#k8s-get-token}

{% note info %}

Please note that a [service account in {{ k8s }}](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/) is not an IAM service account.

{% endnote %}

To get the {{ k8s }} service account token:

1. Configure the local environment to work with the created {{ k8s }} cluster. To do this, run the command:

    {% list tabs %}

    - Bash

        ```
        yc managed-kubernetes cluster get-credentials <cluster-id> --external
        ```

    {% endlist %}

1. Save the configuration for creating a {{ k8s }} service account to a YAML file named `gitlab-admin-service-account.yaml`:

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

1. Get the token using the `kubectl get secrets` command:

    {% list tabs %}

    - Bash

        ```
        kubectl -n kube-system get secrets -o json | \
        jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | \
        base64 --decode
        ```

    {% endlist %}

1. Save the token: you need it for the next steps.

