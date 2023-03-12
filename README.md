## The Overview

TL;DR progress will be slow

This side side-project is an experiment/testing of the Terrateam GitOps workflow. 

My primary focus will be completing certifications and I'll work on this on Saturday nights (with a few beers :rofl:) and any free time I might get on Sunday.

## The Plan

The plan is two-fold:

One end goal is to have a mutli-environment ci/cd GitHub Workflow that will 'plan' on push and 'plan' on pull-request then wait for an approval gate for the 'apply'

The second goal is to use Chec Inspec to validate the deployed resources

## The Stucture
    .
    ├── ...
    ├── cloud                       # azure, aws, gcp
    |   ├── main.tf
    |   ├── variables.tf
    |   ├── output.tf
    |   ├── env.tfvars              # dev.tfvars, prod.tfvars                  
    │   ├── modules
    |   │   ├── module_folder       # load_balancer, virtual_networl
    |   |   |   ├── main.tf
    |   |   |   ├── variables.tf
    |   |   |   ├── output.tf     
    │   ├── integration         
    │   └── unit                
    └── ...

## The Environment

The plan is the make this a three teir stack.

I've created Service Bus queues that will handle the decoupling for whetever the front end will be. At the moment I'm thinking a static web app that will place the form in a queue.

At the moment the middle teir is running on an Azure VMSS fronted by a load balancer. I may change this to be AKS or Functions in the future. But might save that for a seperate project. The middle/application teir would pull the message of the queue.

The backend will be a PaaS probably DynamoDB to keep it simple.


## The List of To-Do :joy:

| Item  | To-Do  |
| ------| ------------- |
| 1     | Add NSG's |
| 2     | Add a database |
| 3     | Fix the terrateam pipeline |
| 4     | Private endpoints |
| 5     | RBAC |