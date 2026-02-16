{% note info %}

The `min-disk-size` value must be greater than the size of the source data in the image and greater than the size of the virtual disk specified in the image.

If you set `min-disk-size` below the allowed minimum, you will get an error and no image will be created. The error message will state the minimum value in bytes, e.g., `Minimal disk size should be greater or equal than 10737418240`.

If you omit `min-disk-size`, the minimum value will be used.

{% endnote %}
