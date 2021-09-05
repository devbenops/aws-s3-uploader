#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import glob 
import boto3
import os 
import sys 
import logging
from botocore.exceptions import NoCredentialsError


AWS_S3_BUCKET = os.environ['AWS_S3_BUCKET'] 
S3_FOLDER = os.environ['S3_FOLDER'] 
FILES = '/files/*.txt' 

FORMAT = "%(asctime)s %(name)-4s %(process)d %(levelname)-6s %(funcName)-8s %(message)s"
logging.basicConfig(format=FORMAT)
logger = logging.getLogger("aws-s3-uploader")

def check_vault_config():
    if 'AWS_S3_BUCKET' not in os.environ:
        logger.error("AWS_S3_BUCKET environment variable not set")
        exit(1)

    if 'S3_FOLDER' not in os.environ:
        logger.error("S3_FOLDER environment variable not set")
        exit(1)
        
def s3_uploader():
    s3 = boto3.client('s3')
    file_list = glob.glob(FILES) 

    try: 

        file_count=1 

        for data_file in file_list: 

                file_name = f"{S3_FOLDER}/{os.path.basename(data_file)}"      

                s3.upload_file(data_file, AWS_S3_BUCKET, file_name) 

                print(f"File {file_count} of {len(file_list)} uploaded") 

                file_count= file_count + 1 
        return True
    
    except NoCredentialsError:
        print("Credentials not available")
        return False

    except: 

        print("An unexpected error occured uploading the Data files to S3") 

        sys.exit(-1) 
    

def main():
    check_vault_config()
    s3_uploader()
    
if __name__ == "__main__":
    main()

        

    