# Developing functions in Functions Framework and deploying them in {{ serverless-containers-full-name }}


The Google Cloud [Functions Framework](https://cloud.google.com/functions/docs/functions-framework) is an open contract implemented as [open-source](https://en.wikipedia.org/wiki/Open-source_software) libraries for multiple programming languages. The framework allows you to develop [functions](../../functions/concepts/function.md) under the [FaaS](https://en.wikipedia.org/wiki/Function_as_a_service) (Funciton as a service) model, capable of processing HTTP requests or [CloudEvents](https://cloudevents.io/).

With the Functions Framework, you can write and run functions in {{ serverless-containers-full-name }} [containers](../../serverless-containers/concepts/container.md) without using [{{ sf-full-name }}](../../functions/index.yaml). Functions written this way can be migrated across different platforms, such as [Cloud Run](https://cloud.google.com/run), [Cloud Run functions](https://cloud.google.com/functions), [Knative](https://knative.dev/docs/), and [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), as well as between these platforms and your local development machine.

This tutorial presents a use case where you will locally create a function using the Functions Framework. You will then build a [Docker image](../../container-registry/concepts/docker-image.md) from this function and upload it to a [registry](../../container-registry/concepts/registry.md) in {{ container-registry-full-name }}. Using the Docker image stored in the registry, you will create a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} that will run your function code when invoked.

This solution enables you to:
* Build and distribute functions as [OCI-compatible](https://opencontainers.org/) Docker images and deploy them on various cloud and on-premises platforms, such as [Kubernetes](https://kubernetes.io/), Cloud Run, Knative, etc.
* Develop, run locally, debug, and test functions as standard web applications using modern [IDEs](https://en.wikipedia.org/wiki/Integrated_development_environment).
* Migrate your functions from Cloud Run functions or Knative while maintaining compatibility with these platforms.
* Create functions in [Dart](https://dart.dev/), [C++](https://en.wikipedia.org/wiki/C%2B%2B), or [Ruby](https://www.ruby-lang.org/en/), which are currently not supported in {{ sf-name }}.

In this tutorial, you will create a test function. For the complete list of supported programming languages, see the Functions Framework GitHub [repository](https://github.com/GoogleCloudPlatform/functions-framework?tab=readme-ov-file#languages--test-status).

To deploy a function in {{ serverless-containers-name }}:
1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#service-account).
1. [Create a registry in {{ container-registry-name }}](#create-registry).
1. [Create a function](#create-function).
1. [Create a Docker image and push it to the registry in {{ container-registry-name }}](#push-docker-image).
1. [Create a container in {{ serverless-containers-name }} from the uploaded Docker image](#setup-container).
1. [Test the function in the container](#run-test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for using the storage, amount of outgoing traffic, and using the {{ container-registry-name }} vulnerability scanner (see the [{{ container-registry-full-name }} pricing](../../container-registry/pricing.md)).
* Fee for using {{ serverless-containers-name }} (see [{{ serverless-containers-full-name }} pricing](../../serverless-containers/pricing.md)).

### Set up your environment {#setup-runtime}

1. Install [cURL](https://curl.haxx.se).
1. [Install and configure](../../cli/quickstart.md) the {{ yandex-cloud }} CLI.
1. [Install and configure](../../container-registry/operations/configure-docker.md) Docker.
1. [Get authenticated](../../container-registry/operations/authentication.md) in {{ container-registry-name }}.
1. Install [Pack](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/). To do this, run these commands in the terminal and wait for the installation to complete:

    ```bash
    sudo add-apt-repository ppa:cncf-buildpacks/pack-cli -y
    sudo apt install pack-cli -y
    ```

    Here we provide the [Pack](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/) installation guide for Linux Ubuntu. If you are using a different OS, see the Pack tutorials with installation instructions.

## Create a service account {#service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**, and in the window that opens:
      1. Name the [service account](../../iam/concepts/users/service-accounts.md): `serverless-containers-sa`.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select [`container-registry.images.puller`](../../container-registry/security/index.md#container-registry-images-puller).
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.


- CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `serverless-containers-sa`:

      ```bash
      yc iam service-account create \
        --name serverless-containers-sa
      ```

      Result:

      ```text
      done (1s)
      id: aje7tnmd885t********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-14T11:09:54.376880905Z"
      name: serverless-containers-sa
      ```

      Save the service account ID (the `id` field value) and the folder ID (the `folder_id` field value), you will need them in the next step.

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Assign the `container-registry.images.puller` [role](../../container-registry/security/index.md#container-registry-images-puller) for the folder to the created service account by specifying the folder and service account IDs you saved in the previous step:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role container-registry.images.puller \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
           role_id: container-registry.images.puller
            subject:
              id: aje7tnmd885t********
              type: serviceAccount
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the service account a role for the folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

{% endlist %}

## Create a registry in {{ container-registry-name }} {#create-registry}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you used to create the service account in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. In the **{{ ui-key.yacloud.cr.overview.popup-create_field_name }}** field, enter the registry name: `functions-framework-registry`.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.
  1. On the page that opens, copy the ID of the created registry, you will need it later.

- CLI {#cli}

  Create a registry named `functions-framework-registry`:

  ```bash
  yc container registry create \
    --name functions-framework-registry
  ```

  Result:

  ```text
  done (1s)
  id: crpfn9p374a3********
  folder_id: b1gt6g8ht345********
  name: functions-framework-registry
  status: ACTIVE
  created_at: "2025-02-14T11:44:23.698Z"
  ```

  Save the ID (the `id` field value) of the created registry, you will need it later.

  For more information about the `yc container registry create` command, see the [CLI reference](../../cli/cli-ref/container/cli-ref/registry/create.md).

- API {#api}

  To create a registry, use the [create](../../container-registry/api-ref/Registry/create.md) method for the [Registry](../../container-registry/api-ref/Registry/index.md) resource or the [RegistryService/Create](../../container-registry/api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}

## Create a function {#create-function}

At this stage, you will locally create a function using the Functions Framework. Here we provide the package installation commands for Linux Ubuntu. If you are using a different OS, see the relevant tutorials for installation instructions.

{% list tabs group=programming_language %}

- Node.js {#node}

  To create a function in [Node.js](https://nodejs.org/en):

  1. Install the [npm](https://nodejs.org/en/learn/getting-started/an-introduction-to-the-npm-package-manager) package manager:

      ```bash
      sudo apt update && \
      sudo apt install npm -y
      ```
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Initialize your project:

      ```bash
      npm init
      ```

      During initialization, leave all requested values at their defaults by pressing **ENTER**. At the end, when you get the `Is this OK?` promt, type `yes` and press **Enter**. This will create the `package.json` project file in your project directory.

      ```json
      {
        "name": "my-first-function",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"
        },
        "author": "",
        "license": "ISC"
      }
      ```
  1. Create a new `index.js` file by opening it in the text editor:

      ```bash
      nano index.js
      ```
  1. Add this code to the `index.js` file:

      ```js
      const functions = require('@google-cloud/functions-framework');

      functions.http('helloWorld', (req, res) => {
        res.send('Hello, World!');
      });
      ```
  1. Install the Functions Framework in your project:

      ```bash
      npm install @google-cloud/functions-framework
      ```
  1. Add this code to the `package.json` file:

      ```bash
      "scripts": {
        "start": "functions-framework --target=helloWorld"
      }
      ```

      Example of the final `package.json` contents:

      ```json
      {
        "name": "my-first-function",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"
        },
        "author": "",
        "license": "ISC",
        "dependencies": {
          "@google-cloud/functions-framework": "^3.4.5"
        },
        "scripts": {
          "start": "functions-framework --target=helloWorld"
        }
      }
      ```
  1. Run your function locally to make sure everything works correctly:

      1. Run the function:

          ```bash
          npm start
          ```

          Result:

          ```text
          > my-first-function@1.0.0 start
          > functions-framework --target=helloWorld

          Serving function...
          Function: helloWorld
          Signature type: http
          URL: http://localhost:8080/
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}

- Python {#python}

  To create a function in [Python](https://www.python.org):

  1. Install Python and [pip](https://pip.pypa.io/en/stable/):

      ```bash
      sudo apt update && \
      sudo apt install python3 python3-pip -y
      ```
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Install the Functions Framework:

      ```bash
      sudo pip install functions-framework
      ```
  1. Create the `main.py` file with the function code by opening it in the text editor:

      ```bash
      nano main.py
      ```
  1. Add this code to the `main.py` file:

      ```python
      import flask
      import functions_framework

      @functions_framework.http
      def helloWorld(request: flask.Request) -> flask.typing.ResponseReturnValue:
          return "Hello, World!"
      ```
  1. Run your function locally to make sure everything works correctly:

      1. Run the function:

          ```bash
          functions-framework --target helloWorld --debug
          ```

          Result:

          ```text
          * Serving Flask app 'hello'
          * Debug mode: on
          WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
          * Running on all addresses (0.0.0.0)
          * Running on http://127.0.0.1:8080
          * Running on http://192.168.1.15:8080
          Press CTRL+C to quit
          * Restarting with watchdog (inotify)
          * Debugger is active!
          * Debugger PIN: 817-187-***
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}

- Go {#go}

  To create a function in [Go](https://go.dev/):

  1. [Install](https://go.dev/doc/install) Go `1.18` or higher.
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Create a new module:

      ```bash
      go mod init example.com/helloWorld
      ```
  1. Create the `function.go` file with the function code by opening it in the text editor:

      ```go
      nano function.go
      ```
  1. Add this code to the `function.go` file:

      ```go
      package function

      import (
        "fmt"
        "net/http"

        "github.com/GoogleCloudPlatform/functions-framework-go/functions"
      )

      func init() {
        functions.HTTP("helloWorld", helloWorld)
      }

      // helloWorld writes "Hello, World!" to the HTTP response.
      func helloWorld(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "Hello, World!")
      }
      ```
  1. Run your function locally to make sure everything works correctly:

      1. Create a directory named `cmd`:

          ```bash
          mkdir cmd
          ```
      1. In the `cmd` directory, create a file named `main.go`:

          ```bash
          nano cmd/main.go
          ```
      1. Add this code to the `main.go` file:

          ```go
          package main

          import (
            "log"
            "os"

            // Blank-import the function package so the init() runs
            _ "example.com/helloWorld"
            "github.com/GoogleCloudPlatform/functions-framework-go/funcframework"
          )

          func main() {
            // Use PORT environment variable, or default to 8080.
            port := "8080"
            if envPort := os.Getenv("PORT"); envPort != "" {
              port = envPort
            }
            
            // By default, listen on all interfaces. If testing locally, run with 
            // LOCAL_ONLY=true to avoid triggering firewall warnings and 
            // exposing the server outside of your own machine.
            hostname := ""
            if localOnly := os.Getenv("LOCAL_ONLY"); localOnly == "true" {
              hostname = "127.0.0.1"
            } 
            if err := funcframework.StartHostPort(hostname, port); err != nil {
              log.Fatalf("funcframework.StartHostPort: %v\n", err)
            }
          }
          ```
      1. Update the dependencies:

          ```bash
          go mod tidy
          ```
      1. Start your local server:

          ```bash
          FUNCTION_TARGET=helloWorld \
          LOCAL_ONLY=true \
          go run cmd/main.go
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}


{% endlist %}

## Create a Docker image and push it to the registry in {{ container-registry-name }} {#push-docker-image}

The function is built using [Buildpacks](https://buildpacks.io) and [builders](https://buildpacks.io/docs/for-app-developers/concepts/builder/) provided by [GCP](https://github.com/GoogleCloudPlatform/buildpacks). You can also use builders provided by [Heroku](https://github.com/heroku/buildpacks).

1. Use Pack, which you installed earlier, to build a Docker image with your app:

    ```bash
    sudo pack build \
     --builder gcr.io/buildpacks/builder:google-22 \
     --env GOOGLE\_FUNCTION\_SIGNATURE\_TYPE=http \
     --env GOOGLE\_FUNCTION\_TARGET=helloWorld \
     my-first-function
    ```

    To additionally configure the container build, e.g., add other packages or dependencies, use [this guide](https://cloud.google.com/docs/buildpacks/build-run-image).

    Result:

    ```text
    ...
    Successfully built image my-first-function
    ```

    You can use the above build command for functions written in different programming languages. The builder will automatically detect the project's language and runtime environment and then build the application into an OCI-compatible Docker image. This way, developers do not need to create a Dockerfile manually.

1. Run the container locally from the Docker image to make sure everything works correctly:

    1. Run this command:

        ```bash
        docker run --rm -p 8080:8080 my-first-function
        ```
    1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

        The function code is running in the locally launched Docker container.
    1. Close the additional terminal window. Stop the running Docker container from the main terminal window by pressing **Ctrl + C**.
1. Assign an URL to the Docker image in the `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>` format and specify the previously saved ID of the registry from {{ container-registry-name }}.

     ```bash
     docker tag my-first-function \
       cr.yandex/<registry_ID>/my-first-function:some-tag
     ```

     {% note info %}

     To push Docker images to {{ container-registry-name }}, you need to assign them URLs in this format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`.

     {% endnote %}
1. Push the Docker image to the registry:

    ```bash
    docker push \
      cr.yandex/<registry_ID>/my-first-function:some-tag
    ```

    Result:

    ```text
    The push refers to repository [cr.yandex/crpfn9p374a3********/my-first-function]
    ...
    14f9fd9947d2: Pushed
    2573e0d81582: Pushed
    some-tag: digest: sha256:1b8bac8da5e64dd4359f81d71a7803f212af385f9718a7a4f9a40bca******** size: 2830
    ```

## Create a container in {{ serverless-containers-name }} from the uploaded Docker image {#setup-container}

Use the Docker image uploaded to {{ container-registry-name }} to create a {{ serverless-containers-name }} container [revision](../../serverless-containers/concepts/container.md#revision).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the resources you created previously.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the container name: `my-first-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-containers.section_image }}**, in the **{{ ui-key.yacloud.serverless-containers.label_image-url }}** field, select the previously uploaded Docker image, `cr.yandex/<registry_ID>/my-first-function:some-tag`.
  1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**, in the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select the previously created service account. `serverless-containers-sa`.
  1. Under **{{ ui-key.yacloud.logging.label_title }}**, disable **{{ ui-key.yacloud.logging.field_logging }}** to opt out of writing logs to the [log group](../../logging/concepts/log-group.md).

      You can leave this option enabled if you prefer to [write](../../serverless-containers/operations/logs-write.md) container execution logs. You will be [charged](../../logging/pricing.md) for writing and storing logs.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.
  1. In the window that opens, under **{{ ui-key.yacloud_org.common.section-base }}**, copy the **{{ ui-key.yacloud.serverless-containers.label_url }}** value; you will need this URL to test function in the container.

- CLI {#cli}

  1. Create a container in `my-first-function`:

      ```bash
      yc serverless container create \
        --name my-first-function
      ```

      Result:

      ```text
      done (1s)
      id: bba0tc5nv6j0********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-14T15:26:04.744Z"
      name: my-first-function
      url: https://bba0tc5nv6j0********.containers.yandexcloud.net/
      status: ACTIVE
      ```

      Save the container invocation `url`, you will need it to test function in the container.

      For more information about the `yc serverless container create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/container/create.md).

  1. Create a revision of the container you created previously:

      ```bash
      yc serverless container revision deploy \
        --container-name my-first-function \
        --image "cr.yandex/<registry_ID>/my-first-function:some-tag" \
        --service-account-id <service_account_ID> \
        --no-logging
      ```

      Where:
      * `<registry_ID>`: ID of the {{ container-registry-name }} registry you saved in the previous step.
      * `<service_account_ID>`: ID of the `serverless-containers-sa` service account you saved in the previous step.
      * `--no-logging`: Disables writing logs to the [log group](../../logging/concepts/log-group.md). Remove this parameter from the command to [write](../../serverless-containers/operations/logs-write.md) container execution logs. You will be [charged](../../logging/pricing.md) for writing and storing logs.

      Result:

      ```text
      done (16s)
      id: bba6f1jllc3t********
      container_id: bbakbil5lg7j********
      created_at: "2025-02-14T20:48:06.424Z"
      image:
        image_url: cr.yandex/crpfn9p374a3********/my-first-function:some-tag
        image_digest: sha256:1b8bac8da5e64dd4359f81d71a7803f212af385f9718a7a4f9a40bca********
      resources:
        memory: "134217728"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 3s
      concurrency: "1"
      service_account_id: aje7tnmd885t********
      status: ACTIVE
      log_options:
        disabled: true
        folder_id: b1gt6g8ht345********
      runtime:
        http: {}
      ```

      For more information about the `yc serverless container revision deploy` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/container/revision/deploy.md).

- API {#api}

  To create a [container](../../serverless-containers/concepts/container.md), use the [create](../../serverless-containers/containers/api-ref/Container/create.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md) gRPC API call.

  To create a container revision, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## Test the function in the container {#run-test}

After creating the container, you got the invocation link. To test the function in the container, use this link in the following request:

```bash
curl \
  --request GET \
  --header "Authorization: Bearer $(yc iam create-token)" \
  <container_invocation_link>
```

Result:

```text
Hello, World%
```

By invoking the container, you ran the code of `my-first-function` you created earlier with the Functions Framework.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../serverless-containers/operations/delete.md) {{ serverless-containers-name }}.
1. [Delete](../../container-registry/operations/docker-image/docker-image-delete.md) the Docker image from the registry in {{ container-registry-name }} and then [delete](../../container-registry/operations/registry/registry-delete.md) the registry.
1. If you did not disable writing container execution logs, [delete](../../logging/operations/delete-group.md) the log group.