from pyspark.sql import SparkSession
import time

spark = SparkSession.builder \
    .appName("WordCountTest") \
    .master("spark://spark-master:7077") \
    .getOrCreate()

print(f"Spark {spark.version} - Master: {spark.sparkContext.master}")

start = time.time()

text_file = spark.read.text("data/sample.txt")

word_counts = text_file.rdd \
    .flatMap(lambda row: row.value.split()) \
    .filter(lambda word: len(word) > 0) \
    .map(lambda word: (word.lower(), 1)) \
    .reduceByKey(lambda a, b: a + b) \
    .sortBy(lambda x: x[1], ascending=False)

top_words = word_counts.take(20)
total = word_counts.count()

print(f"\nProcessed in {time.time() - start:.2f}s")
print(f"\nTop 20 words (from {total} unique):")
for word, count in top_words:
    print(f"  {word:20} {count:>5}")

spark.stop()
