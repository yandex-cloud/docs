## Connect the {{ k8s }} cluster to the GitLab builds {#runners}

To run your build tasks on a {{ k8s }} cluster, connect the cluster in the GitLab settings.

1. In the browser, open a link in the format `http://<public GitLab VM IP address>/root`.

1. Select the project named `gitlab-test`.

1. In the window that opens on the left, click **Operations** and select **Kubernetes**.

1. Click **Add Kubernetes cluster**.

1. In the window that opens click **Add existing cluster**.

1. In the **Kubernetes cluster name** field, enter the cluster name.

1. In the **URL API** field, enter the [master](../../managed-kubernetes/concepts/index.md#master) node address. Retrieve it using the command:

    {% list tabs %}

    - Bash

      ```
      yc managed-kubernetes cluster get <cluster-id> --format=json \
      | jq -r .master.endpoints.external_v4_endpoint
      ```

    {% endlist %}

1. In the **CA Certificate** field, enter the master certificate. Retrieve it using the command:

    {% list tabs %}

    - Bash

      ```
      yc managed-kubernetes cluster get <cluster-id> --format=json \
      | jq -r .master.master_auth.cluster_ca_certificate
      ```

    {% endlist %}

1. In the **Service Token** field, enter the token GitLab will use to create the {{ k8s }} resources.
Use the token you received before you started.

1. Click **Add Kubernetes cluster**.

1. Install the applications required for proper operation of GitLab Runner on the {{ k8s }} cluster:
    - Click **Install** next to **Helm Tiller**.
    - Click **Install** next to **GitLab Runner**.

Now you can run automated builds inside your {{ k8s }} cluster.

Read more about {{ k8s }} cluster connection settings for GitLab builds in the [GitLab documentation](https://docs.gitlab.com/ee/user/project/clusters/#add-existing-kubernetes-cluster).

