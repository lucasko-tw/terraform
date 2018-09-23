### Install gcloud

```sh
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

```

### Setting of gcloud

1. Initial Google gcloud command

	```
	gcloud init
	
	To continue, you must log in. Would you like to log in (Y/n)? Y
	
	Pick cloud project to use:
	 [1] [my-project-1]
	 [2] [my-project-2]
	 ...
	 Please enter your numeric choice:
	 
	 
	 Which compute zone would you like to use as project default?
	 [1] [asia-east1-a]
	 [2] [asia-east1-b]
	 ...
	 [14] Do not use default zone
	 Please enter your numeric choice:
	```


2. Login 


	```
	gcloud auth application-default login
	```

3. Enable Computer API

	```sh
	gcloud services enable compute.googleapis.com
	```

4. Create Computer Engine default service account

	* Download .json file with credentials.

	
## Terraform

### Install Terraform

```
## Install unzip
sudo apt-get install unzip vim

## Download latest version of the terraform
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip

## Extract the downloaded file archive
unzip terraform_0.11.8_linux_amd64.zip

## Move the executable into a directory searched for executables
sudo mv terraform /usr/local/bin/

## Run it
terraform --version
```


### Set up .env

Edit .env

```sh
vim .env
```

Content of .env

```sh
export GOOGLE_APPLICATION_CREDENTIALS="/home/ubuntu/Desktop/service.json"

export GCLOUD_PROJECT="cloudorion-150502"

export GCLOUD_REGION="asia-east1-b" 
```

apply

```sh
source .env
```

### Basic .tf

Edit a new .tf file

```sh
vim gcp.tf
```



gcp.tf

```
resource "google_compute_instance" "test-gcp" {

  name         = "lucasko"
  zone         = "asia-east1-b"
  machine_type = "n1-standard-1"

  tags = [ "mylucas"]

  boot_disk {
        initialize_params {
            image = "ubuntu-1604-lts"
            type  = "pd-ssd"
            size = 40
        }
    }

  network_interface {
    network = "default"
  }


}

```


apply

```sh
terraform init

terraform plan

terraform apply
```

