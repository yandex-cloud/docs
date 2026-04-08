# Deleting an access key

If you have an access key for {{ objstorage-name }}, you can delete it. Once you delete the key, the applications that rely on it will lose access to the storage.

{% note warning %}

Deleting an access key is irreversible. Make sure that your apps no longer use the key.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Get a list of access keys in the project:

      ```bash
      kubectl get apikey -n <project_name>
      ```

  1. Delete an access key:

      ```bash
      kubectl delete apikey <key_name> -n <project_name>
      ```

  1. Optionally, delete the associated secret:

      ```bash
      kubectl delete secret <secret_name> -n <project_name>
      ```

  1. Delete the service account if you no longer need it:

      ```bash
      kubectl delete serviceaccount <service_account_name> -n <project_name>
      ```

  1. Delete the role assignment:

      ```bash
      kubectl delete accessbinding <assignment_name> -n <project_name>
      ```


- Management console {#console}

  1. If you have not opened a project yet, select one.
  1. In the left-hand menu, select **Service accounts**.
  1. Select a service account.
  1. Go to the **Access keys** tab.
  1. Find the key and click **Delete**.
  1. Confirm the deletion.

{% endlist %}

## What's next {#what-next}

* Learn how to [create a new access key](create-accesskey.md).
* Check out the [{{ iam-name }}](../../concepts/components/iam.md) guides.
