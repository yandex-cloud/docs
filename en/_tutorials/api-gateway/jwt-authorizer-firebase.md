# Deploying a web app with JWT authorization in {{ api-gw-name }} and authentication in Firebase

In this tutorial, you will learn how to implement authentication and authorization based on [OAuth 2.0](https://oauth.net/2/) and [OpenID Connect](https://openid.net/connect/) protocols in your web app. For authentication, we will use [Google OAuth](https://developers.google.com/identity/protocols/oauth2) and [Firebase](https://firebase.google.com/docs). Authorization will be performed on the {{ api-gw-name }} side using a JWT authorizer. A web app will include:

* Firebase external authentication service.
* Simple REST API deployed as {{ api-gw-name }}.
* Static website deployed in a {{ objstorage-name }} bucket.

To deploy your web app:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a project and set up Google OAuth in Google Cloud](#create-google-cloud-project).
1. [Set up authentication in Firebase](#create-firebase-project).
1. [Complete Google resource configuration](#google-oauth-setup).
1. [Create an API gateway](#create-gateway).
1. [Create web app files](#project-prepare).
1. [Deploy {{ yandex-cloud }} resources and upload the web app to a bucket](#deploy).
1. [Test the created app](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for running the web app includes:
* Fee for data storage in a bucket and operations with data (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for using the API gateway (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).


## Create a project and set up Google OAuth in Google Cloud {#create-google-cloud-project}

Set up Google OAuth:

1. Log in to the [Google Cloud Console](https://console.cloud.google.com/) and create a new project.
1. In the **API & Services** tab, go to **OAuth consent screen**, select `External` as the app type and click **Create**.
1. Under **OAuth consent screen**, enter the app name and your email address in the **User support email** and **Developer contact information** fields. Click **Save and continue**.
1. Under **Scopes**, click **Add or Remove Scopes** and add the `openid`, `/auth/userinfo.email`, and `/auth/userinfo.profile` scopes. Click **Update** → **Save and continue**.
1. Under **Test users**, specify your email address. Finish creating your app.
1. In the **API & Services** → **Credentials** tab, click **Create credential** and select `OAuth client ID`. Specify `Web application` as the app type.
1. Confirm the app creation and save the `Client ID` and `Client secret`.

## Set up authentication in Firebase {#create-firebase-project}

1. Log in to the [Firebase Console](https://console.firebase.google.com) and create a new project.
1. Under **Authentication** → **Sign-in method** → **Custom providers**, select `OpenID Connect`.
1. Confirm the `OpenID Connect` selection.
1. Enter the provider name and the `Client ID` and `Client secret` you obtained in the [previous step](#create-google-cloud-project). Fill in the **Issuer** field (for Google OAuth, set it to `https://accounts.google.com`).
1. Save the `Callback URL` and complete the OpenID setup.

## Complete Google resource configuration {#google-oauth-setup}

Google Console:

1. In the **API & Services** → **Credentials** tab, click the name of the created client.
1. Add the Callback URL from Firebase you obtained in the [previous step](#create-firebase-project) to the **Authorized redirect URIs** list. Save your changes.

Firebase:

1. Go to **Project Overview** → **Project settings**.
1. Create a web app in the `General` tab. Specify the app name and click **Register App**.
1. Save the app configuration generated under `firebaseConfig`.

## Create an API gateway {#create-gateway}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `jwt-api-gw`.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add a specification:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0

      paths:
        /:
          get:
            x-yc-apigateway-integration:
              type: http
              url: https://oauth2.googleapis.com/tokeninfo
              method: GET
              query:
                id_token: '{token}'
            parameters:
              - name: token
                in: query
                required: true
                schema:
                  type: string
            security:
              - OpenIdAuthorizerScheme: [ ]

      components:
        securitySchemes:
          OpenIdAuthorizerScheme:
            type: openIdConnect
            x-yc-apigateway-authorizer:
              type: jwt
              jwksUri: https://www.googleapis.com/oauth2/v3/certs
              identitySource:
                in: query
                name: token
              issuers:
                - https://accounts.google.com
              requiredClaims:
                - email
      ```

   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Save the following specification to `jwt-auth.yaml`:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0

      paths:
        /:
          get:
            x-yc-apigateway-integration:
              type: http
              url: https://oauth2.googleapis.com/tokeninfo
              method: GET
              query:
                id_token: '{token}'
            parameters:
              - name: token
                in: query
                required: true
                schema:
                  type: string
            security:
              - OpenIdAuthorizerScheme: [ ]

      components:
        securitySchemes:
          OpenIdAuthorizerScheme:
            type: openIdConnect
            x-yc-apigateway-authorizer:
              type: jwt
              jwksUri: https://www.googleapis.com/oauth2/v3/certs
              identitySource:
                in: query
                name: token
              issuers:
                - https://accounts.google.com
              requiredClaims:
                - email
      ```

   1. Run this command:

      ```bash
      yc serverless api-gateway create \
        --name jwt-api-gw \
        --spec=jwt-auth.yaml
      ```

      Where:

      * `name`: API gateway name
      * `spec`: Specification file

      Result:

      ```text
      done (29s)
      id: d5dug9gkmu187i********
      folder_id: b1g55tflru0ek7********
      created_at: "2020-06-17T09:20:22.929Z"
      name: jwt-api-gw
      status: ACTIVE
      domain: d5dug9gkmu187i********.apigw.yandexcloud.net
      log_group_id: ckghq1hm19********
      ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   1. In the configuration file, describe the API gateway parameters:

      ```hcl
      resource "yandex_api_gateway" "jwt-api-gateway" {
        name        = "jwt-api-gw"
        spec        = <<-EOT
          openapi: 3.0.0
          info:
            title: Sample API
            version: 1.0.0
          paths:
            /:
              get:
                x-yc-apigateway-integration:
                  type: http
                  url: https://oauth2.googleapis.com/tokeninfo
                  method: GET
                  query:
                    id_token: '{token}'
                parameters:
                  - name: token
                    in: query
                    required: true
                    schema:
                      type: string
                security:
                  - OpenIdAuthorizerScheme: [ ]
          components:
            securitySchemes:
              OpenIdAuthorizerScheme:
                type: openIdConnect
                x-yc-apigateway-authorizer:
                  type: jwt
                  jwksUri: https://www.googleapis.com/oauth2/v3/certs
                  identitySource:
                    in: query
                    name: token
                  issuers:
                    - https://accounts.google.com
                  requiredClaims:
                    - email
        EOT
      }
      ```

      Where:

      * `name`: API gateway name
      * `spec`: API gateway specification

      For more information about the `yandex_api_gateway` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

   This will create an API gateway in the specified folder.

- API

   To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/apigateway_service.md#Create) gRPC API call.

{% endlist %}

## Create web app files {#project-prepare}

1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-serverless-apigw-jwt-authorizer-firebase) with the app source code:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-serverless-apigw-jwt-authorizer-firebase.git
   ```

1. Open the `src/App.js` file using a text editor and specify the following parameters:

   * `firebaseConfig`: Firebase configuration for your app that you saved when [completing Google resource configuration](#google-oauth-setup).
   * `providerId`: ID of the OpenID Connect provider previously created in Firebase, in `oidc.<provider_name>` format.
   * `apiGwDomain`: Service domain of the previously created API gateway.

1. [Install Node.js](https://nodejs.org/en/download) and the NPM package manager. The package manager will be installed automatically during Node.js installation.
1. In the folder with your app:

   1. Install react-scripts in your project and add it to `devDependencies` in the `package.json` file:

      ```bash
      npm install react-scripts --save-dev
      ```

   1. Run your app build:

      ```bash
      npm run build
      ```

      Command result:

      ```bash
      File sizes after gzip:

        96.05 kB  build\static\js\main.de7af71f.js
        672 B     build\static\css\main.021818e9.css

      The project was built assuming it is hosted at /.
      You can control this with the homepage field in your package.json.

      The build folder is ready to be deployed.
      ```

## Deploy {{ yandex-cloud }} resources and upload the web app to a {{ objstorage-name }} bucket {#deploy}

Deploy a static website:

1. Create a {{ objstorage-name }} bucket:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
      1. On the bucket creation page:
         1. Enter the bucket name: `bucket-for-tutorial`.
         1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** field, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
         1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Run the following command:

         ```bash
         yc storage bucket create \
         --name bucket-for-tutorial \
         --public-read
         ```

         Where:

         * `--name`: Bucket name.
         * `--public-read`: Flag to enable public read access to bucket objects.

         Result:

         ```bash
         name: bucket-for-tutorial
         folder_id: b1gmit33********
         anonymous_access_flags:
           read: false
           list: false
         default_storage_class: STANDARD
         versioning: VERSIONING_DISABLED
         acl: {}
         created_at: "2023-06-08T11:57:49.898024Z"
         ```

   - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the resource parameters:

         ```hcl
         ...
         resource "yandex_iam_service_account" "sa" {
           name = "<service_account_name>"
         }

         resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
           folder_id = "<folder_ID>"
           role      = "storage.editor"
           member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
         }

         resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
           service_account_id = yandex_iam_service_account.sa.id
           description        = "static access key for object storage"
         }

         resource "yandex_storage_bucket" "test" {
           access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
           secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
           bucket     = "bucket-for-tutorial"
           acl        = "public-read"
         }
         ...
         ```

         Where:

         * `yandex_iam_service_account`: Description of the service account that will create and use a bucket:
            * `name`: Service account name
         * `yandex_storage_bucket`: Bucket description:
            * `bucket`: Bucket name
            * `acl`: Bucket access settings

         For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

      1. Create resources:

         {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

      This will create a bucket in the specified folder.

   - API

      To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/bucket_service.md#Create) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

   {% endlist %}

1. Upload objects to the {{ objstorage-name }} bucket:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to upload objects to.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Click `bucket-for-tutorial`.
      1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}** and select the [previously generated](#project-prepare) objects in the `build` folder.
      1. The management console displays all the objects selected for uploading and prompts you to select a [storage class](../../storage/concepts/storage-class.md). The default storage class is defined in the [bucket settings](../../storage/concepts/bucket.md#bucket-settings).
      1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
      1. Refresh the page.

      In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.

   {% endlist %}

1. Set up static website hosting:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), go to `bucket-for-tutorial`.
      1. Go to ![website](../../_assets/storage/website.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
      1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
         * In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the file of the website home page: `index.html`.
         * In the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify the absolute path to the file to display for 4xx errors: `error.html`.
      1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.
      1. In the **{{ ui-key.yacloud.storage.bucket.website.field_link }}** field, copy your website's URL.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create a hosting configuration file named `setup.json`:

         ```json
         {
           "index": "index.html",
           "error": "error404.html"
         }
         ```

         Where:

         * `index`: Absolute path to the file of the website home page.
         * `error`: Absolute path to the file displayed to the user upon a `4xx` error.

      1. Run this command:

         ```bash
         yc storage bucket update --name bucket-for-tutorial \
           --website-settings-from-file setup.json
         ```

         Where:
         * `--name`: Bucket name.
         * `--website-settings-from-file`: Path to the redirect configuration file.

         Result:

         ```text
         name: my-bucket
         folder_id: b1gjs8dck********
         default_storage_class: STANDARD
         versioning: VERSIONING_SUSPENDED
         max_size: "10737418240"
         acl: {}
         created_at: "2022-12-14T08:42:16.273717Z"
         ```

   - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      To set up a redirect for all requests:

      1. Open the {{ TF }} configuration file and add the `redirect_all_requests_to` parameter to the `yandex_storage_bucket` resource description.

         ```hcl
         ...
         resource "yandex_storage_bucket" "test" {
           access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
           secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_ke
           bucket     = "bucket-for-tutorial"
           acl        = "public-read"

           website {
             index_document = "index.html"
             error_document = "error.html"
           }
         }
         ...
         ```

         Where:

         * `website`: Website parameters:
            * `index_document`: Absolute path to the file of the website home page. This is a required parameter.
            * `error_document`: Absolute path to the file displayed to the user upon a `4xx` error. This is an optional parameter.

         For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}//storage_bucket#static-website-hosting).

      1. Create resources:

         {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

      This will set up hosting in the bucket.

   - API

      To set up hosting for a static website, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Update](../../storage/api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../storage/s3/api-ref/hosting/upload.md) S3 API method.

   {% endlist %}

1. Add this URL to the list of authorized domains in Firebase:

   1. Go to **Authentication** → **Settings** → **Authorized domains**.
   1. Click **Add domain** and paste the copied URL.

## Test the created app {#test}

1. Access the static website via the URL obtained when [setting up website hosting](#deploy) and click **Call {{ api-gw-short-name }}** without authorization. Make sure the response is `Got error: Request failed with status code 401`.
1. To log in to the website, click **Log in**.
1. Once authorized, click **Call {{ api-gw-short-name }}** again. Make sure the call is handled successfully and information about the authorized user is returned.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
1. [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
1. [Delete the project in Firebase](https://support.google.com/firebase/answer/9137886?hl=en).
1. [Delete the project in Google Cloud](https://cloud.google.com/go/getting-started#clean-up).