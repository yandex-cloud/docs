# Installing Thumbor

[Thumbor](https://thumbor.readthedocs.io/en/latest/) is an [open-source](https://github.com/thumbor/thumbor) project for on-demand image processing. Thumbor runs as an HTTP service and performs transformations, such as image cropping and resizing, [applying filters](https://thumbor.readthedocs.io/en/latest/filters.html#available-filters) and [many others](https://thumbor.readthedocs.io/en/latest/imaging.html).

Thumbor features:
* Support for all popular image formats.
* Smart cropping and resizing.
* Speeding up image processing by caching.
* Supporting various storage types (local disk, {{ objstorage-full-name }}, and others).
* Face and object recognition (glasses, facial features) based on [computer vision technology](https://github.com/opencv/opencv).
* Integrating with various programming languages.

## Getting started {#before-you-begin}

1. [Create a bucket](../../../storage/operations/buckets/create.md) with restricted access in {{ objstorage-name }}.
1. [Upload images to the bucket](../../../storage/operations/objects/upload.md#simple).
1. [Create a service account](../../../iam/operations/sa/create.md) for Thumbor to run.
1. Create a [static key](../../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam access-key create \
     --service-account-name <Thumbor_service_account_name> \
     --format json > sa-key.json
   ```

1. [Set the bucket object read access rights](../../../storage/operations/objects/edit-acl.md) for the service account.

## Installation using {{ marketplace-full-name }} {#marketplace-install}

1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Click the {{ k8s }} cluster name and select the ![image](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}** tab.
1. Under **Applications available for installation**, select [Thumbor](/marketplace/products/yc/thumbor) and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Configure the application:
   * **Namespace**: Select or create a [namespace](../../concepts/index.md#namespace) for Thumbor.
   * **Application name**: Enter a name for the application.
   * **Bucket name**: Specify the [name of the bucket](#before-you-begin) you created earlier.
   * **{{ objstorage-name }} static access key**: Paste the contents of the `sa-key.json` file.
   * (Optional) **Security key**: Specify the security key for URL signing.
   * **Allow unsigned URLs (unsafe)**: Select this option if you did not specify a security key at the previous step.
   * **Subfolder in the bucket**: Specify the name of the bucket folder (without the ending `/` symbol) where images are located.
1. Click **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Wait for the application to change its status to `Deployed`.

## Installation using a Helm chart {#helm-install}

1. {% include [install-helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [kubectl-install](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. To install a [Helm chart](https://helm.sh/docs/topics/charts/) with Thumbor, run the following command:

   {% list tabs %}

   - Unsigned URLs are allowed

     ```bash
     export HELM_EXPERIMENTAL_OCI=1 && \
     helm pull oci://{{ mkt-k8s-key.yc_thumbor.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_thumbor.helmChart.tag }} \
       --untar && \
     helm install \
       --namespace <Thumbor_namespace> \
       --create-namespace \
       --set bucket_name='<Object_Storage_bucket_name>' \
       --set allow_unsafe_url='true' \
       --set root_path='<bucket_subfolder_name>' \
       --set-file saAccessKeyFile='sa-key.json' \
      thumbor ./thumbor
     ```

   - Unsigned URLs are not allowed

     ```bash
     export HELM_EXPERIMENTAL_OCI=1 && \
     helm pull oci://{{ mkt-k8s-key.yc_thumbor.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_thumbor.helmChart.tag }} \
       --untar && \
     helm install \
       --namespace <Thumbor_namespace> \
       --create-namespace \
       --set bucket_name='<Object_Storage_bucket_name>' \
       --set allow_unsafe_url='false' \
       --set security_key='<security_key_for_URL_signing>' \
       --set root_path='<bucket_subfolder_name>' \
       --set-file saAccessKeyFile='sa-key.json' \
      thumbor ./thumbor/
     ```

   {% endlist %}

## Accessing the application {#app-access}

Once the application is installed, a [{{ network-load-balancer-full-name }} network load balancer](../../../network-load-balancer/) is deployed automatically. The application is accessed over HTTP.

{% note info %}

Before using the application, make sure that the proper [rules for connecting to services from the internet](../connect/security-groups.md#rules-nodes) are set up for your cluster.

{% endnote %}

{% list tabs %}

- Management console

  1. Go to the [folder page]({{ link-console-main }}) and select **{{ network-load-balancer-short-name }}**.
  1. Find out the load balancer's IP address with the following description: `cluster <your_cluster_name>, service <namespace>/thumbor`.
  1. Open `http://<load_balancer_IP>/unsafe/<bucket_image_name>` in the browser address bar.

- CLI

  1. Run the command below to get the load balancer's IP address:

     ```bash
     kubectl get svc \
       --namespace <namespace> \
       --output jsonpath='{.status.loadBalancer.ingress[0].ip}' thumbor
     ```

  1. Open `http://<load_balancer_IP>/unsafe/<bucket_image_name>` in the browser address bar.

{% endlist %}

Learn more about working with images, in the [Thumbor documentation](https://thumbor.readthedocs.io/en/latest/imaging.html).

## What's next {#what-is-next}

Learn how to use Thumbor for editing images on your website. The [Thumbor use case](../../tutorials/marketplace/thumbor.md) described in the documentation involves configuring [{{ cdn-full-name }}](../../../cdn/concepts/index.md). The service allows to achieve faster loading of website images.

## See also {#see-also}

* [Thumbor documentation](https://thumbor.readthedocs.io/en/latest/).
* [{{ objstorage-name }} documentation](../../../storage/).
* [{{ network-load-balancer-name }} documentation](../../../network-load-balancer/).
