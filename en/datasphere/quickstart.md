# Getting started with {{ ml-platform-name }}

{{ ml-platform-full-name }} is an end-to-end ML development environment where you can use familiar IDEs, serverless computing technology, and seamlessly combine a broad range of {{ yandex-cloud }} computing resource configurations. {{ ml-platform-full-name }} is part of the data platform and offers powerful features to easily interact with {{ yandex-cloud }} services. As an IDE, {{ ml-platform-name }} provides [Jupyter® Notebook](https://jupyter.org/).

In this section, you'll learn how to:
1. [Create projects](#create-project).
1. [Run projects](#start-project).
1. [Configure the environment](#install-dependencies).
1. [Upload data to projects](#download-data).
1. [Start training](#start-ml).
1. [Share your results](#share-with-community).

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. Open the [homepage]({{ link-datasphere-main }}) {{ ml-platform-name }}.
1. Accept the user agreement.
1. Select the organization to work with {{ ml-platform-name }} in or create a new one.

## Create a project {#create-project}

{% include [create-project](../_includes/datasphere/ui-create-project.md) %}

## Run the project {#start-project}

{% include [start-project](../_includes/datasphere/ui-start-project.md) %}

## Configure the environment {#install-dependencies}

{% include [install-dependencies-intro](../_includes/datasphere/install-dependencies-intro.md) %}

{% include [install-dependencies-steps](../_includes/datasphere/install-dependencies-steps.md) %}

You can also configure the environment to run your code [using Docker images](operations/user-images.md).

## Upload data to the project {#download-data}

{% include [download-data](../_includes/datasphere/download-data.md) %}

## Start training {#start-ml}

{% include [start-ml](../_includes/datasphere/start-ml.md) %}

## What's next {#what-is-next}

* [Learn about service features](concepts/index.md).
* [See other instructions on how to use the service](operations/index.md).
* [Deploy the trained model as a service](concepts/deploy/index.md).