import findspark

findspark.init()

from pyspark.sql import SparkSession
import sys

def main():
    nums = [1, 2, 3, 4]
    return list(map(lambda x: x * x,nums))


if __name__ == '__main__':
    #Create Spark Session
    spark = SparkSession.builder.appName("demoGrey").getOrCreate()

    if len(sys.argv) != 2:
        print("Invalid arguments,  supply s3 output path")
        sys.exit(1)


    output_path = sys.argv[1]
    output = main()

    #write to s3
    spark.sparkContext.parallelize(output).saveAsTextFile(output_path)