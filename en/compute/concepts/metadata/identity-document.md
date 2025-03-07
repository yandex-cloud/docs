---
title: Identity document in {{ compute-name }} VMs
description: In this article, you will learn about an identity document in the {{ compute-full-name }} VM metadata service.
---

# Identity document

When you create a VM, an identity document that stores information about the VM is generated. It contains the IDs of the VM, Marketplace product, disk image, etc. VMs can request information about themselves from the metadata service.

For more information on how to get an identity document, see [{#T}](../../operations/vm-metadata/get-identity-document.md).

## Signed identity documents {#signed-identity-documents}

If intending to use the contents of an identity document for critical tasks, you should check its contents and confirm its authenticity prior to using it.

Apart from identity documents, the VM [metadata service](../vm-metadata.md) provides their cryptographic signatures. You can use these signatures to verify the document's origin, authenticity, and integrity.

For more information on how to check the contents of the identity document and validate it, see [{#T}](../../operations/vm-metadata/get-identity-document.md#check-id-signature).

#### See also {#see-also}

* [Getting a VM identity document](../../operations/vm-metadata/get-identity-document.md)
* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./accessing-metadata.md)