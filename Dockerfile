FROM python:3.8-alpine
RUN mkdir /cronjob/
RUN mkdir /files/
WORKDIR /cronjob/
RUN pip3 install --upgrade \
    boto3
COPY scripts/upload-s3.py /cronjob/upload-s3.py
ENTRYPOINT ["python3", "/cronjob/upload-s3.py"]