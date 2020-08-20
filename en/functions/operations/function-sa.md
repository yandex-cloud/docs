# Using functions to get an IAM token for a service account

If the function version was created with a service account, you can get an IAM token for it:

- [From the context when calling a function](#context).
- [From the VM metadata using the API](#api).

## Get an IAM token from the context {#context}

If you create a function in a runtime environment supported by {{ sf-name }}, you can get an IAM token from the handler [context](../concepts/function.md#model-desc) (which is the second parameter: `context`).

To get an IAM token, add the row `token: context.token` to the function code and invoke the function:

1. Save the following code to a file named `index.js`:

    ```
    exports.handler = async function (event, context) {
        return {
            token: context.token,
            event: event
        };
    };
    ```

1. [Create a function version](../operations/function/version-manage.md#version-create) using the `index.js` file.

1. [Run the function](../operations/function/function-invoke.md).

    The function response looks like this:

    ```json
    {
      "token": {
        "access_token": "CggVAgAAABoBMRKABHGgpZ......",
        "expires_in": 42299,
        "token_type": "Bearer"
      },
      "event": {
        "payload": ""
      }
    }
    ```

    The IAM token will be returned in the `access_token` field of the response. The remaining lifetime of the IAM token is specified in the `expires_in` field.

## Get an IAM token using the API {#api}

If you work with Yandex.Cloud from inside a VM, you can get an IAM token from the metadata service in [Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata) format, and also add this logic to your function. Read more about this in [Working with Yandex.Cloud from inside a VM](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

