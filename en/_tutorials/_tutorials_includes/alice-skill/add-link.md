## Add the function link to the Alice's skill {#add-link}

{% list tabs %}

- Yandex Dialogs UI

  1. Go to the Alice skill page in your [dashboard.](https://dialogs.yandex.ru/developer/)
  1. Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Skill for Alice** and do the following in the window that opens:

      1. In the **Skill name** field, specify a unique name for the skill you are creating.
      1. In the **Backend** field, select **Function in Yandex Cloud**. Select the function you created earlier from the drop-down list.

          {% note warning %}

          The list shows the functions that you are allowed to view. To attach a function to a skill, you need permission to invoke the function. This permission comes with the [{{ roles-functions-invoker }}](*functions_invoker) role or higher.

          {% endnote %}

      1. Leave all the other parameter values unchanged and click **Save** at the top of the page.

{% endlist %}

[*functions_invoker]: The `functions.functionInvoker` role allows you to invoke functions. For more information on access management in {{ yandex-cloud }}, see [this guide](../../../iam/concepts/access-control/index.md).