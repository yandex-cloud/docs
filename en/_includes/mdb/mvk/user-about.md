{{ mrd-name }} can create {{ VLK }} users and configure their permissions for commands, keys, and Pub/Sub channels in the cluster using [{{ VLK }} access control lists](https://valkey.io/topics/acl) (ACLs).

{{ VLK }} ACLs address two primary objectives:

* Ensure security by enforcing fine-grained access control to commands and keys.
* Prevent accidental errors caused by user actions or software failures.

Creating a cluster automatically creates a `default` user. This user has permissions to access all keys and Pub/Sub channels in the cluster and can execute all commands except administrative ones. You can view the user's detailed permissions in the [user info](../../../managed-valkey/operations/user-list.md#get). 