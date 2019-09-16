# Deleting clusters

You can delete a cluster along with all the data stored in it. Note that data backups are not created automatically: if you want to save data for cluster recovery or future use, you can do that, for example, using [{{ objstorage-full-name }}](https://cloud.yandex.com/services/storage).

{% list tabs %}

- Management console
    1. Open the folder page in the management console.
    1. Select **{{ dataproc-name }}**.
    1. Click ![image](../../_assets/options.svg) for the necessary cluster and select **Delete**.
    1. Confirm cluster deletion.

    {{ dataproc-name }} runs the delete cluster operation.

{% endlist%}

