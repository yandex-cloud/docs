# Module

* [General information](#common-module)
* [JavaScript](#javascript)
* [Documentation](#docs)
* [Using](#usage)
* [Versioning](#versioning-module)
* [Examples](#examples)

## General information {#common-module}

A module is a fragment of code that exports certain functions/variables/constants to be used in scripts.

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/javascript.md) %}

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/docs.md) %}

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/usage.md) %}

## Versioning {#versioning-module}

To learn more, see the [section](../../versioning.md).

You can include the saved version of the module like this:

```js
const myUnreleasedModule = require('my/module@saved');
```

{% include [include](../../../../_includes/datalens/internal/editor/widgets/module/examples.md) %}
