# List of pre-installed software

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Packages for data analysis and machine learning are pre-installed in {{ ml-platform-short-name }}. If you are missing a package, you can [install it](../operations/projects/install-dependencies.md) right from the notebook cell.

{% include [packs](../../_includes/datasphere/migration/preinstalled-packs.md) %}

## Package versions {#versions}

To view the version of the installed package, in the notebook cell, run the command:
```js
%pip show <Package name>
```

To view the list of installed packages and their versions, in the notebook cell, run the command:
```js
%pip list
```

Python 3.8 is used in {{ ml-platform-short-name }} projects by default. If you need Python 3.7, follow the instructions in [{#T}](../operations/projects/python-version.md).

## Updating {#update}

You can both upgrade any pre-installed package to a later version or roll it back to an earlier version.
Upgraded versions are preserved when you change environments or restart your project.

To upgrade a library to the latest version, run the following command in the notebook cell:
```js
%pip install <library name> - U
```

For example, to upgrade TensorFlow to its latest version, run the command:
```js
%pip install tensorflow -U
```

To upgrade a library to a specific version, run the following command in the notebook cell:
```js
%pip install <library name>==<version>
```

For example:
```js
%pip install tensorflow==2.3.1
```

Please keep in mind that the TensorFlow version installed by default depends on your [selected Python version](../operations/projects/python-version.md). If your project runs Python 3.7, TensorFlow 1.15 is installed, and if it runs Python 3.8, TensorFlow 2.6 is installed.

{% note warning %}

Updating a pre-installed library may introduce new data types that are not supported in {{ ml-platform-short-name }} and not versioned. You'll see a warning when you run cells with such types. In this case, please notify technical support about the libraries upgraded and non-supported data types. To be sure that versioning works correctly, roll back the library version.

{% endnote %}

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)