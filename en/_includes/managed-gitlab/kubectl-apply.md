## Configure automatic deployment of {{ k8s }} resources from CI {#k8s-apply}

To set up automatic deployment, specify the [{{ k8s }} master](../../managed-kubernetes/concepts/index.md#master) address and [service account](../../iam/concepts/index.md#sa) token in the {{ GL }} settings.
1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html).
   * `KUBE_URL`: The {{ k8s }} master address. Retrieve it using the command:

     {% list tabs %}

     - Bash

        ```bash
        yc managed-kubernetes cluster get <cluster-id> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

     {% endlist %}

   * `KUBE_TOKEN`: The token which {{ GL }} will use to apply the configuration. Use the token you received before you started.
1. Use environment variables at the application deployment stage.

   The `.gitlab-ci.yml` [configuration](https://docs.gitlab.com/ee/ci/README.html) file will be as follows:

   ```yaml
   deploy:
     image:
       name: gcr.io/cloud-builders/kubectl:latest
       entrypoint: [""]
     stage: deploy
     script:
       - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
       - kubectl config set-credentials admin --token="$KUBE_TOKEN"
       - kubectl config set-context default --cluster=k8s --user=admin
       - kubectl config use-context default
       - kubectl apply -f k8s.yaml
   ```

Now, every time you run an automated build, a task to change the {{ k8s }} resource configuration is created.