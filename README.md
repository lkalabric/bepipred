# bioinfo
<b>Apps to perform bioinfo analysis</b>

So far we developed two scripts to map nucl or prot motifs into a reference Blast database (blastdb):
1) fasta2blastdb.sh - create a blastdb out of a nucl or prot SUBJECT REFSEQ fasta file
2) blastanything.sh - search a QUERY fasta file (can be multiseq fasta file as well) with nucl or prot motif(s) from a previously set blastdb

<b>Requirements</b>

To run both scripts one needs to have a Linux machine with the following commands pre-installed: makeblastdb, tblastn, blastp, git

<b>Installation</b>

$ sudo rpm -ivh ncbi-blast-2.2.18-1.x86_64.rpm<p>
$ sudo apt install git<p>
Note: one must have root privileges to run these commands. If you do not have root privileges, please contact the server admin to run them for you.

<b>Download and run scripts</b>

- Create a repos directory and download the script files using the following commands:
$ mkdir repos
$ cd repos
$ git clone https://github.com/lkalabric/bioinfo.git
Note: I recommend you create and copy the scripts to your bin/ os scripsts/
$ mkdir ~/bin or mkdir ~/scripts
$ cp ~/repos/bioinfo/*.sh ~/bin or cp ~/repos/bioinfo/*.sh ~/scripts

- Change the mode of both files to executable
$ cd ~/scripts/
$ chmod +x *.sh
$ cd ~

- Together with the scripts there are one protein QUERY file (antigen-iedb.fasta) and two SUBSJECT files (M73218.HEV-1.Burma.nt.fasta and M73218.HEV-1.Burma.aa.fasta) for demonstration. Let´s create directories and copy them accordingly:
$ mkdir -p ~/data/QUERY/
$ cp ~/repos/bioinfo/antigens-iedb.fasta ~/data/QUERY/
$ mkdir -p ~/data/REFSEQ/HEV/
$ cp ~/repos/bioinfo/M* ~/data/REFSEQ/HEV/

- Test if they are in your PATH by typing:
$ fasta2blastdb.sh
Note: If you do not see any output in the terminal execute export PATH=$PATH:${HOME}/bin or export PATH=$PATH:${HOME}/scripts according to the place you saved the files in your terminal.

- Run the scripts to search prot queries in a nucl balstdb using tblastn:
$ fasta2blastdb.sh ~/data/REFSEQ/HEV/M73218.HEV-1.Burma.nt.fasta data/HEVnt_DB nucl
$ blastanything.sh ~/data/QUERY/antigens-iedb.fasta ~/data/HEVnt_DB/ tblastn

- Run the scripts to search prot queries in a prot balstdb using tblastn:
$ fasta2blastdb.sh ~/data/REFSEQ/HEV/M73218.HEV-1.Burma.aa.fasta data/HEVaa_DB prot
$ blastanything.sh ~/data/QUERY/antigens-iedb.fasta ~/data/HEVaa_DB/ blastp
