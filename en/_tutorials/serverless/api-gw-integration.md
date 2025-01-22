# Developing a custom integration in {{ api-gw-name }}


Using serverless technology, you can create your own integration with {{ yandex-cloud }} services.

User integration is a {{ sf-full-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-full-name }} [container](../../serverless-containers/concepts/container.md) designed to perform common tasks.

The function or container can be configured in the {{ api-gw-name }} [API gateway specifications](../../api-gateway/concepts/) supporting [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) to execute specific HTTP requests.

Develop {{ ydb-full-name }} integration function for the [{{ ydb-short-name }} DBMS](../../ydb/concepts/#ydb). The function interacts with {{ ydb-name }} and processes external HTTP requests via the API gateway using the [Amazon DynamoDB](https://aws.amazon.com/dynamodb/)-compatible [HTTP API](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/Welcome.html). The function source code language is TypeScript, the runtime environment is Node.js 16.

The integration will be applied to implement the [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) API for a movie database deployed in {{ ydb-name }}.

To deploy a project:
1. [Configure the environment](#setup-environment).
1. [Download a project with integration](#download-project).
1. [Compile a function](#compile-function).
1. [Upload the file of the function to the bucket](#upload-to-bucket).
1. [Prepare a resource configuration for the integration](#prepare-configuration).
1. [Deploy resources for the integration](#deploy-resources).
1. [Test the new CRUD API](#test-api).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources for the integration includes:
* Fee for the occupied data storage volume, number of operations with data, and outgoing traffic (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-name }} pricing for serverless mode](../../ydb/pricing/serverless.md)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).

## Configure the environment {#setup-environment}

{% list tabs group=operating_system %}

- Windows {#windows}

  1. [Install the WSL utility](https://docs.microsoft.com/en-us/windows/wsl/install) to run a Linux environment.
  1. Run the Linux subsystem (by default, Ubuntu).
  1. Configure the environment as described in the Linux manual.

- Linux {#linux}

  {% note info %}

  If you use a distribution other than Ubuntu, install the specified utilities using your package manager commands.

  {% endnote %}

  1. Install the following utilities in the specified order using commands in the terminal:
     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       sudo apt-get install curl git -y
       ```

     * [WebStorm](https://www.jetbrains.com/webstorm/) or any other [development environment that supports TypeScript](https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support):

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

     
     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
       curl --fail --silent --show-error --location https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
       sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
       sudo apt-get update && sudo apt-get install terraform -y
       terraform version
       ```



  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a {{ yandex-cloud }} CLI profile with basic parameters.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.

- macOS {#macos}

  1. Install the following utilities in the specified order using commands in the terminal:
     * [Homebrew](https://brew.sh):

       ```bash
       /bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```

     * [Curl](https://curl.se/) and [Git](https://git-scm.com/):

       ```bash
       brew install curl git
       ```

     * [WebStorm](https://www.jetbrains.com/webstorm/) or any other [development environment that supports TypeScript](https://en.wikipedia.org/wiki/TypeScript#IDE_and_editor_support):

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

     
     * [{{ TF }}](https://www.terraform.io/) `1.0.8` or higher:

       ```bash
       brew tap hashicorp/tap
       brew install hashicorp/tap/terraform
       terraform version
       ```



  1. [Create](../../cli/operations/profile/profile-create.md#interactive-create) a profile with basic parameters.
  1. [Set up](../../ydb/docapi/tools/aws-setup.md) the AWS CLI.

{% endlist %}

## Download a project with integration {#download-project}

Clone the integration project repository:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector.git
```

The `src` folder contains source files for creating the function:
* [event.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/event.ts): The `Event` code describing the [request structure](../../api-gateway/concepts/extensions/cloud-functions.md#request_v1) and `RequestContext` code describing the request context.
* [dynamodb.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/dynamodb.ts): The code to process calls of a function and main commands.
* [iam.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/iam.ts): The code to retrieve [IAM tokens](../../iam/concepts/authorization/iam-token.md) for authorization when executing requests to the {{ ydb-short-name }}.

When a function is called, the operation context is provided in the [dynamodb.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/dynamodb.ts) file in the `requestContext.apiGateway.operationContext` field of the `event` object.

The operation context is defined in the [`context`](../../api-gateway/concepts/extensions/cloud-functions.md#parameters) parameter in the specification of the [API gateway](../../api-gateway/concepts/) invoking the integration function.

{% note info %}

When integrating using a [container](../../serverless-containers/concepts/container.md), the operation context is provided via the special header [`X-Yc-ApiGateway-Operation-Context`](../../api-gateway/concepts/extensions/containers.md#parameters).

{% endnote %}

The file [event.ts](https://github.com/yandex-cloud-examples/yc-serverless-apigw-dynamodb-connector/blob/main/src/event.ts) defines interfaces for main Amazon DynamoDB commands and command parameters that are implemented in this integration. This is necessary for specifying the operation context format and working with the format within a function.

## Compile a function {#compile-function}

1. Open the terminal and go to the project root folder:

   ```bash
   cd <path_to_project_root_directory>
   ```

1. Set the dependencies required for the project:

   ```bash
   npm ci
   ```

1. Compile and build the function code:

   ```bash
   npm run build
   ```

1. Add the built function code to a ZIP archive:
  
   ```bash
   npm run package
   ```

## Upload the file of the function to the bucket {#upload-to-bucket}

1. [Create a bucket](../../storage/operations/buckets/create.md) with public access. Save the bucket name. You will need it later.
1. [Upload](../../storage/operations/objects/upload.md) the `apigw-dynamodb-connector-0.0.1.zip` ZIP archive with the function code from the `build` folder to the bucket.

## Prepare a resource configuration for the integration {#prepare-configuration}

To deploy the CRUD API using the integration function, you will need the [{{ TF }}](https://www.terraform.io) tool.

A special [{{ TF }} module](https://github.com/yandex-cloud-examples/yc-serverless-ydb-api) developed for this integration example makes it easier to configure {{ yandex-cloud }} resources. Created {{ TF }} resources:
* Serverless {{ ydb-short-name }} database.
* Integration function.
* Service account for the function to access the database.
* API gateway.

To prepare configuration files for {{ TF }}:
1. Find out the name of the `ACTIVE` profile of the {{ yandex-cloud }} CLI command line interface. In the terminal, run this command:

   ```bash
   yc config profile list
   ```

1. Get the active profile parameters:

   ```bash
   yc config profile get <profile_name>
   ```

   Save the parameters:
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md).
   * `cloud-id`: [Cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) ID.
   * `folder-id`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
1. Create a `crud-api` directory and navigate to it:

   ```bash
   mkdir crud-api
   cd crud-api
   ```

   Run all subsequent {{ TF }} commands in the `crud-api` folder.
1. Create a file named `main.tf` and copy into it the {{ TF }} module configuration. Set the parameters of the resources to be created:
   * `cloud_id`: Cloud ID.
   * `folder_id`: Folder ID.
   * `oauth_token`: OAuth token.
   * `database_connector_bucket`: Name of the bucket with the integration function.

   ```hcl
   locals {
     cloud_id    = "<cloud_ID>"
     folder_id   = "<folder_ID>"
     oauth_token = "<OAuth_token>"
     zone        = "{{ region-id }}-d"
   }

   module "crud-api" {
     source = "https://github.com/yandex-cloud-examples/yc-serverless-ydb-api"

     folder_id                 = local.folder_id
     api_name                  = "movies-api"
     database_name             = "movies-db"
     service_account_name      = "movies-api-service-account"
     region                    = "region-id"
     openapi_spec              = "api.yaml"
     table_specs               = ["file://table.json"]
     database_connector_bucket = "<name_of_bucket_with_the_integration_function>"
     database_connector_object = "apigw-dynamodb-connector-0.0.1.zip"
   }

   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
       null   = {
         source = "registry.terraform.io/hashicorp/null"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     token     = local.oauth_token
     cloud_id  = local.cloud_id
     folder_id = local.folder_id
     zone      = local.zone
   }

   output "crud_api_domain" {
     value = module.crud-api.api_gateway_domain
   }
   ```

1. Create a file named `table.json` and copy into it the specification of the table schema created by {{ ydb-short-name }}:

   ```json
   {
     "TableName": "movie",
     "KeySchema": [
       {
         "AttributeName": "id",
         "KeyType": "HASH"
       }
     ],
     "AttributeDefinitions": [
       {
         "AttributeName": "id",
         "AttributeType": "S"
       },
       {
         "AttributeName": "title",
         "AttributeType": "S"
       },
       {
         "AttributeName": "year",
         "AttributeType": "N"
       }
     ]
   }
   ```

1. Create a file named `api.yaml` and copy into it the OpenAPI specification of the new API gateway:

   ```yaml
   openapi: "3.0.0"
   info:
     version: 1.0.0
     title: Movies API
   x-yc-apigateway:
     service_account_id: ${SERVICE_ACCOUNT_ID}

   paths:
     /movies:
       post:
         description: Create movie
         operationId: createMovie
         requestBody:
           description: Movie to create
           required: true
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Movie'
         responses:
           '200':
             description: Created or updated movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: PutItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
       get:
         description: Get movies
         operationId: getMovies
         parameters:
           - name: from
             in: query
             description: Identifier from which will be queried movies in ascending order
             required: true
             schema:
               type: string
           - name: limit
             in: query
             description: Maximum number of movies in response
             required: false
             schema:
               type: number
               default: 10
         responses:
           '200':
            description: Movies
             content:
               application/json:
                 schema:
                   type: array
                   items:
                     $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: Scan
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             limit: '{limit}'
             exclusiveStartKey: '{"id": "{from}"}'
     /movies/{movieId}:
       parameters:
         - name: movieId
           in: path
           description: Identifier of movie
           required: true
           schema:
             type: string
       get:
         description: Get movie by id
         operationId: getMovieById
         responses:
           '200':
             description: Movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: GetItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
       put:
         description: Update movie by id
         operationId: updateMovieById
         requestBody:
           description: Movie or attributes to update
           required: true
           content:
             application/json:
               schema:
                 $ref: '#/components/schemas/Movie'
         responses:
           '200':
             description: Updated movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: UpdateItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
       delete:
         description: Delete movie by id
         operationId: deleteMovieById
         responses:
           '200':
             description: Deleted movie
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Movie'
           default:
             description: error
             content:
               application/json:
                 schema:
                   $ref: '#/components/schemas/Error'
         x-yc-apigateway-integration:
           type: cloud_functions
           function_id: ${FUNCTION_ID}
           context:
             command: DeleteItem
             endpoint: ${DATABASE_ENDPOINT}
             tableName: movie
             key: '{"id": "{movieId}"}'
   components:
     schemas:
       Movie:
         type: object
         required:
           - id
           - title
           - year
         properties:
           id:
             type: string
           title:
             type: string
           year:
             type: integer

       Error:
         type: object
         required:
           - message
         properties:
           message:
             type: string
   ```

## Deploy resources for the {#deploy-resources} integration.

1. Initiate {{ TF }}. In the terminal, run this command:

   ```bash
   terraform init
   ```

1. Deploy cloud resources:

   ```bash
   terraform apply
   ```

1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

   In the command output, the `crud_api_domain` variable will show the domain address of the new CRUD API. Save the address. You will need it later.

   You can use the [management console]({{ link-console-main }}) to check the created resources.

## Test the new CRUD API {#test-api}

To test the new CRUD API, send the following HTTP requests:
1. Add movie details. In the terminal, run this command:

   ```bash
   curl \
     --location \
     --request POST 'https://<domain_address_of_CRUD_API>/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "301",
       "title": "The Matrix",
       "year": 1999
     }'
   ```

1. Retrieve movie details:

   ```bash
   curl \
     --location \
     --request GET 'https://<domain_address_of_CRUD_API>/movies/301'
   ```

1. Change movie details:

   ```bash
   curl \
     --location \
     --request PUT 'https://<domain_address_of_CRUD_API>/movies/301' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "title": "The Matrix"
     }'
   ```

1. Add details of another movie:

   ```bash
   curl \
     --location \
     --request POST 'https://<domain_address_of_CRUD_API>/movies' \
     --header 'Content-Type: application/json' \
     --data-raw '{
       "id": "299",
       "title": "The Matrix Reloaded",
       "year": 2003
     }'
   ```

1. Retrieve a movie list:

   ```bash
   curl \
     --location \
     --request GET 'https://<domain_address_of_CRUD_API>/movies?from=1&limit=5'
   ```

1. Delete details of a movie:

   ```bash
   curl \
     --location \
     --request DELETE 'https://<domain_address_of_CRUD_API>/movies/301' \
     --data-raw ''
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* Delete the resources created with {{ TF }}. In the terminal, run this command:

  ```bash
  terraform destroy
  ```

  Confirm the resource deletion: type `yes` in the terminal and press **Enter**.
* [Delete](../../storage/operations/buckets/delete.md) the bucket with the function file.