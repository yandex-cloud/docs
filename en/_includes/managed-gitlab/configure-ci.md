1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html).
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add two environment variables:
      * `KUBE_URL`: [{{ k8s }} master address](../../managed-kubernetes/concepts/index.md#master). Retrieve it using this command:

        ```bash
        yc managed-kubernetes cluster get <{{ k8s }} cluster ID or name> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN`: Token that will use {{ GL }} to apply the configuration. Use the token that you received previously.

      To add a variable:
      1. Click **Add variable**.
      1. In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      1. Click **Add variable**.
1. {{ GL }} enables you to configure [build scripts](https://docs.gitlab.com/ee/ci/README.html) in a YAML file. Create a configuration file named `.gitlab-ci.yml`:
   1. On the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
   1. Name the file `.gitlab-ci.yml`. Add the steps to build and push a [Docker image](../../container-registry/concepts/docker-image.md) and update the application configuration in the [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

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
        image: {{ registry }}/yc/metadata-token-docker-helper:0.2
        services:
          - docker:19.03.1-dind
        script:
          - docker build . -t {{ registry }}/<registry ID>/hello:gitlab-$CI_COMMIT_SHORT_SHA
          - docker push {{ registry }}/<registry ID>/hello:gitlab-$CI_COMMIT_SHORT_SHA

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

   1. In the given file, replace the `<registry ID>` with the ID of your previously created [registry](../../container-registry/concepts/registry.md).
   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following two steps of project build are described:
   * Build a Docker image using the `Dockerfile` from the previous step and push the image to [{{ container-registry-full-name }}](../../container-registry/).
     * For this step, use your container for building Docker images and start a Docker server as a [{{ GL }} service](https://docs.gitlab.com/ee/ci/yaml/README.html#services).
     * For {{ container-registry-name }} authentication, use a [service account](../../iam/concepts/users/service-accounts.md) linked to the {{ k8s }} nodes. When getting started, this account was assigned the [{{ roles-cr-pusher }}](../../container-registry/security/index.md#choosing-roles).
     * To get authentication credentials from the VM [metadata](../../compute/concepts/vm-metadata.md), use an auxiliary public Docker image `{{ registry }}/yc/metadata-token-docker-helper:0.2`. It runs an internal [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper) that obtains a {{ iam-name }} token from the metadata service.
   * Set up an environment to work with {{ k8s }} and apply `k8s.yaml` configurations to {{ k8s }} clusters. This way the application is deployed on the previously created cluster.
1. After saving the file, the build script starts. To track its progress, in the drop-down menu, select **CI/CD** → **Pipelines**. Wait until both build steps are complete.
1. Check the results in the container logs in the {{ k8s }} cluster:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Result:

   ```text
   Hello
   ```