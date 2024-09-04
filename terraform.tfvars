whitelist               = ["0.0.0.0/0"] # open to the world
web_image_id            = "ami-04dfd853d88e818e8" # Ubuntu 22.04
web_instance_type       = "t2.medium" # instance type
course_id               = "20211103_NGS6" # will be used as tag with name 'course'
key_name                = "key_ubuntu_gvg" # key name. Should already be generated with the AWS console. 
volume_size             = 128 # volume size in Gb
