# Available commands

The list of commands available in the notebook is made up of standard commands with some restrictions and additions. View the list of standard commands in the [IPython documentation](https://ipython.readthedocs.io/en/stable/interactive/magics.html). Restrictions and additions are given below.

## Disabled standard commands {#block}

Standard commands that aren't available in the notebook:

* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

## Additional commands {#extension}

Additional commands available in the notebook:

* `%%state_exclude [variable names]`: Excludes the specified variables when saving a state.
* `%%state_include [variable names]`: Adds the specified variables when saving a state.
* `%%state_include_all`: Returns all variables when saving a state.
* `%%state_exclude_ls`: Returns a list of all variables that were excluded when saving a state.

#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)

