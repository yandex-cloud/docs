# Batch processing

Batch processing is a technology for processing data that involves preparing aggregated information based on large arrays of data. This type of data analysis is traditional and is used for processing data stored, for example, in a DBMS.

Data volumes increase with time, but that doesn't mean all data is accessed often. So, rarely used data is usually transferred to storage systems like {{ objstorage-full-name }} which are much more cost-effective than DBMS.

Data is stored in {{ objstorage-full-name }} as a file structure with directories and files. To store data in files, standard storage formats like CSV and JSON are usually used.

{{ yq-full-name }} lets you access data stored in {{ objstorage-full-name }} in the same way as data stored in a DBMS by making queries in an SQL-like language called [YQL](https://ydb.tech/docs/en/yql/reference/syntax/).

{{ objstorage-full-name }} is usually used to manage large amounts of data. {{ yq-full-name }} analyzes the volume of data to handle and runs dozens to hundreds of concurrent data processing jobs in a computing cluster. This ensures a high processing rate even if data volumes are large.