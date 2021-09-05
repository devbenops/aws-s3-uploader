# s3-uploader

The project summarizes

* [ ]
  ```
  A python app which writes a new file to the s3 bucket in every 2 minutes
  ```
* [ ]
  ```
  A terraform setup to provision necessary cloud infrastructure and permissions/policies
  ```

* [ ]
  ```
  A helm chart to deploy the app to the Kubernetes cluster
  ```


##### Tools/Cloud Services used

>> AWS EKS
>> AWS s3
>> AWS DynamoDB
>> Terraform
>>

##### Project Structure  ---- Environments

```
├── global
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tf
│   └── variables.tf
├── qa
│   ├── core
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   ├── eks
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   └── s3
│       ├── main.tf
│       ├── providers.tf
│       ├── terraform.tf
│       └── variables.tf
└── staging
    ├── core
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── terraform.tf
    │   └── variables.tf
    ├── eks
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── providers.tf
    │   ├── terraform.tf
    │   └── variables.tf
    └── s3
        ├── main.tf
        ├── providers.tf
        ├── terraform.tf
        └── variables.tf
```

This project is organized on the followung structure:

1. environments: Contain the root module of the terraform deployment and divided as dev and staging

   Main development environments used in this project : dev,staging

   Note// Create new environment by adding a new folder and add required variable files
2. layers: eks, common, core. Each sub-directory will be used to call a group of Terraform modules sourcing from module/ directory

Layer common - To provision required aws roles for the EKS and nodes

Layer core   - To provision aws vpc, subnets and all required vpc resources + security groups

Layer eks    - To provision aws EKS and node groups

Note//  For development purpose , I hosted the module repo within this Github project, use separate github projects for each module in production

4. pre-terraform.sh: Shell script needed to bootstrap the project: create an s3 bucket to store terraform state files, create dynamoDB table for terraform state lock and checking the existency.

# Access to kubernetes cluster

Once the cluster is ready and worker nodes are up and running, you can use below aws cli command to merge the kubeconfig to local system

   aws eks --region <<region>>  update-kubeconfig --name <<eks-cluster-name>>
# Prerequisites for accessing eks cluster

A local workstation configured with aws cli with necessay IAM permission for kubernetes cluster access. Initially, we need the IAM user which we used to create the eks cluster and its credential to access kubernetes cluster, afterwards we can add additional IAM users in the aws-auth-cm.yaml and apply.

kubectl edit -n kube-system configmap/aws-auth

we can add aws IAM users to map with kubernetes RBAC users, groups.
example :

Create  user user1 in aws console 

Add to aws-auth configmap user1 user ARN.   



                  mapUsers: |
                    - userarn: arn:aws:iam::<<aws-account-id>>:user/user1
                      username: user1
                      groups: 
                      - reader

## Steps to Provision the Terraform Setup

##### Provision terraform:

1. Execute scripts/pre-terraform.sh to provision one s3 bucket and DynamoDB to store Terraform stste files
2. Go to terraform/environments/global and provision global IAM for the EKS clusters
3. Go to terraform/environments/(qa/staging)/(core/eks) and provision core and eks Layer respectively

##### Terraform Commands

>> To Initialize the directory
>>

terraform init

>> To see the plan of the terraform execution
>>

terraform plan

>> To apply the terraform plan follwing a confirmation from our end.
>>

terraform apply

## Build Docker Image/Store it on Docker Hub Private Repository

Create a repository in your Dockerhub for the project

>>> Build the image from the project root directory
>>>
>>

docker build . -t s3-uploader

>> Tag the built docker image with the Repo Location along with your desired version
>>

docker tag s3-uploader:latest <<DOCKERHUB_REPO>>/s3-uploader:v1

>> Push the docker image to the Repository
>>

docker push <<DOCKERHUB_REPO>>nithinbenny/s3-uploader:v1


## Access to kubernetes cluster

Once the cluster is ready and worker nodes are up and running, you can use below aws cli command to merge the kubeconfig to local system.

* [ ]  aws eks --region <<region>>  update-kubeconfig --name <<eks-cluster-name>>

# Prerequisites for accessing eks cluster

A local workstation configured with aws cli with necessay IAM permission for kubernetes cluster access. Initially, we need the IAM user which we used to create the eks cluster and its credential to access kubernetes cluster, afterwards we can add additional IAM users in the aws-auth-cm.yaml and apply.

* [ ]
  ```
  kubectl edit -n kube-system configmap/aws-auth
  ```

we can add aws IAM users to map with kubernetes RBAC users, groups.
example :

Create  user user1 in aws console

Add to aws-auth configmap user1 user ARN.

```mapUsers: |
- userarn: arn:aws:iam::<aws-account-id>:user/user1
username: user1
groups:
- reader
```

##### Configure EKS cluster for the Deployment

>> Create qa/staging namespace in appropriate clusters
>>

```
             kubectl create ns qa/staging 
```
>> Create a kubernetes secret to store dockerhub Credentials
>>

* [ ]
  ```
  kubectl  -n qa/staging create secret generic dockerhub
                --from-file=.dockerconfigjson=<path/to/.docker/config.json>
                   --type=kubernetes.io/dockerconfigjson
  ```

>> Create an IODC provider if not exists and associate with the EKS cluster
>>

* [ ]
  ```
  aws eks describe-cluster --name dev-cluster --query "cluster.identity.oidc.issuer" --output text
  ```



* [ ] eksctl utils associate-iam-oidc-provider --region=region --cluster=<<cluster_name>>  --approve

>> Create an iam service account for the application running on the pod to access s3 bucket.
>>

* [ ] eksctl create iamserviceaccount
  --name aws-s3-uploader
  --namespace (qa/staging)
  --cluster cluster_name
  --attach-policy-arn arn:aws:iam::ACCOUNT_ID:policy/S3_write_access
  --approve
  --override-existing-serviceaccounts

NOTE// The policy "S3_write_access" is already created in the terraform provisioning step( Gloabl IAM layer) as well as the role **s3-platform-challenge-admin** 

>> Find the RoleId of the **s3-platform-challenge-admin** ROLE
>>

aws iam get-role --role-name **s3-platform-challenge-admin**

Example output:

```
"RoleId": "AROATHCDNYUQFN5QNUHX4"
```
Note// We need this RoleId to allow access to the s3 bucket in ** s3 bucket policy**

>> Go to terraform/environments/qa/staging)/s3 and create s3 bucket and its policies for our project.
>>

Terraform will provision the s3 bucket,a bucket policy

OIDC check
----------

aws eks describe-cluster --name dev-cluster --query "cluster.identity.oidc.issuer" --output text

## Step to Deploy the App

I have configured a  helm chart for this Project, thus we need helm3 binary in your local machine

>> Install Helm3 in your local machine:
>>

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

>> Deploy the App:
>>

helm install -f helm/(values-qa.yaml/values-staging.yaml)   s3-uploader . --dry-run

>> Make sure everything is correct and error free
>>

helm install -f helm/(values-qa.yaml/values-staging.yaml)   s3-uploader .


-----------
