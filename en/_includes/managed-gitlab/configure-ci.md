1. Create the [{{ GL }} environment variables](https://docs.gitlab.com/ee/ci/variables/README.html).
   1. Go to **Settings** in the left-hand {{ GL }} panel and select **CI/CD** from the drop-down list.
   1. Click **Expand** next to **Variables**.
   1. Add two environment variables:
      * `CI_REGISTRY`: Address of the previously created [registry](../../container-registry/concepts/registry.md) in `{{ registry }}/<registry_ID>` format.
      * `CI_REGISTRY_KEY`: Key that {{ GL }} will use to access the registry. Copy the contents of the previously obtained `key.json` static key file to access the registry.

      To add a variable:
      * Click **Add variable**.
      * In the window that opens, enter the variable name in the **Key** field and the value in the **Value** field.
      * Click **Add variable**.
1. {{ GL }} enables you to configure [build scripts](https://docs.gitlab.com/ee/ci/README.html) in a YAML file. Create a configuration file named `.gitlab-ci.yml`:
   1. In the left-hand panel in {{ GL }}, select **Repository** and click the **Files** tab.
   1. To the right of the project name, click **+** and select **New file** from the drop-down menu.
   1. Name the file as `.gitlab-ci.yml`. Add the steps to build and push a [Docker image](../../container-registry/concepts/docker-image.md) and update the application configuration in the [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

      ```yaml
      stages:
        - build
        - deploy

      build:
        image:
          name: gcr.io/kaniko-project/executor:debug
          entrypoint: [""]
        stage: build
        script:
          - mkdir -p /kaniko/.docker
          - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor \
              --context "${CI_PROJECT_DIR}" \
              --dockerfile "${CI_PROJECT_DIR}/Dockerfile" \
              --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

      deploy:
        image: bitnami/kubectl:latest
        stage: deploy
        script:
          - kubectl config use-context ${CI_PROJECT_PATH}:<agent_name_in_{{ GL }}>
          - cat k8s.yaml | sed -e "s,__IMAGE__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl -n default apply -f -
      ```

   1. Add a comment to the commit in the **Commit message** field: `CI scripts`.
   1. Click **Commit changes**.

   In the `.gitlab-ci.yml` file, the following two steps of project build are described:
   * Build a Docker image using the `Dockerfile` from the previous step and push the image to [{{ container-registry-full-name }}](../../container-registry/).
      * Docker images inside a container are built using [Kaniko](https://github.com/GoogleContainerTools/kaniko).
      * {{ container-registry-name }} authentication is done using a [service account](../../iam/concepts/users/service-accounts.md) connected to [{{ managed-k8s-name }} nodes](../../managed-kubernetes/concepts/index.md#node-group). When creating a {{ managed-k8s-name }} cluster, this account was assigned the [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) [role](../../iam/concepts/access-control/roles.md).
   * The `k8s.yaml` configuration is applied to the {{ managed-k8s-name }} cluster via {{ GLA }} and a Docker image with `kubectl`.
1. After saving the file, the build script starts. To track its progress, in the drop-down menu, select **CI/CD** → **Pipelines**. Wait until both build steps are complete.
1. Connect to the test application:
   1. Configure service port forwarding to the local computer:

      ```bash
      kubectl port-forward service/dummy 30000:80 \
        --namespace default
      ```

   1. In your browser, open the application at `http://localhost:30000`. You should see the `"Hello world!"` string.