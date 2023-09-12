# Fixing the «The signature of response or assertion was invalid» error when authorizing by a federated account

## Issue description {#issue-descriprtion}

When you try to use a federated account to access your cloud, you see this error message:

```
    "title": "The signature of response or assertion was invalid.\n",
    "status": 400,
    "instance": "/federations/bpf...",
    "request-id": "1a0d23..."
```

## Solution {#issue-resolution}

The certificate used to sign requests on the IdP provider side has probably been updated or changed.
When the certificate changes on the IdP provider side, you also need to replace it on the cloud federation side.

As an example, you can use a guide on how to add a certificate to a federation manually from AD FS.
This process is described on the ["Authenticating using Active Directory"](../../../organization/operations/federations/integration-adfs.md#add-certificate) documentation page.

You can also automate the certificate update process using the [`create` method](../../../organization/api-ref/Certificate/create.md) for the `Certificate` resource or using [YC CLI](../../../cli/quickstart.md#install).

To update the certificate on the federation side using YC CLI, run the command:

```
yc organization-manager federation saml certificate create --federation-name <FEDERATION_NAME> \
  --name "my-certificate" \
  --certificate-file test.pem
```

Based on this, you can create a PowerShell script to automate adding a certificate to a federation.
