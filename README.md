## The Overview

TL;DR progress will be slow

This side side-project is an experiment/testing of the Terrateam GitOps workflow. 

My primary focus will be completing certifications and I'll work on this on Saturday nights (with a few beers :rofl:) and any free time I might get on Sunday.

## The Plan

The plan is two-fold:

One end goal is to have a mutli-environment ci/cd Terrateam Workflow that will 'plan' on push and 'plan' on pull-request then wait for an approval gate for the 'apply'

The second goal is to use Chef Inspec to validate the deployed resources

## The Stucture
    .
    ├── ...
    ├── cloud                       # azure, aws, gcp
    |   ├── main.tf
    |   ├── variables.tf
    |   ├── output.tf
    |   ├── env.tfvars              # dev.tfvars, prod.tfvars                  
    │   ├── modules
    |   │   ├── module_folder       # load_balancer, virtual_network, subnet
    |   |   |   ├── main.tf
    |   |   |   ├── variables.tf
    |   |   |   ├── output.tf     
    │   ├── integration         
    │   └── unit                
    └── ...

## The Environment

The plan is the make this a three teir stack.

The front end will be an Azure Web App host in ASE. This is currently closed off to only allow internal traffic. I'm planning on putting Front Door in front of the Web App to play around with the FD Origins in Terraform.

At the moment the middle teir is running on an Azure VMSS Flex, fronted by a load balancer. I may change this to be AKS or Functions in the future. But might save that for a seperate project.

The Backend will be DynamoDB to keep it simple.


## The List of To-Do :joy:

| Item | To-Do                      |
| ---- | -------------------------- |
| 1    | Add NSG's                  |
| 2    | RBAC                       |
| 3    | Front Door                 |
