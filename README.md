# terraform-k8s-nginx
# Build GCP infrastructure and k8s cluster with Terraform; Deploy autoscaling nginx server, and edit the welcome page. 

* All commands are executed on Google Cloud Shell environment.

* Replace "terraform-k8s-nginx" with your [PROJECT_ID] in order for the deployment to be successful.

# Firstly, we shall download and install Terraform:

wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip

mkdir terraform

cd teraform

unzip ../terraform_0.11.11_linux_amd64.zip

export PATH=$PATH:~/terraform

chmod +x *

cd ..

# Then, we need to create a service account and key:

gcloud iam service-accounts create service

gcloud projects add-iam-policy-binding terraform-k8s-nginx --member "serviceAccount:service@terraform-k8s-nginx.iam.gserviceaccount.com" --role "roles/owner"

gcloud iam service-accounts keys create credentials.json --iam-account service@terraform-k8s-nginx.iam.gserviceaccount.com

# Export the environmental variables:

export GOOGLE_CREDENTIALS=$(cat ~/credentials.json)

export GOOGLE_PROJECT=terraform-k8s-nginx

export GOOGLE_REGION=europe-west1

# Copy the contents of the "tunity-development.tf" from this repository source into the file, save and exit.

vim tunity-provisioning.tf

# Download and update necessary plugins.
terraform init

# Make sure everything is ready to apply.
terraform plan

# Begin with creating the infrastructure and clusters.
teraform apply

* In case of an error, just run the command again, and it shall complete everything smoothly.

# After processes are completed, we will begin with creating our auto-scaling nginx deployment.

vim nginx.sh 

# Copy the contents of "nginx.sh" from this repository source into the file, save and exit.

chmod +x nginx.sh

./nginx.sh

# After the successful script execution, deployment and exposure of the service is done, we want to edit the "index.html" file so when we access the external ip address it would display our own text message.

kubectl edit deployment nginx

# Under "image: nginx" add (without the ""):

command:

  "-" sh
 
  "-" - c
 
  "-" echo "Hello Tunity!" > /usr/share/nginx/html/index.html && service nginx stop && nginx -g "daemon off;"
  
  "-" rm /etc/nginx/conf.d/default.conf

# Note the external ip address, copy it to your browser and surf to it. you should see the "Hello Tunity!" greeting.

kubectl get service nginx
