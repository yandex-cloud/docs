# Questions about regular export of details

#### What is the earliest past period I can export data for? {#earliest-period}
You can export data starting from the date if creating your [billing account](../../billing/concepts/billing-account.md).

#### What will happen if I specify a date for which there is no data when creating an export for past periods? {#no-data-period}
The system will export data starting from the date of creating your [billing account](../../billing/concepts/billing-account.md). No error will occur.

#### Do the CSV files for past periods get updated after their initial export? {#csv-files-update}
Files for past periods get updated if there are changes in consumption data for a previously exported period.

#### What specific bucket encryption types are supported for regular export? {#encryption-types}
Regular export supports {{ objstorage-full-name }} buckets with [{{ kms-full-name }}](../../kms/) encryption keys.

For more information, refer to [Encryption in {{ objstorage-name }}](../../storage/concepts/encryption.md) in the {{ objstorage-full-name }} guide.

#### How can I verify that an export to an encrypted bucket was successful? {#check-encrypted-bucket}
Go to the {{ objstorage-full-name }} bucket you specified when setting up a [regular export](../../billing/operations/get-folder-report.md#regular-download). Make sure the CSV files are there. The files will appear within 5-10 minutes after you create a regular export. Exports covering long periods (more than a year) may take more time.

#### Can I reconfigure a regular export after I create it? {#change-parameters}
No. To change its settings (language, type of detail, bucket), [stop](../../billing/operations/get-folder-report.md#stop-export) the existing regular export and [set up a new one](../../billing/operations/get-folder-report.md#set-up-regular-download).

#### Can I create an export for past periods using an encrypted bucket? {#past-period-encrypted}
Yes. You can create an export for past periods using an encrypted bucket.

#### What happens if export to a bucket fails? {#export-failed}
The regular export's status will change to `Failed`. The billing account owner will get an email.
