# first, create a file containing the private key your created while launching the amazon e3 instance
cloud_keypair_file=cloud_keypair.pem
cloud_instance_public_dns_name=ec2-3-91-55-119.compute-1.amazonaws.com
cloud_user=ec2-user

hdfs_host=localhost
hdfs_host_port=2222
hdfs_user=tse

cloud_file=data2evaluate.csv # can be relative path from home
hdfs_file=/user/$hdfs_user/data2evaluate.csv # have to be absolute path

chmod 400 $cloud_keypair_file
echo "La recuperation d'un gros fichier sur hdfs peut prendre un certain temps."
ssh $hdfs_user@$hdfs_host -p $hdfs_host_port "hdfs dfs -cat $hdfs_file" | ssh -i $cloud_keypair_file $cloud_user@$cloud_instance_public_dns_name "cat > $cloud_file
echo
echo Fin du transfert. Liste des fichiers sur le cloud :
ls
echo
echo Premiere ligne du fichier $cloud_file:
head -1 $cloud_file
"
echo
echo Fin du script. Appuyez sur Entree pour quitter.
read