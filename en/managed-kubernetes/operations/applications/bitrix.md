---
title: Installing Bitrix
description: Follow this guide to install the Bitrix application in your {{ managed-k8s-name }} cluster.
---

# Installing Bitrix

**Bitrix** is an application that prepares and deploys environments for standard installation of 1C Bitrix products in a {{ managed-k8s-full-name }} cluster.

There are two available environment types:

* Admin environment, where you can:

   * Deploy Bitrix products from scratch or from backups.
   * Modify Bitrix components using the admin panel.
   * Develop and test your products.

   Admin environment supports the following tools:

   * Git client.
   * Running agents in cron jobs.
   * Queue server.
   * Sphinx morphological search.
   * Tools for collecting PHP and Nginx metrics.

   You can set up the environment both from {{ marketplace-full-name }} and using a Helm chart.

   You can use the admin environment to install stable versions of Bitrix applications.

* Product environment, which supports all admin features but does not allow you to modify Bitrix components. There is no admin panel in the product environment.

  You can run multiple `Deployment` replicas in your product environment, which provides fault tolerance.

  To set up the product environment, you will need to prepare images based on the provided ones by adding the relevant Bitrix files.

  You can only set up the product environment using a Helm chart.

{% note info %}

The admin and product environments share these assets:

* {{ MY }} database
* {{ objstorage-name }} bucket

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. In your {{ managed-k8s-name }} cluster, create a new [namespace](../../concepts/index.md#namespace) named `bitrix-space` for the admin environment, and `bitrix-prod`, for the product environment.
1. If you want to use your own certificate for the Bitrix website, create a `Secret` resource in both environments’ namespaces as follows:

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: bitrix-tls-secret
      namespace: <namespace>
    type: kubernetes.io/tls
    data:
      tls.crt: <Base64_encoded_certificate>
      tls.key: <Base64_encoded_certificate_private_key>
    ```

1. [Create a bucket](../../../storage/operations/buckets/create.md) to house the shared project directories, `upload` and `backup`.
1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.editor` [role](../../../iam/concepts/access-control/roles.md) for the folder where your bucket is located.
1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md) for the service account and save its ID and secret key.
1. [Create a {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) cluster with the following parameters:

   * **Network**: Select the network hosting your {{ managed-k8s-name }} cluster.
   * Under **Hosts**, check that **Public access** is disabled for all hosts.
   * **{{ ui-key.yacloud.mdb.forms.section_settings }}**:
     * **Innodb Flush Log At Trx Commit**: `2`
     * **Innodb Strict Mode**: `Disabled`
     * **Sync Binlog**: `1000`
     * **Transaction Isolation**: `read committed`

1. If you need to use the queue server (Bitrix Push and Pull module), create a secret key for it:

    ```shell
    docker container run --rm \
        --name push_server_key_generate alpine:3.21 \
        sh -c "(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 128) && echo ''"
    ```

    Save the command output.

1. If you are going to use the product environment, prepare {{ container-registry-name }} resources to push the required Docker images:

   1. Create a container registry:

      ```bash
      yc container registry create --name yc-auto-cr
      ```

   1. Configure a [Docker credential helper](../../../container-registry/operations/authentication.md#cred-helper). It enables you to use private {{ yandex-cloud }} registries without running the `docker login` command.

      To configure a credential helper, run this command:

      ```bash
      yc container registry configure-docker
      ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Installation from {{ marketplace-name }} {#marketplace-install}

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the name of the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster) you need and select the ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Bitrix](/marketplace/products/yc/bitrix-env) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select the namespace you created earlier.
   * **Application name**: Specify the application name.
   * **Volume size**: Specify the [volume](../../concepts/volume.md) size for storing Bitrix files, in `Gi`.
   * **Storage class**: Select the storage class for the volume.
   * **Project domain name**: Specify the full project domain name.
   * **Balancer IP address**: Specify the balancer IP address if you already reserved one.
   * **Traffic management policy**: Select a [policy for routing external traffic]({{ k8s-api-link }}#servicespec-v1-core).
   * **Use certmanager**: Enable to automatically get a Let's Encrypt certificate.

     To successfully get a certificate, [register a public domain zone](../../../dns/operations/zone-create-public.md) and delegate your domain. A certificate will be issued for the domain in this zone after you pass the DNS-01 challenge.

   * **Email address to get notifications from Let's Encrypt**: If you enabled **Use certmanager**, specify the email address for Let's Encrypt® notifications.
   * **Issuer name**: If you enabled **Use certmanager**, specify the name of the resource, `ClusterIssuer` or `Issuer`, to automatically get SSL or TLS certificates.
   * **Secret containing tls.crt and tls.key**: If not using certmanager, specify the name of the secret you created previously.
   * **Configure Git**: Enable if you want to use a Git repo.

     If this is the case, specify the Git repo properties in the relevant fields:

     * **Git repository address**: Repo address as an SSH URL.
     * **Branch**: Working branch of your Git repo.
     * **User**: Git repo user name.
     * **Email**: Git repo user email.
     * **Access key**: Specify Base64-encoded contents of the repo access public key.

   * **Use cron to run agents**: Enable to run Bitrix agents on the schedule specified in `ConfigMap` `<app_name>-bitrix-space-cron`. By default, `ConfigMap` enables running agent jobs every minute, and backup jobs, every 24 hours. You can also add your own schedule.
   * **Use queue server**: Enable to use a queue server (the Bitrix Push and Pull module). The `Deployment` resource for server deployment will start in a separate pod.
   * **Secret key**: If you enabled **Use queue server**, provide the secret key you created previously.
   * **Use Sphinx**: Enable to use Sphinx, a full-text search engine. The `Deployment` resource for Sphinx deplyment will start in a separate pod.
   * **Store cache in Redis**: Enable to store Bitrix cache in Redis. In this case, the cluster will have a separate `StatefulSet` in the app’s namespace: `<app_name>-redis-*`. Do not enable this setting in the admin environment as this may lead to degraded performance.
   * **Export PHP metrics**: Select to enable PHP metrics.
   * **Export NGINX metrics**: Select to enable NGINX metrics.
   * **Storage class for S3**: `csi-s3`, default.
   * **S3 key ID**, **S3 secret key**: Specify the ID and secret key of the static key you [got previously](#before-you-begin).
   * **S3 bucket**: Specify the name of the {{ objstorage-name }} bucket you [created previously](#before-you-begin).
   * **Upload directory size**: Specify the size for the upload directory in the bucket, in `Gi`.
   * **Backup directory size**: Specify the size for the backup directory in the bucket, in `Gi`.
   * **SMTP server**, **SMTP port**, **Mailbox user**, **Mailbox password**: Specify the mail server connection properties.
   * **{{ MY }} host**, **Database user**, **Database user password**, **Database**: Specify properties for connection to the {{ MY }} database in the {{ mmy-name }} cluster you [created previously](#before-you-begin).
   * **NGINX version**: Select the NGINX version for Bitrix.
   * **PHP version**: Select the PHP version for Bitrix.
   * **Use bitrixsetup.php**: Select to install Bitrix from scratch.
   * **Use restore.php**: Select to restore Bitrix from a backup.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.
1. Open your project in the browser at the domain name specified in the settings and install Bitrix using the installation wizard.
1. Check your [tools for working with Git repositories](#working-with-git).

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Bitrix admin environment, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace bitrix-space \
     --set volumeSize="<Bitrix_volume_size>" \
     --set fqdn="<Bitrix_website_domain_name>" \
     --set loadBalancerIP="<load_balancer_IP_address>" \
     --set features.cron=<use_cron_to_run_agents> \
     --set features.push=<use_queue_server> \
     --set features.sphinx=<use_Sphinx_search> \
     --set features.phpExporter=<export_PHP_metrics> \
     --set features.nginxExporter=<export_NGINX_metrics> \
     --set features.git=<use_Git> \
     --set git.repoUrl="<repository_SSH_URL>" \
     --set git.name="<Git_user_name>" \
     --set git.email="<Git_user_email>" \
     --set git.secret="<Base64_acess_key_of_Git_user>" \
     --set s3.secret.accessKey="<bucket_key_ID>" \
     --set s3.secret.secretKey="<bucket_secret_key>" \
     --set s3.bucket="<bucket_name>" \
     --set msmtprc.host="<email_server_FQDN>" \
     --set msmtprc.port="<email_server_port>" \
     --set msmtprc.user="<email_server_user_name>" \
     --set msmtprc.password="<email_server_user_password>" \
     --set push.key="<secret_key_of_Bitrix_Push_server>" \
     --set-json 'mysql={"host":"<{{ MY }}_host_FQDN>","login":"<{{ MY }}_user_name>","password":"<{{ MY }}_user_password>","database":"<{{ MY }}_database_name>"}' \
     --set certmanager.enabled=false \
     --set tls.existingSecret="<name_of_secret_with_certificate>" \
     --set features.cache=<use_Redis_cache> .
     bitrix ./bitrix/
   ```

   When using _certmanager_ to issue a certificate, instead of the `tls.existingSecret` and `certmanager.enabled=false` parameters, specify the following ones:

   * `certmanager.issuer=<Issuer_or_ClusterIssuer_resource>`
   * `certmanager.email=<email_for_Lets_Encrypt_notifications>`

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Bitrix product environment, do the following:
   1. Create a new [namespace](../../concepts/index.md#namespace) in your cluster: `bitrix-prod`.
   1. Create a local folder named `bitrix` or, if your project is uploaded to a Git repository, clone your repository to this folder:

       ```shell
       git clone <repository_SSH_URL> bitrix
       ```

   1. Prepare the image of your Bitrix PHP app:

      1. Download the `bitrix-admin-php` image:

         ```shell
         docker pull {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.tag }}
         ```

      1. Tag the registry you [created earlier](#before-you-begin):

         ```shell
         docker tag {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.tag }} {{ registry }}/<registry_ID>/bitrix-env/bitrix/bitrix-admin-php
         ```

      1. In the `bitrix` folder home directory, create a file named `Dockerfile-php` with the following contents:

          ```text
          FROM {{ registry }}/<registry_ID>/bitrix-env/bitrix/bitrix-admin-php
          COPY --chown=bitrix:bitrix bitrix/ /home/bitrix/www
          WORKDIR /home/bitrix/www
          ```

      1. Build a Docker image to set up the product environment by running this command:

         ```shell
         docker build --platform linux/amd64 \
             -f Dockerfile-php \
             -t {{ registry }}/<registry_ID>/bitrix-prod-php \
             --no-cache .
         ```

      1. Push your new image to the registry by running this command:

         ```shell
         docker push {{ registry }}/<registry_ID>/bitrix-prod-php
         ```

   1. Repeat step 2 to prepare a Bitrix NGINX image, `bitrix-prod-nginx`, based on this image: `{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.name }}:{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.tag }}`.

   1. Run Helm chart installation:

       ```bash
       helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
         --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
         --untar && \
       helm install \
         --namespace bitrix-prod \
         --set environment=prod \
         --set replicaCount=<number_of_Bitrix_pod_replicas> \
         --set fqdn="<Bitrix_website_domain_name>" \
         --set loadBalancerIP="<load_balancer_IP_address>" \
         --set features.cron=<use_cron_to_run_agents> \
         --set features.push=<use_queue_server> \
         --set features.sphinx=<use_Sphinx_search> \
         --set features.phpExporter=<export_PHP_metrics> \
         --set features.nginxExporter=<export_NGINX_metrics> \
         --set s3.secret.accessKey="<bucket_key_ID>" \
         --set s3.secret.secretKey="<bucket_secret_key>" \
         --set s3.bucket="<bucket_name>" \
         --set msmtprc.host="<email_server_FQDN>" \
         --set msmtprc.port="<email_server_port>" \
         --set msmtprc.user="<email_server_user_name>" \
         --set msmtprc.password="<email_server_user_password>" \
         --set push.key="<secret_key_of_Bitrix_Push_server>" \
         --set mysql.host="<{{ MY }}_host_FQDN>" \
         --set mysql.login="<{{ MY }}_user_name>" \
         --set mysql.password="<{{ MY }}_user_password>" \
         --set mysql.database="<{{ MY }}_database_name>" \
         --set php.image="{{ registry }}/<registry_ID>/bitrix-prod-php" \
         --set nginx.image="{{ registry }}/<registry_ID>/bitrix-prod-nginx" \
         --set certmanager.enabled=false \
         --set tls.existingSecret="<name_of_secret_with_certificate>" \
         bitrix ./bitrix/
       ```

       When using _certmanager_ to issue a certificate, instead of the `tls.existingSecret` and `certmanager.enabled=false` parameters, specify the following ones:

       * `certmanager.issuer="<Issuer_or_ClusterIssuer_resource>"`
       * `certmanager.email="<email_for_Lets_Encrypt_notifications>"`

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Working with a Git repository {#working-with-git}

To work with a repository, you need the admin environment.

1. Connect to the pod container from the admin environment:

   ```shell
   kubectl -n bitrix-space exec \
     <bitrix_main_pod_name> \
     -c git -it -- \
     sh /home/bitrix/www $
   ```

1. The container supports `git` commands, as well as a utility script, `/scripts/commit-all.sh`, to push all changes from the `bitrix` directory to the repo you configured in the previous steps. To use it, run this command:

   ```shell
   /scripts/commit-all.sh <commit description>
   ```

## See also {#see-also}

* [Container environment for Bitrix](https://github.com/bitrix-tools/env-docker)
* [1C Bitrix: Site Management](https://dev.1c-bitrix.ru/docs/php.php#tab-admins-link)
* [1C Bitrix24](https://helpdesk.bitrix24.ru/)
* [1C Bitrix: Solutions for industries](https://dev.1c-bitrix.ru/docs/solutions.php)