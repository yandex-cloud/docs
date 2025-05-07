
# Hosting a static Gatsby website in {{ objstorage-full-name }}

In this tutorial, you will learn how to host your static [Gatsby](https://www.gatsbyjs.com/docs)-based website in [{{ objstorage-name }}](../../storage/) and configure HTTPS access to it using [{{ certificate-manager-full-name }}](../../certificate-manager/).

To create and host a static website in {{ objstorage-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Register a domain name](#register-domain).
1. [Create and configure an {{ objstorage-name }} bucket](#create-and-configure-bucket).
1. [Link the domain name to the bucket](#bind-domain).
1. [Add a TLS certificate to {{ certificate-manager-full-name }}](#issue-certificate).
1. [Configure HTTPS access to the bucket](#configure-https).
1. [Create the website locally](#create-local-site).
1. [Upload your website to the bucket](#upload-site).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Install and configure the AWS CLI

Install and configure the AWS CLI by following [this tutorial](../../storage/tools/aws-cli.md#before-you-begin).

### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for using a public DNS zone and for public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).
* Fee for data storage in {{ objstorage-name }}, data operations, and outbound traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).

## Register a domain name {#register-domain}

1. In your domain registrar's account, register a domain name, e.g., `gatsbytest.ru`.
1. To get access to public zone domain names, delegate the domain. To do this, in your domain registrar's account, specify the DNS server addresses: `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`.

    Delegation does not take effect immediately. It usually takes up to 24 hours for internet service providers to update records.
    You can check the domain delegation using [Whois](https://www.reg.ru/whois/check_site) or the `dig` utility:

    ```bash
    dig +short NS gatsbytest.ru
    ```

    Result:

    ```text
    ns2.{{ dns-ns-host-sld }}.
    ns1.{{ dns-ns-host-sld }}.
    ```

## Create and configure an {{ objstorage-name }} bucket {#create-and-configure-bucket}

To host a static website in the cloud, [create](../../storage/operations/buckets/create.md) a bucket and [configure](../../storage/operations/hosting/setup.md#hosting) it:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_empty-create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, specify the domain name you registered, e.g., `gatsbytest.ru`.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field, specify `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. Select the **Public** [access](../../storage/concepts/bucket.md#bucket-access) type for all operations.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. On the page with the list of buckets, select the bucket you created.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Select `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
  1. In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify the absolute path to the website home page file. For the website from the Gatsby template, specify `index.html`.
  1. Optionaly, in the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify the absolute path to the file to display in the event of `4xx` errors. For the website from the Gatsby template, specify `404.html`.
  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.


- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Create a bucket:

      ```bash
      yc storage bucket create \
        --name <bucket_name> \
        --default-storage-class standard \
        --max-size 1073741824 \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Where `--name` is the name of the bucket. Specify the domain name you registered, e.g., `gatsbytest.ru`.

      Result:

      ```text
      name: gatsbytest.ru
      folder_id: b1g681qpemb4********
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "1073741824"
      acl: {}
      created_at: "2024-09-09T15:23:34.919887Z"
      ```

      For more information about the `yc storage bucket create` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  1. Enable static website hosting in the bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --website-settings '{"index": "index.html", "error": "404.html"}'
      ```

      Where:

      * `--name`: Name of the bucket you created earlier, e.g., `gatsbytest.ru`.
      * `index`: Absolute path to the website home page file. For the website from the Gatsby template, specify `index.html`.
      * `error`: Absolute path to the file the user will see in case of `4xx` errors. For the website from the Gatsby template, specify `404.html`.

      Result:

      ```yaml
      name: gatsbytest.ru
      folder_id: b1g681qpemb4********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "1073741824"
      acl: {}
      created_at: "2024-09-09T15:23:34.919887Z"
      website_settings:
        redirect_all_requests: {}
      ```

      For more information about the `yc storage bucket update` command, see the [CLI reference](../../cli/cli-ref/storage/cli-ref/bucket/update.md).

- AWS CLI {#aws-cli}

  1. Create a bucket:

      ```bash
      aws s3api create-bucket \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --acl public-read
      ```

      Where `--bucket` is the bucket name. Specify the domain name you registered, e.g., `gatsbytest.ru`.

      Result:

      ```text
      {
          "Location": "/gatsbytest.ru"
      }
      ```

  1. Enable static website hosting in the bucket:

      ```bash
      aws s3api put-bucket-website \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --website-configuration '{
          "IndexDocument": {
            "Suffix": "index.html"
          },
          "ErrorDocument": {
            "Key": "404.html"
          }
        }'
      ```

      Where:
      
      * `--bucket`: Name of the bucket you created earlier, e.g., `gatsbytest.ru`.
      * `IndexDocument.Suffix`: Absolute path to the website home page file. For the website from the template, specify `index.html`.
      * `ErrorDocument.Key`: Absolute path to the file the user will see in case of `4xx` errors. For the website from the Gatsby template, specify `404.html`.

- API {#api}

  To create a bucket, use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call, or the [create](../../storage/s3/api-ref/bucket/create.md) S3 API method.

  To set up hosting for a static website, use the [update](../../storage/api-ref/Bucket/update.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource, the [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../storage/s3/api-ref/hosting/upload.md) S3 API method.

{% endlist %}

## Link the domain name to the bucket {#bind-domain}

On the DNS sever, create a public [DNS zone](../../dns/concepts/dns-zone.md) and an [ANAME resource record](../../dns/concepts/resource-record.md#aname) linking your domain name to the bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the bucket you created earlier.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab.
  1. Under **{{ ui-key.yacloud.storage.bucket.website.title_connected-domains }}**, click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.dns.button_zone-create }}** and select the domain zone under the same name as the bucket, e.g., `gatsbytest.ru.` (ending with a period). Click **{{ ui-key.yacloud.common.create }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

      Wait until the record is created.

  1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a public DNS zone named `gatsbytest-ru-zone` in {{ dns-full-name }}:

      ```bash
      yc dns zone create \
        --name gatsbytest-ru-zone \
        --zone <domain_name> \
        --public-visibility
      ```

      Where `--zone` is your domain name, e.g., `gatsbytest.ru.`. The `--zone` parameter value must end with a period. For example, `gatsbytest.ru.` matches the `gatsbytest.ru` domain.

      Result:

      ```text
      id: dns39gihj0ef********
      folder_id: b1g681qpemb4********
      created_at: "2024-09-09T15:23:34.919887Z"
      name: gatsbytest-ru-zone
      zone: gatsbytest.ru.
      public_visibility: {}
      ```

      For more information about the `yc dns zone create` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/create.md).

  1. Create an ANAME resource record in the `gatsbytest-ru-zone` public DNS zone:

      ```bash
      yc dns zone add-records \
        --name gatsbytest-ru-zone \
        --record "@ 600 ANAME <domain_name>.{{ s3-web-host }}"
      ```

      Result:

      ```text
      +--------+----------------+-------+---------------------------------------+-----+
      | ACTION |      NAME      | TYPE  |                 DATA                  | TTL |
      +--------+----------------+-------+---------------------------------------+-----+
      | +      | gatsbytest.ru. | ANAME | gatsbytest.ru.website.yandexcloud.net | 600 |
      +--------+----------------+-------+---------------------------------------+-----+
      ```

      For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  To create a public DNS zone, use the [create](../../dns/api-ref/DnsZone/create.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md) gRPC API call.

  To create a resource record in a DNS zone, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}

## Add a TLS certificate to {{ certificate-manager-full-name }} {#issue-certificate}

To configure access to your website over a secure protocol, get a TLS certificate and configure HTTPS access to your bucket.

{% list tabs group=instructions %}

- Management console {#console}

  1. Add a Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) to {{ certificate-manager-name }} for your domain the website will be using.

      1. In the [management console]({{ link-console-main }}), select the folder to create your certificate in.
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** and select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. In the window that opens, specify a name for the certificate being created in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field, e.g., `gatsbytestcert`.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, specify your domain name, e.g., `gatsbytest.ru`.
      1. Select `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` as the [type of domain rights check](../../certificate-manager/concepts/challenges.md).
      1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

          A new certificate with the `Validating` status will appear in the certificate list. This status means that a Let's Encrypt® certificate was requested and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) for it to be successfully processed.

  1. To successfully issue the certificate, pass the domain rights check:

      1. From the list of certificates, select `gatsbytestcert`.
      1. In the window that opens, under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, select `CNAME record`.
      1. Click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** and in the window that opens, click **{{ ui-key.yacloud.common.create }}**.

      Checking rights for a domain may take from a few minutes to a few days. Wait until the check is complete. As a result, the certificate will be issued and get the `Issued` status.

- {{ yandex-cloud }} CLI {#cli}

  1. Add a Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) to {{ certificate-manager-name }} for your domain the website will be using.

      Run this command:

      ```bash
      yc certificate-manager certificate request \
        --name gatsbytestcert \
        --challenge dns \
        --domains <domain_name>
      ```

      Where `--domains` is the name of your domain for the web server, e.g., `gatsbytest.ru`.

      Result:
      ```bash
      id: fpqbs12t6ion********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-24T14:36:39.299844798Z"
      name: gatsbytestcert
      type: MANAGED
      domains:
        - gatsbytest.ru
      status: VALIDATING
      updated_at: "2023-12-24T14:36:39.299844798Z"
      ```

      For more information about the `yc certificate-manager certificate request` command, see the [CLI reference](../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Save the ID (`id`) of the created certificate as you will need it to pass the domain rights check.

  1. To successfully issue the certificate, pass a domain rights check:

      1. Get values of the resource records required for passing the check:

          ```bash
          yc certificate-manager certificate get \
            --name gatsbytestcert \
            --full
          ```

          Result:

          ```bash
          id: fpq2gpi42teg********
          folder_id: b1gt6g8ht345********
          created_at: "2023-12-24T18:13:45.960Z"
          name: gatsbytestcert
          type: MANAGED
          domains:
            - gatsbytest.ru
          status: VALIDATING
          updated_at: "2023-12-24T18:13:45.960Z"
          challenges:
            - domain: gatsbytest.ru
              type: DNS
              created_at: "2023-12-24T18:13:45.960Z"
              updated_at: "2023-12-24T18:13:49.280Z"
              status: PENDING
              message: Create a record in your DNS provider.
              dns_challenge:
                name: _acme-challenge.gatsbytest.ru
                type: CNAME
                value: fpq2gpi42teg********.cm.yandexcloud.net.
            - domain: gatsbytest.ru
              type: DNS
              created_at: "2023-12-24T18:13:45.960Z"
              updated_at: "2023-12-24T18:13:49.280Z"
              status: PENDING
              message: Create a record in your DNS provider.
              dns_challenge:
                name: _acme-challenge.gatsbytest.ru.
                type: TXT
                value: iiyJJJlsaFIqQ7DMUzira0OKU3iXuaqiN7U********
          ```

          For more information about the `yc certificate-manager certificate get` command, see the [CLI reference](../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

          Save the value of the `value` field from the `CNAME` type section under `challenges.dns_challenge`. You will need this value at the next step.

          A new certificate with the `Validating` status will appear in the certificate list. This status means that a Let's Encrypt® certificate was requested and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) for it to be successfully processed.

      1. Create a CNAME [resource record](../../dns/concepts/resource-record.md) to pass a domain rights check:

          ```bash
          yc dns zone add-records \
            --name gatsbytest-ru-zone \
            --record "_acme-challenge 600 CNAME <dns_challenge_value>"
          ```

          Where `<dns_challenge_value>` is the value saved at the previous step, required to check rights to a domain using a CNAME record.

          Result:

          ```text
          +--------+----------------------------------+-------+------------------------------------------+-----+
          | ACTION |              NAME                | TYPE  |                   DATA                   | TTL |
          +--------+----------------------------------+-------+------------------------------------------+-----+
          | +      | _acme-challenge.gatsbytest.ru.   | CNAME | fpq2gpi42teg********.cm.yandexcloud.net. | 600 |
          +--------+----------------------------------+-------+------------------------------------------+-----+
          ```

          For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

          The domain rights check may take from a few minutes to a few days. Wait until it is complete. As a result, the certificate will be issued and get the `Issued` status.

      1. Make sure that the certificate status has changed to `Issued`:

          ```bash
          yc certificate-manager certificate get \
            --name gatsbytestcert
          ```

          Result:

          ```text
          id: fpqr2j0sdb1n********
          folder_id: b1gt6g8ht345********
          created_at: "2023-12-24T16:38:02.206Z"
          name: gatsbytestcert
          type: MANAGED
          domains:
            - gatsbytest.ru
          status: ISSUED
          issuer: CN=R3,O=Let's Encrypt,C=US
          serial: 4b7d7f0968097ae1a7707854a80********
          updated_at: "2023-12-24T16:46:03.578Z"
          issued_at: "2023-12-24T16:46:03.578Z"
          not_after: "2024-03-23T15:44:59Z"
          not_before: "2023-12-24T15:45:00Z"
          ```

- API {#api}

  1. Add a Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) to {{ certificate-manager-name }} for your domain the website will be using.

      To add a certificate, use the [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md) gRPC API call.

      A new certificate with the `Validating` status will appear in the certificate list. This status means that a Let's Encrypt® certificate was requested and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) for it to be successfully processed.

  1. To successfully issue the certificate, pass a domain rights check:

      To get the information required to pass the rights check for a domain, use the [get](../../certificate-manager/api-ref/Certificate/get.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) gRPC API call with the `view=FULL` flag.

      To create a CNAME resource record in a DNS zone, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}


## Configure HTTPS access to the bucket {#configure-https}.

[Add](../../storage/operations/hosting/certificate.md#cert-manager) a certificate in the bucket settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ objstorage-name }}**.
  1. Click the bucket name, `gatsbytest.ru` in our example.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_https }}** tab.
  1. Click **{{ ui-key.yacloud.storage.bucket.https.button_empty-action }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.https.field_source }}** field, select **{{ ui-key.yacloud.storage.bucket.https.value_method-certificate-manager }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.https.field_certificate }}** field, select the certificate from the list that opens.
  1. Click **{{ ui-key.yacloud.storage.bucket.https.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc storage bucket set-https \
    --name <bucket_name> \
    --certificate-id <certificate_ID>
  ```

  Where:

  * `--name`: Bucket name, `gatsbytest.ru` in our example.
  * `--certificate-id`: Certificate ID in {{ certificate-manager-name }}.

  Result:

  ```text
  source_type: SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER
  certificate_id: fpqe2g0hfr0e********
  ```

- API {#api}

  To link a {{ certificate-manager-name }} TLS certificate to the bucket, use the [setHTTPSConfig](../../storage/api-ref/Bucket/setHTTPSConfig.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource or the [BucketService/SetHTTPSConfig](../../storage/api-ref/grpc/Bucket/setHTTPSConfig.md) gRPC API call.

{% endlist %}

{% note info %}

It may take some time to activate the settings.

{% endnote %}


## Create a website locally {#create-local-site}

For testing purposes, create a website on your local computer using a template from [Gatsby Starter Library](https://www.gatsbyjs.com/starters/).

1. To create a website, run these commands:

    ```bash
    sudo npm install -g gatsby-cli
    gatsby new my-gatsby-project https://github.com/gatsbyjs/gatsby-starter-blog
    ```

1. Navigate to the website directory:

    ```bash
    cd my-gatsby-project
    ```

1. Compile the website for local access:

    ```bash
    gatsby develop
    ```

    Wait for the command to complete.

1. Make sure the website is available at `http://localhost:8000`.



## Upload your website to the bucket {#upload-site}

To build and upload a working version of the website to your bucket, use [AWS CLI](https://aws.amazon.com/ru/cli/) and the [S3 plugin](https://www.gatsbyjs.com/plugins/gatsby-plugin-s3/?=S3) from the Gatsby suite of built-in plugins.


### Install the S3 plugin {#setup-s3-plugin}

1. On your local machine, navigate to the `my-gatsby-project` website directory and run this command:

    ```bash
    npm i gatsby-plugin-s3
    ```

1. Open the `gatsby-config.js` file and add the plugin declaration to the `plugins` section:

    ```text
    plugins: [
        {
          resolve: 'gatsby-plugin-s3',
          options: {
            bucketName: '<bucket_name>',
            region: 'us-east-1',
            customAwsEndpointHostname: '{{ s3-storage-host }}'
          }
        },
        ...
    ]
    ```

    Where `bucketName` is the bucket name, `gatsbytest.ru` in our example.

    {% note info %}

    Do not change the region value as this may lead to an error.

    {% endnote %}

1. Open the `package.json` file and add the `deploy` entry to the `scripts` section:

    ```text
    "scripts": {
        "deploy": "gatsby-plugin-s3 deploy --yes",
        ...
    }
    ```


### Upload your website to the bucket {#upload-site}

1. Compile the website by running this command:

    ```bash
    sudo npm run build
    ```

1. Wait for the compilation to complete and upload your website to the bucket by running the following command:

    ```bash
    npm run deploy
    ```

## Check the result {#check-result}

Once the upload is complete, check that you can access your website using its domain name over the secure protocol. To do this, in your browser, go to `https://<bucket_name>`. In our example, the link is `https://gatsbytest.ru`.

## How to delete the resources you created {#clear-out}

To shut down the resources you created and stop paying for them:

1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
1. Delete the [resource records](../../dns/operations/resource-record-delete.md) and [domain zone](../../dns/operations/zone-delete.md) if required.
1. [Delete](../../certificate-manager/operations/managed/cert-delete.md) the TLS certificate if required.
