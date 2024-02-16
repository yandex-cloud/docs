# Available commands

{% include [serverless-deprecation-note](../../_includes/datasphere/serverless-deprecation-note.md) %}

The list of commands available in a notebook consists of regular commands with some restrictions and additions. You can view the list of regular commands in the [IPython documentation](https://ipython.readthedocs.io/en/stable/interactive/magics.html). For the restrictions and additions, see below.

## Disabled regular commands {#block}

Regular commands that are not available in a notebook:
* `%%bash`
* `%%perl`
* `%%python`
* `%%python2`
* `%%python3`
* `%%ruby`
* `%%script`
* `%%sh`

### Alternative use of blocked commands {#restriction}

#### %%bash {#bash}

To run bash commands, put `bash` explicitly at the beginning of the cell:

* With no configuration specified, which means using the default configuration.

   ```
   #!:bash
   ```
* With a configuration specified:

   ```
   #!<configuration_name>:bash
   ```

   > For example, to run commands in the c1.4 configuration, enter `#!c1.4:bash`

The available configurations are described in [{#T}](configurations.md).

**Restrictions**

The following restrictions apply to using bash commands:
* Background jobs, such as `sshd`, are not supported.
* Launching `pip` is not supported; use the `%pip` format instead.

## Additional commands {#extension}

This section covers additional commands available in a notebook.

### Managing state saving {#state}

Commands to exclude and add variables when saving a state:
* `%state_exclude [variable names]`: Excludes the specified variables when saving a state.
* `%state_include [variable names]`: Adds the specified variables when saving a state.
* `%state_include_all`: Returns all variables when saving a state.
* `%state_exclude_ls`: Returns a list of all variables that were excluded when saving a state.

### Adding read-only variables {#readonly}

The state of cells is saved after they are run and the variable values are overwritten. Saving large variables may take some time. If a variable is intended to store a constant value, it can be declared as a read-only variable. Such variables are not overwritten when saving and serializing data, which speeds up these operations.

To specify that a variable in a cell is read-only, use this command:

```
#pragma readonly/ro <variable_1>, <variable_2>
```

Put this command in the first lines of the cell before the code; you may also put it after the configuration update (`#!c1.4`,&nbsp;`#!g1.1`).

Here are some options for running the command (for example purposes, we use the `x` and `y` variables):
* `#pragma readonly x, y`
* `#pragma readonly x y`
* `#pragma readonly x`
* `#pragma readonly y`
* `#pragma ro x, y`


#### See also {#see-also}

* [{#T}](../operations/projects/install-dependencies.md)
* [{#T}](configurations.md)
* [{#T}](limits.md)
* [{#T}](../operations/index.md)