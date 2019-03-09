# terraform-k8s-nginx
Build GCP infrastructure and k8s clusters with Terraform

Firstly, we shall download and install Terraform:

wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip

mkdir terraform
cd teraform
unzip ../https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
export PATH=$PATH:~/terraform
chmod +x *
cd ..

Then, we would need to create a service account and key:

gcloud iam service-accounts create service

gcloud projects add-iam-policy-binding terraform-k8s-nginx --member "serviceAccount:service@terraform-k8s-nginx.iam.gserviceaccount.com" --role "roles/owner"

gcloud iam service-accounts keys create credentials.json --iam-account service@terraform-k8s-nginx.iam.gserviceaccount.com

Then, exporting of the environmental variables:

export GOOGLE_CREDENTIALS=$(cat ~/credentials.json)

export GOOGLE_PROJECT=terraform-k8s-nginx

export GOOGLE_REGION=europe-west1

* vim tunity-development.tf and copy the contents of the file, save and exit
execute "terraform init" in order to download and update necessary plugins.
execute "terraform plan" to make sure everything is ready to apply
execute "teraform apply" and begin with creating the infrastructure and clusters.

after creating is completed, we would like to begin with creating our nginx deployments.

vim "nginx.sh" copy the contents of "nginx.sh" into the file

execute "./nginx.sh"

after the successful script execution and deployment and exposure of the service is done, we would like to edit the "index.html" file so when we access the external ip address it would display "Hello Tunity!":

edit the pods in deployment to display "Hello Tunity!":

kubectl edit deployment nginx

under "image: nginx" add:
command:
- sh
- -c
- echo "Hello Tunity!" > /usr/share/nginx/html/index.html && service nginx stop && nginx -g "daemon off;"
- rm /etc/nginx/conf.d/default.conf

then, we would like to get the External-IP address of the service and browse to it:

kubectl get service nginx

note the external ip address, copy it to your browser and surf to it. you should see the "Hello Tunity!" greeting.
