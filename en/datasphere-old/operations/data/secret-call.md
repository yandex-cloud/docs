# Referencing a secret

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

Once you create a secret, you can reference it from your code as an environment variable.

{% list tabs %}

- Python

   ```python
   import os
   os.environ # list all environment variables
   os.environ[‘SECRET_NAME’] # get the secret SECRET_NAME from environment variables
   ```

- bash

   ```bash
   #!:bash
   printenv SECRET_NAME
   ```

{% endlist %}