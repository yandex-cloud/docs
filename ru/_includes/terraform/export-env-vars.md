Запишите чувствительные данные профиля: IAM-токен, идентификатор облака и каталога в переменные окружения:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export YC_TOKEN=$(yc iam create-token)
  export YC_CLOUD_ID=$(yc config get cloud-id)
  export YC_FOLDER_ID=$(yc config get folder-id)
  ```

- PowerShell {#powershell}

  ```powershell
  $Env:YC_TOKEN=$(yc iam create-token)
  $Env:YC_CLOUD_ID=$(yc config get cloud-id)
  $Env:YC_FOLDER_ID=$(yc config get folder-id)
  ```

{% endlist %}

Где:

`yc iam create-token` — получение IAM-токена для текущей сессии.
`yc config get cloud-id` — получение идентификатора облака из текущего профиля CLI.
`yc config get folder-id` — получение идентификатора каталога из текущего профиля CLI.


В результате в переменных окружения сохранятся IAM-токен, а также идентификатор облака и идентификатор каталога.
