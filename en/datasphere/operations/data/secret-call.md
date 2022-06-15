# Referencing a secret

Once you create a secret, you can reference it from your code as an environment variable.

{% list tabs %}

- Python

   ```python
   import os
   os.environ # list of all environment variables
   os.environ[‘SECRET_NAME’] # secret SECRET_NAME from environment variables
   ```

- bash

   ```bash
   #!:bash
   printenv SECRET_NAME
   ```

{% endlist %}