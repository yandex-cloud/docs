1. Create the [GitLab environment variables](https://docs.gitlab.com/ee/ci/variables/README.html).
    1. In GitLab, go to **Settings** in the left panel and select **CI/CD** from the drop-down list.
    1. Click **Expand** next to **Variables**.
    1. Add two environment variables:
        - `KUBE_URL`: The [master](../../managed-kubernetes/concepts/index.md#master) node address. Retrieve it using the command:

          {% list tabs %}

          - Bash

              ```
              yc managed-kubernetes cluster get <cluster-id> --format=json \
              | jq -r .master.endpoints.external_v4_endpoint
              ```

          {% endlist %}

        - `KUBE_TOKEN`: The token GitLab will use to apply the configuration. Use the token received when getting started.
    1. Click **Save variables**.

1. With GitLab, you can configure your [build scripts](https://docs.gitlab.com/ee/ci/README.html) in a YAML file. Create a configuration file named `.gitlab-ci.yml`:
    1. In GitLab, go to **Project** in the left panel and select **Details**.
    1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
    1. Name the file `.gitlab-ci.yml`. Add the steps to build and push a Docker image and update the {{ k8s }} cluster:

    ```yaml
    stages:
      - build
      - deploy
    
    build:
      stage: build
      variables:
        DOCKER_DRIVER: overlay2
        DOCKER_TLS_CERTDIR: ""
        DOCKER_HOST: tcp://localhost:2375/
      image: cr.yandex/yc/metadata-token-docker-helper:0.2
      services:
        - docker:19.03.1-dind
      script:
        - docker build . -t cr.yandex/<registry ID>/hello:gitlab-$CI_COMMIT_SHORT_SHA
        - docker push cr.yandex/<registry ID>/hello:gitlab-$CI_COMMIT_SHORT_SHA
    
    deploy:
      image: gcr.io/cloud-builders/kubectl:latest
      stage: deploy
      script:
        - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
        - kubectl config set-credentials admin --token="$KUBE_TOKEN"
        - kubectl config set-context default --cluster=k8s --user=admin
        - kubectl config use-context default
        - sed -i "s/__VERSION__/gitlab-$CI_COMMIT_SHORT_SHA/" k8s.yaml
        - kubectl apply -f k8s.yaml
    ```
    1. In the given file, replace the `<registry ID>` with the ID of your previously created registry.
    1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
    1. Click **Commit changes**.

    {% note info %}

    In the `.gitlab-ci.yml` file, the following two steps of project build are described:
    * Build a Docker image using the `Dockerfile` from the previous step and push the image to {{ container-registry-name }}.
        * For this step, use the Docker image build container and run the Docker server as a [GitLab service](https://docs.gitlab.com/ee/ci/yaml/README.html#services).
        * For {{ container-registry-name }} authentication, use a service account linked to the {{ k8s }} nodes. When getting started, this account was assigned the [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) role.
        * To get authentication data from VM metadata, use an auxiliary public Docker image `cr.yandex/yc/metadata-token-docker-helper:0.2`. It runs [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper), which gets an IAM token from the metadata service.
    * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ k8s }} clusters. This way the application is deployed on the previously created cluster.

    {% endnote %}

1. After saving the file, the build script should start. You can view its progress on the **CI/CD** tab on the left by selecting **Pipelines** from the drop-down menu. Wait until both build steps are complete.

1. Check the results in the container logs in the {{ k8s }} cluster:

{% list tabs %}

- Bash

    ```
    kubectl logs deployment/hello-world-deployment -n hello-world
    
    Hello
    ```

{% endlist %}

