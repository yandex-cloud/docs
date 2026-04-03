[Some {{ yandex-cloud }} services](../../iam/concepts/authorization/ephemeral-keys.md#supported-services) support authentication with [ephemeral access keys](../../iam/concepts/authorization/ephemeral-keys.md).

Ephemeral access keys are created for [Yandex accounts](../../iam/concepts/users/accounts.md#passport), [federated accounts](../../iam/concepts/users/accounts.md#saml-federation), [local users](../../iam/concepts/users/accounts.md#local), and [service accounts](../../iam/concepts/users/service-accounts.md).


## Creating an ephemeral access key {#create}

{% include [access-control-sa-ephemeralkey-notice](./access-control-sa-ephemeralkey-notice.md) %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. View the description of the command for creating an ephemeral access key:

      ```bash
      yc iam access-key issue-ephemeral --help
      ```

  1. Create an ephemeral access key:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <account_ID> \
        --session-name <session_name> \
        --policy <file_path> \
        --duration <lifespan>
      ```

      Where:

      * `--subject-id`: Service account ID. If this parameter is not specified, the system will generate the key for the user sending the request.
      * `--session-name`: Session name, 1 to 64 characters long. It is required for identifying a session if the service account is [impersonated](../../iam/concepts/access-control/impersonation.md) for multiple users. This is a required setting.
      * `--policy`: Path to the [access policy](../../storage/concepts/policy.md) file as a [data schema](../../storage/s3/api-ref/policy/scheme.md) in JSON format. It this parameter is not specified, the key will grant full [bucket](../../storage/concepts/bucket.md) access.
      * `--duration`: Key lifespan, from `15m` to `12h`. It this parameter is not specified, the key lifespan will be limited to that of the current session's IAM token.

      Result:

      ```text
      access_key_id: ajelprpohp8t********
      secret: YCOs05v-KRXqhYpUINdWArH4MINhMyJ6CGU********
      session_token: s1.9muilY********
      expires_at: "2025-12-16T06:23:51.383485065Z"
      ```

  1. Save `access_key_id`, the `secret` key, and `session_token`. You will not be able to get these values again.

{% endlist %}


## Testing bucket access {#test}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Make sure the account you created the ephemeral access key for has access to the relevant bucket. If it does not, [assign](../../iam/operations/sa/assign-role-for-sa.md) your account the required [role](../../storage/security/index.md#roles-list), e.g., [storage.viewer](../../storage/security/index.md#storage-viewer), for the bucket.

      Alternatively, you can use [ACL](../../storage/security/acl.md) permissions for a bucket.

  1. Add a new profile to `~/.aws/credentials`:

      ```text
      [<profile_name>]
      aws_access_key_id     = <key_ID>
      aws_secret_access_key = <secret_key>
      aws_session_token     = <session_token>
      ```

      Specify in your profile the values you got when creating the ephemeral access key:

      * `aws_access_key_id`: `access_key_id` key ID.
      * `aws_secret_access_key`: `secret` key.
      * `aws_session_token`: `session_token`.

  1. Save to the client device the object from the prefix of the bucket access was granted to:

      ```bash
      aws --endpoint https://{{ s3-storage-host }} s3 cp \
        s3://<bucket_name>/<prefix><object_name> ./
      ```

      Result:

      ```text
      download: s3://<bucket_name>/<prefix><object_name> to ./<object_name>
      ```

{% endlist %}