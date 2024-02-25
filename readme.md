The IaC code of aws account

terraform force-unlock -force 39ea2e99-72b0-5a96-2302-b12bffbafed2

terraform init 
terraform plan
terraform apply

rds ec2 connect cmd:
mysql -h terraform-20240223134441912900000001.c3m6wy02227a.ap-northeast-1.rds.amazonaws.com -P 3306 -u root -p