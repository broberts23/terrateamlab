## The Overview

TL;DR progress will be slow

This side side-project is an experiment/testing of the Terrateam GitOps workflow. 

My primary side-project  will be completing certifications and I'll work on this on Saturday nights (with a few beers :rofl:) and any free time I might get on Sunday.

## The Plan

There's no real plan. I'd like to achieve a multi-cloud, multi-environment deployment.

One end goal is to have a mutli-environment ci/cd Terrateam Workflow that will 'plan' on push and 'plan' on pull-request then wait for an approval gate for the 'apply'

Another goal was to use system/integration testing to validate the deployed resources.

Another is to replicate the same resources across Azure, GCP and AWS.


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

The plan is to make a decoupled three teir stack.

The front/web teir is an Azure Web App hosted in an ASE. This is currently closed off to only allow internal traffic. I'm planning on putting Front Door in front of the Web App to play around with the FD Origins in Terraform.

Between the front and middle teir I've setup Service Bus queues.

At the moment the middle/application teir is running on Azure VMSS Flex, fronted by a load balancer. 

The backend will be DynamoDB to keep it simple.


## The List of To-Do :joy:

| Item | To-Do                      |
| ---- | -------------------------- |
| 1    | Add NSG's                  |
| 2    | RBAC                       |
| 3    | Front Door                 |
| 4    | terrascan/terratest        |
