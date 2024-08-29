# Table is not ready yet

`ERR.DS_API.SOURCE_CONFIG.TABLE_NOT_CONFIGURED`

The dataset's schema has just been changed. Wait until the preview table is recreated (this may take several minutes).

This error occurs when accessing a table for which data processing is still in progress. Update the page 10-15 minutes later and try again. If the error persists, [contact technical support]({{ link-console-support }}). In your message, specify the ID of the dataset and/or connection in which the error occurs.

This error is also likely if subquery parameters in the dataset are filled incorrectly. In which case fix the subquery parameters and make sure the dataset has been validated.