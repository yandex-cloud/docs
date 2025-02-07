When accessing a resource of an AWS-compatible service ({{ objstorage-name }}), the static access key and its ID will be extracted from the {{ lockbox-name }} secret into special environment variables, which will be used for request authentication.

This approach will ensure safe storage and use of your key when accessing the services.

You can use the following tools to create an infrastructure: