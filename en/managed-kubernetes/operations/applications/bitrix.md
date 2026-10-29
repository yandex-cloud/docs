---
title: Installing Bitrix
description: Follow this guide to install the Bitrix application in your {{ managed-k8s-name }} cluster.
---

# Installing Bitrix

**Bitrix** is an application that prepares and deploys environments for standard installation of 1C Bitrix products in a {{ managed-k8s-full-name }} cluster.

It supports two environment types: admin and production.

#### Admin environment {#admin-environment}

The admin environment is used for:

* Deployment of Bitrix products from scratch or from a backup.
* Modification of Bitrix components via the admin panel.
* Testing and development.

You can also use this environment to install stable versions of Bitrix applications.

Admin environment supports the following tools:

* Git client.
* Running agents in cron jobs.
* Queue server.
* Sphinx morphological search.
* Tools for collecting PHP and Nginx metrics.

You can install the admin environment from {{ marketplace-full-name }} or using a Helm chart.

#### Production environment {#prod-environment}

The production environment is designed for fault-tolerant and highly available Bitrix deployment. It supports all the admin features except for the admin panel and does not allow you to modify Bitrix components.

You can install the production environment only using a Helm chart. Prior to installation, prepare custom images based on those provided and add the necessary Bitrix files to them.

{% note info %}

The admin and production environments share these assets:

* {{ MY }} database
* {{ objstorage-name }} bucket

{% endnote %}

## Getting started {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. In the {{ managed-k8s-name }} cluster, create new [namespaces](../../concepts/index.md#namespace) for the admin and production environments, e.g., `bitrix-admin` and `bitrix-prod`.
1. If you want to issue a Let's Encrypt certificate for a Bitrix website using [cert-manager](https://cert-manager.io/), follow [this guide](cert-manager-cloud-dns.md) to install cert-manager with the {{ dns-full-name }} ACME webhook plugin.
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

1. [Install the csi-s3 application](./csi-s3.md). This is a requirement, because {{ objstorage-name }} is used to store shared data.
1. [Create a bucket](../../../storage/operations/buckets/create.md) to house the shared project directories, `upload` and `backup`.
1. [Create a service account](../../../iam/operations/sa/create.md) with the `storage.editor` [role](../../../iam/concepts/access-control/roles.md) for the folder where your bucket is located.
1. [Create a static access key](../../../iam/operations/authentication/manage-access-keys.md) for the service account and save its ID and secret key.
1. [Create a {{ mmy-name }}](../../../managed-mysql/operations/cluster-create.md) cluster with the following parameters:

   * **Network**: Select the network hosting your {{ managed-k8s-name }} cluster.
   * Under **Hosts**, check that **Public access** is disabled for all hosts.
   * **{{ ui-key.yacloud.mdb.forms.section_settings }}**:
     * **Innodb Flush Log At Trx Commit**: `2`
     * **Innodb Strict Mode**: `Disabled`
     * **Join Buffer Size**: `2621440`
     * **Sort Buffer Size**: `2621440`
     * **Sync Binlog**: `0`
     * **Transaction Isolation**: `read committed`

1. If you need to use the queue server (Bitrix Push and Pull module), create a secret key for it:

    ```shell
    docker container run --rm \
        --name push_server_key_generate alpine:3.21 \
        sh -c "(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 128) && echo ''"
    ```

    Save the command output.

1. If you are going to use the production environment, prepare {{ container-registry-name }} resources to push the required Docker images:

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

1. In the [management console]({{ link-console-main }}), select the folder.
1. [Navigate]({{ link-console-main }}/link/managed-kubernetes) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Select the [{{ managed-k8s-name }} cluster](../../concepts/index.md#kubernetes-cluster).
1. Click the **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) tab and select **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. Under **{{ ui-key.yacloud.marketplace-v2.label_available-products }}**, select [Bitrix](/marketplace/products/yc/bitrix-env) and click **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Configure the application:
   * **Namespace**: Select the namespace you created earlier for the admin environment.
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

   * **Use cron to run agents**: Enable to run Bitrix agents on the schedule specified in `ConfigMap` `<app_name>-<namespace_for_admin_environment>-cron`. By default, `ConfigMap` enables running agent jobs every minute, and backup jobs, every 24 hours. You can also add your own schedule.
   * **Use queue server**: Enable to use a queue server (the Bitrix Push and Pull module). The `Deployment` resource for server deployment will start in a separate pod.
   * **Secret key**: If you enabled **Use queue server**, provide the secret key you created previously.
   * **Use Sphinx**: Enable to use Sphinx, a full-text search engine. The `Deployment` resource for Sphinx deployment will start in a separate pod.
   * **Use built-in Redis**: Leave this option on to deploy Redis together with the application. In which case the **External Redis host** and **Redis password** fields should remain empty.

     For connection to a separately deployed Redis instance, disable this option and specify the following:

     * **External Redis host**: Specify the address of the server accessible from the application. This is a required setting.
     * **External Redis port**: Specify the connection port. The default value is `6379`.
     * **Redis password**: Specify the connection password. Leave this field empty if the server requires no password.

     Redis is used to store sessions regardless of the **Store cache in Redis** option. Disabling the built-in Redis requires a connection to an external one.

   * **Store cache in Redis**: Enable to store Bitrix cache in Redis. We do not recommend enabling this option in the admin environment.
   * **Export PHP metrics**: Select to enable PHP metrics.
   * **Export NGINX metrics**: Select to enable NGINX metrics.
   * **Storage class for S3**: `csi-s3`, default.
   * **S3 key ID**, **S3 secret key**: Specify the ID and secret key of the static key you [got previously](#before-you-begin).
   * **S3 bucket**: Specify the name of the {{ objstorage-name }} bucket you [created previously](#before-you-begin).
   * **SMTP server**, **SMTP port**, **Mailbox user**, **Mailbox password**: Specify the mail server connection properties.
   * **PHP version**: Specify the PHP version for Bitrix. Available versions: `8.2.33`, `8.3.33`, `8.4.25`, and `8.5.10`.
   * **Use bitrixsetup.php**: Select to install Bitrix from scratch.
   * **Use restore.php**: Select to restore Bitrix from a backup.

1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.
1. Open your project in the browser at the domain name specified in the settings and install Bitrix using the installation wizard. When configuring your database, specify the host address, database name, user login and password in the {{ mmy-name }} cluster you [created earlier](#before-you-begin).
1. Check your [tools for working with Git repositories](#working-with-git).

## Installation using a Helm chart {#helm-install}

1. {% include [helm-install](../../../_includes/managed-kubernetes/helm-install.md) %}

   Additional chart settings and available image tags are listed in `values.yaml`. To print its contents, run this command:

   ```bash
   helm show values oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }}
   ```

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Bitrix admin environment, run this command:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <namespace_for_admin_environment> \
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
     --set certmanager.enabled=false \
     --set tls.existingSecret="<name_of_secret_with_certificate>" \
     bitrix ./bitrix-env/
   ```

   When using `certmanager` to issue a certificate, instead of the `tls.existingSecret` and `certmanager.enabled=false` parameters, specify the following ones:

   * `certmanager.issuer=<Issuer_or_ClusterIssuer_resource>`
   * `certmanager.email=<email_for_Lets_Encrypt_notifications>`

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   After you have deployed the admin environment, open your project at the specified domain name and install Bitrix using the installation wizard. When configuring your database, specify the parameters for connection to the {{ mmy-name }} cluster [created earlier](#before-you-begin):

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with the Bitrix production environment, proceed as follows:
   1. If your project is uploaded to a Git repository, clone your repository to the `bitrix` folder:

       ```shell
       git clone <repository_SSH_URL> bitrix
       ```

   1. Prepare the image of your Bitrix PHP app. Use the same `<php_version>` tag at every stage: the chart uses it to figure out the path to the PHP configuration. Make sure the tag contains the full version in `MAJOR.MINOR.PATCH` format, e.g., `8.5.10`.

      1. Pull the `bitrix-admin-php` image:

         ```shell
         docker pull {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:<php_version>
         ```

      1. Tag the registry you [created earlier](#before-you-begin):

         ```shell
         docker tag {{ mkt-k8s-key.yc_bitrix-env.dockerImages.php.repository.name }}:<php_version> {{ registry }}/<registry_ID>/bitrix-env/bitrix/bitrix-admin-php:<php_version>
         ```

      1. In the `bitrix` folder home directory, create a file named `Dockerfile` with the following contents:

          ```text
          FROM {{ registry }}/<registry_ID>/bitrix-env/bitrix/bitrix-admin-php:<php_version>
          COPY --chown=bitrix:bitrix bitrix/ /home/bitrix/www
          WORKDIR /home/bitrix/www
          ```

      1. Build a Docker image to deploy the production environment by running this command:

         ```shell
         docker build --platform linux/amd64 \
             -t {{ registry }}/<registry_ID>/bitrix-prod-php:<php_version> \
             --no-cache .
         ```

      1. Push your new image to the registry by running this command:

         ```shell
         docker push {{ registry }}/<registry_ID>/bitrix-prod-php:<php_version>
         ```

   1. Repeat step 2 to prepare a Bitrix NGINX image, `bitrix-prod-nginx`, based on this base image: `{{ mkt-k8s-key.yc_bitrix-env.dockerImages.nginx.repository.name }}:<nginx_version>`.

   1. Prepare the `.settings.php` file with the installed Bitrix product settings. For example, export it from the `php` container of the `<release_name>-<admin_enrivonment_workspace>-main` Deployment pod.

      ```bash
      kubectl exec \
        --namespace <namespace_for_admin_environment> \
        deploy/<release_name>-<namespace_for_admin_environment>-main \
        -c php -- cat /home/bitrix/www/bitrix/.settings.php > settings.php
      ```

   1. Create a secret named `bitrix-user-settings` with the `.settings.php` key in the product environment namespace created earlier:

      ```bash
      kubectl create secret generic bitrix-user-settings \
        --namespace <namespace_for_production_environment> \
        --from-file=.settings.php=./settings.php
      ```

   1. Run Helm chart installation:

       ```bash
       helm pull oci://{{ mkt-k8s-key.yc_bitrix-env.helmChart.name }} \
         --version {{ mkt-k8s-key.yc_bitrix-env.helmChart.tag }} \
         --untar && \
       helm install \
         --namespace <namespace_for_production_environment> \
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
         --set settings.existingSecret="bitrix-user-settings" \
         --set php.image="{{ registry }}/<registry_ID>/bitrix-prod-php:<php_version>" \
         --set nginx.image="{{ registry }}/<registry_ID>/bitrix-prod-nginx:<nginx_version>" \
         --set certmanager.enabled=false \
         --set tls.existingSecret="<name_of_secret_with_certificate>" \
         bitrix ./bitrix-env/
       ```

       When using `certmanager` to issue a certificate, instead of the `tls.existingSecret` and `certmanager.enabled=false` parameters, specify the following ones:

       * `certmanager.issuer="<Issuer_or_ClusterIssuer_resource>"`
       * `certmanager.email="<email_for_Lets_Encrypt_notifications>"`

       {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Working with a Git repository {#working-with-git}

To work with a repository, you need the admin environment.

1. Connect to the pod container from the admin environment:

   ```shell
   kubectl -n <namespace_for_admin_environment> exec \
     <bitrix_main_pod_name> \
     -c git -it -- sh
   ```

1. The container supports `git` commands, as well as a utility script, `/scripts/commit-all.sh`, to push all changes from the `bitrix` directory to the repo you configured in the previous steps. To use it, run this command:

   ```shell
   /scripts/commit-all.sh <commit description>
   ```

#### Useful links {#see-also}

* [1C Bitrix: Web environment](https://dev.1c-bitrix.ru/learning/course/index.php?COURSE_ID=32&LESSON_ID=29234&LESSON_PATH=3903.4862.29228.29234)
* [Container environment for Bitrix](https://github.com/bitrix-tools/env-docker)
