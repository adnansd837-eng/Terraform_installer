#import.tf use to bring already existing instance

import {
    id = "i-0c6f3da565b6eb680"                    #instance id
    to = aws_instance.my_existing_instance        #instance name 
}

resource "aws_instance" "my_existing_instance"{    
    ami = "ami-01a00762f46d584a1"                  #ami id
    instance_type = "t2.medium"                    #instancetype
    key_name = "terra-2-key"                       #key name
}
