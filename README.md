## The Overview

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

## The List of To-Do :joy:

| Item  | To-Do  |
| ------| ------------- |
| 1     | Add NSG's |
| 2     | Add a database |
| 3     | Fix the terrateam pipeline |