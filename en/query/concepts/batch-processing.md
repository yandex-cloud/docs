# Batch processing

Batch processing is a technology for processing data that involves preparing aggregated information based on large arrays of data. This type of data analysis is traditional and is used for processing data stored, for example, in a DBMS.

Data volumes increase with time but that does not mean all data is accessed often. So, rarely used data is usually transferred to storage systems like {{ objstorage-full-name }} which are much more cost-effective than DBMS.

Data is stored in {{ objstorage-full-name }} as a file structure with directories and files. To store data in files, use standard storage formats: CSV, JSON, etc.

{{ yq-full-name }} allows you to access data stored in {{ objstorage-full-name }} in the same way as a DBMS by making queries in an SQL dialect called [YQL]({{ ydb.docs }}/yql/reference/syntax/).

{{ objstorage-full-name }} usually stores massive amounts of data. {{ yq-full-name }} analyzes how much data needs processing and runs dozens to hundreds of concurrent data processing jobs within the computing cluster. This allows maintaining a high processing speed even for large data volumes.