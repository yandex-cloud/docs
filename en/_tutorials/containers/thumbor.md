# Editing website images using Thumbor


[Thumbor](https://thumbor.readthedocs.io/en/latest/) is an [open-source](https://github.com/thumbor/thumbor) project for on-demand image processing. Thumbor provides basic settings for editing images. For example, you can use it to resize the original image, increase its contrast ratio, or remove the red-eye effect.

Thumbor is a convenient tool you can use to make images for websites, e.g., to create thumbnails for video previews. Thumbor supports image caching. This allows you to reduce labor costs for your website support.

In the example below, images are posted to a website and edited using Thumbor. The edit includes resizing and adding a watermark. To upload images faster, a CDN is configured for the website using [{{ cdn-full-name }}](../../cdn/concepts/index.md).

To edit images using Thumbor and enable the CDN:

1. [Install Thumbor](#install).
1. [Prepare images for Thumbor testing](#images).
1. [Configure {{ cdn-name }}](#cdn).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for an {{ objstorage-name }} bucket: data storage and data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for {{ cdn-name }}: Outbound traffic (see [{{ objstorage-name }} pricing](../../cdn/pricing.md)).


## Getting started {#before-you-begin}

### Set up your infrastructure {#infra}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create service accounts](../../iam/operations/sa/create.md):

      * Service account for the resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../managed-kubernetes/security/index.md#yc-api) for the folder where the {{ managed-k8s-name }} cluster is being created. This service account will be used to create resources for the {{ managed-k8s-name }} cluster.

      * Service account for nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) role for the folder with the Docker image [registry](../../container-registry/concepts/registry.md). The nodes will pull Docker images from the registry under this account.

         You can use the same service account for both operations.

      * The `thumbor-sa` service account for Thumbor.

   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating it, specify the preconfigured security groups.
   1. [Create a bucket](../../storage/operations/buckets/create.md) in {{ objstorage-full-name }}.
   1. [Grant the `thumbor-sa` service account](../../storage/operations/objects/edit-acl.md) the `READ` permission for the bucket.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [k8s-for-thumbor.tf](https://github.com/yandex-cloud-examples/yc-mk8s-thumbor/blob/main/k8s-for-thumbor.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * Service accounts for various services:

         * For the {{ managed-k8s-name }} cluster and node group.
         * For Thumbor.
         * For creating {{ objstorage-name }} buckets.

      * {{ managed-k8s-name }} cluster.
      * Node group.
      
      * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      * Static access key for bucket creation.
      * Bucket.

   1. Specify the following in the `k8s-for-thumbor.tf` file:

      * [Folder ID](../../resource-manager/operations/folder/get-id.md).
      * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.

   1. Make sure the {{ TF }} configuration file is correct using this command:

      ```bash
      terraform validate
      ```

      If the file contains any errors, {{ TF }} will point them out.

   1. Create an infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}


## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

For a Let's Encrypt® certificate, pass an [ownership check](../../certificate-manager/operations/managed/cert-validate.md) for the domain specified in the certificate.


## Install Thumbor {#install}

1. Create a [static access key](../../iam/concepts/authorization/access-key.md) for the `thumbor-sa` service account and save it to the `sa-key.json` file:

   ```bash
   yc iam access-key create --service-account-name thumbor-sa \
      --format json > sa-key.json
   ```

1. [Install Thumbor](../../managed-kubernetes/operations/applications/thumbor.md) with the following settings:

   * **Namespace**: `thumbor`.
   * **Application name**: `thumbor`.
   * **Bucket name**: Bucket to which you uploaded your images.
   * **{{ objstorage-name }} static access key**: Contents of the `sa-key.json` file.
   * **Unsigned URLs**: Allowed.

## Prepare images for Thumbor testing {#images}

1. Download images:

   * [poster_rodents_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_rodents_bunnysize.jpg)
   * [poster_bunny_bunnysize.jpg](https://peach.blender.org/wp-content/uploads/poster_bunny_bunnysize.jpg)
   * [cc.xlarge.png](https://mirrors.creativecommons.org/presskit/icons/cc.xlarge.png) ([Creative Commons](https://en.wikipedia.org/wiki/Creative_Commons) logo)

1. Upload the images to the bucket:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. In the [management console]({{ link-console-main }}), select the folder to upload an object to.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Click the bucket name.
      1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
      1. In the window that opens, select the required files and click **Open**.
      1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
      1. Refresh the page.

      In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.

   - {{ TF }} {#tf}

      You can only upload objects to a bucket after you create it. Therefore, a separate configuration file is used for uploading images.

      1. Download the [images-for-thumbor.tf](https://github.com/yandex-cloud-examples/yc-mk8s-thumbor/blob/main/images-for-thumbor.tf) configuration file to the working directory containing the `k8s-for-thumbor.tf` file. This file describes {{ objstorage-name }} objects, i.e., the images you downloaded to upload to the bucket.
      1. In the `images-for-thumbor.tf` file, specify relative or absolute paths to the images. For example, if your images are stored in the same directory as the configuration files, specify:

         * `poster_rodents_bunnysize.jpg`
         * `poster_bunny_bunnysize.jpg`
         * `cc.xlarge.png`

      1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use its resources and data sources.
      1. Make sure the {{ TF }} configuration file is correct using this command:

         ```bash
         terraform validate
         ```

         If the file contains any errors, {{ TF }} will point them out.

      1. Start image upload to the bucket:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

## Configure the CDN {#cdn}

1. Get Thumbor's external IP address:

   ```bash
   kubectl -n thumbor get svc thumbor \
      -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
   ```

1. Create an origin group in {{ cdn-name }}:

   ```bash
   yc cdn origin-group create \
      --name thumbor \
      --origin source=<Thumbor_IP_address>,enabled=true
   ```

   Result example:

   ```text
   id: "123***"
   folder_id: {{ folder-id-example }}
   name: thumbor
   use_next: true
   origins:
     - id: "234****"
       origin_group_id: "345***"
       source: {{ domain-name-example }}
       enabled: true
   ```

   This will get you the origin group ID in the `origin_group_id` parameter. You will need this ID in the next step.

1. Create a CDN resource and connect the origin group to it:

   ```bash
   yc cdn resource create \
      --cname <resource_domain_name> \
      --origin-group-id=<origin_group_ID> \
      --origin-protocol=https \
      --ignore-query-string \
      --cert-manager-ssl-cert-id <certificate_ID> \
      --forward-host-header
   ```

   Resource domain name example: `{{ domain-name-example }}`

   Sample result:

   ```text
   id: bc855oumelrq********
   folder_id: {{ folder-id-example }}
   cname: {{ domain-name-example }}
   created_at: "2022-01-15T15:13:42.827643Z"
   updated_at: "2022-01-15T15:13:42.827671Z"
   active: true
   options:
     edge_cache_settings:
       enabled: true
       default_value: "345600"
     query_params_options:
       ignore_query_string:
         enabled: true
         value: true
     host_options:
       forward_host_header:
         enabled: true
         value: true
     stale:
       enabled: true
       value:
         - error
         - updating
   origin_group_id: "345***"
   origin_group_name: thumbor
   origin_protocol: HTTPS
   ssl_certificate:
     type: CM
     status: CREATING
   ```

   It takes 15 to 30 minutes to connect a CDN resource.

1. On the CDN resource page in the [management console]({{ link-console-main }}), get the CDN provider's domain name, e.g., `{{ cname-example-yc }}`.

1. Configure a CNAME record for your domain:

   1. Navigate to your domain’s DNS settings on your DNS hosting provider’s website.
   1. Prepare a CNAME record so that it points to the address on the `.yccdn.cloud.yandex.net` or `.edgecdn.ru` domain (depending on the employed [CDN provider](../../cdn/concepts/providers.md)) you copied earlier. For example, if the website domain name is `{{ domain-name-example }}`, create a CNAME record or replace an existing one for `cdn`:

      ```http
      cdn CNAME {{ cname-example-yc }}.
      ```

## Check the result {#check-result}

Open your website at the URL:

* `https://<resource_domain_name>/unsafe/300x400/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<resource_domain_name>/unsafe/600x800/filters:watermark(cc.xlarge.png,10,-10,80,20)/poster_bunny_bunnysize.jpg`
* `https://<resource_domain_name>/unsafe/400x300/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`
* `https://<resource_domain_name>/unsafe/800x600/filters:watermark(cc.xlarge.png,-10,10,80,15)/poster_rodents_bunnysize.jpg`

You will see the prepared images of different sizes. Each image carries a [Creative Commons](https://en.wikipedia.org/wiki/Creative_Commons) watermark.

{% include [Configuring security groups if the resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the objects](../../storage/operations/objects/delete.md) from the buckets.
1. Delete the other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [CDN resource](../../cdn/operations/resources/delete-resource.md).
        1. [CDN origin group](../../cdn/operations/origin-groups/delete-group.md).
        1. [Node group](../../managed-kubernetes/operations/node-group/node-group-delete.md).
        1. [{{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
        1. [Public static IP](../../vpc/operations/address-delete.md) if you reserved one for the cluster.
        1. [Service accounts](../../iam/operations/sa/delete.md).
        1. [Buckets](../../storage/operations/buckets/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
