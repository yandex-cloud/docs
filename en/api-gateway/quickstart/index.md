# Getting started

Using these instructions, you'll create and test different types of extensions: first, you'll set up an API gateway for getting [static responses](../concepts/extensions/dummy.md) and then add integration for [invoking functions](../concepts/extensions/cloud-functions.md).

## Before you start {#before-you-begin}

To start working with Yandex.Cloud:

1. Log in to [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}) make sure that you enabled a [billing account](../../billing/concepts/billing-account.md), and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create an API gateway {#create-api-gw}

Create an API gateway and access it.

{% list tabs %}

- Management console

    To create an API gateway:

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.

    1. In the list of services, select **{{ api-gw-name }}**.

    1. Click **Create API gateway**.

    1. In the **Name** field, enter `numbers`.

    1. (optional) In the **Description** field, enter a description.

    1. In the **Specification** section, add a specification:

        ```
        openapi: "3.0.0"
        info:
          version: 1.0.0
          title: Test API
        paths:
          /hello:
            get:
              summary: Say hello
              operationId: hello
              parameters:
                - name: user
                  in: query
                  description: User name to appear in greetings
                  required: false
                  schema:
                    type: string
                    default: 'world'
              responses:
                '200':
                  description: Greeting
                  content:
                    'text/plain':
                       schema:
                         type: "string"
              x-yc-apigateway-integration:
                type: dummy
                http_code: 200
                http_headers:
                  'Content-Type': "text/plain"
                content:
                  'text/plain': "Hello, {user}!\n"
        ```

    1. Click **Create**.

    1. Access the API gateway.

        1. In the window that opens, click on the created API gateway.

        1. Copy the **Domain** field value and create a link like: `https://<domain>/hello?user=API`. The resulting link should look like this:

            ```
            https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
            ```

        1. Access the API gateway using one of the commands:

            ```
            curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello?user=API
            curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/hello
            ```

{% endlist %}

## Add an integration with a function {#functions}

### Create a function {#function}

Create a function to get a list of numbers. Read more about functions in the documentation for [{{ sf-name }}](../../functions).

{% list tabs %}

- Management console

    To create a function:
    1. Create a function:
        1. In [management console]({{ link-console-main }}), select the folder where you want to create your function.
        1. Click **Create resource**.
        1. Choose **Function**.
        1. In the **Name** field, specify `list`.
        1. Click **Create**.
    1. Create the function version:
        1. In the window that opens, select the function you created.

        1. Under **Latest version**, click **Create in editor**.

        1. In the window that opens, in the **Runtime environment** field, choose `nodejs12`.

        1. In the **Method** field, select the code editor.

        1. Click **Create file** in the editor below.
            1. In the window that opens, enter the `index.js` file name.
            1. Click **Create**.

        1. Paste the following code in the `index.js` file:

            ```
            module.exports.handler = async (event) => {
                return {
                    "statusCode": 200,
                    "headers": {"content-type": "application/json"},
                    "body": "[0, 1, 2]"
                };
            };
            ```

        1. In the **Entry point** field, specify `index.handler`.

        1. Click **Create version**.

{% endlist %}

### Extend the API gateway specification {#update}

Add function information to the API gateway specification.

{% list tabs %}

- Management console

    To update an API gateway specification:

    1. In the [management console]({{ link-console-main }}), select the folder to update the API gateway in.

    1. In the window that opens, select the API gateway and click ![image](../../_assets/options.svg).

    1. In the menu that opens, click **Edit**.

    1. Under **Specification**, add an extended version of the specification

        Added the `/numbers` method which uses the `x-yc-apigateway-integration` extension like `cloud_functions` to invoke a function by ID.

        To ensure that the API gateway works properly, in the `function_id` parameter, specify the ID of the function to invoke.

        ```
        openapi: "3.0.0"
        info:
          version: 1.0.0
          title: Test API
        paths:
          /hello:
            get:
              summary: Say hello
              operationId: hello
              parameters:
                - name: user
                  in: query
                  description: User name to appear in greetings
                  required: false
                  schema:
                    type: string
                    default: 'world'
              responses:
                '200':
                  description: Greeting
                  content:
                    'text/plain':
                       schema:
                         type: "string"
              x-yc-apigateway-integration:
                type: dummy
                http_code: 200
                http_headers:
                  'Content-Type': "text/plain"
                content:
                  'text/plain': "Hello, {user}!\n"
          /numbers:
            get:
              summary: List some numbers
              operationId: listNumbers
              responses:
                '200':
                  description: Another example
                  content:
                    'application/json':
                       schema:
                         type: "array"
                         items:
                           type: "integer"
              x-yc-apigateway-integration:
                type: cloud_functions
                function_id: <function ID>
        ```

{% endlist %}

### Access the function via the API gateway {#api-gw}

Access the API gateway:

```
curl https://falrnjna8r5vj88ero6a.apigw.yandexcloud.net/user_ids
[0, 1, 2]
```

#### See also {#see-also}

* [Concepts for using the service](../concepts/index.md).
* [Step-by-step instructions for managing API gateways](../operations/index.md).

