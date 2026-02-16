To get a list of available images using the CLI, run this command:

```bash
yc compute image list --folder-id standard-images
```

Result:

```text
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
|          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
...
| fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
| fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
| fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
...
+----------------------+-------------------------------------+--------------------------+----------------------+--------+
```

Where:

* `ID`: Image ID.
* `NAME`: Image name.
* `FAMILY`: ID of the [image family](../compute/concepts/image.md#family) the image belongs to.
* `PRODUCT IDS`: IDs of {{ marketplace-full-name }} [products](../marketplace/concepts/product.md) associated with the image.
* `STATUS`: Current status of the image. It may take one of the following values:

    * `STATUS_UNSPECIFIED`: Image status is not defined.
    * `CREATING`: Image is being created.
    * `READY`: Image is ready to use.
    * `ERROR`: You cannot use the image due to an issue.
    * `DELETING`: Image is being deleted.