Signing artifacts enhances security to ensure your software validity, integrity, reliability, and compliance with the requirements.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifacts are signed while building an application.

{% endlist %}

**Guides and solutions to use:**

To sign artifacts within a pipeline, you can use [Cosign](https://github.com/sigstore/cosign), a third-party command line utility for signing [artifacts](https://docs.sigstore.dev/signing/quickstart/), images, and [in-to-to attestations](https://github.com/in-toto/attestation/tree/main/spec/predicates). Then you can upload these artifacts to {{ container-registry-full-name }}.

A special build of Cosign allows you to store the created [digital signature key pair](../../../kms/concepts/asymmetric-signature-key.md) in [{{ kms-full-name }}](../../../kms/quickstart/index.md), sign files and artifacts with the private key of the pair, and verify a digital signature using its public key.

To learn more, see [{#T}](../../../container-registry/tutorials/sign-cr-with-cosign.md).