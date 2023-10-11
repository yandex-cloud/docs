# Working with YDB via Terraform {#ydb-terraform-working}

[Terraform](https://www.terraform.io) is an open-source software solution developed by HashiCorp. It is designed for managing cloud infrastructure based on the Infrastructure as Code (IaC) paradigm. This means that the desired state of the infrastructure is described in configuration files, and Terraform applies these changes to the infrastructure using auxiliary programs (providers). You write Terraform `.tf` configuration files using a special language, [HCL](https://developer.hashicorp.com/terraform/language/syntax) (HashiCorp Configuration Language). The HCL code is very similar to JSON and organized into logical sections within configuration files.

With Terraform, you can create and modify YDB databases, as well as manage their resources: tables, indexes, and table changefeeds. Keep in mind that the configuration file created for managing YDB becomes the single point of control for the database state. Make sure to make all your database changes via it. This is because after every successful change, Terraform creates a state file, i.e., a textual representation of the current database state, and further changes rely on it.

If you update the database state via the configuration file, and then change something else via the management console or CLI, Terraform will remain unaware of these changes until you run the terraform plan or terraform refresh commands. These commands will force Terraform to compare the current state of resources with the saved state file. However, this does not mean that Terraform will automatically accept new changes and update the state file. The next time you run the terraform apply command, Terraform will try to bring the resources back to the state described in your configuration file, which could overwrite or delete your external changes. Therefore, to avoid conflicts of YDB state changes, make sure to use the single point of access, i.e., the configuration file.

We offer the `yandex_ydb` provider to connect Terraform to YDB, and the [yc](../../cli/quickstart.md) console client for authentication.

This section contains the following instructions:
1. [Obtaining authentication data](credentials.md).
1. [Installing and configuring Terraform and the YDB provider](install.md).
1. [Creating configuration files and connecting to YDB](configure.md).
1. [Creating and editing parameters of a serverless database](serverless-database.md).
1. [Creating and editing parameters of a dedicated database](dedicated-database.md).
1. [Creating row-based tables in a database](row-tables.md).
1. [Creating a table changefeed](cdc.md).
