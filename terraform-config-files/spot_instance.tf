variable "availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "image_id" {
    default = "ami-0089b8e98cd95257d"
}
variable "instance_type" {
    default = "t3.micro"
}
variable "vpc_security_group_ids" {
    default = ["sg-08adc4f8582bb097a"]
}
variable "max_price" {
    default = "null"
}

# SET THE INSTANCE NAMES
variable "instance_names" {
    default = [
        "frontend",
        "mongodb",
        "catalogue",
        "redis",
        "user",
        "cart",
        "mysql",
        "shipping",
        "rabbitmq",
        "payment",
        "dispatch"
    ]
}

resource "aws_spot_instance_request" "devops" {
    count = length(var.instance_names)
    ami = var.image_id
    instance_type = var.instance_type
    availability_zone = element(var.availability_zones, count.index)
    vpc_security_group_ids = var.vpc_security_group_ids
    spot_price = var.max_price
    spot_type = "persistent"
    instance_interruption_behavior = "stop"
    associate_public_ip_address = true
    tags = {
        resource_type = "instance"
        Name = element(var.instance_names, count.index)
        Envinorment = "Testing"
    }
}
