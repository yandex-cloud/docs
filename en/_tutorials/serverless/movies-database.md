# Developing CRUD APIs for movie services


With serverless technology, you can create a [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) API for a movie data service.

The CRUD API runs inside a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-full-name }} for accessing the movie database deployed in {{ ydb-full-name }}.

The container is configured in the [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification)-based [{{ api-gw-full-name }}](../../api-gateway/concepts/index.md) specification to handle specific HTTP requests.

The container will communicate with {{ ydb-name }} and handle external HTTP requests via an API gateway using the [Amazon DynamoDB](https://aws.amazon.com/ru/dynamodb/)-compatible [HTTP API](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html). The CRUD API is written in TypeScript and runs on Node.js 16.

To deploy a project:
1. [Set up your environment](#setup-environment).
1. [Initialize {{ TF }}](#init-terraform).
1. [Create a {{ ydb-name }} database](#create-database).
1. [Implement CRUD operations](#implement-operations).
1. [Develop a REST API](#develop-rest-api).
1. [Test the new CRUD API](#test-api).

If you no longer need the resources you created, [delete](#clear-out) them.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of CRUD API resources includes:
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-name }} pricing for serverless mode](../../ydb/pricing/serverless.md)).
* Fee for container invocation count, computing resources allocated to run the application, and outbound traffic (see [{{ serverless-containers-name }} pricing](../../serverless-containers/pricing.md)).
* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).

## Set up your environment {#setup-environment}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install) to run a Linux environment.
  1. Run the Linux subsystem (by default, Ubuntu).
  1. Configure the environment as described in this tutorial for Linux.

- Linux {#linux}

  {% note info %}

  If you are using a distribution other than Ubuntu, install the specified tools using your package manager.

  {% endnote %}

  1. Install the following tools in the specified order by running the relevant commands in your terminal:
     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * [WebStorm](https://www.jetbrains.com/webstorm/) or any other [TypeScript-enabled IDE](https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support):

       ```bash
       sudo snap install webstorm --classic
       ```

     * [Node.js](https://nodejs.org/en/) `16.9.1` or higher:

       ```bash
       curl --silent --location https://deb.nodesource.com/setup_16.x | sudo -E bash
       sudo apt-get install nodejs
       node -v
       npm -v
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       sudo npm install -g typescript
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" --output "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       sudo apt-get update
       sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
       curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       sudo apt-get update
       sudo apt-get install docker-ce docker-ce-cli containerd.io -y
       sudo docker run hello-world
       ```

     
     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
       curl --fail --silent --show-error --location https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
       sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
       sudo apt-get update && sudo apt-get install terraform -y
       terraform version
       ```



  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a {{ yandex-cloud }} CLI profile with basic settings.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.
  1. [Set up](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) Docker so that a non-root user can manage it:

     ```bash
     sudo groupadd docker
     sudo usermod -aG docker $USER
     newgrp docker
     docker run hello-world
     ```

- macOS {#macos}

  1. Install the following tools in the specified order by running the relevant commands in your terminal:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * [WebStorm](https://www.jetbrains.com/webstorm/) or any other [TypeScript-enabled IDE](https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support):

       ```bash
       brew install --cask webstorm
       ```

     * [Node.js](https://nodejs.org/en/) `16.9.1` or higher:

       ```bash
       brew install node
       node -v
       npm -v
       ```

     * [TypeScript](https://www.typescriptlang.org/):

       ```bash
       npm install -g typescript
       ```

     * [{{ yandex-cloud }} CLI](../../cli/quickstart.md):

       ```bash
       curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI](https://aws.amazon.com/cli/):

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       brew install --cask docker
       ```

     
     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       brew tap hashicorp/tap
       brew install hashicorp/tap/terraform
       terraform version
       ```



  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a profile with basic settings.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.

{% endlist %}

## Initiate {{ TF }} {#init-terraform}

1. Clone a repository with source files for the CRUD API project:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website.git
   ```

   Open the project directory in WebStorm and review the source files.
1. Go to the `deploy` directory:

   ```bash
   cd <path_to_deploy_directory>
   ```

1. Find out the name of the `ACTIVE` profile of the {{ yandex-cloud }} CLI. In the terminal, run this command:

   ```bash
   yc config profile list
   ```

1. Get the active profile properties:

   ```bash
   yc config profile get <profile_name>
   ```

1. Copy these properties to [provider.tf](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/deploy/provider.tf):
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md).
   * `cloud-id`: [Cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) ID.
   * `folder-id`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
1. Export the folder ID to the environment variable:

   ```bash
   export FOLDER_ID=<folder_ID>
   echo $FOLDER_ID
   ```

1. Run the {{ TF }} initialization command:

   ```bash
   terraform init
   ```

   {% note info %}

   Run all {{ TF }} commands in the `deploy` directory.

   {% endnote %}

## Create a {{ ydb-name }} database {#create-database}

Our project uses a [{{ ydb-short-name }}]({{ link-cloud-services }}/ydb) database in serverless mode. This database consists of two tables: `movies` to keep movie data and `votes` to keep user ratings. Each table entry contains the ID and fixed attributes.
1. The {{ TF }} configuration for database creation is described in [ydb.tf](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/deploy/ydb.tf). Create a database:

   ```bash
   terraform apply -target=yandex_ydb_database_serverless.movies_database
   ```

   Confirm creating the resources by typing `yes` in the terminal and pressing **Enter**.

   You will see these variables in the command output:
   * `movies_database_document_api_endpoint`: Document API endpoint of the database.
   * `movies_database_path`: Relative path to the database.

   Use the [management console]({{ link-console-main }}) or the `yc ydb database list` CLI command to check that the `movies-database` DB has been successfully created.
1. Export the `movies_database_document_api_endpoint` and `movies_database_path` values from the previous command output to environment variables:

   ```bash
   export DOCUMENT_API_ENDPOINT=<DB_Document_API_endpoint>
   echo $DOCUMENT_API_ENDPOINT

   export MOVIES_DATABASE_PATH=<relative_path_to_database>
   echo $MOVIES_DATABASE_PATH
   ```

1. Create tables named `movies` and `votes` in `movies-database`:

   ```bash
   aws dynamodb create-table \
     --table-name movies \
     --attribute-definitions \
       AttributeName=id,AttributeType=N \
       AttributeName=title,AttributeType=S \
       AttributeName=type,AttributeType=S \
       AttributeName=original_title,AttributeType=S \
       AttributeName=original_language,AttributeType=S \
       AttributeName=release_date,AttributeType=S \
       AttributeName=poster_path,AttributeType=S \
       AttributeName=popularity,AttributeType=N \
       AttributeName=video,AttributeType=S \
       AttributeName=vote_count,AttributeType=N \
       AttributeName=vote_average,AttributeType=N \
       AttributeName=genres,AttributeType=S \
       AttributeName=backdrop_path,AttributeType=S \
       AttributeName=adult,AttributeType=S \
       AttributeName=overview,AttributeType=S \
     --key-schema \
       AttributeName=id,KeyType=HASH \
     --global-secondary-indexes \
       "[
         {
           \"IndexName\": \"PopularityIndex\",
           \"KeySchema\": [{\"AttributeName\":\"type\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"popularity\",\"KeyType\":\"RANGE\"}],
           \"Projection\":{
             \"ProjectionType\":\"ALL\"
           }
         }
       ]" \
     --endpoint ${DOCUMENT_API_ENDPOINT}

   aws dynamodb create-table \
     --table-name votes \
     --attribute-definitions \
       AttributeName=id,AttributeType=S \
       AttributeName=user_id,AttributeType=S \
       AttributeName=movie_id,AttributeType=N \
       AttributeName=value,AttributeType=N \
     --key-schema \
       AttributeName=id,KeyType=HASH \
     --global-secondary-indexes \
       "[
         {
           \"IndexName\": \"MovieIndex\",
           \"KeySchema\": [{\"AttributeName\":\"movie_id\",\"KeyType\":\"HASH\"}],
           \"Projection\":{
             \"ProjectionType\":\"ALL\"
           }
         }
       ]" \
     --endpoint ${DOCUMENT_API_ENDPOINT}
   ```

1. Make sure the tables were successfully created:

   ```bash
   aws dynamodb describe-table \
     --table-name movies \
     --endpoint ${DOCUMENT_API_ENDPOINT}

   aws dynamodb describe-table \
     --table-name votes \
     --endpoint ${DOCUMENT_API_ENDPOINT}
   ```

   Each table supports two indexes:
   * The `movies` table supports an index to quickly find a movie by its ID and an index to sort movies by popularity.
   * The `votes` table supports an index to locate a user's rating for a movie and an index to get all ratings for a movie.

## Implement CRUD operations {#implement-operations}

Every time you create, read, update, or delete data, the database layer is involved. These actions are collectively called CRUD operations.

In the [Document API](../../ydb/docapi/api-ref/), you access the database using the [AWS SDK for JavaScript v3](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/index.html):
* [model.ts](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/src/model.ts) defines the `Movie` and `Vote` models via the TypeScript interface.
* [repository.ws](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/src/repository.ts) implements CRUD operations for using these entities.

All data-related operations use [IAM tokens](../../iam/concepts/authorization/iam-token.md) for authorization. Any operation begins by calling the [metadata service](../../serverless-containers/operations/sa.md) to get an IAM token.

### Create a service account {#create-sa}

1. The {{ TF }} configuration for creating a service account is described in [sa.tf](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/deploy/sa.tf). Create a service account:

   ```bash
   terraform apply -target=yandex_iam_service_account.movies_api_sa
   ```

   Confirm creating the resources by typing `yes` in the terminal and pressing **Enter**.
1. In the command output, the `movies_api_sa_id` variable contains the ID of the new service account. Export it to the environment variable:

   ```bash
   export MOVIES_API_SA_ID=<service_account_ID>
   echo $MOVIES_API_SA_ID
   ```

1. Assign roles to the service account:

   ```bash
   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role ydb.admin \
     --subject serviceAccount:${MOVIES_API_SA_ID}

   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role container-registry.images.puller \
     --subject serviceAccount:${MOVIES_API_SA_ID}

   yc resource-manager folder add-access-binding ${FOLDER_ID} \
     --role serverless.containers.invoker \
     --subject serviceAccount:${MOVIES_API_SA_ID}
   ```

   Where:

   * `--role`: Role you want to assign.
   * `--subject serviceAccount`: Service account ID.

   The service account gets the roles for the following purposes:
   * Invoking a container in [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers).
   * Running operations in [{{ ydb-short-name }}]({{ link-cloud-services }}/ydb).

   Make sure to assign the roles for the entire folder rather than an individual resource.

### Compile the application's TypeScript source code {#compile-app}

1. Go to the repository root directory and install required dependencies with this command:

   ```bash
   cd <path_to_sls-web-application_directory>
   npm ci
   ```

   After running it, your project will include the `node_modules` directory with all required dependencies.
1. Run your project build:

   ```bash
   npm run build
   ```

   After running it, your project will include the `dist` directory with the compiled JS files.

## Develop a REST API {#develop-rest-api}

The [openapi/api.yaml](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/openapi/api.yaml) file already contains an OpenAPI specification that describes the main operations with movies and ratings.

To implement the service according to the specification, you will use [OpenAPI Backend](https://github.com/anttiviljami/openapi-backend) in combination with [Express](https://expressjs.com). The [app.ts](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/src/app.ts) file describes the required classes, operation mappings, and HTTP service initialization.

### Deploy your application in {{ serverless-containers-name }} {#deploy-container}

Build your application as a Docker image and run it in [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers):
1. In the [OpenAPI specifications](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/openapi/api.yaml) (`api.yaml`), enter the ID of the previously created service account in the `x-yc-apigateway.service_account_id` field.
1. The [container-registry.tf](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/deploy/container-registry.tf) file defines the configuration of the registry and repository that will store the application Docker image. Go to the `deploy` directory and create resources in [{{ container-registry-full-name }}]({{ link-cloud-services }}/container-registry):

   ```bash
   cd <path_to_deploy_directory>
   terraform apply -target=yandex_container_registry.default
   terraform apply -target=yandex_container_repository.movies_api_repository
   ```

   Confirm creating the resources by typing `yes` in the terminal and pressing **Enter**.
1. In the command output, the `movies_api_repository_name` variable contains the name of the repository to upload the Docker image to. Export it to the environment variable:

   ```bash
   export MOVIES_API_REPOSITORY_NAME=<repository_name>
   echo $MOVIES_API_REPOSITORY_NAME
   ```

1. Configure Docker to push images to the created repository:

   ```bash
   yc container registry configure-docker
   ```

1. The [Dockerfile](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/Dockerfile) describes the configuration for building the Docker image. Build the image and push it to the repository:

   ```bash
   docker build -t ${MOVIES_API_REPOSITORY_NAME}:0.0.1 .
   docker push ${MOVIES_API_REPOSITORY_NAME}:0.0.1
   ```

1. Create a container in {{ serverless-containers-name }}:

   ```bash
   yc sls container create \
     --name movies-api-container \
     --folder-id ${FOLDER_ID}
   ```

   Where:

   * `--name`: Container name.
   * `--folder-id`: Folder ID.
1. The command output gives the new container ID. Export it to the environment variable:

   ```bash
   export MOVIES_API_CONTAINER_ID=<container_ID>
   echo $MOVIES_API_CONTAINER_ID
   ```

1. Create a container [revision](../../serverless-containers/concepts/container.md) from Docker image `0.0.1`:

   ```bash
   yc sls container revisions deploy \
     --folder-id ${FOLDER_ID} \
     --container-id ${MOVIES_API_CONTAINER_ID} \
     --memory 512M \
     --cores 1 \
     --execution-timeout 5s \
     --concurrency 4 \
     --environment AWS_ACCESS_KEY_ID=FAKE_AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY=FAKE_AWS_SECRET_ACCESS_KEY,DOCUMENT_API_ENDPOINT=${DOCUMENT_API_ENDPOINT} \
     --service-account-id ${MOVIES_API_SA_ID} \
     --image ${MOVIES_API_REPOSITORY_NAME}:0.0.1
   ```

   Where:

   * `--folder-id`: Folder ID.
   * `--container-id`: Container ID.
   * `--memory`: Memory available for the container.
   * `--cores`: Number of vCPUs available to the container.
   * `--execution-timeout`: Execution timeout.
   * `--concurrency`: Maximum number of concurrent container invocations. If the number of container invocations exceeds the `--concurrency` value, {{ serverless-containers-name }} scales the container up by running its additional instances.
   * `--environment`: Environment variables. The application reads the Document API endpoint from the `DOCUMENT_API_ENDPOINT` environment variable.
   * `--service-account-id`: Service account ID.
   * `--image`: Repository name.

### Deploy your API in {{ api-gw-name }} {#deploy-api-gw}

1. In the [OpenAPI specifications](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/openapi/api.yaml) (`api.yaml`), replace `${MOVIES_API_CONTAINER_ID}` with the ID of the container you created.
1. The [api-gateway.tf](https://github.com/yandex-cloud-examples/yc-practicum-serverless-web-application-movie-website/blob/main/deploy/api-gateway.tf) file describes the {{ TF }} configuration for creating an [API gateway](../../api-gateway/concepts/index.md). Deploy an API gateway:

   ```bash
   terraform apply -target=yandex_api_gateway.movies_api_gateway
   ```

   Confirm creating the resources by typing `yes` in the terminal and pressing **Enter**.
1. In the command output, the `movies_api_gateway_domain` variable contains the domain name of the API gateway. Export it to the environment variable:

   ```bash
   export MOVIES_API_GATEWAY_DOMAIN=<API_gateway_domain_name>
   echo $MOVIES_API_GATEWAY_DOMAIN
   ```

## Test the new CRUD API {#test-api}

To test the new CRUD API, run the following HTTP requests using the `curl` command:
1. Retrieve a movie list:

   ```bash
   curl "${MOVIES_API_GATEWAY_DOMAIN}/movies?limit=10"
   ```

   The response must return an empty list (`[]`) since there are no entries in the database yet.
1. Add movie details:

   ```bash
   curl \
     --location \
     --request POST 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "301",
       "title": "The Matrix",
       "release_date": 1999
     }'
   ```

1. Retrieve movie details:

   ```bash
   curl \
     --location \
     --request GET 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies/301'
   ```

1. Add details for another movie:

   ```bash
   curl \
     --location \
     --request POST 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "299",
       "title": "The Matrix Reloaded",
       "release_date": 2003
     }'
   ```

1. Retrieve a movie list:

   ```bash
   curl \
     --location \
     --request GET 'https://${MOVIES_API_GATEWAY_DOMAIN}/movies?from=1&limit=5'
   ```

You can also upload the specification to [Postman](https://www.postman.com) or [SwaggerHub](https://swagger.io/tools/swaggerhub/) by adding the address of the created API gateway from the `${MOVIES_API_GATEWAY_DOMAIN}` variable to the `servers` section. This will enable you to easily make REST API calls.

View diagnostic information about the container. In the [management console]({{ link-console-main }}), go to the container page. The **{{ ui-key.yacloud.common.logs }}** tab shows messages about container invocations and the **{{ ui-key.yacloud.common.monitoring }}** tab, charts of container invocations, average request processing times, and number of errors.

You can also view monitoring logs and charts on the API gateway page.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created with {{ TF }}, delete them. In the terminal, run this command:

```bash
terraform destroy
```

Confirm the resource deletion by typing `yes` in the terminal and pressing **Enter**.

#### See also {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [{{ TF }} reference. {{ yandex-cloud }} provider]({{ tf-provider-link }}).
* [Document table](../../ydb/operations/schema.md).
* [x-yc-apigateway-integration](../../api-gateway/concepts/extensions/containers.md).
* [{#T}](../../serverless-containers/concepts/logs.md).
* [{#T}](../../serverless-containers/operations/monitoring.md).