## Big data project
This is a TSE school project featuring a full big data pipeline: distributed storage -> cloud processing -> analysis database.  
Each of these parts run on a sepaarate machine. We used a Hortonbox Sandbox VM, an Amazon e3 server and a Linux Mint VM.  
Developed by: Aurélien Turpin, Baptise Wolff and Raphaël Chevasson  
Clients/teachers: Charlotte Laclau, Julien Tissier and Remy Girodon
## Description
### Background
Our project is part of a real estate loan management approach. It is therefore easy to imagine that it will be available to a bank or real estate agency.
The aim is therefore to know if a person applying for a mortgage is sufficiently reliable, economically speaking, to repay it without any problems. We have at our disposal several information about this person, such as his or her job, status, the type of property he or she wishes to buy, etc...
### Implementation
The project is not only about creating a prediction model. It also includes the provision of this model, storage management, security (because it is sensitive data that we will have at our disposal) and the communication channels between these different components.
We will therefore briefly describe the architecture of the project:
* The loan applicant's data will be downloaded and installed on a Hadoop VM, on an HDFS file system
* This data will then be sent to a VM in the AWS cloud in a secure way, due to the sensitive nature of the data
* This is where the prediction model comes in, it is run on a VM in the cloud. Its objective is to predict whether or not contractors will be able to repay their loans given the information on them that we have available. These results are stored in a CSV file in the cloud
* The last step is to organize and store these predictions in a local MongoDB database by repatriating the data

## Architecture
![alt text](https://raw.githubusercontent.com/RaphaelChevasson/big-data-project/master/images/Architecture.png)

## How to use
### The first time :
 - see [how te create user on the hdfs machine](how_to_create_user_on_hdfs_machine.md) and [how to setup the mongodb_machine](how_to_setup_the_mongodb_machine.md)
 - push [the prediction script](production/train_and_test.py) and [dependency file](python_dependencies.txt) on the cloud machine
### Then :
Use anyone of the four shell scripts (`*.sh`) contained in the [`production/`](production/) folder.  
These scripts always consists of two parts: variables you can change (where to connect, file to transfer), then the code itself.  
Usually, they are used in this order:
- [put_data_from_here_to_hdfs.sh](put_data_from_here_to_hdfs.sh) (if you need it)
- [put_data_from_hdfs_to_cloud.sh](put_data_from_hdfs_to_cloud.sh)
- [predict_on_cloud.sh](predict_on_cloud.sh)
- [put_data_from_cloud_to_mongodb.sh](put_data_from_cloud_to_mongodb.sh)
