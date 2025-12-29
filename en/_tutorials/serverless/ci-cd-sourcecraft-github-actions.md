# Setting up CI/CD to deploy an application to {{ serverless-containers-full-name }} using GitHub Actions


In this tutorial, you will set up a [CI/CD process]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) to deploy a containerized application to [{{ serverless-containers-name }}](../../serverless-containers/concepts/index.md) from a {{ src-name }} [repository]({{ link-src-docs }}/sourcecraft/concepts/#repos) using [GitHub Actions]({{ link-src-docs }}/sourcecraft/concepts/gh-actions). The integration between {{ src-name }} and {{ yandex-cloud }} will be implemented using a [service connection]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

{% include [service-connection-role-warning](../../_includes/sourcecraft/service-connection-role-warning.md) %}

To set up CI/CD to deploy an application to {{ serverless-containers-name }} from a{{ src-name }} repository using GitHub Actions:
1. [Create a service account](#create-sa).
1. [Create a registry](#create-registry).
1. [Create a repository](#create-repository-sc).
1. [Create a service connection](#create-service-connection).
1. [Configure CI/CD](#config-ci-cd).
1. [Test CI/CD](#check-ci-cd).
1. [Make sure the container has been created](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Fee for storing the created Docker images (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md).
* Fee for the number of container invocations, computing resources allocated to the application, and outgoing traffic (see [{{ serverless-containers-name }} pricing](../../serverless-containers/pricing.md).

## Create a service account {#create-sa}

You will use this [service account](../../iam/concepts/users/service-accounts.md) to upload Docker images to [registries](../../container-registry/concepts/registry.md) in {{ container-registry-full-name }} and deploy [containers](../../serverless-containers/concepts/container.md) to {{ serverless-containers-name }}.

{% list tabs group=instructions %}

- Management console {#console}

  1. Log in to the {{ yandex-cloud }} [management console]({{ link-console-main }}).
  1. On the left side of the screen, click the line with the name of the folder where you want to deploy your container.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `github-action`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select these roles:

      * `{{ roles-cr-pusher }}`: To work with Docker images in a registry.
      * `serverless-containers.editor`: To manage the container.
      * `iam.serviceAccounts.user`: To enable specifying a service account when creating a container revision. This account will be used to pull the Docker image from the registry.

  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Create a service account:

      ```bash
      yc iam service-account create \
        --name github-action
        --folder-name <folder_name>
      ```

      Result:

      ```yaml
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: github-action
      ```

  1. Assign the service account the following [roles](../../iam/concepts/access-control/roles.md) for the folder:

      * `iam.serviceAccounts.user`: To enable specifying a service account when creating a container revision. This account will be used to pull the Docker image from the registry:

        ```bash
        yc resource-manager folder add-access-binding <folder_name> \
          --service-account-name github-action \
          --role iam.serviceAccounts.user \
          --folder-name <folder_name>
        ```

      * `serverless-containers.editor`: To manage the container:

        ```bash
        yc resource-manager folder add-access-binding <folder_name> \
          --service-account-name github-action \
          --role serverless-containers.editor \
          --folder-name <folder_name>
        ```

      * `{{ roles-cr-pusher }}`: To work with Docker images in the registry:

        ```bash
        yc resource-manager folder add-access-binding <folder_name> \
          --service-account-name github-action \
          --role {{ roles-cr-pusher }} \
          --folder-name <folder_name>
        ```

- API {#api}

  1. Create a service account named `github-action`. To do this, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. Assign the service account these [roles](../../iam/concepts/access-control/roles.md) for the current folder:

      * `iam.serviceAccounts.user`: To enable specifying a service account when creating a container revision. This account will be used to pull the Docker image from the registry.
      * `serverless-containers.editor`: To manage the container.
      * `{{ roles-cr-pusher }}`: To work with Docker images in the registry.

      To do this, use the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

{% endlist %}

## Create a registry {#create-registry}

The registry in {{ container-registry-name }} will house the application’s Docker image.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Specify `github-action` as the registry name.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.
  1. Save the new registry’s ID, you will need it later.

- CLI {#cli}

  Create a registry named `github-action`:

  ```bash
  yc container registry create --name github-action
  ```

  Result:

  ```text
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: github-action
  status: ACTIVE
  created_at: "2025-10-03T10:34:06.601Z"
  ```

  Save the new registry’s ID, you will need it later.

- API {#api}

  Use the [create](../../container-registry/api-ref/Registry/create.md) REST API method for the [Registry](../../container-registry/api-ref/Registry/index.md) resource or the [RegistryService/CreateRegistryRequest](../../container-registry/api-ref/grpc/Registry/create.md) gRPC API call.

  Save the new registry’s ID, you will need it later.

{% endlist %}

## Create a repository {#create-repository-sc}

The repository will be created from the [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless) template and store the `Dockerfile`, auxiliary files for creating the Docker image, and the CI/CD process settings.

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the [service home page]({{ link-src-main }}).
  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_create-repository }}**.
  1. In the window that opens, select **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_create-blank }}**.
  1. Under **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_new-repo-details }}**:
      * In the **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_owner-field }}** field, select the [organization]({{ link-src-docs }}/sourcecraft/concepts/#org) in which you created the {{ yandex-cloud }} service account.
      * In the **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_repo-field }}** field, specify a name for the repository. 

        The name must be unique within the organization. The name may contain the following [ASCII characters](https://ru.wikipedia.org/wiki/ASCII): lowercase and uppercase Latin letters, numbers, commas, hyphens, and underscores.

        The address to access the repository at is displayed below the name.

      * Optionally, in the **{{ ui-key.sourcecraft.ui_modules_repoSettings.field_description }}** field, enter a description for the repository.

  1. Under **{{ ui-key.sourcecraft.ui_modules_repoCreate.section_template }}**, click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_browse-templates }}**, select the [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless) template, and click **{{ ui-key.sourcecraft.ui_modules_repo.button_use-template }}**.

      To view the template contents, click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_preview-template }}**.

      The template contains:
      * [.sourcecraft/ci.yaml]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/.sourcecraft/ci.yaml) file with a pre-installed configuration of the CI/CD process that runs when a commit is created and does the following:
        * Obtains a {{ yandex-cloud }} IAM token using a service connection named `default-service-connection`.
        * Installs [Docker Buildx](https://github.com/docker/buildx) in the [worker]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#workers) environment using the [Docker Setup Buildx](https://github.com/marketplace/actions/docker-setup-buildx) GitHub Action.
        * Authenticates with {{ container-registry-name }} using the [Docker Login](https://github.com/marketplace/actions/docker-login) GitHub Action and the {{ yandex-cloud }} IAM token.
        * Builds a Docker image from the `Dockerfile` located at the repository root and pushes it to {{ container-registry-name }} using the [Build and Push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images) GitHub Action.
        * Deploys a container in {{ serverless-containers-name }} from the built Docker image.
      * [Dockerfile]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/Dockerfile), [index.html]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/index.html), and [docker/nginx/conf.d/default.conf]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/docker/nginx/conf.d/default.conf) with the configuration of a container with a static web app based on [Nginx](https://nginx.org/{{ lang }}/).

  1. Click **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_create-repo }}**.

{% endlist %}

## Create a service connection {#create-service-connection}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. Navigate to the ![image](../../_assets/console-icons/briefcase.svg) **{{ ui-key.sourcecraft.ui_lib.organizations }}** tab.
  1. Select the organization where you created the {{ yandex-cloud }} service account.
  1. On the organization page, in the ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.ui_lib.settings }}** section, go to the ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_service-connections }}** section.
  1. Click **{{ ui-key.sourcecraft.ui_modules_serviceConnections.button_add-connection }}**.
  1. Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_basic }}**, specify the service connection name, `default-service-connection`.
  1. Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_scope }}**, select the repository you created earlier.
  1. Under **{{ ui-key.sourcecraft.ui_modules_serviceConnections.section_cloud-settings }}**, select:

      * Folder where you previously deployed the cloud infrastructure and assigned a role to the service account.
      * `github-action` service account.

        {% note tip %}

        To re-request the list of clouds, folders, and service accounts from {{ yandex-cloud }}, click ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Synchronize**. This can be of use if alongside creating a service connection you also created a folder or service account.

        {% endnote %}

  1. Click **{{ ui-key.sourcecraft.ui_modules_serviceConnections.button_create-connection }}**.

      Wait for the operation to complete. The page that opens will display the service connection details.

      A {{ iam-full-name }} [workload identity federation](../../iam/concepts/workload-identity.md) will be automatically created in {{ yandex-cloud }}.

      To view the parameters of the new OIDC provider, click the federation name under ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.sourcecraft.ui_modules_serviceConnections.title_oidc-federation }}**.

{% endlist %}

## Configure CI/CD {#config-ci-cd}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Select `.sourcecraft/ci.yaml`.
  1. In the top-right corner, click ![image](../../_assets/console-icons/pencil.svg) **Edit**.
  1. In the `YC_DOCKER_REGISTRY_URI` parameter, specify the ID of the registry you [previously](#create-registry) created:

      ```yaml
      YC_DOCKER_REGISTRY_URI: {{ registry }}/<registry_ID>
      ```

  1. In the top-right corner, click **{{ ui-key.sourcecraft.ui_modules_repo.action_commit }}**.
  1. Commit:

      1. Enter a message about the changes.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_commit-branch }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.field_text_commit-directly-to-the-branch }} main**.
      1. Under **{{ ui-key.sourcecraft.ui_modules_repo.field_after-commit-action }}**, select **{{ ui-key.sourcecraft.ui_modules_repo.option_just-commit }}**.
      1. Click **{{ ui-key.sourcecraft.ui_modules_repo.button_commit }}**.

{% endlist %}

After saving the changes, `demo-service-connection-workflow` will start.

## Test CI/CD {#check-ci-cd}

{% list tabs group=instructions %}

- {{ src-name }} UI {#src}

  1. Open the {{ src-name }} [home page]({{ link-src-main }}).
  1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.ui_modules_orgCommon.link_your-craftspace }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_lib.repositories }}**.
  1. Select the repository you created earlier.
  1. Under ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-code }}** on the repository page, go to ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.ui_modules_repo.action_cicd }}**.
  1. In the list of automation executions, you will see a new execution. Wait for the status to change to ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_succeeded }}**.

{% endlist %}

## Make sure the container has been created {#check-result}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. In the list, you should see `demo-serverless-container1`; select it.

      Under **{{ ui-key.yacloud.serverless-containers.section-revisions }}**, you should now see the container revision with the same timestamp as the [CI/CD process execution](#check-ci-cd).

- CLI {#cli}

  Run this command:

  ```bash
  yc serverless container revision list \
    --container-name demo-serverless-container1
  ```

  Where `--container-name` is the container name specified in `.sourcecraft/ci.yaml`.

  Result:

  ```text
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  |          ID          |     CONTAINER ID     |                 IMAGE                                  |     CREATED AT      |
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  | bba27hejd69a******** | bba83i1mrb5s******** | {{ registry }}/yc/serverless/demo-serverless-container1     | 2025-10-04 09:38:14 |
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  ```

- API {#api}

  Use the [listRevisions](../../serverless-containers/containers/api-ref/Container/listRevisions.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [RegistryService/CreateRegistryRequest](../../serverless-containers/containers/api-ref/grpc/Container/listRevisions.md) gRPC API call.

{% endlist %}

## Delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../serverless-containers/operations/delete.md) the container.
1. [Delete](../../container-registry/operations/docker-image/docker-image-delete.md) the Docker image.
1. [Delete](../../container-registry/operations/registry/registry-delete.md) the registry.

## See also {#see-also}

* [Configuring CI/CD between {{ src-name }} and {{ sf-full-name }}](../../tutorials/serverless/ci-cd-sourcecraft-functions.md)
* [Configuring a service connection to {{ yandex-cloud }} in {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/service-connections)
* [Integration with GitHub Actions in {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/gh-actions)
* [serverless-functions repository in {{ src-name }}]({{ link-src-main }}/yandex-cloud-examples/serverless-functions)
* [yc-ci-cd-serverless repository in {{ src-name }}]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless)
* [Using a {{ GL }} pipeline in the {{ src-name }} CI/CD]({{ link-src-docs }}/sourcecraft/operations/gl-pipelines)