hdfs_host=localhost
hdfs_host_port=2222
hdfs_user=tse
local_file=10_lines.csv  # can be relative path
hdfs_file=/user/$hdfs_user/data2evaluate.csv # have to be absolute path

echo Connexion au serveur de prédiction...
cat $local_file | ssh $hdfs_user@$hdfs_host -p $hdfs_host_port "
hdfs dfs -put - $hdfs_file
echo Fin du transfert. Liste des fichiers sur hdfs :
hdfs dfs -ls /user/$hdfs_user
"
echo Fin du script. Appuyez sur Entree pour quitter.
read