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
