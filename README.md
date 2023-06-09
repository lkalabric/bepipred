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
Note: One must have root privileges to run these commands. If you do not have root privileges, please contact the server admin to run them for you.

<b>Download and run scripts</b>

- Create a repos directory and download the script files using the following commands:
$ mkdir repos<p>
$ cd repos<p>
$ git clone https://github.com/lkalabric/bioinfo.git<p>
Note: I recommend you create and copy the scripts to your bin/ os scripsts/<p>
$ mkdir ~/bin or mkdir ~/scripts<p>
$ cp ~/repos/bioinfo/*.sh ~/bin or cp ~/repos/bioinfo/*.sh ~/scripts<p>

- Change the mode of both files to executable<p>
$ cd ~/scripts/<p>
$ chmod +x *.sh<p>
$ cd ~<p>

- Together with the scripts there are one protein QUERY file (antigen-iedb.fasta) and two SUBSJECT files (M73218.HEV-1.Burma.nt.fasta and M73218.HEV-1.Burma.aa.fasta) for demonstration. Let's prepare the environment for analysis by creating directories and copying the files into them:<p>
$ mkdir -p ~/data/QUERY/<p>
$ cp ~/repos/bioinfo/antigens-iedb.fasta ~/data/QUERY/<p>
$ mkdir -p ~/data/REFSEQ/HEV/<p>
$ cp ~/repos/bioinfo/M* ~/data/REFSEQ/HEV/<p>

- Test if they are in your PATH by typing:<p>
$ fasta2blastdb.sh<p>
Note: If you do not see any output in the terminal execute export PATH=$PATH:${HOME}/bin or export PATH=$PATH:${HOME}/scripts according to the place you saved the files in your terminal.

- Run the scripts to search prot queries in a nucl balstdb using tblastn:<p>
$ fasta2blastdb.sh ~/data/REFSEQ/HEV/M73218.HEV-1.Burma.nt.fasta data/HEVnt_DB nucl<p>
$ blastanything.sh ~/data/QUERY/antigens-iedb.fasta ~/data/HEVnt_DB/ tblastn<p>

- Run the scripts to search prot queries in a prot balstdb using tblastn:<p>
$ fasta2blastdb.sh ~/data/REFSEQ/HEV/M73218.HEV-1.Burma.aa.fasta data/HEVaa_DB prot<p>
$ blastanything.sh ~/data/QUERY/antigens-iedb.fasta ~/data/HEVaa_DB/ blastp
