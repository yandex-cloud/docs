# URL shortener

With this script, you'll create a URL shortening service using serverless technologies available in {{ yandex-cloud }}.

The service accepts user requests via a public [API gateway](../../api-gateway/concepts/index.md). The [hosting](../../storage/concepts/hosting.md) service sends the user an HTML page with a field for entering the URL. The [function](../../functions/concepts/function.md) sends the entered URL for storage in a [serverless database](../../ydb/concepts/serverless-and-dedicated.md#serverless), shortens it, and returns it to the user. When the user enters the shortened URL, the function finds the full URL in the database and redirects the user's request to it.

To configure and test the service:
1. [Before you start](#before-begin).
1. [Set up hosting for the URL shortener page](#object-storage).
1. [Create a service account](#service-account).
1. [Create a database in {{ ydb-full-name }}](#ydb).
1. [Set up a function in {{ sf-full-name }}](#function).
1. [Publish the service via {{ api-gw-full-name }}](#api-gw).
1. [Test the URL shortener](#test-shortener).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources for the script includes:
* A fee for using the storage (see [pricing{{ objstorage-full-name }}](../../storage/pricing.md)).
* A fee for accessing the database (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).
* 0A fee for function calls (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* A fee for requests to the API gateway (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).


## Set up hosting for the URL shortener page {#object-storage}

To create a bucket to place the HTML page of your service in and configure it for hosting static websites:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select your working folder.
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter a name for the bucket like` for-serverless-shortener`.

         {% note warning %}

         Bucket names are unique throughout {{ objstorage-name }}, meaning that you can't create two buckets with the same name (even in different folders located in different clouds).

         {% endnote %}

      1. Set the maximum size to `1 GB`.
      1. Choose `Public` access to read objects.
      1. Click **Create bucket** to complete the operation.
   1. Copy the HTML code and paste it into the `index.html` file:

      {% cut "HTML code" %}

      ```html
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <title>URL shortener</title>
        <!-- will help you avoid an extra GET request to an address /favicon.ico -->
        <link rel="icon" href="data:;base64,iVBORw0KGgo=">
      </head>

      <body>
        <h1>Welcome</h1>
        <form action="javascript:shorten()">
          <label for="url">Enter a link:</label><br>
          <input id="url" name="url" type="text"><br>
          <input type="submit" value="Shorten">
        </form>
        <p id="shortened"></p>
      </body>

      <script>
        function shorten() {
          const link = document.getElementById("url").value
          fetch("/shorten", {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: link
          })
          .then(response => response.json())
          .then(data => {
            const url = data.url
            document.getElementById("shortened").innerHTML = `<a href=${url}>${url}</a>`
          })
          .catch(error => {
            document.getElementById("shortened").innerHTML = `<p>The error ${error} has occurred, try again</p>`
          })
        }
      </script>

      </html>
      ```

      {% endcut %}

   1. Click on the name of the created bucket.
   1. Click **Upload objects**.
   1. Specify the prepared `index.html` file.
   1. Click **Upload**.
   1. In the left pane, select **Website**.
   1. Select **Hosting**.
   1. Specify the website's homepage: `index.html`.
   1. Click **Save**.

{% endlist %}

## Create a service account {#service-account}

To create a service account for the service components to interact:

{% list tabs %}

- Management console

   1. Go to your working folder.
   1. In the left pane, select **Service accounts**.
   1. Click **Create service account**.
   1. Enter the name of the service account: `serverless-shortener`.
   1. Click **Add role** and choose the `editor` role.
   1. Click **Create**.
   1. Click on the name of the created service account.

      Save the service account ID, you'll need it in the next steps.

{% endlist %}

## Create a database in {{ ydb-name }} {#ydb}

To create a {{ ydb-name }} database and configure it to store URLs:

{% list tabs %}

- Management console

   1. Go to your working folder.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the DB name: `for-serverless-shortener`.
   1. Select the **Serverless** database type.
   1. Click **Create database**.
   1. Wait until the database starts.

      When a database is being created, it has the `Provisioning` status. When it's ready for use, the status changes to `Running`.
   1. Click on the name of the created database.

      Save the values of the **Endpoint**, **Database**, and **Protocol** fields of the **{{ ydb-short-name }} endpoint** section. You'll need them in the next steps.
   1. In the left pane, select **Navigation**.
   1. Click **SQL query**.
   1. Copy the SQL query and paste it into the **Query** field:

      ```sql
      CREATE TABLE links
      (
        id Utf8,
        link Utf8,
        PRIMARY KEY (id)
      );
      ```

   1. Click **Run**.

{% endlist %}

## Set up a function in {{ sf-name }} {#function}

To create and set up a URL shortening function:

{% list tabs %}

- Management console

   1. Go to your working folder.
   1. In the list of services, select **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter the function name: `for-serverless-shortener`.
   1. Click **Create**.
   1. In the **Python** drop-down list, choose the `python37` runtime environment.
   1. Click **Next**.
   1. Copy the function code and paste it into the `index.py` file under **Function code**.

      {% cut "Function code" %}

      ```py
      from kikimr.public.sdk.python import client as ydb

      import urllib.parse
      import hashlib
      import base64
      import json
      import os

      def decode(event, body):
        # The request body can be encoded.
        is_base64_encoded = event.get('isBase64Encoded')
        if is_base64_encoded:
          body = str(base64.b64decode(body), 'utf-8')
        return body

      def response(statusCode, headers, isBase64Encoded, body):
        return {
          'statusCode': statusCode,
          'headers': headers,
          'isBase64Encoded': isBase64Encoded,
          'body': body,
        }

      def get_config():
        endpoint = os.getenv("endpoint")
        database = os.getenv("database")
        if endpoint is None or database is None:
          raise AssertionError("Enter both environment variables")
        credentials = ydb.construct_credentials_from_environ()
        return ydb.DriverConfig(endpoint, database, credentials=credentials)

      def execute(config, query, params):
        with ydb.Driver(config) as driver:
          try:
            driver.wait(timeout=5)
          except TimeoutError:
            print("Connect failed to YDB")
            print("Last reported errors by discovery:")
            print(driver.discovery_debug_details())
            return None

          session = driver.table_client.session().create()
          prepared_query = session.prepare(query)

          return session.transaction(ydb.SerializableReadWrite()).execute(
            prepared_query,
            params,
            commit_tx=True
          )


      def insert_link(id, link):
        config = get_config()
        query = """
          DECLARE $id AS Utf8;
          DECLARE $link AS Utf8;

          UPSERT INTO links (id, link) VALUES ($id, $link);
          """
        params = {'$id': id, '$link': link}
        execute(config, query, params)

      def find_link(id):
        print(id)
        config = get_config()
        query = """
          DECLARE $id AS Utf8;

          SELECT link FROM links where id=$id;
          """
        params = {'$id': id}
        result_set = execute(config, query, params)
        if not result_set or not result_set[0].rows:
          return None

        return result_set[0].rows[0].link

      def shorten(event):
        body = event.get('body')

        if body:
          body = decode(event, body)
          original_host = event.get('headers').get('Origin')
          link_id = hashlib.sha256(body.encode('utf8')).hexdigest()[:6]
          # The link might include encoded characters, for example, %. They might create issues with API Gateway operation on redirect,
          # Make sure to remove them by calling urllib.parse.unquote.
          insert_link(link_id, urllib.parse.unquote(body))
          return response(200, {'Content-Type': 'application/json'}, False, json.dumps({'url': f'{original_host}/r/{link_id}'}))

        return response(400, {}, False, 'The url parameter is missing in the request body')

      def redirect(event):
        link_id = event.get('pathParams').get('id')
        redirect_to = find_link(link_id)

        if redirect_to:
          return response(302, {'Location': redirect_to}, False, '')

        return response(404, {}, False, 'This link does not exist')

      # We need these checks because we have only one function.
      # Ideally, each path in the API Gateway should have its own function.
      def get_result(url, event):
        if url == "/shorten":
          return shorten(event)
        if url.startswith("/r/"):
          return redirect(event)

        return response(404, {}, False, 'This path does not exist')

      def handler(event, context):
        url = event.get('url')
        if url:
          # The API Gateway may return a URL with a trailing question mark.
          if url[-1] == '?':
            url = url[:-1]
          return get_result(url, event)

        return response(404, {}, False, 'This function should be called using the API Gateway.')
      ```

      {% endcut %}

   1. Copy the following text and paste it into the `requirements.txt` file under **Function code**:

      ```txt
      ydb
      ```

   1. Specify the entry point: `index.handler`.
   1. Set the timeout value to `5`.
   1. Select the `serverless-shortener` service account.
   1. Add environment variables:
      * `endpoint`: Enter a string that is generated from the database protocol and endpoint.

         For example, if the protocol is `grpcs` and the endpoint is `{{ ydb.host-serverless }}:{{ ydb.port-serverless }}`, enter `{{ ydb.ep-serverless }}`.
      * `database`: Enter the previously saved **Database** field value.
      * `USE_METADATA_CREDENTIALS`: Enter `1`.
   1. In the upper-right part of the **Editor** section, click **Create version**.
   1. Under **General information**, enable **Public function**.

   Save the function ID, you'll need it in the next steps.

{% endlist %}

## Publish the service via {{ api-gw-name }} {#api-gw}

To publish the service via {{ api-gw-name }}:

{% list tabs %}

- Management console

   1. Go to your working folder.
   1. In the list of services, select **{{ api-gw-name }}**.
   1. Click **Create API gateway**.
   1. In the **Name** field, enter `for-serverless-shortener`.
   1. Copy and paste the following code into the **Specification** section:

      {% cut "Specification" %}

      ```yaml
      openapi: 3.0.0
      info:
        title: for-serverless-shortener
        version: 1.0.0
      paths:
        /:
          get:
            x-yc-apigateway-integration:
              type: object_storage
              bucket: for-serverless-shortener # <-- name of the bucket
              object: index.html # <-- HTML file name
              presigned_redirect: false
              service_account: <service_account_id> # <-- service-account-ID
            operationId: static
        /shorten:
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function_id> # <-- function ID
            operationId: shorten
        /r/{id}:
          get:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function_id> # <-- function ID
            operationId: redirect
            parameters:
            - description: id of the url
              explode: false
              in: path
              name: id
              required: true
              schema:
                type: string
              style: simple
      ```

      {% endcut %}

      Edit the specification code:
      * Replace `<service_account_id>` with the ID of the previously created service account.
      * Replace `<function_id>` with the ID of the previously created function.
   1. Click **Create**.
   1. Click on the name of the created API gateway.
   1. Copy the `url` value from the specification.

      Use this URL to work with the created service.

{% endlist %}

## Test the URL shortener {#test-shortener}

To check that the service components interact properly:
1. Open the copied URL in the browser.
1. In the input field, enter the URL that you want to shorten.
1. Click **Shorten**.

   You'll see the shortened URL below.
1. Follow this link. As a result, the same page should open as when using the full URL.

## Delete the service components {#clear-out}

To delete all the created service components:

{% list tabs %}

- Management console

   1. Delete the API gateway:
      1. Go to your working folder.
      1. In the list of services, select **{{ api-gw-name }}**.
      1. To the right of the API gateway name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
   1. Delete the function:
      1. Go to your working folder.
      1. In the list of services, select **{{ sf-name }}**.
      1. To the right of the function name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
   1. Delete the database:
      1. Go to your working folder.
      1. In the list of services, select **{{ ydb-name }}**.
      1. To the right of the database name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
   1. Delete the service account:
      1. Go to your working folder.
      1. In the left pane, select **Service accounts**.
      1. To the right of the service account name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
   1. Delete the bucket:
      1. Go to your working folder.
      1. Select **{{ objstorage-name }}**.
      1. Click on the name of the created bucket.
      1. To the right of the bucket name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.
      1. Return to the **Buckets** page.
      1. To the right of the bucket name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Delete**.
      1. Click **Delete**.

{% endlist %}