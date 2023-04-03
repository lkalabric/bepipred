# bioinfo
Apps to perform bioinfo analysis

So far we developed to scripts to map motifs, nucl or prot, in a reference genome:
1) fasta2blast.sh - create a blastdb out of a nucl or prot SUBJECT REFSEQ fasta file
2) blastanything.sh - search a QUERY fasta file (can be multiseq fasta file as well) with nucl or prot motif(s) from a previously set blastdb

Requirements
In order to run both scripts one need to have a linux machine with the following commands pre-installed: makeblastdb, tblastn, blastp, git

Install:
$ sudo rpm -ivh ncbi-blast-2.2.18-1.x86_64.rpm
$ sudo apt install git
Note: one must have root privileges to run these commands. If you do not have root privileges, please contact the server admin to run them to you.

Download and run scripts
Create a directory called repos to download the script files and follow this commands:
$ cd repos
$ git clone 

