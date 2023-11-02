# Getting started with {{ iam-name }}

{{ iam-name }} (IAM) allows you to manage access to {{ yandex-cloud }} resources. With IAM, only users with the relevant access rights can perform operations on resources.

You can get started with your Yandex accounts or service accounts:

* A _Yandex account_ is your [Yandex](https://yandex.ru/support/passport/index.html) or [Yandex 360](https://360.yandex.ru/) account.

   The following users can [get started using their Yandex accounts](quickstart.md):

   * Organization owners (`organization-manager.organizations.owner`).
   * Organization administrators (`organization-manager.admin`).
   * Cloud owners (`resource-manager.clouds.owner`).
   * Cloud administrators (`admin`).

   Read [this guide](quickstart.md#before-you-begin) to find out about the roles of your account.

* [Service accounts](concepts/users/service-accounts.md) are auxiliary accounts that your programs can use to perform operations in {{ yandex-cloud }}. Service accounts are free of charge. They allow you to flexibly manage access for your programs.

   Not only cloud owners and administrators, but also folder administrators (`admin`) [can get started with service accounts](quickstart-sa.md).
