#!/bin/bash

#------------------------------------------------------------------------------------
#
#	DATE/TIME:	Mon Feb 21 10:12:31 IST 2017	
#	AUTHOR:		Rahul Kumeriya
#	Mail ID:	rahulkumeriya@gmail.com
#	Description:	Script to find log without actual login to respective server
#	Precaution:	Certain cases are there wherewe need to check manually
#	----------------------------------------------------------------------
#		USAGES: ./log_checker <INSTANCE> <JOB_NAME
#-----------------------------------------------------------------------------------

if [ $# -lt 2 ]
then
	echo "USAGES: ./log_checker.sh <Instance> <Job_name>"
	exit
else
	
	export AUTOSYS_SERVER=$1
	autosys_job_status.sh -j $2 -q > job.txt
	
	machine_name=`cat job.txt | grep machine | awk -F ' ' '{print $2}'`
	value=`cat job.txt | grep machine | wc -w`
	profile=`cat job.txt | grep profile | awk -F ' ' '{print $2}'`
	std_out_file=`cat job.txt | grep std_out_file | awk -F ' ' '{print $2}' | awk -F / '{print $1}' | cut -c 2-`
	out_file=`cat job.txt | grep std_out_file | awk -F ' ' '{print $2}'`
	file=`cat job.txt | grep std_out_file | awk -F ' ' '{print $2}' | cut -c 1`
	job_initial=`echo $2 | cut -c 1-3`

#TO CHECK THE TYPE OF VARIBALES TO GRABBED THE PATH

if [[ $file == '$' ]]
then	

ssh -T -q `whoami`@$machine_name <<EOF

#FUNCTIONS FOR FORMATING PURPOSE

log_start_insert_lines(){
	echo -e "$(tput setaf 2) \t\t\t\t\t\t LOG BEGINS $(tput sgr0)"
}

log_end_insert_lines(){
	echo -e "$(tput setaf 2) \t\t\t\t\t\t  LOG ENDS $(tput sgr0)"
}

log_file_name(){
echo 
echo "$(tput setaf 2) ++++++++++++++++++++++++++ YOUR ARE VIEWING BELOW LOGS ++++++++++++++++++++++++++ $(tput sgr0)"
echo 
}

space()
{
echo "$(tput setaf 2) ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  $(tput sgr0)"
}



# TO CHECK SERVER 1 and SERVER 2 LOGS

if [[ $machine_name == "SERVER_1.server.com" ]]
then
	log_start_insert_lines
	log_file_name
	
	find /app/server1/log -maxdepth 3 -type f -ctime 0 -mtime 0 -iname "$2*log" -exec ls -lart {} \;
	space
	find /app/server2/bin/log -maxdepth 3 -type f -ctime 0 -mtime 0 -iname "$2*log" -exec ls -lart {} \;

	log_end_insert_lines
else

source $profile
. profile 
if [[ $? -eq 0 ]] 
then
	if [[ $std_out_file == 'LOGPATH' ]]
	then
	
	#SERVER1_BATCH preofile loading
		if [[ $machine_name == "SERVER_3.server.com" ]]
		then
			log_start_insert_lines 
			log_file_name
			
			find /opt/bin/batch/log -maxdepth 3 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \;
			space
			find /opt/batch/log -maxdepth 3 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
 			
			log_end_insert_lines

		elif [[ $machine_name == "SERVER_4.server.com" || $machine_name == "SERVER_5.server.com" ]]
		then
			
	#SERVER_7 batch
		
			if [[ $job_initial == 'rah' ]]
			then
			log_start_insert_lines 
			log_file_name
		
			find /app/rules/bin/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \;	 
			space	
			find /opt/application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
		
	#SERVER_8 batch
		
			elif [[ $job_initial == 'hul' ]]
			then
			log_start_insert_lines 
			log_file_name
		
			find /app/application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \;	 
			space	
			find /opt/application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
			
	#RAA batch
	
			elif [[ $job_initial == 'raa' ]]
			then
			log_start_insert_lines 
			log_file_name
		
			find /app/application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \;	 
			space	
			find /application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
	
	#OOL batch
		
			elif [[ $job_initial == 'ool' ]]
			then
			log_start_insert_lines 
			log_file_name
		
			find /app/ml/python/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; 
			space	
			find /app/ool/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
		
	#NIY batch
		
			elif [[ $job_initial == 'niy' ]] 
			then
			log_start_insert_lines 
			log_file_nam
		
			find /app/login/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; 
			space	
			find /application/log -maxdepth 7 -mindepth 1 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
				
			else 
				cat job.txt
			fi
		
	#ati batch

		elif [[ $machine_name == "SERVER_3.server.com" || $machine_name == "SERVER_5.server.com" ]]
		then
			log_start_insert_lines 
			log_file_name
			
			find /app/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; 
			space	
			find /app/log/bin/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
				
		elif [[ $machine_name == "SERVER_6.server.com" ]]
		then
			log_start_insert_lines 
			log_file_name
			
			find /application/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; 
			space	
			find /application/niy/ati/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
			log_end_insert_lines
		
		else
			cat job.txt
		fi

	else
		echo "PLEASE CHECK MANUALLY "
	fi

#RUT failures with issue in loading profile 

elif [[ $machine_name == "SERVER_8.server.com" || $machine_name == "SERVER_10.server.com" ]]
then 
	log_start_insert_lines 
	log_file_name
			
	find /application/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; 
	space	
	find /app/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;
				 
	log_end_insert_lines

	
elif [[ $machine_name == "SERVER_13.server.com" ]]
then
        log_start_insert_lines
        log_file_name

        find /app/application/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \;
        space
        find /app/log -maxdepth 3 -mindepth 2 -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec tail -100 {} \;

        log_end_insert_lines

else
       cat job.txt
fi

fi
 
EOF

exit 1

#To check th log where need to move manually to the log path

elif [[ $file == '/' ]]
then

echo "$(tput setaf 2) -------------------------------- LOG BEGINS --------------------------------------$(tput sgr0)"
echo
echo "$(tput setaf 2) ++++++++++++++++++++++++++ YOUR ARE VIEWING BELOW LOGS ++++++++++++++++++++++++++ $(tput sgr0)"	 

	if [[ `echo $out_file | awk -F ' ' '{print $2}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $2}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2}'` 
	
	elif [[ `echo $out_file | awk -F ' ' '{print $3}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $3}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2"/"$3}'` 

	elif [[ `echo $out_file | awk -F ' ' '{print $4}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $4}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2"/"$3"/"$4}'`

 
	elif [[ `echo $out_file | awk -F ' ' '{print $5}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $5}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2"/"$3"/"$4"/"$5}'`


	elif [[ `echo $out_file | awk -F ' ' '{print $6}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $6}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2"/"$3"/"$4"/"$5"/"$6}'`


	elif [[ `echo $out_file | awk -F ' ' '{print $7}'` == 'logs' || `echo $out_file | awk -F ' ' '{print $7}'` == 'log' ]]
	then
		path=`echo $out_file | awk -F '/' '{print "/"$2"/"$3"/"$4"/"$5"/"%6"/"$7}'`

	else 
		echo "PLEASE CHECK MANUALLY"
	fi

export path

echo "$(tput setaf 2) -------------------------------- LOG ENDS --------------------------------------$(tput sgr0)"
echo 

elif [[ $file == 'D' || $file == 'd' ]]
then
	echo "$machine_name .... THIS IS WINDOWS SERVER !!!!  Please connect using in REMOTE SEVER to SEEK LOGS !!!"
fi

ssh -T -q `whoami`@$machine_name<<EOF

 find $path -ctime 0 -mtime 0 -type f  -iname "$2*log" -exec ls -lart {} \; -exec tail -100 {} \;

EOF
fi

rm -rf job.txt


