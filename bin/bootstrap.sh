aws ec2 create-security-group --group-name control-node-sg --description "Control node SG" >> security_group_id
aws ec2 authorize-security-group-ingress --group-name control-node-sg --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 create-key-pair --key-name cn-key --query 'KeyMaterial' --output text > cn-key.pem
LATEST_AMI=`aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn2-ami-hvm-2.0.????????-x86_64-gp2' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'`
echo "Using AMI ${LATEST_AMI}"
aws ec2 run-instances --image-id ${LATEST_AMI} --security-group-ids xxxxxxxxx --instance-type t2.micro --key-name example-key 