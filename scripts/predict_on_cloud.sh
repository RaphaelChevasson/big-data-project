# first, create a file containing the private key your created while launching the amazon e3 instance
cloud_keypair_file=cloud_keypair.pem
cloud_instance_public_dns_name=ec2-3-91-55-119.compute-1.amazonaws.com
cloud_user=ec2-user

chmod 400 $cloud_keypair_file
ssh -i $cloud_keypair_file $cloud_user@$cloud_instance_public_dns_name "
pip install -r python_dependencies.txt
python train_and_test.py"
echo
echo Fin du script. Appuyez sur Entree pour quitter.
read