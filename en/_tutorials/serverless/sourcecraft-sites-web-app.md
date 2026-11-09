# Web application on {{ src-name }} Sites and {{ sf-full-name }}

This guide demonstrates an example of deploying a simple web application using various services and tools:

- Frontend: Static website on [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites).
- Backend: [{{ sf-full-name }}]({{ link-docs }}/functions/concepts/function) cloud function combined with a [{{ api-gw-full-name }}]({{ link-docs }}/api-gateway/concepts/) gateway.
- Storing and working with code: [{{ src-name }}]({{ link-src-docs }}/) repository.
- Creating {{ yandex-cloud }} resources: [{{ src-name }} CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) and [{{ src-name }} service connections]({{ link-src-docs }}/sourcecraft/concepts/service-connections) to {{ yandex-cloud }}.

This web application is suitable for development and prototyping, or for a pet project. Advantages of this approach:

- There is no need to set up a virtual machine or a server for either the frontend or the backend.
- Free hosting on [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites) with HTTPS access (no need to upload your own TLS certificate).
- The [free tier]({{ link-docs }}/billing/concepts/serverless-free-tier) for **{{ sf-full-name }}** and **{{ api-gw-full-name }}** allows you to use them at no cost under light workloads.
- Free access to {{ src-name }} features for working with code and CI/CD under the **{{ src-name }} Free** [pricing plan]({{ link-src-docs }}/sourcecraft/pricing#src-plans).

{% note info %}

A web application (website) is published based on files hosted in a public [repository]({{ link-src-docs }}/sourcecraft/concepts/#repos) belonging to a public {{ src-name }} [organization]({{ link-src-docs }}/sourcecraft/concepts/#org).

You can confirm ownership of a {{ src-name }} Sites website in [Yandex Webmaster](https://webmaster.yandex.ru). For more information, see [Questions about {{ src-name }}]({{ link-src-docs }}/sourcecraft/qa/sourcecraft-sites#verify-site-owner).

{% endnote %}

To create a web app:

1. [Get ready to work](#prepare).
1. [Clone]({{ link-src-docs }}/sourcecraft/operations/repo-clone) (`git clone https://git@git.sourcecraft.dev/examples/sourcecraft-sites-web-app.git`) or [fork]({{ link-src-docs }}/sourcecraft/operations/fork-work#create-fork) the [repository](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) into your organization on {{ src-name }}.
1. [Create a service connection]({{ link-src-docs }}/sourcecraft/operations/service-connections) named `default-service-connection`.
1. [Manually run]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) the `create-resources` workflow on the `master` branch.
1. [Test your application](#test).

If you no longer need the resources you have created, [delete](#clear-out) them and [unpublish](#delete) the website.

## Getting started {#prepare}

1. {% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}
1. Authenticate in {{ src-name }} on the service [home page]({{ link-src-main }}) or [sign up]({{ link-src-docs }}/sourcecraft/quickstart#registration).

### Required paid resources {#paid-resources}

The cost of web application infrastructure support includes:
* Cost of using the gateway (see [{{ api-gw-full-name }} pricing]({{ link-docs }}/api-gateway/pricing)).
* Cost of using a cloud function ([{{ sf-full-name }} pricing]({{ link-docs }}/functions/pricing)).

## Testing the application {#test}

To open the application, navigate to the following URL in your browser: `https://<organization_slug>.sourcecraft.site/<repository_name>`. If everything was set up correctly, you will see an input field for a name and a button on the page that opens. Enter a name and click the button; a greeting line should then appear below.

## Deleting {{ yandex-cloud }} resources {#clear-out}

You can delete the resources (the gateway and the cloud function) using one of the following methods:

* Manually in the {{ yandex-cloud }} console ([delete the function]({{ link-docs }}/functions/operations/function/function-delete), [delete the API gateway]({{ link-docs }}/api-gateway/operations/api-gw-delete)).
* [Manually]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) run the `delete-resources` workflow in the repository.

## Unpublishing a website {#delete}

To unpublish a website, simply perform one of the following actions:

* Making a repository or organization private.
* Removing the `.sourcecraft/sites.yaml` file from the repository's main branch.

## Useful links {#see-also}

[Connecting to a {{ ydb-name }} database from a Python function in {{ sf-full-name }}]({{ link-docs }}/tutorials/serverless/connect-from-cf)
