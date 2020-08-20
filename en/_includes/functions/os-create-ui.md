To create a trigger:

1. Open **{{ sf-name }}** in the folder where you want to create a trigger for {{ objstorage-name }}.
1. Go to the **Triggers** tab.
1. Click **Create trigger**.
1. Under **Basic parameters**:
    * Enter a name and description for the trigger.
    * In the **Type** field, select **Object Storage**.
1. Under **Object Storage settings**:
    * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
    * In the **Event types** field, select the events.
    * (optional) In the **Object key prefix** field, enter a [prefix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
    * (optional) In the **Object key suffix** field, enter a [suffix](../../functions/concepts/trigger/os-trigger.md#filter) for filtering.
1. Under **Repeat request settings**:
    * In the **Interval** field, specify 5 seconds.
    * In the **Message batch size** field, enter 5.
1. Under **Function settings**:
    * Select the function for the trigger to call.
    * Specify [the function version tag](../../functions/concepts/function.md#tag).
    * Specify the service account that will be used to call the function.
1. Click **Create trigger**.

