# Secure password transmission to an initialization script

You can use an initialization script when creating a VM based on a Windows image. Such a script may contain system user passwords To protect sensitive data, use [{{ lockbox-full-name }}](../../lockbox/) tools and [{{ kms-full-name }}](../../kms/) keys instead of explicitly specifying settings in the script.

In this tutorial, you will create a Windows VM using an initialization script which retrieves usernames and passwords from Yandex Lockbox.

You can create a Windows VM while protecting sensitive information in the initialization script using one of the following tools:
