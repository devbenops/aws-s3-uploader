########################################################
## Bootstraping Terraform Environment ##
########################################################
#!/bin/bash


bucket_name=eks-demo-101
region=eu-central-1
dynamodb_table=terraform-state-lock


### s3 bucket creation ##

create_tfstate_s3_bucket (){
    aws s3api create-bucket --bucket $bucket_name --region $region --acl private --create-bucket-configuration LocationConstraint=$region 
    echo "S3 bucket is created successfully"
}

check_s3_bucket () {
   if [[ $(aws s3api list-buckets --query 'Buckets[?Name == `eks-demo-101`].[Name]' --output text) = ${bucket_name} ]]; then 
      echo "s3 bucket ${bucket_name} exists"; 
    else
      echo "Creating s3 bucket ${bucket_name} for Terraform EKS"
      create_tfstate_s3_bucket
   fi
}

# create dynamoDB Table    ##

create_tflock_table (){
    aws dynamodb create-table --cli-input-json file://table-tf-state-lock.json --region $region
    echo "DynamoDB table ${dynamodb_table} is created successfully"
}

check_table () {
    table_status=$(aws dynamodb describe-table --table-name ${dynamodb_table}  --query "Table.TableStatus" --region $region --output text)
    if [ $table_status == 'ACTIVE' ]; then
       echo "Table ${dynamodb_table} exists"     
    else
       echo "Creating DynamoDB table ${dynamodb_table}"
       create_tflock_table
    fi
}


check_s3_bucket 

check_table

