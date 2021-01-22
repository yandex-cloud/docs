# Creating and executing functions

Create and execute a [function](../concepts/function.md) that welcomes the user. To do this, use Python or Node.js.

- [Before you start](#before-you-begin)
- [Create a function in Python](#python-func)
    - [Create a function](#create-py-func)
    - [Create the first version of the function](#create-py-version)
- [Create a function in Node.js](#nodejs-func)
    - [Create a function](#create-js-func)
    - [Create the first version of the function](#create-js-version)
- [Invoke the function](#invoke)
- [What's next](#what-is-next)

## Before you start {#before-you-begin}

1. [Create a folder](../../resource-manager/operations/folder/create.md) in {{ yandex-cloud }}.
1. [Install](../../cli/quickstart.md) the YC CLI command line interface.

## Create a function in Python {#python-func}

{% list tabs %}

- Management console

  1. In the management console, select the folder to create your function in.

  1. Click **Create resource**.

  1. Choose **Function**.

  1. Enter a function name.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Create**.

- CLI

  Use the following command to create a function:

  ```
  $ yc serverless function create --name=my-python-function
  .done
  id: b09bhaokchn9pnbrlseb
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-06-14T10:03:37.475Z"
  name: my-python-function
  log_group_id: eolm8aoq9vcppsieej6h
  http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
  ```

{% endlist %}

### Create the first version of the function {#create-py-version}

{% include [create-version](../../_includes/functions/create-version.md) %}

#### Prepare a ZIP archive with the function code {#create-py-zip}

1. Save the following code to a file named `main.py`:

    ```
    def handler(event, context):
        name = 'World'
        if 'queryStringParameters' in event and 'name' in event['queryStringParameters']:
            name = event['queryStringParameters']['name']

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': False,
            'body': 'Hello, {}!'.format(name)
        }
    ```

1. Add the `main.py` file to the `hello-py.zip` archive.

#### Create a function version {#create-py-func}

{% list tabs %}

- Management console
  1. Open **{{ sf-name }}** in the folder where you want to create the function [version](../concepts/function.md#version).
  1. Select the function to create the version for.
  1. Under **Latest version**, click **Create in editor**.
  1. Set the version parameters:
      - **Runtime environment:** `python37`.
      - **Timeout, seconds:** 5.
      - **RAM:** 128 MB.
      - **Service account:** Not selected.
  1. Prepare the function code:
      - **Method:** ZIP archive.
      - **File:** `hello-py.zip`.
      - **Entry point:** `main.handler`.
  1. Click **Create version**.

- CLI

  Create the function version:

  ```
  $ yc serverless function version create \
  --function-name=my-python-function \ # Function name.
  --runtime python37 \ # Runtime environment.
  --entrypoint main.handler \ # The handler specified in the <function file name>.<handler name> format.
  --memory 128m \ # Amount of RAM.
  --execution-timeout 5s \ # The maximum function execution time before the timeout is reached.
  --source-path ./hello-py.zip # ZIP archive with the function code and all the required dependencies.
  ```

{% endlist %}

## Create a function in Node.js {#nodejs-func}

{% list tabs %}

- Management console

  1. In the management console, select the folder to create your function in.

  1. Click **Create resource**.

  1. Choose **Function**.

  1. Enter a function name.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Click **Create**.

- CLI

  Use the following command to create a function:

  ```
  $ yc serverless function create --name=my-nodejs-function
  ..........done
  id: b09hnm3nucbm1tk8dops
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-06-14T09:53:39.885Z"
  name: my-nodejs-function
  log_group_id: eol8eetd68mq3849eurs
  http_invoke_url: https://functions.yandexcloud.net/b09hnm3nucbm1tk8dops
  ```

{% endlist %}

### Create the first version of the function {#create-js-version}

To create the function version, you'll need a ZIP archive with the function code and all the required dependencies.

#### Prepare a ZIP archive with the function code {#create-js-zip}

1. Save the following code to a file named `index.js`:

    ```
    exports.handler = async function (event, context) {
        let name = 'World';
        if (event.queryStringParameters && event.queryStringParameters.name) {
            name = event.queryStringParameters.name
        }
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };

    ```

1. Add `index.js` to the `hello-js.zip` archive.

#### Create a function version {#create-js-func}

{% list tabs %}

- Management console
  1. Open **{{ sf-name }}** in the folder where you want to create the function version.
  1. Select the function to create the version for.
  1. Under **Latest version**, click **Create in editor**.
  1. Set the version parameters:
      - **Runtime environment:** `nodejs12`.
      - **Timeout, seconds:** 5.
      - **RAM:** 128 MB.
      - **Service account:** Not selected.
  1. Prepare the function code:
      - **Method:** ZIP archive.
      - **File:** `hello-js.zip`.
      - **Entry point:** `index.handler`.
  1. Click **Create version**.

- CLI

  Create the function version:

  ```
  $ yc serverless function version create \
  --function-name=my-nodejs-function \ # Function name.
  --runtime nodejs12 \ # Runtime environment.
  --entrypoint index.handler \ The handler, specified in <function file name>.<handler name> format.
  --memory 128m \ # Amount of RAM.
  --execution-timeout 5s \ # The maximum function execution time before the timeout is reached.
  --source-path ./hello-js.zip # ZIP archive with the function code and all required dependencies.
  ```

{% endlist %}

## Invoke the function {#invoke}

{% note info %}

To allow any user to invoke your function, [make it public](../operations/function-public.md). For more information about access rights, see [{#T}](../security/index.md).

{% endnote %}

To access the function, use its name or unique ID, which can be obtained using the command:

```
$ yc serverless function list
+----------------------+--------------------+----------------------+
|          ID          |        NAME        |      FOLDER ID       |
+----------------------+--------------------+----------------------+
| b097d9ous3gep99khe83 | my-beta-function   | aoek49ghmknnpj1ll45e |
| b09bhaokchn9pnbrlseb | my-python-function | aoek49ghmknnpj1ll45e |
| b09hnm3nucbm1tk8dops | my-nodejs-function | aoek49ghmknnpj1ll45e |
+----------------------+--------------------+----------------------+
```

{% list tabs %}

- HTTP

    {% note info %}

    For security reasons, the function can only be called using TLS protocol.

    {% endnote %}

    You can view the function invocation link in the `http_invoke_url` parameter while [creating a function](../operations/function/function-create.md).

    Call the function as a regular HTTP request by inserting the function call link in the browser address bar. In this case, we use the example of a function written in [Python](#python-func):

    ```
    {{ sf-url }}/b09bhaokchn9pnbrlseb
    ```

    The following response appears on the page:

    ```
    Hello, World!
    ```

    When calling the function, you can add some parameters to the URL. As an example, add the `name` parameter:

    ```
    {{ sf-url }}/b09bhaokchn9pnbrlseb?name=Username
    ```

    The following response appears on the page:

    ```
    Hello, Username!
    ```

- CLI

    Call the function by specifying in the parameter a name for the greeting:

    ```
    $ yc serverless function invoke my-python-function -d '{"queryStringParameters": {"name": "Username"}}'
    {"statusCode":200,"isBase64Encoded":false,"body":"{\"message\":\"Hello, Username!\"}"}
    ```

{% endlist %}

## What's next {#what-is-next}

- For more information about the structure of functions invoked in different ways (HTTP or CLI), seе [{#T}](../concepts/function-invoke.md).
- Read about [service concepts](../concepts/index.md).
- For information about what you can do with functions and their versions, see our [step-by-step instructions](../operations/index.md).

