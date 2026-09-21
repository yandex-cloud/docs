# Securely providing a password to an initialization script

You can use an initialization script when creating a Windows VM. Such a script may contain the administrator’s and other users’ logins and passwords. To protect sensitive data, use [{{ lockbox-full-name }}](../../lockbox/) features and [{{ kms-full-name }}](../../kms/) keys rather than specifying the credentials directly in the script.

In this tutorial, you will create a Windows VM using an initialization script which retrieves usernames and passwords from Yandex Lockbox.

You can create a Windows VM while protecting sensitive information in the initialization script using one of the following tools:
