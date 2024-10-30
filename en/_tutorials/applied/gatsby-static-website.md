---
title: Hosting a static Gatsby website
description: Creating and hosting a static Gatsby website in {{ yandex-cloud }}
keywords:
  - gatsby
  - gatsby website hosting
  - setting up a gatsby website
  - gatsby website
---

# Hosting a static Gatsby website in {{ objstorage-full-name }}

In this tutorial, you will learn how to host your static [Gatsby](https://www.gatsbyjs.com/docs)-based website in {{ objstorage-name }} and configure HTTPS access to it.

To create and host a static website in {{ objstorage-name }}:

1. [Prepare your cloud](#before-you-begin).
1. [Register a domain name](#register-domain).
1. [Create the website locally](#create-local-site).
1. [Create and configure an {{ objstorage-name }} bucket](#create-bucket).
1. [Upload your website to the bucket](#upload-site).
1. [Configure HTTPS access](#configure-https).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

Infrastructure support costs include fees for storing data in {{ objstorage-name }}, data operations, and outbound traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

## Register a domain name {#register-domain}

1. In your domain registrar's account, register a domain name, e.g., `gatsbytest.ru`.
1. To get access to public zone domain names, delegate the domain. To do this, in your domain registrar's account, specify the DNS server addresses: `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`.

	Delegation does not take effect immediately. It usually takes up to 24 hours for the internet service providers to update records.
	You can check the domain delegation using [Whois](https://www.reg.ru/whois/check_site) or the `dig` utility:

	```bash
	dig +short NS gatsbytest.ru
	```

	Result:

	```
	ns2.{{ dns-ns-host-sld }}.
	ns1.{{ dns-ns-host-sld }}.
	```

## Create the website locally {#create-local-site}

For testing purposes, create a website on your local computer using a template from the [Gatsby Starter Library](https://www.gatsbyjs.com/starters/).

1. To create the website, run these commands:

	```
	npm install -g gatsby-cli
	gatsby new my-gatsby-project https://github.com/gatsbyjs/gatsby-starter-blog
	cd gatsby-starter-blog
	```

1. Make sure the website has been created. To do this, run the following command:

	```
	gatsby develop
	```

	Wait for the command to run and check that the website is available at this address:

	```
	http://localhost:8000
	```

## Create and configure an {{ objstorage-name }} bucket {#create-bucket}

### Create a bucket

To host your static website in the cloud, create a bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a bucket in.
  1. Select **{{ objstorage-name }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. On the bucket creation page:
      1. Specify the domain name you registered, e.g., `gatsbytest.ru`, as the name of your bucket.
      1. For testing purposes, specify the minimum bucket size.
      1. Select the **Public** [access](../../storage/concepts/bucket.md#bucket-access) type for all operations.
      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Create a bucket in the default folder:

      ```bash
      yc storage bucket create \
         --name <bucket_name> \
         --default-storage-class <storage_class> \
         --max-size <maximum_bucket_size> \
         --public-read \
         --public-list \
         --public-config-read
      ```

      Where:

      * `--name`: Bucket name. Specify the domain name you registered, e.g., `gatsbytest.ru`.
      * `--default-storage-class`: [Storage class](../../storage/concepts/storage-class.md). Possible values:
         * `standard`: Standard storage.
         * `cold`: Cold storage.
         * `ice`: Ice storage.
      * `--max-size`: Maximum bucket size, in bytes (`0` for unlimited).
      * `--public-read`: Flag to enable public access to read bucket objects.
      * `--public-list`: Flag to enable public access to view the list of bucket objects.
      * `--public-config-read`: Flag to enable public access to read bucket settings.

- AWS CLI {#aws-cli}

   If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).

   In the terminal, run the command below by specifying the bucket name and the {{ objstorage-name }} endpoint:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
      s3 mb s3://<bucket_name>
   ```
   Where:

   * `--name`: Bucket name. Specify the domain name you registered, e.g., `gatsbytest.ru`.

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the resources you want to create:

     ```
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
       required_version = ">= 0.13"
     }

     provider "yandex" {
       token     = "<IAM_or_OAuth_token>"
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_iam_service_account" "sa" {
       name = "<service_account_name>"
     }

     // Assigning a role to a service account
     resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
       folder_id = "<folder_ID>"
       role      = "storage.editor"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Creating a static access key
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     // Creating a bucket using a key
     resource "yandex_storage_bucket" "test" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<bucket_name>"
     }
     ```

     Where:

     * `yandex_iam_service_account`: Description of the service account to create and use the bucket:
       * `name`: Service account name
     * `--description`: Secret description
       * `bucket`: Bucket name. Specify the domain name you registered, e.g., `gatsbytest.ru`.


  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:
        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy cloud resources.

     1. Run this command:
        ```
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

{% endlist %}

### Configure your bucket

To configure a bucket for static website hosting:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure hosting for.
  1. Go to the ![website](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Under **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**:
      * In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the file of the website home page. For the website from the Gatsby template, specify `index.html`.
      * Optionally, in the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, you can specify the absolute path to the file displayed on 4xx errors. For the website from the Gatsby template, specify `404.html`.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a hosting settings file in JSON format. Here is an example:

     ```json
     {
       "index": "index.html",
       "error": "404.html"
     }
     ```

     Where:

     * `index`: Absolute path to the file of the website home page.
     * `error`: Absolute path to the file the user will see in case of 4xx errors.

  1. Run the following command:

     ```bash
     yc storage bucket update --name <bucket_name> \
       --website-settings-from-file <path_to_file>
     ```

     Where:
     * `--name`: Bucket name, `gatsbytest.ru` in our example.
     * `--website-settings-from-file`: Path to the hosting settings file.

  To make sure the bucket description now contains the hosting settings, run this command:

  ```bash
  yc storage --name <bucket_name> bucket get --full
  ```

  Result:

  ```text
  website_settings:
    index: index.html
    error: error404.html
    redirect_all_requests: {}
  ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Before you start, retrieve the [static access keys](../../iam/operations/sa/create-access-key.md): a secret key and a key ID used for authentication in {{ objstorage-short-name }}.


  1. In the configuration file, describe the parameters of the resources you want to create:


     ```hcl
     provider "yandex" {
       token     = "<OAuth>"
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_storage_bucket" "test" {
       access_key = "<static_key_ID>"
       secret_key = "<secret_key>"
       bucket     = "<bucket_name>"
       acl        = "public-read"

       website {
         index_document = "index.html"
         error_document = "404.html"
       }

     }
     ```

     Where:

     * `access_key`: Static access key ID.
     * `secret_key`: Private access key value.
     * `bucket`: Bucket name.
     * `acl`: [ACL](../../storage/concepts/acl.md#predefined-acls) access management parameters.
     * `website`: Website parameters:
       * `index_document`: Absolute path to the website home page file. This is a required parameter.
       * `error_document`: Absolute path to the file the user will see in case of `4xx` errors. This is an optional parameter.

  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy cloud resources.

     1. Run this command:

     ```
     terraform apply
     ```

     1. Confirm that you want to create the resources.

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

  To set up hosting for a static website, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../storage/s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

### Link the domain name

On the DNS sever, create a public [DNS zone](../../dns/concepts/dns-zone.md) and a [resource record](../../dns/concepts/resource-record.md) which links your domain name to the bucket:

{% list tabs group=instructions %}

- {{ dns-full-name }} {#dns}

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to use your own domain for.
   1. Go to the ![website](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
   1. In **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**, under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select the domain zone of the same name with the bucket, e.g., `gatsbytest.ru.` (ending with a period). Click **{{ ui-key.yacloud.common.create }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

{% endlist %}

## Upload your website to the bucket {#upload-site}

To build and upload a working version of the website to your bucket, use [AWS CLI](https://aws.amazon.com/ru/cli/) and the [S3 plugin](https://www.gatsbyjs.com/plugins/gatsby-plugin-s3/?=S3) from the Gatsby suite of built-in plugins.

### Set up the AWS CLI

1. To install the AWS CLI, use the [instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) posted on the developer's site.
1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign the service account the roles](../../iam/operations/sa/assign-role-for-sa.md) required for your project. For more information about roles, see the [{{ iam-name }} documentation](../../iam/concepts/access-control/roles.md).
1. [Create a static access key](../../iam/operations/sa/create-access-key.md).
1. To configure the AWS CLI, type the `aws configure` command. The command will request values for the following parameters:
   - `AWS Access Key ID`: ID of the static key created in the previous step.
   - `AWS Secret Access Key`: Contents of the static access key.
   - `Default region name`: `{{ region-id }}`.

   {% note info %}

   To work with {{ objstorage-name }}, always specify `{{ region-id }}` as the region.
   An incorrectly specified region will lead to an authorization error.

   {% endnote %}

1. Leave the other parameter values unchanged.

### Install the S3 plugin

1. On your local machine, go to the `gatsby-starter-blog` website folder and run this command:

   ```
   npm i gatsby-plugin-s3
   ```

1. Open the `gatsby-config.js` file and add the plugin declaration to the `plugins` section:

   ```
   plugins: [
      {
        resolve: 'gatsby-plugin-s3',
        options: {
          bucketName: '<bucket_name>',
          region: 'us-east-1',
          customAwsEndpointHostname: 'storage.yandexcloud.net'
        }
      },
      ...
   ]
   ```

   Where `<bucket_name>` is the bucket name, `gatsbytest.ru` in our example.

   {% note info %}

   Do not change the region value as this may lead to an error.

   {% endnote %}

1. Open the `package.json` file and add the `deploy` entry to the `scripts` section:

   ```
   "scripts": {
   	"deploy": "gatsby-plugin-s3 deploy --yes",
      ...
   }
   ```

### Upload your website to the bucket

1. Compile the website by running this command:

   ```
   sudo npm run build
   ```

1. Wait for the compilation to complete and upload your website to the bucket by running the following command:

   ```
   sudo npm run deploy
   ```

1. Once the upload is complete, check that you can access your website using its domain name. Open your browser and go to:

   ```
   http://<bucket_name>
   ```

   Where `<bucket_name>` is the bucket name, `gatsbytest.ru` in our example.


## Configure HTTPS access {#configure-https}

To configure access to your website over a secure protocol, get a security certificate and configure HTTPS access to the bucket.

### Get Let's Encrypt® certificates

1. Add a new Let's Encrypt® certificate:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to add a certificate.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
      1. In the menu that opens, select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. In the window that opens, enter a name for your certificate in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
      1. (Optional) In the **Description** field, enter a description for the certificate.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, enter the name of the bucket where your website resides. In our example, it is `gatsbytest.ru`.
      1. Select the [type of domain rights check](../../certificate-manager/concepts/challenges.md): `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`.
      1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

   - CLI {#cli}

      1. Run this command:

         ```bash
         yc certificate-manager certificate request \
            --name gatsbycert \
            --domains gatsbytest.ru
         ```

         Where:
         * `--name`: Certificate name
         * `--domains`: Certificate domains

   - {{ TF }} {#tf}

      1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

         ```hcl
         resource "yandex_cm_certificate" "le-certificate" {
            name    = "<certificate_name>"
            domains = ["<domain>"]

            managed {
            challenge_type = "HTTP"
            }
         }
         ```

         Where:
         * `domains`: List of domains you need to create a certificate for. In our example, it is `gatsbytest.ru`.
         * `challenge_type`: [Type of domain rights check](../../certificate-manager/concepts/challenges.md) the domain owner must [pass](../../certificate-manager/operations/managed/cert-validate.md).

      1. Create resources:

         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      A certificate will then be created in the specified [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). You can check the new certificate and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc certificate-manager certificate get <certificate_name>
      ```

   - API {#api}

      To add a certificate, use the [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md) gRPC API call.

   {% endlist %}

   The new certificate will appear in the certificate list with the `Validating` status. This status means that a request to issue a Let's Encrypt® certificate was created and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) to process it successfully.

1. Get the information required to complete the domain rights check:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you added the [certificate](../../certificate-manager/concepts/managed-certificate.md) to.
     1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
     1. Select the certificate to check from the list and click it.
     1. In the **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** section of the window that opens, you can find the details you need to pass the domain rights check: **File location URL** and **Contents**.

   - CLI {#cli}

     1. Run this command:

        ```bash
        yc certificate-manager certificate get \
          --id fpq6gvvm6piu******** \
          --full
        ```

        Where:

        * `--id`: [Certificate](../../certificate-manager/concepts/managed-certificate.md) ID.
        * `--full`: Show a list of active domain rights checks.

        Result:

        ```text
        id: fpq6gvvm6piu********
        folder_id: b1g7gvsi89m3********
        created_at: "2024-03-27T08:49:11.533771Z"
        name: gatsbycert
        type: MANAGED
        domains:
        - gatsbytest.ru
        status: VALIDATING
        updated_at: "2020-09-15T08:49:11.533771Z"
        challenges:
        - domain: gatsbytest.ru
          type: HTTP
          created_at: "2024-03-27T12:20:32.326Z"
          updated_at: "2024-03-27T12:30:16.709Z"
          status: PENDING
          message: Create a file in your web server's base directory.
          http_challenge:
            url: http://gatsbytest.ru/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
            content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYP********
        ```

   - API {#api}

     To get the information required to pass the domain rights check, use the [get](../../certificate-manager/api-ref/Certificate/get.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) gRPC API call with the `view=FULL` flag.

   {% endlist %}

1. On your local computer, create subfolders for the validation file in the `gatsby-starter-blog` website folder. For this, follow these steps:

   ```
   mkdir .well-known
   cd .well-known
   mkdir acme-challenge
   ```

1. Create a validation file based on the information you got. To do this, copy the final part of the validation file URL and use it as a name to create a file in the `acme-challenge` folder:

   ```
   cd acme-challenge
   nano <file_name>
   ```

   Where <file_name> is the final part of the validation file URL.
   
   For example, if this is your URL: 
   ```
   http://gatsbytest.ru/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
   ```

   Run the following: 
   ```
   nano 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
   ```

   Save the validation file contents to the file.

1. When you pass the domain rights check, the domain check status under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** will change to `Valid`. The certificate will be issued and its status will change to `Issued`.

### Configure HTTPS access to your bucket

1. Add the certificate in the bucket's HTTPS access settings:

   {% list tabs group=instructions %}

   - Management console {#console}

       1. In the [management console]({{ link-console-main }}), select the folder.
       1. Select **{{ objstorage-name }}**.
       1. Click the bucket name, `gatsbytest.ru` in our example.
       1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
       1. In the right-hand panel that opens, click **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
       1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
       1. In the **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** field, select the certificate from the list that opens.
       1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

   - {{ yandex-cloud }} CLI {#cli}

      Run the following command:

      ```bash
      yc storage bucket set-https --name <bucket_name> --certificate-id <certificate_ID>
      ```

      Where:
      * `--name`: Bucket name, `gatsbytest.ru` in our example.
      * `--certificate-id`: Certificate ID in {{ certificate-manager-name }}.

      Result:

      ```text
      source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
      certificate_id: fpqe2g0hfr0e********
      ```

   - {{ TF }} {#tf}

     To select a certificate from {{ certificate-manager-name }}:

     1. Open the {{ TF }} configuration file and add the `https` section to the bucket description:

        ```hcl
        ...
        resource "yandex_storage_bucket" "b" {
          bucket = "<bucket_name>"

          https {
            certificate_id = "<certificate_ID>"
          }
        }
        ...
        ```

        Where:
        * `bucket`: Bucket name, `gatsbytest.ru` in our example.
        * `certificate_id`: certificate ID in {{ certificate-manager-name }} that will be used for the bucket.

     1. Check the configuration using this command:

        ```bash
        terraform validate
        ```

        If the configuration is correct, you will get this message:

        ```bash
        Success! The configuration is valid.
        ```

     1. Run this command:

        ```bash
        terraform plan
        ```

        The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

     1. Apply the configuration changes:

        ```bash
        terraform apply
        ```

     1. Confirm the changes: type `yes` into the terminal and press **Enter**.

        You can use the [management console]({{ link-console-main }}) to check the selected certificate.

   - API {#api}

     To select a certificate from {{ certificate-manager-name }}, use the [setHTTPSConfig](../../storage/api-ref/Bucket/setHTTPSConfig.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource or the [BucketService/SetHTTPSConfig](../../storage/api-ref/grpc/Bucket/setHTTPSConfig.md) gRPC API call.

   {% endlist %}

1. Check that you can now access your website over a secure protocol. Go to this address:

   ```
   https://<bucket_name>
   ```

   Where `<bucket_name>` is the bucket name, `gatsbytest.ru` in our example.

{% note info %}

It may take some time to activate the settings.

{% endnote %}

## How to delete the resources you created {#clear-out}

To shut down the created resources and stop paying for them:

1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete the bucket](../../storage/operations/buckets/delete.md).
