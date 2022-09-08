### Get a {{ k8s }} service account token to authenticate with {{ GL }} {#k8s-get-token}

{% note info %}

Please note that your service account in {{ k8s }} is different from your [{{ iam-full-name }} service account](../../iam/concepts/users/service-accounts.md). For more information, see the [{{ managed-k8s-name }} documentation](../../managed-kubernetes/concepts/index.md#service-accounts).

{% endnote %}

To get the {{ k8s }} service account token:
1. Configure the local environment to work with the created {{ k8s }} cluster.

   ```bash
   {{ yc-k8s }} cluster get-credentials <cluster ID or name> --external
   ```

1. Save the specification for creating a {{ k8s }} service account to a YAML file named `gitlab-admin-service-account.yaml`:

   ```yaml
   ---
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

1. Create a service account:

   ```bash
   kubectl apply -f gitlab-admin-service-account.yaml
   ```

1. Retrieve the service account token:

   ```bash
   kubectl -n kube-system get secrets -o json | \
   jq -r '.items[] | select(.metadata.name | startswith("gitlab-admin")) | .data.token' | \
   base64 --decode
   ```

1. Save the token: you need it for the next steps.