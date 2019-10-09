FROM openjdk:8-alpine as target

COPY --from=builder /tmp/2.17.3/dbgen/ /tmp/tpch_gen/dbgen/

WORKDIR /spark

ARG spark_version=2.4.4
ARG hadoop_version=2.7
ENV SPARK_VERSION $spark_version
ENV HADOOP_VERSION $hadoop_version
ENV SPARK_ARCHIVE spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

COPY init_db.sh /tmp/init_db.sh

RUN apk --no-cache add wget bash procps coreutils \
	&& wget -q "http://apachemirror.wuchna.com/spark/spark-${SPARK_VERSION}/${SPARK_ARCHIVE}" \
	&& tar -xf $SPARK_ARCHIVE \
	&& rm $SPARK_ARCHIVE \
	&& chmod +x /tmp/init_db.sh \
	&& sed -i -e 's/\r$//' /tmp/init_db.sh

ENV SPARK_DIR "/spark/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}"
 
#ENTRYPOINT ["sh", "/tmp/init_db.sh"]
CMD /bin/bash /tmp/init_db.sh && tail -f /dev/null
#CMD tail -f /dev/null