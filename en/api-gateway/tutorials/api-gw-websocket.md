# Communicating with an API gateway using the WebSocket protocol

To connect to an API gateway via the WebSocket protocol:

1. [Create an API gateway](#create).
1. [Establish a connection](#connect).
1. [Test the connection](#check).

If you no longer need the created resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of the resources includes charges for the number of API gateway requests and outgoing traffic (see [{{ api-gw-full-name }} pricing](../pricing.md)).

## Create an API gateway {#create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create an API gateway.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. Click Create **API gateway**.
   1. In the **Name** field, enter `websocket`.
   1. (optional) In the **Description** field, enter a description.
   1. In the **Specification** section, add a specification:
      ```yaml
      openapi: 3.0.0
      info:
        title: Test API
        version: 1.0.0
      paths:
        /connections:
          x-yc-apigateway-websocket-message:
            summary: Get connection identifier
            operationId: getConnectionID
            parameters:
              - name: X-Yc-Apigateway-Websocket-Connection-Id
                in: header
                description: Websocket connection identifier
                required: true
                schema:
                  type: string
            responses:
              '200':
                description: Connection identifier
                content:
                  text/plain:
                    schema:
                      type: string
            x-yc-apigateway-integration:
              type: dummy
              http_code: 200
              http_headers:
                Content-Type: application/json
              content:
                text/plain: '{"connection_id":"{X-Yc-Apigateway-Websocket-Connection-Id}"}'
      ```
   1. Click **Create**.

{% endlist %}

## Establish a connection {#connect}

1. Open the terminal and install the [wscat](https://www.npmjs.com/package/wscat) utility:
   ```bash
   npm install -g wscat
   ```
1. Connect to the API gateway. Replace `<API_gateway_ID>` with an API gateway ID.
   ```bash
   wscat -c wss://<API_gateway_ID>.apigw.yandexcloud.net/connections
   Connected (press CTRL+C to quit)
   ```
1. Type in any message and press `Enter`.

The message will be sent to the API gateway via the existing connection. The API gateway will call integration and send a response that you will see on your screen. The response will contain the connection ID:
```bash
> Hello!
< {"connection_id":"<connection ID>"}
```
## Test the connection {#check}

Open a new terminal window and test the connection using the returned connection ID.

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Retrieve information on the existing connection:
      ```bash
      yc serverless api-gateway websocket get <connection_ID>
      ```
   1. Send a message to the client:
      ```bash
      yc serverless api-gateway websocket send <connection ID> --data Hello!
      ```
   1. Close the connection:
      ```bash
      yc serverless api-gateway websocket disconnect <connection ID>
      ```
   1. Go to the terminal window with the established connection. It should display the following information:
      ```bash
      wscat -c wss://<API gateway ID>.apigw.yandexcloud.net/connections
      Connected (press CTRL+C to quit)
      > Hello!
      < {"connection_id":"<connection ID>"}
      < Hello!
      Disconnected (code: 1000, reason: "")
      ```

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the resources created, delete the [API gateway](../operations/api-gw-delete.md).
