# Web application on {{ src-name }} Sites and {{ sf-full-name }}

In this tutorial, you will deploy a web application from a [repository](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) using {{ src-name }} [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd). The app features the following components:

* Frontend: Static website on [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites) with a field for enter the name and a **Hello** button.
* Backend: {{ sf-full-name }} [function](../../functions/concepts/function.md) in Python that returns `Hello, <name>!`.
* {{ api-gw-full-name }} [gateway](../../api-gateway/concepts/index.md) that accepts requests from the frontend and [calls the function](../../api-gateway/concepts/extensions/cloud-functions.md).

The application code and CI/CD configuration are stored in a {{ src-name }} [repository]({{ link-src-docs }}/sourcecraft/concepts/#repos). {{ yandex-cloud }} resources are created through a [service connection]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

This use case is suitable for prototypes and smaller projects: you do not have to manager servers, and {{ src-name }} Sites provides free hosting with HTTPS access without uploading a custom TLS certificate.

To create a web app:

1. [Get ready to work](#prepare).
1. [Create a service account](#create-sa).
1. [Create a repository fork](#create-repository).
1. [Create a service connection](#create-service-connection).
1. [Prepare the configuration and application code](#configure).
1. [Deploy the application](#deploy).
1. [Test the application](#test).

If you no longer need the resources you have created, [delete them](#clear-out) and [unpublish the website](#delete).

## Get ready to work {#prepare}

1. Log in to the {{ yandex-cloud }} [management console]({{ link-console-main }}) or sign up.
1. Make sure you have a [billing account](../../billing/concepts/billing-account.md) with the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../../billing/quickstart/index.md) and [link a cloud](../../billing/operations/pin-cloud.md) to it.
1. Select or [create a folder](../../resource-manager/operations/folder/create.md) to place your function and API gateway in.
1. Authenticate in {{ src-name }} on the service [home page]({{ link-src-main }}) or [sign up]({{ link-src-docs }}/sourcecraft/security/registration).
1. Select or [create a public organization]({{ link-src-docs }}/sourcecraft/operations/org-create) in {{ src-name }}.

    To create a service connection at the organization level, you need the [{{ ui-key.sourcecraft.lib.value_role-org-admin_sTd3t }}]({{ link-src-docs }}/sourcecraft/security/#organization-manager-admin) (`organization-manager.admin`) or [{{ ui-key.sourcecraft.lib.value_role-org-owner_f9UaR }}]({{ link-src-docs }}/sourcecraft/security/#organization-manager-organizations-owner) (`organization-manager.organizations.owner`) role.

{% note warning %}

You can only publish a website from a public repository in a public {{ src-name }} organization. The repository files will be available to all internet users. Do not save tokens, access keys, and other secrets in them. A service connection allows accessing {{ yandex-cloud }} without storing long-lived keys in the code.

{% endnote %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for function calls, computing resources, and outgoing traffic (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Fee for gateway requests and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).

{% note info %}

For {{ sf-name }} and {{ api-gw-name }}, a [non-chargeable amount of services](../../billing/concepts/serverless-free-tier.md) is available. Exceeding this limit is charged according to the relevant pricing policy.

Website hosting on {{ src-name }} Sites is free. You can find the CI/CD terms of use in the [{{ src-name }} pricing policy]({{ link-src-docs }}/sourcecraft/pricing#tariff-differences).

{% endnote %}

## Create a service account {#create-sa}

Under a [service account](../../iam/concepts/users/service-accounts.md), CI/CD workflows will create and delete resources, while the API gateway will call a function.

1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select your prepared folder.
1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `sites-web-app-sa`.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select roles for the folder:

    * [functions.editor](../../functions/security/index.md#functions-editor): For creating, updating, calling, and deleting a function.
    * [api-gateway.editor](../../api-gateway/security/index.md#api-gateway-editor): For creating and deleting an API gateway.
    * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user): For specifying a service account in the function version and specifying an API gateway.

1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

## Create a repository fork {#create-repository}

A [fork]({{ link-src-docs }}/sourcecraft/concepts/#forks) enables copying the example into your organization along with the CI/CD and {{ src-name }} Sites settings.

1. Open the [example repository](https://sourcecraft.dev/examples/sourcecraft-sites-web-app).
1. In the top-right corner, click ![image](../../_assets/console-icons/code-fork.svg) **Fork**.
1. Select your prepared public organization and specify the repository name, e.g., `sourcecraft-sites-web-app`.
1. Select the `master` branch for the fork and click **Create a fork**.

The repository stores:

* `.sourcecraft/ci.yaml`: CI/CD configuration with the `create-resources` and `delete-resources` workflows.
* `.sourcecraft/sites.yaml`: Website publication configuration from the `sites` directory in the `release` branch.
* `sites/`: Frontend HTML and JavaScript. The `sites/config.js` file contains the address of the API gateway that the workflow provides when deploying.
* `src/index.py`: Python function code.
* `yc-scripts/`: Scripts for getting an IAM token, creating and deleting {{ yandex-cloud }} resources.

{% note info %}

Cloning the example to a local computer does not create a repository in your organization. To follow this tutorial, use the fork you created in {{ src-name }}.

{% endnote %}

## Create a service connection {#create-service-connection}

Create a connection at the organization level. The `default-service-connection` name must match the one specified in `.sourcecraft/ci.yaml`.

1. In {{ src-name }}, open the organization where you created the repository fork.
1. Under ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.lib.settings_cwUYS }}**, navigate to ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}**.
1. In the top-right corner, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.serviceConnections.button_add-connection_6Bj7i }}**.
1. Under **{{ ui-key.sourcecraft.serviceConnections.section_basic_wmaiy }}**, specify the `default-service-connection` name.
1. Under **{{ ui-key.sourcecraft.serviceConnections.section_scope_9gXcu }}**, allow using it for all repositories.
1. Under **{{ ui-key.sourcecraft.serviceConnections.section_cloud-settings_tDMfn }}**, select your prepared folder and the `sites-web-app-sa` service account.

    {% include [service-connection-synchronization](../../_includes/sourcecraft/service-connection-synchronization.md) %}

1. Click **{{ ui-key.sourcecraft.serviceConnections.button_create-connection_uyK29 }}** and wait for the operation to complete.

For details, see [this tutorial on configuring a service connection]({{ link-src-docs }}/sourcecraft/operations/service-connections).

## Prepare the configuration and application code {#configure}

To edit a file in the {{ src-name }} UI, open it and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.sourcecraft.repo.action_edit_ahQT7 }}**. After editing each file, click **{{ ui-key.sourcecraft.repo.action_commit_brj4B }}** and commit to the `master` branch.

1. Open the `.sourcecraft/ci.yaml` file.
1. Make sure the `tokens:SERVICE_CONNECTION_WITH_TOKEN:service_connection` section shows the name of the service connection you created earlier.
1. In the `env` section, check the names of the function (`YC_FUNCTION_NAME`) and API gateway (`YC_API_GATEWAY_NAME`).

    {% note warning %}

    Make sure the selected cloud folder has no function and API gateway with these names. If it does, set other names: the workflow updates the existing function and uses the names from this configuration when deleting resources.

    {% endnote %}

## Deploy the application {#deploy}

1. In your repository, under ![image](../../_assets/console-icons/terminal-line.svg) **{{ ui-key.sourcecraft.cicd.title_cicd_qoXmk }}**, navigate to the ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.repo.action_cicd_4jypo }}** section.
1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.cicd.action_start-workflow_njaSz }}**.
1. Select the `master` branch for the configuration and launch, and the `create-resources` workflow; then click **{{ ui-key.sourcecraft.cicd.action_start_7MWxe }}**.
1. Wait until the workflow completes with the **{{ ui-key.sourcecraft.cicd.value_succeeded_3Dd8C }}** status. If the workflow completed with an error, open it and check the logs of the cube that was not executed.

The workflow gets an IAM token through the service connection, sets a function and its version, and then creates an API gateway with the `GET /hello/{name}` route. After that, it writes the gateway address to the `sites/config.js` file and publishes the files in the `release` branch.

The `.sourcecraft/sites.yaml` file in the main branch is already configured to publish from the `release` branch:

```yaml
site:
  root: sites
  ref: release
```

After this branch appears, the website is published automatically in a few minutes.

## Test the application {#test}

1. Open `https://<organization_slug>.sourcecraft.site/<repositry_name>/` in your browser.
1. In the **Name** field, enter the name, e.g., `Alice`, and click **Hello**.
1. Make sure `Hello, Alice!` appeared under the button.

## Delete the {{ yandex-cloud }} resources {#clear-out}

1. In your repository, [manually run]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) the `delete-resources` workflow from the `master` branch.
1. Wait for its successful completion. The workflow will delete the API gateway and function under the names from `.sourcecraft/ci.yaml`.

You can also delete the [API gateway](../../api-gateway/operations/api-gw-delete.md) and [function](../../functions/operations/function/function-delete.md) in the {{ yandex-cloud }} console.

If the `sites-web-app-sa` service account is no longer in use, [delete it](../../iam/operations/sa/delete.md) after deleting the function and API gateway.

## Unpublish the website {#delete}

Deleting the function and API gateway does not unpublish the static website. After deleting the cloud resources, delete the `.sourcecraft/sites.yaml` file from the `master` main branch.

#### Useful links {#see-also}

* [Hosting a static website using {{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/tutorials/sites)
* [Configuring CI/CD with {{ sf-name }}](../../tutorials/serverless/ci-cd-sourcecraft-functions.md)
* [Connecting to a {{ ydb-name }} database from a Python function in {{ sf-name }}](../../tutorials/serverless/connect-from-cf.md)
