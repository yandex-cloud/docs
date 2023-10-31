### Get a {{ k8s }} service account token to authenticate with {{ GL }} {#k8s-get-token}

{% note info %}

The [{{ k8s }} service account](../../managed-kubernetes/concepts/index.md#service-accounts) is different from the [{{ iam-full-name }} service account](../../iam/concepts/users/service-accounts.md).

{% endnote %}

To get the {{ k8s }} service account token:
1. Configure the local environment to work with the created [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

   ```bash
   {{ yc-k8s }} cluster get-credentials <cluster ID or name> --external
   ```

1. Save the specification for creating a {{ k8s }} service account to a YAML file named `gitlab-admin-service-account.yaml`:

   {% cut "gitlab-admin-service-account.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: gitlab-admin
     namespace: kube-system
   ---
   apiVersion: rbac.authorization.k8s.io/v1
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
   ---
   apiVersion: v1
   kind: Secret
   metadata:
     name: gitlab-admin-token
     namespace: kube-system
     annotations:
       kubernetes.io/service-account.name: gitlab-admin
   type: kubernetes.io/service-account-token
   ```

   {% endcut %}

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