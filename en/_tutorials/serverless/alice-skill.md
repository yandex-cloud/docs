# Creating a skill for Alice

As an example, we will create a skill called <q>Parrot</q>, which repeats everything a user writes or says. The example is available in two programming languages: Python and Node.js.

To add an Alice skill based on a [function](../../functions/concepts/function.md):

1. [Get your cloud ready](#before-you-begin).
1. [Prepare the skill code](#prepare-code).
1. [Create a function and a function version](#create-function).
1. [Add the function link to Alice's skill](#add-link).
1. [Test the skill](#test).

If you no longer need the resources you created, [delete them](#clear-out).

You can find more information about developing skills for Alice [here](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare the code for Alice's skill {#prepare-code}

To create a [version](../../functions/concepts/function.md#version) of a function, you can use one of the [code upload formats](../../functions/concepts/function.md#upload). As an example, we will upload the code as a ZIP archive.

{% list tabs group=programming_language %}

- Python {#python}

    1. Download a sample file from GitHub: [parrot.py](https://github.com/yandex-cloud-examples/yc-alice-skill-python/blob/main/parrot/parrot.py).
    1. Create a ZIP archive named `parrot-py.zip` with the `parrot.py` file.

- Node.js {#node}

    1. Download a sample file from GitHub: [index.js](https://github.com/yandex-cloud-examples/yc-alice-skill-node/blob/main/parrot/index.js).
    1. Create a ZIP archive named `parrot-js.zip` with the `index.js` file.

{% endlist %}

## Create a function and a function version {#create-function}

Once created, the function will contain only information about itself: name, description, unique ID, etc. The actual skill code will be added to the function version.

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create the function in.
1. Click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select ![curly-brackets-function](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
1. Enter a function name. The naming requirements are as follows:

    {% include [name-format](../../_includes/name-format.md) %}

1. Click **{{ ui-key.yacloud.common.create }}**.
1. Create a [function version](../../functions/concepts/function.md#version):

    {% list tabs group=programming_language %}

    - Python {#python}

      1. From the list of programming languages, select `{{ python-full-ver }}`.
      1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Prepare the function code:

          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` and attach the `parrot-py.zip` archive you created earlier.
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `parrot.handler`.
      1. Set the version parameters:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
          * Leave the rest of the parameters at their defaults.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    - Node.js {#node}

      1. From the list of programming languages, select `{{ nodejs-full-ver }}`.
      1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Prepare the function code:

          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` and attach the `parrot-js.zip` archive you created earlier.
          * In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.
      1. Set the version parameters:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
          * Leave the rest of the parameters at their defaults.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    {% endlist %}

## Add the function link to Alice's skill {#add-link}

1. Go to the Alice skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. Click **Create dialog**. In the window that opens, select **Skill**.
1. On the **Settings** tab:

    1. In the **Skill name** field, specify a unique name for the skill you are creating.
    1. In the **Backend** field, select **Function in {{ yandex-cloud }}**. Select the function you created earlier from the drop-down list.

    {% note warning %}
    
    The list shows the functions that you are allowed to view. To attach a function to a skill, you need permission to launch the function. This permission is included in the [{{ roles-functions-invoker }}](../../functions/security/index.md#serverless-functions-invoker) and [{{ roles-editor }}](../../functions/security/index.md#functions-editor) roles or higher.
    
    {% endnote %}

    1. At the bottom of the page, click **Save**.

## Test the skill {#test}

1. Open the **Testing** tab on the skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. If everything is set up correctly, the **Chat** section will display a message inviting you to start a conversation: `Hello! I'll repeat anything you say to me.`. 
1. Send a message and make sure the response is the same.

## How to delete the resources you created {#clear-out}

To stop the skill, [delete](../../functions/operations/function/function-delete.md) the function.