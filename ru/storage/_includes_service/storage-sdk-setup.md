1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1.  В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = {{ region-id }}
    endpoint_url = https://{{ s3-storage-host }}
    ```

    {% note info %}

    Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому {{ objstorage-name }} принимает также значение `us-east-1`.

    {% endnote %}