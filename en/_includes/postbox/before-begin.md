## Getting started {#before-begin}

1. [Create](../../iam/operations/sa/create.md) a service account in the folder as the address. If you create the service account and address in different folders, you will get an error when attempting to send an email.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `postbox.sender` [role](../../postbox/security/index.md#postbox-sender) to the service account.
1. [Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) a static access key. Save the ID and secret key to a secure location. You will not be able to view the secret key properties again after you close the window.
1. [Configure the AWS CLI](../../postbox/tools/aws-cli.md#setup).
