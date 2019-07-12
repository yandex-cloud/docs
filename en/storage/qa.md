# Questions and answers about Object Storage

#### What is Yandex Object Storage? {#qa-what-is}

Yandex Object Storage is a universal, scalable solution for data storage. It is the perfect choice both for high-load services that require reliable and fast access to data, and for projects with minimal requirements for storage infrastructure.

#### What can I do with Yandex Object Storage? {#qa-usecases}

With Object Storage, you can:

- Store files of your project (website or server app) in Object Storage and make access to them either public or private. Files can be in any format.
- Store large archive data (up to 5 TB per file) and make them available only to those you allow.
- Enable collaboration with data inside a distributed organization.
- Provide access to your data from any place on Earth where internet access is available.

#### How do I get started with Yandex Object Storage? {#qa-quickstart}

To start working with Object Storage:

1. Sign up for Yandex.Cloud.
1. Create a folder.
At this step, you can already use Object Storage via the Yandex.Cloud management console. You can create and delete buckets, as well as upload objects to and download them from buckets.
1. Get static keys to use the Object Storage HTTP API or available SDKs and apps.

For more detailed instructions, see the sections [#T](quickstart.md) and [#T](s3/index.md).

#### What data formats can I store? {#qa-data-types}

You can store data in any format. Yandex Object Storage saves data in its original form without any modification.

#### How can I leave feedback on Yandex Object Storage? {#qa-feedback}

Use the feedback form on the support page in the management console.

#### How do I contact technical support? {qa-support-channels}

You can contact technical support using any of these methods:

{% include [support-channels](../_includes/support-channels.md) %}

#### How much data can I store? {#qa-storage-volume}

Read the section [#T](concepts/limits.md).

#### How can I delete multiple objects at a time? {#qa-delete-multiple-objects}

You can delete multiple objects via the Yandex.Cloud management console or the API using the method [deleteMultipleObjects](s3/api-ref/object/deletemultipleobjects.md).

#### What does Yandex do with the data I store in Yandex Object Storage? {#qa-data-use-by-yandex}

The data is saved in the form in which it was transmitted by the user.

#### Does Yandex use Object Storage to store its own data? {#qa-usage-by-yandex}

Yes, it does. Object Storage is used in the Yandex infrastructure. Several Yandex services store their websites' static data in the storage.

#### What data consistency model does Yandex Object Storage use? {#qa-consistency}

For overwritable (PUT) or removable (DELETE) objects, the eventual consistency model is used.

#### What AWS S3 features are supported in Yandex Object Storage? {#qa-s3-support}

Object Storage supports:

- Authorization using static tokens.
- Some HTTP API methods. For a full list of supported methods, see the [API reference](s3/api-ref/index.md).

#### Where is my data stored? {#qa-where}

Data is stored in several geographically distributed data centers located in Russia.

#### How is my data protected in Yandex Object Storage? {#qa-data-security}

Physical media are located in Yandex's data centers that are high security facilities.

Data is stored in an encrypted format and none of those who have access to the physical media can read the data.

By default, the storage is accessed via HTTPS.

