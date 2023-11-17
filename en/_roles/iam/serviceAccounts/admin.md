The `iam.serviceAccounts.admin` role allows you to manage service accounts and permissions to access them. The role includes the following permissions:

* Changing the description and other mutable attributes of a service account.
* Creating all types of keys for a service account.
* Getting IAM tokens for a service account.
* Setting up access rights for a service account.

For some services, you need a service account to perform operations, such as in Instance Groups or Managed Service for Kubernetes. If you specified a service account in the request, IAM will check whether you have permissions to use this account.