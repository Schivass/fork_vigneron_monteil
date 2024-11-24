# Examples API

Simple API that returns example records from a database.

## Prerequisites

- you need to install [uv](https://docs.astral.sh/uv/guides/install-python/)
- you must have a PostgreSQL instance available with an `example` table

## Installation

```shell
# Install Python in the right version
uv python install

# Install dependencies and create virtual env
uv sync
```

## Run

```shell
# Export environment variables to connect to the PostgreSQL database...
export DATABASE_HOST=
export DATABASE_PORT=
export DATABASE_NAME=
export DATABASE_USER=
export DATABASE_PASSWORD='' # Use single quotes to avoid shell interpolation with characters like $ or #
# ...and the storage account
export STORAGE_ACCOUNT_URL=

# Run the application
uv run fastapi dev examples/examples.py
```

## Run tests

```
uv run pytest tests/
```

They go on:

- http://localhost:8000/docs
- http://localhost:8000/
- http://localhost:8000/examples


I'll explain the principle of Terraform's file structure and show some typical schemas for these common files.



```hcl
# variables.tf
# Input variables - define parameters that can be passed to the configuration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# main.tf
# Main configuration file - defines the actual infrastructure resources
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name        = "${var.environment}-public-subnet"
    Environment = var.environment
  }
}

# outputs.tf
# Output values - define what information should be shown after applying
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the created public subnet"
  value       = aws_subnet.public.id
}

```
## Composition of this code

1. **variables.tf**:
   - Acts as the input interface for your Terraform configuration
   - Defines all variables that can be customized when applying the configuration
   - Makes your code more reusable and maintainable
   - Variables can have descriptions, types, and default values
   - Can be overridden via command line, environment variables, or .tfvars files

2. **main.tf**:
   - Contains the core infrastructure configuration
   - Defines what resources should be created
   - References variables using the `var.` prefix
   - Typically includes:
     - Provider configurations (not in this code, yet it's terraform_config.tf who manage this)
     - Resource definitions
     - Data source declarations
     - Local values and module calls

3. **outputs.tf**:
   - Defines what information should be exposed after Terraform applies the configuration
   - Useful for:
     - Showing important resource attributes
     - Passing information between modules (as you can see in database module by example)
     - Debugging and verification (like in main.tf with app service url and resource group name)

## Some of the best links we used

1. Terraform links
  - https://developer.hashicorp.com/terraform/docs
  - https://developer.hashicorp.com/terraform/tutorials
  - https://www.terraform-best-practices.com/

2. Learning path azure
  - https://learn.microsoft.com/en-us/azure/developer/terraform/

3. Signing Commits
  - https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
  - https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key

4. github actions
  - https://nektosact.com/installation/index.html (testing github actions in local)
