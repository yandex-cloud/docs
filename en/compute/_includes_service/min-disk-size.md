{% note info %}

The `min-disk-size` value must be greater than the volume of the source data in the image and greater than the size of the virtual disk specified in the image.

If the `min-disk-size` value you specify is less than that allowed, an error will occur and no image will be created. The error description will contain the minimum value in bytes, for example, `Minimal disk size should be greater than or equal to 10737418240`.

If no `min-disk-size` is specified, the minimum value will be used.

{% endnote %}
