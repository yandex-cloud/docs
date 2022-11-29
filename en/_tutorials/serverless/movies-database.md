# Developing CRUD APIs for movie services

Using serverless technology, you can create [CRUD]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/CRUD){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Create,_read,_update_and_delete){% endif %} APIs for services that keep movie data.

The implementation of CRUD APIs employs the {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md), which is designed for a movie database deployed in {{ ydb-full-name }}.

The container is configured in the {{ api-gw-full-name }} [API gateway](../../api-gateway/concepts/)specifications supporting [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) to execute specific HTTP requests.

The container interacts with {{ ydb-name }} and processes external HTTP requests via the API gateway using the [Amazon DynamoDB](https://aws.amazon.com/ru/dynamodb/)-compatible [HTTP API](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html). The CRUD API source code language is TypeScript, the runtime environment is Node.js 16.

To deploy a project:
1. [Configure the environment](#setup-environment).
1. [Initiate {{ TF }}](#init-terraform).
1. [Create a {{ ydb-name }} database](#create-database).
1. [Run CRUD operations](#implement-operations).
1. [Develop the REST API](#develop-rest-api).
1. [Check the performance of the CRUD API](#test-api).

If you no longer need the created resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of CRUD API resources includes:
* A fee for {{ ydb-name }} operations and data storage (see [{{ ydb-name }} pricing for serverless mode](../../ydb/pricing/serverless.md)).
* A fee for the number of container calls, computing resources allocated to execute the application, and outgoing traffic (see [{{ serverless-containers-name }} pricing](../../serverless-containers/pricing.md)).
* A fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).

## Configure the environment {#setup-environment}

{% list tabs %}

- Windows

  1. [Install the WSL]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/windows/wsl/install){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/windows/wsl/install){% endif %} utility to run a Linux environment.
  1. Run the Linux subsystem (by default, Ubuntu).
  1. Configure the environment as described in the Linux manual.

- Linux

  {% note info %}

  If you use a distribution other than Ubuntu, install the specified utilities using your package manager commands.

  {% endnote %}

  1. Install the following utilities in the specified order using commands in the terminal:
     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * [WebStorm]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/webstorm/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/webstorm/){% endif %} or any other [development environment that supports TypeScript]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support){% endif %}:

       ```bash
       sudo snap install webstorm --classic
       ```

     * [Node.js]{% if lang == "ru" %}(https://nodejs.org/ru/){% endif %}{% if lang == "en" %}(https://nodejs.org/en/){% endif %} `16.9.1` or higher:

       ```bash
       curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash
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
       curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI]{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}:

       ```bash
       curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
       unzip awscliv2.zip
       sudo ./aws/install
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       sudo apt-get update
       sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y
       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
       sudo apt-get update
       sudo apt-get install docker-ce docker-ce-cli containerd.io -y
       sudo docker run hello-world
       ```

     {% if region != "ru" %}

     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
       curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
       sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
       sudo apt-get update && sudo apt-get install terraform -y
       terraform version
       ```

     {% endif %}

  {% if region == "ru" %}

  1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} `1.0.8` or higher.

  {% endif %}

  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a {{ yandex-cloud }} CLI profile with basic parameters.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.
  1. [Set up](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) Docker management on behalf of a user without privileges.

     ```bash
     sudo groupadd docker
     sudo usermod -aG docker $USER
     newgrp docker
     docker run hello-world
     ```

- MacOS

  1. Install the following utilities in the specified order using commands in the terminal:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * [WebStorm]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/webstorm/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/webstorm/){% endif %} or any other [development environment that supports TypeScript]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/TypeScript#IDE_и_поддержка_редакторов){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support){% endif %}:

       ```bash
       brew install --cask webstorm
       ```

     * [Node.js]{% if lang == "ru" %}(https://nodejs.org/ru/){% endif %}{% if lang == "en" %}(https://nodejs.org/en/){% endif %} `16.9.1` or higher:

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
       curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
       exec -l $SHELL
       yc version
       ```

     * [AWS CLI]{% if lang == "ru" %}(https://aws.amazon.com/ru/cli/){% endif %}{% if lang == "en" %}(https://aws.amazon.com/cli/){% endif %}:

       ```bash
       curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
       sudo installer -pkg AWSCLIV2.pkg -target /
       ```

     * [Docker](https://www.docker.com/):

       ```bash
       brew install --cask docker
       ```

     {% if region != "ru" %}

     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       brew tap hashicorp/tap
       brew install hashicorp/tap/terraform
       terraform version
       ```

     {% endif %}

  {% if region == "ru" %}

  1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#from-yc-mirror) {{ TF }} `1.0.8` or higher.

  {% endif %}

  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a profile with basic parameters.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.

{% endlist %}

## Initiate {{ TF }} {#init-terraform}

1. Clone a repository with source files for the CRUD API project:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website.git
   ```

   Open the folder project in WebStorm and review the source files.
1. Go to the `deploy` folder:

   ```bash
   cd <path_to_deploy_folder>
   ```

1. Find out the name of the `ACTIVE` profile of the {{ yandex-cloud }} CLI command line interface. In the terminal, run the command:

   ```bash
   yc config profile list
   ```

1. Get the active profile parameters:

   ```bash
   yc config profile get <profile_name>
   ```

1. Copy the parameters to [provider.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/provider.tf):
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md).
   * `cloud-id`: ID of the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
   * `folder-id`: ID of the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

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

   Run all the {{ TF }} commands in the `deploy` folder.

   {% endnote %}

## Create a {{ ydb-name }} database {#create-database}

The project uses a [{{ ydb-name }}]({{ link-cloud-services }}/ydb) database in serverless mode. The database consists of two tables: `movies` to keep movie data and `votes` to keep user rates. Each table entry contains the ID and the final set of attributes.
1. The {{ TF }} configuration for database creation is described in [ydb.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/ydb.tf). Create a database:

   ```bash
   terraform apply -target=yandex_ydb_database_serverless.movies_database
   ```

   Confirm resource creation: type `yes` in the terminal and press **Enter**.

   The command result contains the variables:
   * `movies_database_document_api_endpoint`: The Document API endpoint of a database.
   * `movies_database_path`: The relative path to the database.

   You can make sure the `movies-database` DB is created in the [management console]({{ link-console-main }}) or using the CLI command `yc ydb database list`.

1. Export the values `movies_database_document_api_endpoint` and `movies_database_path` from the previous command result to environment variables:

   ```bash
   export DOCUMENT_API_ENDPOINT=<movies_database_document_api_endpoint>
   echo $DOCUMENT_API_ENDPOINT

   export MOVIES_DATABASE_PATH=<movies_database_path>
   echo $MOVIES_DATABASE_PATH
   ```

1. Create the `movies` and `votes` tables in the `movies-database` DB:

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

1. Make sure the tables are created:

   ```bash
   aws dynamodb describe-table \
     --table-name movies \
     --endpoint ${DOCUMENT_API_ENDPOINT}

   aws dynamodb describe-table \
     --table-name votes \
     --endpoint ${DOCUMENT_API_ENDPOINT}
   ```

   Each table supports two indexes:
   * `Movies`: The index for quickly searching for a movie by ID, and index for sorting movies by popularity.
   * `Votes`: The index for searching for a user's votes by movie, and index for getting all movie rates.

## Run CRUD operations {#implement-operations}

A database layer is used every time data is retrieved, updated, or deleted. These actions are called CRUD operations.

Interaction with the database via the [Document API](../../ydb/docapi/api-ref/) is performed using the [AWS SDK for JavaScript v3](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/index.html) library:
* [model.ts](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/model.ts) defines the models of a `Movie` movie and `Vote` rates via the TypeScript interface.
* [repository.ws](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/repository.ts) implements CRUD operations for using these entities.

[IAM tokens](../../iam/concepts/authorization/iam-token.md) are used for authorization when data operations are executed. To get an IAM token before the operation, the [metadata service](../../serverless-containers/operations/sa.md) is called.

### Create a service account {#create-sa}

1. The {{ TF }} configuration to create a service account is described in [sa.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/sa.tf). Create a service account:

   ```bash
   terraform apply -target=yandex_iam_service_account.movies_api_sa
   ```

   Confirm resource creation: type `yes` in the terminal and press **Enter**.
1. In the command result, the `movies_api_sa_id` shows the ID of the created service account. Export it to the environment variable:

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
   * `role`: The role assigned.
   * `-subject serviceAccount`: Service account ID.

   The service account is assigned roles for the following actions:
   * Calling the container in [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers).
   * Executing operations in [{{ ydb-name }}]({{ link-cloud-services }}/ydb).

   The roles are assigned to the whole folder rather than an individual resource.

### Compile the application source code in TypeScript {#compile-app}

1. Go to the repository root folder and install all the necessary dependencies:

   ```bash
   cd <path_to_folder_sls-web-application>
   npm ci
   ```

   After the command is executed, the `node_modules` with all the necessary dependencies appears in the folder.
1. Run the project build:

   ```bash
   npm run build
   ```

   After the command is executed, the `dist` folder with the compiled JS files appears in the folder.

## Develop the REST API {#develop-rest-api}

The file [openapi/api.yaml](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) already has the OpenAPI specifications, which describe the chief operations with movies and rates.

To implement the service according to the specifications, the [OpenAPI Backend](https://github.com/anttiviljami/openapi-backend) library is used in combination with the [Express](https://expressjs.com) framework. The file [app.ts](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/src/app.ts) describes required classes, operation mapping, and the starting of an HTTP service.

### Deploy the application in {{ serverless-containers-name }} {#deploy-container}

Build the application as a Docker image and run it in [{{ serverless-containers-name }}]({{ link-cloud-services }}/serverless-containers):
1. In the [OpenAPI specifications](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) `api.yaml`, in the `x-yc-apigateway.service_account_id` field, type the ID of the created service account.
1. The file [container-registry.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/container-registry.tf) describes a configuration of the registry and repository to which an application Docker image is uploaded. Go to the `deploy` folder and create resources in [Container Registry]({{ link-cloud-services }}/container-registry):

   ```bash
   cd <path_to_folder_deploy>
   terraform apply -target=yandex_container_registry.default
   terraform apply -target=yandex_container_repository.movies_api_repository
   ```

   Confirm resource creation: type `yes` in the terminal and press **Enter**.
1. In the command result, the `movies_api_repository_name` variable shows the name of the repository to which a Docker image will be uploaded. Export it to the environment variable:

   ```bash
   export MOVIES_API_REPOSITORY_NAME=<repository_name>
   echo $MOVIES_API_REPOSITORY_NAME
   ```

1. Set up Docker for the created repository:

   ```bash
   yc container registry configure-docker
   ```

1. The file [Dockerfile](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/Dockerfile) describes a configuration to build a Docker image. Build the image and upload it to the repository created in the previous step:

   ```bash
   docker build -t ${MOVIES_API_REPOSITORY_NAME}:0.0.1.
   docker push ${MOVIES_API_REPOSITORY_NAME}:0.0.1
   ```

1. Create a {{ serverless-containers-name }} container:

   ```bash
   yc sls container create \
     --name movies-api-container \
     --folder-id ${FOLDER_ID}
   ```

   Where:
   * `name` is the container name.
   * `folder-id`: ID of the folder.

1. The command result shows the ID of the container. Export it to the environment variable:

   ```bash
   export MOVIES_API_CONTAINER_ID=<container_ID>
   echo $MOVIES_API_CONTAINER_ID
   ```

1. Create a container [revision](../../serverless-containers/concepts/container.md) from a Docker image version `0.0.1`:

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
   * `folder-id`: ID of the folder.
   * `container-id`: Container ID.
   * `memory`: Amount of memory available for the container.
   * `cores`: Number of vCPU cores available for the container.
   * `execution-timeout`: Execution timeout.
   * `concurrency`: Maximum number of concurrent container calls. If the number of requests to a container exceeds the value of the `concurrency` parameter, the service scales the container up by launching additional copies.
   * `environment`: Environment variables. The Document API endpoint of a database is passed to the application via the `DOCUMENT_API_ENDPOINT` environment variable.
   * `service-account-id`: The ID of your service account.
   * `image`: Repository name.

### Deploy the API in {{api-gw-name}} {#deploy-api-gw}

1. In the [OpenAPI specifications](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/openapi/api.yaml) `api.yaml`, replace the `${MOVIES_API_CONTAINER_ID}` variable with the ID of the created container.
1. The file [api-gateway.tf](https://github.com/yandex-cloud-examples/yc-serverless-web-application-movie-website/blob/main/deploy/api-gateway.tf) describes a {{ TF }} configuration for creating the [API gateway](../../api-gateway/concepts/index.md). Deploy the API gateway:

   ```bash
   terraform apply -target=yandex_api_gateway.movies_api_gateway
   ```

   Confirm resource creation: type `yes` in the terminal and press **Enter**.
1. In the command result, the `movies_api_gateway_domain` variable shows the domain name of the API gateway. Export it to the environment variable:

   ```bash
   export MOVIES_API_GATEWAY_DOMAIN=<API_gateway_domain_name>
   echo $MOVIES_API_GATEWAY_DOMAIN
   ```

## Check the performance of the created CRUD API {#test-api}

To check the performance of the created CRUD API, run the following HTTP requests using the `curl` command:
1. Retrieve a movie list:

   ```bash
   curl "${MOVIES_API_GATEWAY_DOMAIN}/movies?limit=10"
   ```

   The response must return an empty list `[]`, because at the moment, there's no data in the database.
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

1. Add details of another movie:

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

You can also upload the specifications to [Postman](https://www.postman.com) or [SwaggerHub](https://swagger.io/tools/swaggerhub/) by adding the address of the created API gateway from the `${MOVIES_API_GATEWAY_DOMAIN}` variable to the `servers` section. Now it'll be easier to run requests to the REST API.

View diagnostic information about the container. In the [management console]({{ link-console-main }}), go to the container page. The **Logs** tab shows messages about container calls and the **Monitoring** tab charts of container calls, average request processing times, and number of errors.

You can also view monitoring logs and charts on the API gateway page.

## How to delete created resources {#clear-out}

To stop paying for resources created using {{ TF }}, delete them. In the terminal, run the command:

```bash
terraform destroy
```

Confirm resource deletion: type `yes` in the terminal and press **Enter**.

#### See also {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Terraform reference. {{ yandex-cloud }} provider]({{ tf-provider-link }}).
* [Document table](../../ydb/operations/schema.md).
* [X-yc-apigateway-integration extension](../../api-gateway/concepts/extensions/containers.md).
* [{#T}](../../serverless-containers/concepts/logs.md).
* [{#T}](../../serverless-containers/operations/monitoring.md).