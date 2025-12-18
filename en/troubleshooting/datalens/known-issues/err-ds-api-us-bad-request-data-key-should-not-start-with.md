# Resolving the `ERR.DS_API.US.BAD_REQUEST data.key should not start with /` error



## Issue description {#issue-description}

When creating a connection, you see the `ERR.DS_API.US.BAD_REQUEST` error.

## Solution {#issue-resolution}

This error may arise when you try to create a connection at the root of the {{ datalens-name }} hierarchy (inside the **{{ ui-key.datalens.component.aside-header.view.switch_root }}** folder).

Specify a folder with a different name in the pop-up window opened by the **{{ ui-key.datalens.connection.connections-list.modify.button_create-connection }}** button.