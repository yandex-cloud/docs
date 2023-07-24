1. Clone the [{{ yandex-cloud }} API repository](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. [Create](../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-short-name }} API.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-tts }}` role, or higher, to the service account, which will allow it to work with {{ speechkit-name }} in the folder it was created in.
1. [Get](../../iam/operations/iam-token/create-for-sa.md) an IAM token for the service account.
