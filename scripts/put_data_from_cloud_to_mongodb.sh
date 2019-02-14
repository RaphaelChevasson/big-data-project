# first, create a file containing the private key your created while launching the amazon e3 instance
cloud_keypair_file=cloud_keypair.pem
cloud_instance_public_dns_name=ec2-3-91-55-119.compute-1.amazonaws.com
cloud_user=ec2-user

mongodb_host=localhost
mongodb_host_port=222
mongodb_user=adminvm

cloud_file=data2evaluate.csv # can be relative path from home
mongodb_file=results.csv # can be relative path from home
mongodb_database_name=mydb
mongodb_table_name=things

chmod 400 $cloud_keypair_file
ssh -i $cloud_keypair_file $cloud_user@$cloud_instance_public_dns_name "cat $cloud_file" | ssh $mongodb_user@$mongodb_host -p $mongodb_host_port "
cat > $mongodb_file
#sudo service mongod start # please start the service before
mongoimport -d $mongodb_database_name -c $mongodb_table_name --type csv --file $mongodb_file --headerline
echo Fin du transfert vers la database."
echo
echo Fin du script. Appuyez sur Entree pour quitter.
read