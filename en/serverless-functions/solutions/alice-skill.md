# Creating skills for Alice

As an example, we'll create a skill called <q>Parrot</q>, which repeats everything a user writes or says. We implement our example in two programming languages: Python and Node.js.

To add skills based on a [function](../concepts/function.md) to Alice:

1. [Prepare the skill code](#prepare-code).
1. [Create a function](#create-function).
1. [Create a version of the function](#create-version).
1. [Make a link to the function](#link).
1. [Add the function link to Alice's skill](#add-link).
1. [Test the skill](#test).

More about [developing Alice's skills](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## 1. Prepare the code for Alice's skill {#prepare-code}

Please note that you should add the file with the function code to a ZIP archive. This is one [way to upload code to the service](../concepts/function.md) {{ sf-short-name }}.

{% list tabs %}

- Python
    1. Download a sample file from GitHub: [parrot.py](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/python/parrot/parrot.py).
    1. Create a ZIP archive named `parrot-py.zip` and add the `parrot.py` file.

- Node.js
    1. Download a sample file from GitHub: [index.js](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/nodejs/parrot/index.js).
    1. Create a ZIP archive named `parrot-js.zip` and add the `index.js` file.

{% endlist %}

## 2. Create a function: {#create-function}

{% note important %}

To be able to call a function, a user must be assigned the appropriate access rights. Access rights are set for the folder. To learn how to do this, see [{#T}](../operations/function-public.md).

{% endnote %}

Once created, the function will only contain information about itself, like its name, description, and unique ID. The skill's code will be added to the function when you [create a version](#create-version).

1. In the [management console]({{ link-console-main }}), select the folder where you want to create your function.
1. Click **Create resource**.
1. Choose **Function**.
1. Enter a function name.

    {% include [name-format](../../_includes/name-format.md) %}

1. Click **Create**.

## 3. Create a version of the function {#create-version}

Choose the programming language and create a [version of the function](../concepts/function.md#version).

{% list tabs %}

- Python
  1. In the [management console]({{ link-console-main }}), open **Serverless Functions** in the folder where you want to create the version of the function.
  1. Select the function to create the version for.
  1. Under **Latest version**, click **Create in editor**.
  1. Set the version parameters:
      - **Runtime environment:** `python37`.
      - **Timeout, seconds:** 2.
      - **RAM:** 128 MB.
      - **Service account:** Not selected.
  1. Prepare the function code:
      - **Method:** ZIP archive.
      - **File:** `parrot-py.zip`.
      - **Entry point:** `parrot.handler`.
  1. Click **Create version**.

- Node.js
  1. In the [management console]({{ link-console-main }}), open **Serverless Functions** in the folder where you want to create the version of the function.
  1. Select the function to create the version for.
  1. Under **Latest version**, click **Create in editor**.
  1. Set the version parameters:
      - **Runtime environment:** `nodejs10`.
      - **Timeout, seconds:** 2.
      - **RAM:** 128 MB.
      - **Service account:** Not selected.
  1. Prepare the function code:
      - **Method:** ZIP archive.
      - **File:** `parrot-js.zip`.
      - **Entry point:** `index.handler`.
  1. Click **Create version**.

{% endlist %}

## 4. Make a link to the function {#link}

{% note important %}

To call the function properly, the link must contain the following query string parameter: `integration=raw`. If you omit it, the function is called as an HTTP request handler. This requires a specific data structure for a request to the function and its response. For more information, see [{#T}](../concepts/function-invoke.md).

{% endnote %}

Copy the link from the function description and add the required parameter:

1. In the [management console]({{ link-console-main }}), open **Serverless Functions** in the folder where the skill function was created.

1. Select the appropriate function.

1. On the **Review** page, under **General information**, copy the link from the **Link to invoke** field.

1. Add the following query string parameter to the link: `integration=raw`:

    ```
    https://functions.yandexcloud.net/d4eu6mm0t6cci8jrccp7?integration=raw
    ```

## 5. Add the function link to Alice's skill {#add-link}

1. Go to Alice's skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. Open the **Settings** tab.
1. In the **Webhook URL** field, add the function link created in [step 4](#link).
1. Click **Save** at the bottom of the page to save changes.

## 6. Test the skill {#test}

1. Open the **Testing** tab on the skill page in your [dashboard](https://dialogs.yandex.ru/developer/).
1. If everything is set up correctly, the **Chat** section will display a message inviting you to start a conversation: `Hello! I'll repeat anything you say to me.`.
1. Send a message and make sure the response is the same.

