### Test the hook {#test-hook}

1. Under **System Hooks** (**Project Hooks** for an individual project), click **Test**.
1. Select **Merge request events** from the drop-down list.

The test request should return this response: `Hook executed successfully: HTTP 204`. If the test request returns an error, the hook settings are incorrect.
