## Configure automatic deployment of {{ k8s }} resources using CI {#k8s-apply}

To set up automatic deployment, specify the master address and {{ k8s }} service account token in the GitLab settings.

1. Create the [GitLab environment variables](https://docs.gitlab.com/ee/ci/variables/README.html):
    - `KUBE_URL`: The [master](../../managed-kubernetes/concepts/index.md#master) node address. Retrieve it using the command:

      {% list tabs %}

      - Bash

          ```
          yc managed-kubernetes cluster get <cluster-id> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
          ```

      {% endlist %}

    - `KUBE_TOKEN`: The token GitLab will use to apply the configuration. Use the token you received before you started.
1. Use environment variables at the application deployment stage.

  Make sure that the `.gitlab-ci.yml` configuration file looks like this:
[Configuration file](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` will then look like this:

    ```
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

Now, every time you make a commit, GitLab builds your application into a Docker image and deploys it on the {{ k8s }} cluster.

