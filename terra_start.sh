if [ ! -e terra/terra_rsa ]; then
	ssh-keygen -t rsa -N "" -f terra/terra_rsa
	chmod 0400 terra/terra_rsa
fi

echo
echo "###########"
echo "Terraform Init is starting...."
echo "###########"
terraform init
echo
echo "###########"
echo "Terraform apply is starting...."
echo "###########"
terraform apply -auto-approve
