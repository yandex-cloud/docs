1. In the terminal window, go to the directory containing the infrastructure plan.

    {% note warning %}

    Make sure the directory has no {{ TF }} manifests with the resources you want to keep. {{ TF }} deletes all resources that were created using the manifests in the current directory.

    {% endnote %}

1. Delete resources:

    1. Run this command:

        ```bash
        terraform destroy
        ```

    1. Confirm deleting the resources and wait for the operation to complete.

    All the resources described in the {{ TF }} manifests will be deleted.
