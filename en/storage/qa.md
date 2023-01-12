# Questions and answers about {{ objstorage-name }}

#### What is {{ objstorage-full-name }}? {#qa-what-is}

{{ objstorage-full-name }} is a universal scalable solution for data storage. It is the perfect choice both for high-load services that require reliable and fast access to data, and for projects with minimal requirements for storage infrastructure.

#### What can I do with {{ objstorage-full-name }}? {#qa-usecases}

With {{ objstorage-name }}, you can:
* Store your project files (website or server app) in {{ objstorage-name }} and make access to them either public or private. Files can be in any format.
* Store large archive data (up to 5TB per file) and make them available only to those you allow.
* Enable shared work with data inside a distributed organization.
* Provide access to your data from any place on Earth where internet access is available.

#### How do I get started with {{ objstorage-full-name }}? {#qa-quickstart}

To get started with {{ objstorage-name }}:
1. Sign up for {{ yandex-cloud }}.
1. Create a folder.

   At this step, you can already use {{ objstorage-name }} via the {{ yandex-cloud }} management console. You can create and delete buckets, as well as upload objects to and download them from buckets.
1. Get static keys to use the {{ objstorage-name }} HTTP API or available SDKs and apps.

For more detailed instructions, see [{#T}](quickstart.md) and [{#T}](s3/index.md).

#### What data formats can I store? {#qa-data-types}

You can store data in any format. {{ objstorage-full-name }} saves data in its original form without any modification.



#### How can I leave feedback on {{ objstorage-full-name }}? {#qa-feedback}

Use the feedback form on the support page in the management console.


#### How do I contact technical support? {qa-support-channels}


You can contact technical support in the management console under [Support]({{ link-console-support }}).



#### How much data can I store? {#qa-storage-volume}

Read the section [{#T}](concepts/limits.md).

#### How can I delete multiple objects at a time? {#qa-delete-multiple-objects}

You can delete multiple objects via the {{ yandex-cloud }} management console or the API using the [deleteMultipleObjects](s3/api-ref/object/deletemultipleobjects.md) method.

#### What does {{ yandex-cloud }} do with the data I store in {{ objstorage-full-name }}? {#qa-data-use-by-platform}

The data is saved in the form in which it was transmitted by the user.



#### Does Yandex use {{ objstorage-name }} to store its own data? {#qa-usage-by-yandex}

Yes. {{ objstorage-name }} is used in the Yandex infrastructure. Several Yandex services store their websites' static data in the storage.



#### What data consistency model does {{ objstorage-full-name }} use? {#qa-consistency}

For overwritable (PUT) and removable (DELETE) objects, the strong consistency model is used.

#### What AWS S3 features are supported in {{ objstorage-full-name }}? {#qa-s3-support}

{{ objstorage-name }} supports:
* Authorization using static tokens.
* Some HTTP API methods. For a full list of supported methods, see the [API reference](s3/api-ref/index.md).



#### Where is my data stored? {#qa-where}

Data is stored in several geographically distributed data centers located in Russia. For more information, see [{#T}](../overview/concepts/geo-scope.md).



#### How is my data protected in {{ objstorage-full-name }}? {#qa-data-security}

Physical media is located in {{ yandex-cloud }} data centers, wich are highly secure facilities.

Data is stored in an encrypted format and none of those who have access to the physical media can read the data.

By default, the storage is accessed via HTTPS.

#### How do you guarantee the performance of {{ objstorage-full-name }}? {#qa-timings}

{{ objstorage-name }} has internal SLAs and SLOs that guarantee a specific speed of sending data to the customer, which, among other things, depend on the storage class.

The {{ objstorage-name }} response time depends on multiple factors:
* Client-side performance (network speed, CPU load, or disk subsystem load).
* The speed of trunk connections, connections between data centers, or client-server connections.
* Performance of {{ objstorage-name }} itself.

This is why we can't specify a particular response time value. However, we do not consider a sharp increase in response time or a marked decrease in the speed of sending data to be the norm, and keep working to improve the technical characteristics of {{ objstorage-name }}.



{% include [fz-152.md](../_qa/fz-152.md) %}



{% include [logs.md](../_qa/logs.md) %}