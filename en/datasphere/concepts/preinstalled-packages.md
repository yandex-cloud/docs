# List of pre-installed software

{{ ml-platform-short-name }} already has pre-installed packages for data analysis and machine learning. If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell.

You have the option to select one of the standard DS Default images or to [create a custom environment](../operations/user-images.md) for working in {{ ml-platform-name }}. Standard images differ in their Python versions and sets of libraries.

By default, an image with Python 3.10 is used in {{ ml-platform-short-name }} projects. If you need Python 3.7 or Python 3.8, follow the guide in [{#T}](../operations/projects/python-version.md).

## List of pre-installed packages {#preinstalled-packages}

All images come with preinstalled NVIDIA-SMI 525.125.06, driver version 525.125.06, and CUDA version 12.0.

To view a list of installed packages and their versions, you can also run the following command in a notebook cell:

```js
%pip list
```

{% include [packs](../../_includes/datasphere/migration/preinstalled-packs.md) %}

{% note warning %}

The DS Default (Python 3.7) system image is incompatible with the g2.x (GPU A100) [configurations](configurations.md).

{% endnote %}

## Updating {#update}

You can upgrade any pre-installed package to a later version or roll it back to an earlier one.
Upgraded versions are preserved when you change environments or restart your project in [{{ ds }} mode](project.md#serverless).

To upgrade a library to the latest version, run the following command in the notebook cell:

```js
%pip install <library_name> -U
```

For example, to upgrade TensorFlow to its latest version, run this command:

```js
%pip install tensorflow -U
```

To upgrade a library to a specific version, run the following command in the notebook cell:

```js
%pip install <library_name>==<version>
```

Here is an example:

```js
%pip install tensorflow==2.3.1
```

For more information on working with the `pip` package management system, refer to the [official Python documentation](https://docs.python.org/3/installing/index.html).

{% note warning %}

Updating a pre-installed library may introduce new data types that are not supported in {{ ml-platform-short-name }}. You will see a warning when you run cells with such data types. In this case, notify the support team about the updated libraries and the non-supported data types. For correct operation, roll back the library version.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)