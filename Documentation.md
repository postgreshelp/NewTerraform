## Documentation

### start with empty folder

#### 1. Find/read the existing default VPC.
#### create providers.tf

```
terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 5.0"
		}
	}
}

provider "aws" {
	region = "us-east-1"
}
```

#### create data.tf

```
data "aws_vpc" "default" {
  default = true
}
```

#### create outputs.tf

```
output "default_vpc_id" {
  description = "ID of the existing default VPC"
  value       = data.aws_vpc.default.id
}
```

#### Run the below commands

```
Terraform init
Terraform validate
Terraform apply
```

#### Sample output

```
PS C:\Users\hp\Documents\Course\NewTerraform> Terraform init
Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.100.0...
- Installed hashicorp/aws v5.100.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS C:\Users\hp\Documents\Course\NewTerraform> 
PS C:\Users\hp\Documents\Course\NewTerraform> terraform validate
Success! The configuration is valid.

PS C:\Users\hp\Documents\Course\NewTerraform> 
PS C:\Users\hp\Documents\Course\NewTerraform> terraform apply
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 2s [id=vpc-063618af923af9f03]

Changes to Outputs:
  + default_vpc_id = "vpc-063618af923af9f03"

You can apply this plan to save these new output values to the Terraform state,
without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

default_vpc_id = "vpc-063618af923af9f03"
PS C:\Users\hp\Documents\Course\NewTerraform> 
````

### 2. Import an existing VPC into Terraform

### Get the CIDR for your VPC

aws ec2 describe-vpcs --vpc-ids vpc-02f476ec787e998c6

expected output
```
10.10.0.0/16
```

create aws-vpc.tf

```
resource "aws_vpc" "b03_vpc" {
  cidr_block = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "B03-VPC"
  }
}
```

Run the below commands

```
Terraform init
Terraform validate
terraform import aws_vpc.b03_vpc vpc-02f476ec787e998c6
```

###output log


PS C:\Users\hp\Documents\Course\NewTerraform> terraform init   
Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.100.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS C:\Users\hp\Documents\Course\NewTerraform> terraform validate
Success! The configuration is valid.

PS C:\Users\hp\Documents\Course\NewTerraform> 
PS C:\Users\hp\Documents\Course\NewTerraform> 
PS C:\Users\hp\Documents\Course\NewTerraform> terraform import aws_vpc.b03_vpc vpc-02f476ec787e998c6
aws_vpc.b03_vpc: Importing from ID "vpc-02f476ec787e998c6"...
data.aws_vpc.default: Reading...
aws_vpc.b03_vpc: Import prepared!
  Prepared aws_vpc for import
aws_vpc.b03_vpc: Refreshing state... [id=vpc-02f476ec787e998c6]
data.aws_vpc.default: Read complete after 2s [id=vpc-063618af923af9f03]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

PS C:\Users\hp\Documents\Course\NewTerraform> 

#### Push everything to get

### To remove everything from git

```
cd C:\Users\hp\Documents\Course\NewTerraform
Remove-Item -Recurse -Force .git
```

#### 1. Right-click NewTerraform (the folder/root at the top of Explorer) → New File.

```
.gitignore
```

Then put this inside it:

```
.terraform/
*.tfstate
*.tfstate.*
.terraform.tfstate.lock.info
*.code-workspace
```


