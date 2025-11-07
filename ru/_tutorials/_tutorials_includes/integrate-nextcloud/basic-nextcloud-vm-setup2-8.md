В открывшемся окне на панели слева в блоке **Administration** выберите ![app-dark-icon](../../../_assets/tutorials/integrate-nextcloud/app-dark-icon.svg) **External storage** и в открывшемся окне в блоке **External storage** задайте настройки интеграции с {{ objstorage-name }}:

1. В секции **External storage** выберите `Amazon S3`.
1. В секции **Authentication** выберите `Access key`.
1. В секции **Configuration**:

    * В поле **Bucket** укажите имя созданного ранее бакета. Например: `my-nextcloud-bucket`.
    * В поле **Hostname** укажите `{{ s3-storage-host }}`.
    * В поле **Port** укажите `443`.
    * В поле **Access key** вставьте полученный ранее идентификатор статического ключа доступа.
    * В поле **Secret key** вставьте полученный ранее секретный ключ статического ключа доступа.
1. В секции **Available for** включите опцию **All people**.
1. В правой части редактируемого блока нажмите значок ![check](../../../_assets/console-icons/check.svg), чтобы сохранить изменения.

    Для подтверждения действия во всплывающем окне введите ваш пароль администратора Nextcloud.