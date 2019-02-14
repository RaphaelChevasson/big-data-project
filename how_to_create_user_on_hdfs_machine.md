For security reasons, if you use the Hortonworks sandbox for hdfs storage, you might want to change existing user passwords and possibly create your own user, as we did. Here is the steps do this:

# create user on ambari using admin account

admin -> manage ambari -> users -> add users

# create user on ssh or shellinabox using root account

- add user: `useradd  tse`  
- set password: `passwd tse`

# create a hdfs directory for the user

```
su hdfs
hdfs dfs -mkdir /user/tse
hdfs dfs -chown tse:hdfs /user/tse
hdfs dfs -chmod 700 /user/tse
#test that the tse user can operate hdfs:
su tse
echo testcontent | hdfs dfs -put - /user/tse/testfile
hdfs dfs -ls /user/tse/testfile
```