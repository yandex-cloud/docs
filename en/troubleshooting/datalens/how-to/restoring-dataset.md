# How to restore a broken dataset


## Scenario description {#case-description}

You need to restore a broken dataset.

## Solution {#case-resolution}

A possible reason for the dataset damage is that the dataset file has been deleted from the file connection.

You will not be able to recover the dataset. When deleting the file from the connection, its structure changes. However, the dataset expects the old connection structure and consequently returns an error.

The only option is to recreate the dataset based on the updated connection.
