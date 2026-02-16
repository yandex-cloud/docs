---
title: How to sign a file or artifact using Cosign
description: Follow this guide to sign a file or artifact, or verify an electronic signature using the Cosign utility.
---

# Digitally signing files and artifacts using Cosign

You can use digital signature key pairs created with the [Cosign](https://docs.sigstore.dev/signing/quickstart/) utility in {{ kms-name }}. A special build of Cosign allows you to store the created key pair in {{ kms-short-name }}, sign files and artifacts with the pair's private key, and verify a digital signature using its public key.

## Getting started {#before-you-begin}

1. Install a special Cosign build for your OS:

    {% include [install-cosign](../../_includes/kms/install-cosign.md) %}

1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) and save it to the `$YC_IAM_TOKEN` environment variable:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      ```bash
      export YC_IAM_TOKEN=$(yc iam create-token)
      ```

    - PowerShell {#powershell}

      ```powershell
      $env:YC_IAM_TOKEN = $(yc iam create-token)
      ```

    {% endlist %}

## Sign a local file {#create-signature}

1. Create a digital signature key pair and save it to {{ kms-short-name }}:

    ```bash
    cosign generate-key-pair \
      --kms yckms:///folder/<folder_ID>/keyname/<key_pair_name>
    ```

    Where:
    * `<folder_ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to save the new key pair to.
    * `<key_pair_name>`: Name of the signature key pair you are creating.

    Result:

    ```bash
    client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
    client.go:310: generated yckms KEY_ID: 'abj15qhhh98d********'
    Public key written to cosign.pub
    ```

    The utility will return the ID of the created signature key pair and save a public signature key to a local file. Save the key pair ID, you will need it in the next steps.
    
    You can always get the ID of your signature key pair in the [management console]({{ link-console-main }}) or using a [CLI command](../../cli/cli-ref/kms/cli-ref/asymmetric-signature-key/list.md).

1. Sign a local file:

    ```bash
    cosign sign-blob \
      --key yckms:///<key_pair_ID> \
      --tlog-upload=false \
      <file_path>
    ```

    Where:
    * `<key_pair_ID>`: ID of the signature key pair you got in the previous step.
    * `<path_to_file>`: Path to the local file you want to sign.

    Result:

    ```bash
    Using payload from: <file_path>
    client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
    <digital_signature_value>
    ```

    Save the resulting digital signature value. You will need it for signature verification in the next step.

## Verify the digital signature {#verify-signature}

To verify the signature, run the following command:

```bash
cosign verify-blob \
  --key yckms:///<key_pair_ID> \
  --insecure-ignore-tlog \
  --signature "<digital_signature_value>" \
  <file_path>
```

Where:
* `--key`: Signature key pair ID obtained earlier.
* `--signature`: Digital signature value obtained in the previous step.
* `<path_to_file>`: Path to the local file whose signature you want to verify.

Result:

```bash
WARNING: Skipping tlog verification is an insecure practice that lacks of transparency and auditability verification for the blob.
client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
Verified OK
```

#### See also {#see-also}

* [Signing and verifying {{ container-registry-name }} Docker images in {{ managed-k8s-name }}](../../container-registry/tutorials/sign-cr-with-cosign.md).