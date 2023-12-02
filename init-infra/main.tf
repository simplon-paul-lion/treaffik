module "resource_group"{
    source = "github.com/simplon-paul-lion/main-terraform/resource_group"
    name = var.name
    location = var.location

}

module "vnet" {
    source = "github.com/simplon-paul-lion/main-terraform/vnet"
    name = var.name
    resource_group_name = module.resource_group.rg.name
    location = module.resource_group.rg.location
    cidr = var.cidr
}

module "subnet"{
    source = "github.com/simplon-paul-lion/main-terraform/subnet"
    name = var.name
    address_prefixes = var.address_prefixes
    location = module.resource_group.rg.location
}

module "aks" {
    source = "github.com/simplon-paul-lion/main-terraform/aks"
    name = module.resource_group.rg.name
    aks_node_pool_config = var.aks_node_pool_config
    location = module.resource_group.rg.location
    domain_name_label = lower(module.resource_group.rg.name)
}




