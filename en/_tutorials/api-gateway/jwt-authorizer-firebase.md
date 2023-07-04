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
   1. In the list of services, select **{{ api-gw-name }}**.
   1. Click Create **API gateway**.
   1. In the **Name** field, enter `jwt-api-gw`.
   1. In the **Specification** section, add a specification:

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

   1. Click **Create**.

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
      1. Select **{{ objstorage-name }}**.
      1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
      1. On the bucket creation page:
         1. Enter the bucket name: `bucket-for-tutorial`.
         1. In the **Object read access** field, select `Public`.
         1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}** to complete the operation.

   {% endlist %}

1. Upload objects to the {{ objstorage-name }} bucket:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to upload objects to.
      1. Select **{{ objstorage-name }}**.
      1. Click `bucket-for-tutorial`.
      1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. In the window that opens, select the objects [generated previously](#project-prepare) in the `build` folder and click **Open**.
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
      1. In the **Link** field, copy your website's URL.

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