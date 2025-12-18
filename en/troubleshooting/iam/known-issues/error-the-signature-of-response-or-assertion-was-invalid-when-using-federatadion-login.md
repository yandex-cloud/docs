# Fixing the `The signature of response or assertion was invalid` error when authenticating with a federated account


## Issue description {#issue-description}

When you try to use a federated account to access your cloud, you see this error message:

```
"title": "The signature of response or assertion was invalid.\n",
"status": 400,
"instance": "/federations/bpf...",
"request-id": "1a0d23..."
```
## Solution {#issue-resolution}

The certificate used to sign requests on the IdP side has probably been updated or changed. When the certificate changes on the IdP side, you also need to change it on the cloud federation side.

For example, you can add an AD FS certificate to a federation manually. To learn how to do this, see [**Authenticating using Active Directory**](../../../organization/tutorials/federations/integration-adfs.md#add-certificate).

You can also automate the certificate update process using the [`create` method](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the `Certificate` resource or via the [YC CLI](../../../cli/quickstart.md#install).

To update the certificate on the federation side using the YC CLI, run this command:
```
yc organization-manager federation saml certificate create --federation-name <federation_name> \
  --name "my-certificate" \
  --certificate-file test.pem
```

Based on this, you can create a PowerShell script to automate adding a certificate to a federation.
