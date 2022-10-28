# Getting started with {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../_includes/datasphere/datasphere-old-note.md) %}

{{ ml-platform-name }} is a service that simplifies the use of the {{ jlab }}Lab development environment on {{ yandex-cloud }} computing resources. This lets you perform complex calculations, such as training neural networks or analyzing big data, using the familiar {{ jlab }} Notebook interface.

In this section, you'll learn how to:

1. [Create projects](#create-project) for the {{ jlab }}Lab environment.
1. [Install packages](#install-dependencies) you need.
1. [Manage computing resources](#control-compute-resources) by changing their configurations.

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
   {% endif %}

## Assign roles for using DataSphere {#roles}

In the management console on the [Access management]({{ link-console-access-management }}) page, make sure you have relevant roles:

* To work with existing projects, you need the `datasphere.user` role or higher.

* To create, edit, and delete projects, you need the `datasphere.admin` role or higher.

Read more about [access management](security/index.md).

## Create a project {#create-project}

{% include [include](../_includes/datasphere/create-project.md) %}

## Install dependencies {#install-dependencies}

Popular packages for data analysis and machine learning are pre-installed and ready for use, see the [list](concepts/preinstalled-packages.md).

You can install missing packages using the pip package manager.

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
