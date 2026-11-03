```python
import sys
from pyspark.sql import SparkSession


def main():
    if len(sys.argv) != 3:
        print(
            "Usage: job_process_data <input_path> <output_path>",
            file=sys.stderr
        )
        sys.exit(-1)

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    spark = (
        SparkSession.builder
        .appName("object-storage-example")
        .config("spark.executor.instances", 1)
        .getOrCreate()
    )

    df = spark.read.load(
        input_path,
        format="csv",
        header=True,
        inferSchema=True
    )

    df.createOrReplaceTempView("source_data")

    result_df = spark.sql("""
        SELECT
            id,
            value
        FROM source_data
        WHERE value >= 30
    """)

    result_df.write.mode("overwrite").save(
        output_path,
        format="parquet"
    )

    spark.stop()


if __name__ == "__main__":
    main()
```