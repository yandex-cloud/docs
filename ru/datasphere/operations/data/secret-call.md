# Вызов секрета 

Созданный секрет можно использовать в коде как переменные окружения.

{% list tabs %}

- Python

   ```python
   import os
   os.environ # список всех переменных окружения
   os.environ['SECRET_NAME'] # секрет SECRET_NAME из переменных окружения
   ```

- bash

   ```bash
   #!:bash
   printenv SECRET_NAME
   ```

{% endlist %}