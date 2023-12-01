# Invoking a {{ sf-full-name }} function

You can integrate a form with a [{{ sf-full-name }} function](../functions/index.yaml). For example, you can collect user data and transfer it to a website or database to register customers using the form.

{% note alert %}

You can integrate a form with {{ sf-name }} functions only using [forms for business](forms-for-org.md). To do this, make sure a form has a [{{ yandex-cloud }} organization](../organization/operations/enable-org.md) enabled with a [cloud configured](../resource-manager/operations/cloud/create.md).

{% endnote %}

### Step 1. Create a service account {#step-one}

1. Go to the [{{ yandex-cloud }} management console]({{ link-console-main }}).
1. In the left-hand panel, select the folder to create a function in.
1. In the top-right corner, click ![](../_assets/forms/svg/settings.svg) → **Create service account**.
1. In the service account creation window, fill in the following fields:
   1. **Name**; it may only contain lowercase Latin letters, numbers, and hyphens.
   1. **Description**; it may contain any characters.
   1. In the **Roles in folder** field, add the `{{ roles-functions-invoker }}` role.
1. Click **Create**.

If no billing account is linked to your {{ yandex-cloud }} account, a window for creating a billing account will open. Fill in its fields to create an account. For more information, see [{#T}](../getting-started/individuals/registration.md#new-account).

### Step 2. Create a service account key {#step-two}

1. In the left-hand panel of the [management console]({{ link-console-main }}), select the folder where the appropriate service account is located.
1. Go to the **Service accounts** tab.
1. Select the account you need.
1. In the top panel on the account page, click **Create new key**→ **Create API key**.
1. Provide a brief description for the key.
1. Click **Create**.
1. This will open a window with the key ID and the secret key. Store them in a secure place. You will not be able to access them after you close the window.

### Step 3. Enable cloud function invocation {#step-three}

1. In {{ forms-full-name }}, open the form to set up the cloud function integration for.
1. Go to the **Settings** tab and select **Additional** in the left panel.
1. Under **Cloud function key**, fill in the **Key ID** and **Secret key** fields. Paste the values you copied when creating the service account key there.
1. Click **Save**.

### Step 4. Create a cloud function {#step-four}

1. Go back to the [{{ yandex-cloud }} management console]({{ link-console-main }}).
1. In the left-hand panel, click ![](../_assets/organization/icon-services-menu.svg) and select {{ sf-name }}.
1. In the top-right corner, click **Create function**.
1. On the function creation page, fill in the following fields:
   1. **Name**; it may only contain lowercase Latin letters, numbers, and hyphens.
   1. **Description**; it may contain any characters.
1. Select the programming language that your function will be written in.
1. Select a tab with the function source:
   * **Code editor** to write the function code directly in it.
   * **Object Storage** to select a bucket and object with the appropriate function.
   * **ZIP archive** to attach a `.zip` file with the appropriate function.
1. You can optionally set up the function parameters and logging. All parameters required for creating a function are preset.
1. Click **Save changes**.
1. On the function page, copy the value from the **ID** field.

To learn more about creating functions, see the [documentation for cloud functions](../functions/quickstart/create-function/index.md).

### Step 5. Set up integration {#step-five}

1. Go back to the form and click the **Integrations** tab.
1. Select a group of actions to set up issue creation in and click {{ sf-name }} at the bottom of the group.
1. In the **Function code** field, paste the function ID that you copied in the previous step.
1. Under **Parameters**, you can optionally select additional parameters to be transferred to the function.
1. Click **Save**.

Responses to the form will be delivered in JSON format. See its structure below:

```json
{
    "id":<form response ID>,
    "uid":"<user ID>",
    "data":{
        "<prompt ID with its type specified>":{
            "value":<response to prompt>,
            "question":{
                "id":<prompt ID>,
                "slug":"<prompt ID with its type specified>",
                "options":{
                    <prompt parameters>
                },
                "answer_type":{
                    "id":<ID of prompt type>,"slug":"<prompt type>"
                }
            }		
        }
    },
"survey":{
    "id":"<form ID>"
    },
"created":"<form response date>",
"cloud_uid":"<user ID>"
}
```

You can view the sent request and the function execution results on the [completed integrations](notifications.md#completed-integration) page.
