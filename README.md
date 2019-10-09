# docker-spark
# Usage
[docker build USAGE](https://docs.docker.com/engine/reference/commandline/build/)  
[docker run USAGE](https://docs.docker.com/engine/reference/run/)  

This Spark container takes Spark and Hadoop versions as build-time environment variables
```
Mirror used to download Spark distribution in the dockerfile: http://apachemirror.wuchna.com/spark/
Optional mirror that can be used: https://archive.apache.org/dist/spark/?C=N;O=A
Current Spark versions available: 2.3.4, 2.4.4
Current Hadoop versions available: 2.6, 2.7
Versions set as default in dockerfile: Spark: 2.4.4, Hadoop: 2.7
```

To build the dockerfile with a particular Spark and Hadoop version:
```
docker build -t spark:<image-tag> .
docker build --build-arg SPARK_VERSION=2.4.4 HADOOP_VERSION=2.7 --build-arg HADOOP_VERSION=2.7 -t spark:<image-tag> .
```

To start a local instance of the latest spark on Linux:
```
docker run -d -t --name spark-master -p 10000:10000 spark:<image-tag>
```

To start a local instance of the latest spark thrifserver:
```
docker run -d -t --name spark-master -p 10000:10000 spark:<image-tag>
```

To view the container logs
```
docker logs container-id > logs_db.txt
