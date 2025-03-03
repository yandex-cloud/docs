# Building a CI/CD pipeline in {{ GL }} with serverless products


You can build a continuous integration/continuous delivery (CI/CD) pipeline using serverless products.

As an example, we will use a [Django](https://www.djangoproject.com/) web app simulating an online store shopping cart. The app uses a database to store product descriptions and the user session to store the product cart status. We deploy the Django app in a [{{ serverless-containers-name }} container](../../serverless-containers/concepts/container.md) with secrets securely delivered to it through [{{ lockbox-name }}](../../lockbox/). [{{ api-gw-full-name }}](../../api-gateway/) accepts user requests and redirects them to the app container.

The project uses two environments:
* `prod`: Production environment available to users.
* `testing`: Test environment for testing the app before the release.

For each environment, there is an individual {{ yandex-cloud }} [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and separate static resources, e.g., the DB and [service accounts](../../iam/concepts/users/service-accounts.md). This isolates the environments from each other at the [{{ iam-full-name }}](../../iam/) settings level.

There is also a common `infra` folder with a in [{{ container-registry-full-name }}](../../container-registry/) [registry](../../container-registry/concepts/registry.md) containing all app’s [Docker images](../../container-registry/concepts/docker-image.md). The system publishes the images under the `builder` service account. The `prod` and `testing` environment service accounts have restricted permissions in the `infra` folder limited to [pulling Docker images](../../container-registry/operations/docker-image/docker-image-pull.md).

To build a CI/CD pipeline with serverless products:
1. [Create a {{ GL }} instance](#create-gitlab).
1. [Configure {{ GL }}](#configure-gitlab).
1. [Create a {{ GLR }}](#runners).
1. [Upload files to the {{ GL }} repository](#add-files).
1. [Create {{ GL }} environment variables](#add-variables).
1. [Create the CI script configuration file](#add-ci).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

### Download a project {#download-project}

Clone the [yc-serverless-gitlab-ci-cd repository](https://github.com/yandex-cloud-examples/yc-serverless-gitlab-ci-cd) using Git:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-gitlab-ci-cd.git
```

### Install additional dependencies {#prepare}

Install the following tools in the local environment:
* [{{ yandex-cloud }} command line interface](../../cli/operations/install-cli.md).
* [`jq` JSON stream processor](https://stedolan.github.io/jq/download/).
* [`yq` YAML stream processor](https://github.com/mikefarah/yq#install).
* [Python 3.8 or higher](https://www.python.org/downloads/).
* Python libraries listed in the `application/requirements.txt` project file:

  ```bash
  python -m pip install -r ./application/requirements.txt
  ```

### Prepare the infrastructure {#deploy-infrastructure}

1. Navigate to the project directory; run the `bootstrap.sh` script and specify your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) ID:

   ```bash
   YC_CLOUD_ID=<cloud_ID> ./bootstrap.sh
   ```

   The script will deploy the basic infrastructure and create YAML resource description files in the `config` directory. You can edit the script to create additional resource folders. For example, this way you can add another test environment.

   {% note warning %}

   Once completed, the script will display {{ GL }} environment variables and their values. Save them, as you will need them later.

   {% endnote %}

1. [Create service accounts](../../iam/operations/sa/create.md):
   * Service account for resources with the [{{ roles-editor }}](../../iam/roles-reference.md#editor) [role](../../iam/concepts/access-control/roles.md) for the [{{ managed-k8s-full-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) folder. This service account will be used to create {{ managed-k8s-name }} cluster resources.
   * Service account for [nodes](../../managed-kubernetes/concepts/index.md#node-group) with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) role for the Docker image registry folder. Nodes will pull the required Docker images from the registry on behalf of this account.

   You can use the same service account for both operations.
1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md). When creating the cluster, specify the previously created service accounts for the resources and nodes.
1. [Configure security groups](../../managed-kubernetes/operations/connect/security-groups.md) for the {{ managed-k8s-name }} cluster.
1. [Configure a security group](../../managed-gitlab/operations/configure-security-group.md) for the [{{ mgl-full-name }} instance](../../managed-gitlab/concepts/index.md#instance).

## Create a {{ GL }} instance {#create-gitlab}

Create either a {{ mgl-name }} instance or a [VM](../../compute/concepts/vm.md) with a {{ GL }} [image](../../compute/concepts/image.md) on the same [cloud network](../../vpc/concepts/network.md#network) as the {{ managed-k8s-name }} cluster.

{% list tabs group=gl_installation %}

- {{ mgl-name }} instance {#instance-mgl}

  Create a {{ mgl-name }} instance by following [this guide](../../managed-gitlab/quickstart.md#instance-create).

- VM with a {{ GL }} image {#gl-image-vm}

  Launch {{ GL }} on a VM with a [public IP](../../vpc/concepts/address.md#public-addresses).

  {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Upload files to the {{ GL }} repository {#add-files}

1. [Add an SSH key to securely access {{ GL }}](https://docs.gitlab.com/ee/user/ssh.html).
1. [Clone the `gitlab-test` repository](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-with-ssh) over SSH.
1. Copy all files from the `yc-serverless-gitlab-ci-cd` repository to `gitlab-test`.
1. Navigate to the `gitlab-test` directory.
1. Index the new files:

   ```bash
   git add .
   ```

1. Commit the files:

   ```bash
   git commit -m "Add project files"
   ```

1. Push changes to the `gitlab-test` repository:

   ```bash
   git push
   ```

## Create {{ GL }} environment variables {#add-variables}

1. In {{ GL }}, navigate to **Settings** in the left-hand panel and select **CI/CD** from the drop-down list.
1. Click **Expand** next to **Variables**.
1. Add environment variables with the protection option disabled. The `bootstrap.sh` script will display all the required variables and their values:
   * `cloud_id`: Your cloud ID.
   * `CI_REGISTRY`: {{ container-registry-name }}-based registry ID with the `{{ registry }}/` prefix in the `infra` folder.
   * `CI_REGISTRY_KEY`: The `builder` service account [key](../../iam/concepts/users/service-accounts.md#sa-key).
   * `cart_prod`: {{ yandex-cloud }} production folder name.
   * `DOCAPI_ENDPOINT_prod`: Document API endpoint of the [{{ ydb-full-name }}](../../ydb/) database in the `prod` folder.
   * `PROD_SA_ID`: `deployer` service account ID in the `prod` folder.
   * `SA_PROD_DEPLOYER_PRIVATE_KEY`: `deployer` service account key in the `prod` folder.
   * `prod_container_id`: {{ serverless-containers-name }}-based container ID in the `prod` folder.
   * `cart_testing`: {{ yandex-cloud }} test folder name.
   * `DOCAPI_ENDPOINT_testing`: Document API endpoint of the {{ ydb-name }} database in the `testing` folder.
   * `TESTING_SA_ID`: The `deployer` service account ID in the `testing` folder.
   * `SA_TESTING_DEPLOYER_PRIVATE_KEY`: The `deployer` service account key in the `testing` folder.

   To add a variable:
   1. Click **Add variable**.
   1. In the window that opens, specify the variable name in the **Key** field and its value in the **Value** field.
   1. Disable the **Protect variable** option.
   1. Click **Add variable**.

## Create the CI script configuration file {#add-ci}

1. Open the `gitlab-test` project.
1. Click ![image](../../_assets/console-icons/plus.svg) in the repository navigation bar and select **New file** from the drop-down menu.
1. Name the file as `.gitlab-ci.yml` and add the following build stages to it:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
     - build
     - deploy-test-env
     - test
     - delete-test-env
     - release

   # Building a container image.
   build-job:
     stage: build
   # Using `kaniko` to create a container inside another container for enhanced security.
     image:
       name: gcr.io/kaniko-project/executor:debug
       entrypoint: [""]
     script:
       - mkdir -p /kaniko/.docker
   # Upload the container image to the registry. The image is tagged with the commit hash.
       - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
       - >-
         /kaniko/executor
         --context "${CI_PROJECT_DIR}/application"
         --dockerfile "${CI_PROJECT_DIR}/application/Dockerfile"
         --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

   # Deploying a test environment using a built-in container image.
   deploy-test-env-job:
     stage: deploy-test-env
     image: alpine:3.15
     script:
   # Installing tools.
       - apk add -q --no-cache bash curl jq gettext
       - apk add yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
       - curl --fail -silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
    # Authentication with a service account key.
       - echo "$SA_TESTING_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
   # Setting up the {{ api-gw-name }} variables and creating a container.
       - export sa_id=$TESTING_SA_ID
       - export container_id=$(yc serverless container create --name testing --cloud-id ${cloud_id} --folder-name ${cart_testing} | yq .id)
   # Deploying a revision.
       - yc serverless container revision deploy --container-name testing --image "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}" --cores 1 --memory 512mb --concurrency 1 --execution-timeout 10s --cloud-id ${cloud_id} --folder-name ${cart_testing} --service-account-id ${TESTING_SA_ID} --environment DOCAPI_ENDPOINT=${DOCAPI_ENDPOINT_testing},DB_TABLE_PREFIX='' --secret environment-variable=AWS_ACCESS_KEY_ID,name=cart-app,key=AWS_ACCESS_KEY_ID --secret environment-variable=AWS_SECRET_ACCESS_KEY,name=cart-app,key=AWS_SECRET_ACCESS_KEY --secret environment-variable=SECRET_KEY,name=cart-app,key=SECRET_KEY
   # Setting up a template and deploying {{ api-gw-name }}.
       - (cat ${CI_PROJECT_DIR}/apigw.yaml.j2 | envsubst) > apigw.yaml
       - cat apigw.yaml
       - yc serverless api-gateway create --name testing --spec=apigw.yaml --description "created from gitlab CI" --cloud-id ${cloud_id} --folder-name ${cart_testing}
       - mkdir output
       - export gwdomain=$(yc serverless api-gateway get testing --cloud-id ${cloud_id} --folder-name ${cart_testing} | yq .domain)
       - echo "https://"$gwdomain>output/gwurl
     artifacts:
       paths: [output/]

   e2e-test-job:
     stage: test
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl
       - apk add yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
       - cat output/gwurl
       - export gwurlvar=$(cat output/gwurl)
       - curl $gwurlvar

   load-test-job:
     stage: test
     image: alpine:3.15
     script:
       - echo "Here goes load testing commands"
       - echo "Might even invoke bash with prepared bash script"
       - echo "Hello!"

   delete-test-env-job:
     stage: delete-test-env
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl jq gettext yq
       - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
       - echo "$SA_TESTING_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
       - yc serverless api-gateway delete testing --cloud-id ${cloud_id} --folder-name ${cart_testing}
       - yc serverless container delete testing --cloud-id ${cloud_id} --folder-name ${cart_testing}

   release-job:
     stage: release
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl jq gettext
       - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
       - echo "$SA_PROD_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
       - yc serverless container revision deploy --container-name prod --image "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}" --cores 1 --memory 512mb --concurrency 1 --execution-timeout 10s --cloud-id ${cloud_id} --folder-name ${cart_prod} --service-account-id ${PROD_SA_ID} --environment DOCAPI_ENDPOINT=${DOCAPI_ENDPOINT_prod},DB_TABLE_PREFIX='' --secret environment-variable=AWS_ACCESS_KEY_ID,name=cart-app,key=AWS_ACCESS_KEY_ID --secret environment-variable=AWS_SECRET_ACCESS_KEY,name=cart-app,key=AWS_SECRET_ACCESS_KEY --secret environment-variable=SECRET_KEY,name=cart-app,key=SECRET_KEY
       - container_id=${prod_container_id}
   # Creating a production environment.
     environment:
       name: production/$CI_COMMIT_SHORT_SHA
   ```

   {% endcut %}

1. Add a comment in the **Commit message** field: `CI scripts`.
1. Click **Commit changes**.

The `.gitlab-ci.yml` file contains the following steps of the CI script:
* **build**: Building a Docker image with `Dockerfile` and pushing the image to {{ container-registry-name }}.
* **deploy-test-env**: App test deployment. Additionally, we described the [artifacts](https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html) feature to transfer data from one stage to another that we are not going to use here. You can configure it, if required.
* **test**: Testing the app. The tests involve E2E simulation and load testing. You can describe and set up custom tests as well.
* **delete-test-env**: Deleting the test app.
* **release**: Deploying the app in production. This stage also uses [deployment environments](https://docs.gitlab.com/ee/ci/environments/). The system creates and saves them each time the pipeline is run successfully. Use them to restore and deploy the previous app version.

After you save the `.gitlab-ci.yml` configuration file, the build script will start.

## Check the result {#check-result}

To check the build script results, select **Build** on the left-hand panel in the `gitlab-test` project, and then **Pipelines** from the drop-down menu. Make sure all five stages complete successfully.

You can access the app at the {{ api-gw-name }} service domain URL in the `prod` folder. You can find this URL in the [management console]({{ link-console-main }}) or in the `domain` field of the `bootstrap.sh` script runtime log.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
1. [Delete](../../resource-manager/operations/folder/delete.md) the `prod`, `testing`, and `infra` folders with their content.
1. [Delete the {{ mgl-name }} instance](../../managed-gitlab/operations/instance/instance-delete.md) or the [{{ GL }} image VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the cluster public static IP address if you reserved one.
1. [Delete the service accounts](../../iam/operations/sa/delete.md).
