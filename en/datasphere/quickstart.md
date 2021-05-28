# Getting started with {{ ml-platform-name }}

{{ ml-platform-name }} is a service that simplifies the use of the JupyterLab development environment on {{ yandex-cloud }} computing resources. This lets you perform complex calculations, such as training neural networks or analyzing big data, using the familiar Jupyter Notebook interface.

In this section, you'll learn how to:

1. [Create projects](#create-project) where you'll work in the JupyterLab environment.
1. [Install required packages](#install-dependencies).
1. [Manage computing resources](#control-compute-resources) by changing their configurations.

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if you don't have an account yet.
1. On the [Billing]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. On the [Access management]({{ link-console-access-management }}) page, make sure you have the `editor` role or higher. The role must be assigned for the folder where you'll work or the cloud that the folder belongs to.

## Create a project {#create-project}

{% include [include](../_includes/datasphere/create-project.md) %}

## Install dependencies {#install-dependencies}

{% include [include](../_includes/datasphere/install-dependencies-intro.md) %}

{% include [include](../_includes/datasphere/install-dependencies-steps.md) %}

## Increase computing resources for your cell {#control-compute-resources}

{% include [include](../_includes/datasphere/control-compute-resources-intro.md) %}

{% include [include](../_includes/datasphere/control-compute-resources-steps.md) %}

## Contact support in the service {#support}

{% include [include](../_includes/datasphere/notebook-support.md) %}

## What's next {#what-is-next}

- [Learn about service features](concepts/index.md).
- [Share a link to the notebook with all the results](operations/projects/publication.md).
- [See other instructions on how to use the service](operations/index.md).

