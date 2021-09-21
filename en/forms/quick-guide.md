# How to create your first form

Learn your way around Yandex.Forms by creating a simple form:

1. [Add form prompts for users to respond to](#create-form).

1. [Publish your form and ask users to fill it out](#publish).

1. [Get a table with user responses](#get-answers).

## Step 1. Create a form {#create-form}

{% include [forms-versions](../_includes/forms/forms-versions.md) %}

1. In the top panel, click **Create a form**.

1. From the list on the left, select the blocks and put them on the form in the following order:

    | No. | Blocks | Settings |
    | ----- | ----- | ----- |
    | 1 | ![](../_assets/forms/text-block.png) | Enter text:<br/>`Please fill out this trial form.`<br/>Add a comment:<br/>` Required fields are marked with an asterisk.` |
    | 2 | ![](../_assets/forms/short-text-block.png) | Enter a prompt:<br/>`Last name:`<br/>Enable the **Required prompt** option. |
    | 3 | ![](../_assets/forms/single-option-block.png) | Enter a prompt:<br/>`Gender:`<br/>Add responses:<ul><li>`male`<li>`female`<ul/> |
    | 4 | ![](../_assets/forms/drop-down-list-block.png) | Enter a prompt:<br/>`Marital status:`<br/>Add responses:<ul><li>`single`<li>`married`<ul/> |
    | 5 | ![](../_assets/forms/short-text-block.png) | Enter a prompt:<br/>`Maiden name:` |

1. Set the conditions for showing the <q>Maiden name</q> prompt:

    1. Hover over the <q>Maiden name</q> block and click the ![](../_assets/forms/conditions.png) icon that appears.

    1. Add two conditions and fill in the fields as in the example:

        ![](../_assets/forms/block-conditions-settings.png)

    Now this prompt is only visible in the form if the user previously selected the female gender and <q>married</q> status.

## Step 2. Publish your form {#publish}

To allow users to fill out the form, you need to publish it:

1. Click **Share**.

1. To copy the link to the form, click ![](../_assets/forms/icon-copy.png) in the **Link** field.

1. Paste the link in your browser address bar and open it. If you've done everything correctly, the new form opens:

    ![](../_assets/forms/form-example.png)

1. Send users a link to the form.

## Step 3. Get responses to prompts {#get-answers}

To get a table with user responses to form prompts:

1. Go to the **Responses** tab.

1. In the **Download responses** list, enable the **All** option.

1. In the **Format** list, select **XLSX**.

1. In the **Filter by response date** list, select **For all time**.

1. Click **Download**.

