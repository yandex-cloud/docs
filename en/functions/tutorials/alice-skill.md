---
title: "Creating skills for Alice"
description: "Example of creating a skill for Alice based on two programming languages: Python and Node.js As an example, we will create an Alice skill called <q>Parrot</q> that will repeat everything the user writes or says."
keywords:
  - creating skills for Alice
  - Alice's skill
  - example of creating a skill for Alice
---

# Creating skills for Alice

As an example, we will create a skill called <q>Parrot</q>, which repeats everything a user writes or says. The example is based on two programming languages: Python and Node.js.

To add an Alice skill based on a [function](../concepts/function.md):

1. [Prepare your cloud](#before-you-begin).
1. [Prepare the skill code](#prepare-code).
1. [Create a function](#create-function).
1. [Create a function version](#create-version).
1. [Add the function link to Alice's skill](#add-link).
1. [Test the skill](#test).

If you no longer need the resources you created, [delete them](#clear-out).

You can find more information about developing skills for Alice [here](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare the code for Alice's skill {#prepare-code}

To create a [version](../../functions/concepts/function.md#version) of a function, you can use one of the [code upload formats](../../functions/concepts/function.md#upload). As an example, we will upload the code as a ZIP archive.

{% list tabs %}

- Python

   1. Download a sample file from GitHub: [parrot.py](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/python/parrot/parrot.py).
   1. Create a ZIP archive named `parrot-py.zip` and add the `parrot.py` file.

- Node.js

   1. Download a sample file from GitHub: [index.js](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/nodejs/parrot/index.js).
   1. Create a ZIP archive named `parrot-js.zip` and add the `index.js` file.

{% endlist %}

## Create a function {#create-function}

Once created, the function will only contain information about itself, like its name, description, and unique ID. The skill's code will be added to the function when [creating a version](#create-version).

1. In the [management console]({{ link-console-main }}), select the folder to create your function in.
1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
1. Enter a function name. The naming requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.

## Create a function version {#create-version}

Select the programming language and create a [version of the function](../concepts/function.md#version).

{% list tabs %}

- Python

   1. In the [management console]({{ link-console-main }}), open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** in the folder where you want to create the function version.
   1. Select the function to create the version for.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}**, click **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
   1. Set the version parameters:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python37`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`
   1. Prepare the function code:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `parrot-py.zip`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `parrot.handler`
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- Node.js

   1. In the [management console]({{ link-console-main }}), open **{{ sf-name }}** in the folder where you want to create the function version.
   1. Select the function to create the version for.
   1. Under **Latest version**, click **Create in editor**.
   1. Set the version parameters:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs12`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`
   1. Prepare the function code:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `parrot-js.zip`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Add the function link to Alice's skill {#add-link}

1. Go to the Alice skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. Click **Create dialog**. In the window that opens, select **Alice skill**.
1. On the **Settings** tab, in the **Backend** field, select **Function in {{ yandex-cloud }}**. Select the function you need from the dropdown list.

   {% note warning %}

   The list shows the functions that you are allowed to view. To attach a function to a skill, you need permission to launch the function. This permission is part of the roles [{{ roles-functions-invoker }}](../security/index.md#serverless-functions-invoker), [{{ roles-editor }}](../security/index.md#functions-editor) and higher.

   {% endnote %}
1. Click **Save** at the bottom of the page to save changes.

## Test the skill {#test}

1. Open the **Testing** tab on the skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. If everything is set up correctly, the **Chat** section will display a message inviting you to start a conversation: `Hello! I'll repeat anything you say to me.`.
1. Send a message and make sure the response is the same.

## How to delete the resources you created {#clear-out}

To stop the skill, [delete](../operations/function/function-delete.md) the function.