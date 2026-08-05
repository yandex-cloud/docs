# Installing Hugo using {{ cloud-apps-name }}


Follow this guide to install and configure a static website on [Hugo](https://gohugo.io/), a static website generator, using [{{ cloud-apps-name }}](../../cloud-apps/). The application will deploy the website to [{{ objstorage-name }}](../../storage/) and configure domain access with automatically issued SSL certificates.

{% include [static-site-sc-note](../../_includes/tutorials/static-site-sc-note.md) %}

To install Hugo:

1. [Get your cloud ready](#before-you-begin).
1. [Configure a DNS zone](#configure-dns).
1. [Install Hugo using {{ cloud-apps-name }}](#install-hugo).
1. [Prepare a website repository](#prepare-repo).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for using a public DNS zone and public DNS requests (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).
* Fee for data storage in {{ objstorage-full-name }}, data operations, and outgoing traffic (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for storing secrets in {{ lockbox-name }} (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).

## Configure a DNS zone {#configure-dns}

{% include [configure-dns](../_tutorials_includes/website/configure-dns.md) %}

## Install Hugo using {{ cloud-apps-name }} {#install-hugo}

Install a [static website](/marketplace/products/yc/static-site) on Hugo using {{ cloud-apps-name }}. The application will deploy the website to [{{ objstorage-name }}](../../storage/) and configure domain access.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go]({{ link-console-main }}/link/cloud-apps/) to {{ cloud-apps-name }}.  
  1. Click **{{ ui-key.yacloud.cloud-apps.button_install-application }}**.
  1. Select the **Static website in {{ objstorage-name }}** application.
  1. Configure your application:

      #|
      || **Parameter** | **Required** | **Default value** | **Description** ||
      || **{{ ui-key.yacloud.common.name }}** | Yes | — | Application instance name ||
      || **{{ ui-key.yacloud.common.description }}** | — | — | Application instance description ||
      || **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** | Yes | — | Service account you are going to use to install the app. The service account must have the `storage.admin`, `lockbox.admin`, `certificate-manager.admin`, and `dns.admin` roles for the folder.
      To create a service account with the required permissions during app installation, select `{{ ui-key.yacloud.component.service-account-field.label_sg-auto }}`. ||
      || **DNS zone** | Yes | — | ID of the DNS zone to host the application's website. ||
      || **Subdomain** | — | Empty | Domain where the Hugo static website will be available. This domain is formed by adding a subdomain to the DNS zone domain, e.g., `site.example.com` or `example.com` if no subdomain is specified. ||
      || **Website configuration** | Yes | — | Select **Hugo** from the drop-down list. ||
      || **Maximum bucket size** | — | `10` | Maximum size of the {{ objstorage-name }} bucket to host the website's static files, in GB. ||
      |#

  1. Click **{{ ui-key.yacloud.cloud-apps.button_install }}**.

     The app installation will take a few minutes. During installation, an {{ objstorage-name }} bucket, DNS records for the website subdomain, and the required resources for HTTPS access will be created. Wait for the installation to complete.

{% endlist %}

## Prepare a repository {#prepare-repo}

After the application is installed, prepare a {{ src-name }} repository with the website's source code:

1. If you do not have Git installed yet, follow [this guide](https://git-scm.com/book/ru/v2/Введение-Установка-Git) to install it.

1. [Create]({{ link-src-docs }}/sourcecraft/operations/repo-create#create-from-template) a repository from the [`cloudapp-hugo` template](https://sourcecraft.dev/yandex-cloud-examples/cloudapp-hugo).

1. On your local computer, open the working directory where you want to host your website project.

1. [Clone]({{ link-src-docs }}/sourcecraft/operations/repo-clone) the repository created from the template.

1. Go to the cloned repository. Complete all further steps, i.e., environment configuration, building, and deployment, inside this folder.

## Deploy the website {#deploy-site}

Open the `README` file in the repository root and complete the steps from that file:

1. [Set up]({{ link-src-docs }}/sourcecraft/operations/service-connections) a service connection. Specify the service account you created when installing the application.
      
   You will need the service connection name specified during account creation to complete the setup.

1. Update the configuration files in your editor, e.g., in Visual Studio Code:

   1. `hugo.toml`:

      ```typescript
      baseURL = 'https://<domain>'
      title = '<website_name>'
      ...
      [deployment]
      [[deployment.targets]]
      name = 'production'
      url = 's3://<domain>?region=ru-central-1&endpoint=https://storage.yandexcloud.net'
      ...
      ```

      Where:
      * `<domain>`: Domain for access to the website. It usually matches the name of the bucket created when installing the application.
      * `<website_name>`: Name of your website.

   1. `.sourcecraft/ci.yaml`:

      ```yaml
      tokens:
        SERVICE_CONNECTION:
          service_connection: <service_connection>
          scope: org

      workflows:
        hugo-deploy:
          env:
            DOMAIN_NAME: <domain>
      ```

      Where:
      * `<service_connection>`: Service connection name.
      * `<domain>`: Domain where the website will be available. It usually matches the name of the bucket created when installing the application.
      * `scope`: Service connection level. The possible values are:
         * `repo`: For repository-level connections.
         * `org`: For organization-level connections.

1. Run the CI/CD pipeline to deploy the static website. To do this, run the following commands one by one inside the `main` branch:

   ```bash
   git commit -a
   ```

   Enter a name for the commit.

   ```bash
   git push
   ```

   After the pipeline runs successfully, the website will be available at `https://<domain>`. The system automatically builds your project and uploads the result to the {{ objstorage-name }} bucket.

## Configure the website {#configure-site}

1. Install the required [Hugo](https://gohugo.io/installation/) version for local development.

1. Start the dev server:

   ```bash
   hugo server
   ```

   The website will be available at `http://localhost:1313`.

1. Build the production version by running this command:

   ```bash
   hugo
   ```

   The build result will be saved to the `public/` directory.

1. View the production build locally by running this command:

   ```bash
   hugo server --disableFastRender
   ```
1. To publish changes, run the CI/CD pipeline as described in [{#T}](#deploy-site).

## Check the result {#check-result}

Make sure your Hugo static website is successfully published and available at the public domain:

1. In your browser, open the domain or subdomain you specified during application installation (e.g., `https://site.example.com`).

1. Make sure the main page of your Hugo website loads and its navigation works.

1. If the template included a test page or section, navigate to it via the relevant link and make sure it also opens at the public URL.

If the website opens and all images, styles, and pages render correctly, your website was deployed successfully.

## How to delete the resources you created {#clear-out}

To shut down the resources you created and stop paying for them:

1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the {{ objstorage-name }} bucket you created when installing the app.

1. Delete the **Static website in {{ objstorage-name }}** application in {{ cloud-apps-name }}:

   1. In the [management console]({{ link-console-main }}), select the folder the application is installed in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
   1. Find the **Static website in {{ objstorage-name }}** application in the list.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the app and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion and wait for it to complete. The empty bucket and the remaining resources of this application instance will also be deleted.

1. If you created a service account during application installation, [delete](../../iam/operations/sa/delete.md) it.

1. [Delete](../../dns/operations/zone-delete.md) the public DNS zone.

1. Delete the {{ src-full-name }} service connection:

   1. Open the {{ src-name }} [home page]({{ link-src-main }}).
   1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** tab, under ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}**, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
   1. Select the repository created from the `cloudapp-hugo` template.
   1. Under ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.repo.title_navigation-repository-settings_35xCK }}**, navigate to ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}** and select the relevant service connection.
   1. In the top-right corner, click ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** and confirm the deletion.

1. [Delete]({{ link-src-docs }}/sourcecraft/operations/repo-delete) the repository created from the template in {{ src-full-name }}.
