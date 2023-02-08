module "instance"{
    source = "./modules/ec2"
    instance_type="t2.nano"
    tag="flavien"
    sg=module.security_groups.name
}
module "volume"{
    source = "./modules/ebs"
    taille=40
    instance_id=module.instance.id
}
module "ip"{
    source = "./modules/public_ip"
    instance_id=module.instance.id
}
module "security_groups"{
    source = "./modules/sg"
}

module "iam"{
    source = "./modules/iam"
    users=["toto","tata"]
    group="titi"
}

