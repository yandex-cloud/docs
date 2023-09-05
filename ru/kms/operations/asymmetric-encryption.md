# Асимметричное шифрование данных

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

В этом разделе вы узнаете, как в {{ kms-short-name }} шифровать и расшифровывать данные по схеме [асимметричного шифрования](../concepts/asymmetric-encryption.md).

## Перед началом работы {#before-you-begin}

Шифрование в этой инструкции выполняется с помощью утилиты [OpenSSL](https://www.openssl.org/). Если эта утилита у вас не установлена, установите ее:

{% include [install-openssl](../../_includes/kms/install-openssl.md) %}

## Зашифруйте данные {#encryption}

1. Если у вас еще нет ключевой пары шифрования, [создайте](./asymmetric-encryption-key.md#create) ее.

1. Получите открытый ключ шифрования и сохраните его:

    {% list tabs %}

    - Консоль управления
    
      1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужная ключевая пара.
      1. В списке сервисов выберите **{{ kms-name }}**.
      1. На панели слева выберите **Асимметричные ключи**.
      1. Перейдите на вкладку **Шифрование**.
      1. В строке с нужной ключевой парой нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) и выберите **Публичный ключ**.
      1. В открывшемся окне нажмите кнопку **Скачать**, чтобы скачать публичный ключ шифрования.
    
    - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Посмотрите описание команды CLI для получения открытого ключа шифрования:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key --help
          ```

      1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара шифрования.

      1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}
      
      1. Получите открытый ключ шифрования, указав полученный ранее идентификатор ключевой пары:

          ```bash
          yc kms asymmetric-encryption-crypto get-public-key \
            --id <идентификатор_ключевой_пары>
          ```

          Результат:

          ```bash
          key_id: abj9g2dil5sj********
          public_key: |
          -----BEGIN PUBLIC KEY-----
          MIIB...
          ...QAB
          -----END PUBLIC KEY-----
          ```
          
          Сохраните полученный ключ в файл, например, в файл `public.key`. Убедитесь, что в файле отсутствуют пробелы в начале строк.

    {% endlist %}
    
1. Зашифруйте файл с сообщением с помощью утилиты OpenSSL:

    {% include [asymmetric-encryption-message-size-note](../../_includes/kms/a-encryption-message-size-note.md) %}

    ```bash
    openssl pkeyutl \
      -in <путь_к_файлу_с_сообщением> \
      -encrypt \
      -pubin \
      -inkey <путь_к_файлу_с_публичным_ключом> \
      -pkeyopt rsa_padding_mode:oaep \
      -pkeyopt rsa_oaep_md:sha256 \
      -pkeyopt rsa_mgf1_md:sha256 | base64 > <путь_к_файлу_с_шифртекстом>
    ````

    Где:
    * `-in` — путь к файлу с сообщением, которое нужно зашифровать.
    * `-inkey` — путь к файлу с публичным ключом шифрования.
    * `<путь_к_файлу_с_шифртекстом>` — путь к файлу, в котором будет сохранено зашифрованное сообщение.
    
    В результате выполнения команды зашифрованное сообщение сохранится в указанном файле в кодировке `base64`.
    
## Расшифруйте данные {#decryption}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для расшифрования данных с помощью закрытого ключа шифрования:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt --help
      ```

  1. [Получите](../../resource-manager/operations/folder/get-id.md) идентификатор каталога, в котором сохранена ключевая пара шифрования.

  1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}
  
  1. Расшифруйте шифртекст:
  
      ```bash
      yc kms asymmetric-encryption-crypto decrypt \
        --id <идентификатор_ключевой_пары> \
        --ciphertext-file <путь_к_файлу_с_шифртекстом> \
        --plaintext-file <путь_к_файлу_с_расшифрованным_сообщением> \
        --inform base64
      ```

      Где:

      * `--id` — полученный ранее идентификатор ключевой пары шифрования.
      * `--ciphertext-file` — путь к файлу, содержащему шифртекст в кодировке `base64`.
      * `--plaintext-file` — путь к файлу, в который будет расшифровано сообщение.

      Результат:
      
      ```bash
      key_id: abjt22qubivb********
      plaintext: 0KHQv...QuSE=
      ```

      В результате выполнения команды зашифрованное сообщение будет расшифровано закрытым ключом шифрования в {{ kms-short-name }}, а расшифрованный текст сохранится в указанном файле.

{% endlist %}