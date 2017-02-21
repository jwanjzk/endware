#! /bin/sh
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: Endwall
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.01
# Revision Date: February 21, 2017
#
# Change Log:  - File creation
#
#####################################################################
# Dependencies: youtube-dl, mpv, read
#####################################################################
# Instructions:  make a directory ~/bin and copy this file there, add this to the $PATH
#                then make the file executable and run it.
# $ mkdir ~/bin
# $ cp endstream.sh ~/bin/endstream
# $ cd ~/bin
# $ chmod u+wrx endstream
# $ export PATH=~/bin:"$PATH"
#
# Run ENDSTREAM
# $ endstream
#
####################################################################
#############################################################################################################################################################################
#                                         ACKNOWLEDGMENTS
#############################################################################################################################################################################
#  The Endware Development Team would like to acknowledge the work and efforts of OdiliTime, Balrog and SnakeDude who graciously hosted and promoted this software project. 
#  We would also like to acknowledge the work and efforts of Stephen Lynx, the creator and maintainer of LynxChan.  
#  Without their efforts and their wonderful web site www.endchan.xyz, The Endware Suite would not exist in the public domain at all in any form. 
#
#  So thanks to OdiliTime, Balrog, SnakeDude, and Stephen Lynx for inspiring this work and for hosting and promoting it. 
#  
#  The Endware Suite including Endwall,Endsets,Endlists,Endtools,Endloads and Endtube are named in honor of Endchan.
#
#  The Endware Suite is available for download at the following locations:
#  https://gitgud.io/Endwall/ , https://github.com/endwall2/, https://www.endchan.xyz/os/, http://42xlyaqlurifvvtq.onion,
#
#  Special thanks to the designer of the current EndWare logo which replaces the previous logo. It looks great!
#  Thank you also to early beta testers including a@a, and to other contributors including Joshua Moon (for user_agents.txt split and other good suggestions) 
#  as well as to the detractors who helped to critique this work and to ultimately improve it.  
#  
#  We also acknowledge paste.debian.net, ix.io, gitgud and github for their hosting services, 
#  without which distribution would be limited, so thank you.
#
#  https://www.endchan.xyz, http://paste.debian.net, https://gitgud.io, https://github.com, http://ix.io  
#
#  We salute you! 
#  
#  In the end, may it all end well.
#
#  The Endware Development Team
##############################################################################################################################################################################
##############################################################################################################################################################################
#                                                              LICENSE AGREEMENT  
##############################################################################################################################################################################
#  BEGINNING OF LICENSE AGREEMENT
#  TITLE:  THE ENDWARE END USER LICENSE AGREEMENT (EULA) 
#  CREATION DATE: MARCH 19, 2016
#  VERSION: 1.14
#  VERSION DATE: FEBRUARY 11, 2017
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2017
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, posses, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, government official, sovereign, monarch, head of state,
#        dignitary, ambassador, legislator, senator, noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any sex or gender, including men, women, and any other gender not mentioned.       
#  1) e) This program may be used by anyone of any affiliation, political viewpoint, political affiliation, religious belief, religious affiliation, and by those of non-belief or non affiliation.
#  1) f) This program may be used by any person of any race, ethnicity, identity, origin, genetic makeup, physical appearance, mental ability, and by those of any other physical 
#        or non physical characteristics of differentiation.
#  1) g) This program may be used by any human being of any sexual orientation, including heterosexual, homosexual, bisexual, asexual, or any other sexual orientation not mentioned.
#  1) h) This program may be used by anyone. 
#  WHERE MAY A USER USE THIS PROGRAM ?
#  2) a) This program may be used in any country, in any geographic location of the planet Earth, in any marine or maritime environment, at sea, sub-sea, in a submarine, underground,
#        in the air, in an airplane, dirigible, blimp, or balloon, and at any distance from the surface of the planet Earth, including in orbit about the Earth or the Moon,
#        on a satellite orbiting about the Earth, the Moon, about any Solar System planet and its moons, on any space transport vehicle, and anywhere in the Solar System including the Moon, Mars, and all other Solar System planets not listed.  
#  2) b) This program may be used in any residential, commercial, business, and governmental property or location and in all public and private spaces. 
#  2) c) This program may be used anywhere.
#  IN WHAT CONTEXT OR CIRCUMSTANCES MAY A USER USE THIS PROGRAM?
#  3)  This program may be used by any person, human being or sentient individual for any purpose and in any context and in any setting including for personal use, academic use,
#      business use, commercial use, government use, non-governmental organization use, non-profit organization use, military use, civilian use, and generally any other use 
#      not specifically mentioned.
#  WHAT MAY A "USER" DO WITH THIS PROGRAM ?
#  4) Any user of this program is granted the freedom to study the code.
#  5) a) Any user of this program is granted the freedom to distribute, publish, and share the code with any neighbor of their choice electronically or by any other method of transmission. 
#  5) b) The LICENCSE AGREEMENT, ACKNOWLEDGMENTS, Header and Instructions must remain attached to the code in their entirety when re-distributed.
#  5) c) Any user of this program is granted the freedom to sell this software as distributed or to bundle it with other software or salable goods.
#  6) a) Any user of this program is granted the freedom to modify and improve the code.
#  6) b) When modified or improved, any user of this program is granted the freedom of re-distribution of their modified code if and only if the user attatchs the LICENSE AGREEMENT
#        in its entirety to their modified code before re-distribution.
#  6) c) Any user of this software is granted the freedom to sell their modified copy of this software or to bundle their modified copy with other software or salable goods.
#  7) a) Any user of this program is granted the freedom to run this code on any computer of their choice.
#  7) b) Any user of this program is granted the freedom to run as many simultaneous instances of this code, on as many computers as they are able to and desire, and for as long as they desire and are
#        able to do so with any degree of simultaneity in use. 
#  WHAT MUST A "USER" NOT DO WITH THIS PROGRAM ?
#  8) Any user of this program is not granted the freedom to procure a patent for the methods presented in this software, and agrees not to do so.
#  9) Any user of this program is not granted the freedom to arbitrarily procure a copyright on this software as presented, and agrees not to do so.
#  10) Any user of this program is not granted the freedom to obtain or retain intellectual property rights on this software as presented and agrees not to do so.
#  11) a) Any user of this program may use this software as part of a patented process, as a substitutable input into the process; however the user agrees not to attempt to patent this software as part of their patented process. 
#      b) This software is a tool, like a hammer, and may be used in a process which applies for and gains a patent, as a substitutable input into the process;
#         however the software tool itself may not be included in the patent or covered by the patent as a novel invention, and the user agrees not to do this and not to attempt to do this.
#  WHO GRANTS THESE FREEDOMS ?
#  12) The creators of this software are the original developer,"Endwall", and anyone listed as being a member of "The Endware Development Team", as well as ancillary contributors, and user modifiers and developers of the software. 
#  13) The aforementioned freedoms of use listed in sections 4),5),6),and 7) are granted by the creators of this software and the Endware Development Team to any qualifying user listed in section 1) and 
#      comporting with any restrictions and qualifications mentioned in sections 2), 3), 8), 9), 10) and 11) of this LICENSE AGREEMENT.
#  WHAT RELATIONSHIP DO THE USERS HAVE WITH THE CREATORS OF THE SOFTWARE ?
#  14)  This software is distributed "as is" without any warranty and without any guaranty and the creators do not imply anything about its usefulness or efficacy.
#  15)  If the user suffers or sustains financial loss, informational loss, material loss, physical loss or data loss as a result of using, running, or modifying this software 
#       the user agrees that they will hold the creators of this software, "The Endware Development Team", "Endwall", and the programmers involved in its creation, free from prosecution, 
#       free from indemnity, and free from liability, and will not attempt to seek restitution, compensation, or payment for any such loss real or imagined.
#  16)  If a user makes a significant improvement to this software, and if this improvement is included in a release, the user agrees not to seek remuneration or payment 
#       from the creators of this software or from Endwall or from the Endware Development Team, for any such work contribution performed, and the user understands 
#       that there will be no such remuneration or payment rendered to them for any such contribution. 
#  END OF LICENSE AGREEMENT
##################################################################################################################################################################################
#  ADDITIONAL NOTES:
#  17)  If a user finds a significant flaw or makes a significant improvement to this software, please feel free to notify the original developers so that we may also
#       include your user improvement in the next release; users are not obligated to do this, but we would enjoy this courtesy tremendously.
#
#  18)  Sections 0) a) 0) b) and 1) a) are sufficient for use; however sections 1) b) through 1) h) are presented to clarify 1 a) and to enforce non-discrimination and non-exclusion of use.  
#       For example some people may choose to redefine the meaning of the words "person" "human being" or "sentient individual" to exclude certain types of people.
#       This would be deemed unacceptable and is specifically rejected by the enumeration presented.  If the wording presented is problematic please contact us and suggest a change,
#       and it will be taken into consideration.  
#################################################################################################################################################################################
######################################## BEGINNING OF PROGRAM    ##########################################################

###############  VERSION INFORMATION  ##############
version="0.01"
rev_date="21/02/2017"
branch="gnu/linux"
##################################################
for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo " ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl mpv using"
   echo "  Type in the terminal $ endstream "
   echo "  Now read the list and pick a number,input it and press enter."
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDGET: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
 fi
done

echo " English Language Streams || French Language Streams || Spanish Language Streams || Other Language Streams"
echo "1)  France 24 English        21) France 24 Francais      41) Videos Directo          62) CCTV 4 Chinese "
echo "2) Al Jazeera English        22) Euronews Francais       42) Q24"
echo "3) Fox News                  23) NTVUganda               43) 100% Noticias"
echo "4) CNN stream 1              24) KTN Kenya               44) Televisa del Bajio"         
echo "5) CNN stream 2              25) Africa News             45) Televisa del Golfo"
echo "6) ABC Australia             26) TLM                     46) Televisa Guadalajara"
echo "7) CBS NEWS / MSNBC / NBC    27) France Inter            47) Televisa del Noreste"
echo "8) NEWSMAX                   28) RFI                     48) Televisa Veracruz"
echo "9) Bloomberg                 29) Imagine Radio           49) GalaTV Morelos"
echo "10) Channels 24 Nigeria      ==SPANISH LANGUAGE==        50) Televisa Puebla"
echo "11) Africa News Live         30) TeleSUR                 51) GalaTV Queretaro"
echo "12) GCTN English             31) RT Espanol              52) Televisa Mexicali"
echo "13) TRT World                32) DW Espanol              53) GalaTV Chihuahua"
echo "14) TWiT                     33) NTN24                   54) GalaTV Acapulco"
echo "15) CNBC Africa              34) Canal 8 San Juan        55) GalaTV Zacatecas "
echo "16) RBSN Live                35) c5n                     56) Televisa Campeche"
echo "17) TYT                      36) Canal Siete             57) Televisa Hermosillo"
echo "                             37) HispanTV                58) GalaTV Laguna"
echo "==EUROZONE RESTRICTED==      38) Globovision             59) 1070 Noticias"
echo "18) SKY NEWS Britain         39) Excelsior TV            60) Unknown 1"
echo "19) Euronews English         40) Hipodormo               61) Unknown 2  "
echo "20) DW English      

echo " Please Select a Number corresponding to a YouTube news live stream "

read n

case $n in 
################    MAIN  ENGLISH  ##################################
# 1) France 24 Anglais 
1) link=https://www.youtube.com/watch?v=1Ydto3Iyzic ;;
# 2) Al Jazeera
2) link=https://www.youtube.com/watch?v=pJC-vohDHl8 ;;
# 3) Fox
3) link=https://www.youtube.com/watch?v=Sp8HfLuX-4w ;;
# 4) CNN Stream 1
4) link=https://www.youtube.com/watch?v=hq9Mpmb80Kw ;;
# 5) CNN Stream 2
5) link=https://www.youtube.com/watch?v=5w5lmAgl5wU ;;
# 6) ABC Australia Live NEWS
6) link=https://www.youtube.com/watch?v=EDmdDMVE4_g ;;
# 7) CBS NEWS / MSNBC / NBC 
7) link=https://www.youtube.com/watch?v=0Mm_DatWXyY ;;
# 8) NEWSMAX
8) link=https://www.youtube.com/watch?v=Qtq6EP2VvjE ;;
# 9) Bloomberg
9) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w ;;
# 10) Channels 24 Nigeria
10) link=https://www.youtube.com/watch?v=ANM-dq5USTc ;;
# 11) Africa News Live
11) link=https://www.youtube.com/watch?v=zcWWdvRaaSA ;;
# 12) GCTN English
12) link=https://www.youtube.com/watch?v=x4vdN0u9Ksw ;;
#  13) TRT World
13) link=https://www.youtube.com/watch?v=N7jfTZLkhms ;;
###############      OTHER ENGLISH          ##################################
#  14) TWiT
14) link=https://www.youtube.com/watch?v=Gthvw4Bevkg ;;
#  15) CNBC Africa
15) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI ;;
#  16) RBSN Live
16) link=https://www.youtube.com/watch?v=4hUovMOUqJs ;;
#  17) TYT 
17) link=https://www.youtube.com/watch?v=Iwdz7yYk5Ys ;;
###############    RESTRICTED TO EUROPE     ###########################
# 18) SKY NEWS
18) link=https://www.youtube.com/watch?v=y60wDzZt8yg ;;
# 19) Euronews English Live
19) link=https://www.youtube.com/watch?v=Nxid1JTdfrk ;;
# 20) DW English
20) link=https://www.youtube.com/watch?v=gNosnzCaS4I ;;
#################    FRENCH   ###################################
# 21) France 24 Francais
21) link=https://www.youtube.com/watch?v=vp-82gDggk4 ;;
# 22) Euronews
22) link=https://www.youtube.com/watch?v=03O3ZyJW-Tc ;;
# 23) NTVUganda
23) link=https://www.youtube.com/watch?v=PLFM82-Br8Y ;;
# 24) KTN Kenya
24) link=https://www.youtube.com/watch?v=W3xCC_sDNxA ;;
# 25) Africa News
25) link=https://www.youtube.com/watch?v=tUjOfmeLpHo ;;
# 26) TLM 
26) link=https://www.youtube.com/watch?v=vOLDMexUxpM ;;
# 27) France Inter
27) link=https://www.youtube.com/watch?v=59Rw7-8PRng ;;
# 28) RFI
28) link=https://www.youtube.com/watch?v=N8tHbVYKRBY ;;
# 29) Imagine Radio
29) link=https://www.youtube.com/watch?v=OSOXIMOxpEw ;;
###################  SPANISH  #################################
# 30) TeleSUR
30) link=https://www.youtube.com/watch?v=3fwfmhTYUZs ;;
# 31) RT Espanol
31) link=https://www.youtube.com/watch?v=OALyNX4IbBI ;;
# 32) DW Espanol
32) link=https://www.youtube.com/watch?v=wBDQlzVRMgU ;;
# 33) NTN24 
33) link=https://www.youtube.com/watch?v=-ukAwFoV9pY ;;
# 34) Canal 8 San Juan
34) link=https://www.youtube.com/watch?v=yiwJzHW123c ;;
# 35) c5n
35) link=https://www.youtube.com/watch?v=rio_WuZUbD8 ;;
# 36) Canal Siete
36) link=https://www.youtube.com/watch?v=EUgiU4KZEPo ;;
# 37) HispanTV 
37) link=https://www.youtube.com/watch?v=kibgnmaJoAs ;;
# 38) Globovision
38) link=https://www.youtube.com/watch?v=Lm-AmFtPlc4 ;;
# 39) Excelsior TV
39) link=https://www.youtube.com/watch?v=NANvipRo_eE ;;
# 40) Hipodormo
40) link=https://www.youtube.com/watch?v=wUg_XReEIHA ;;
# 41) Videos Directo
41) link=https://www.youtube.com/watch?v=gxXvDDl4cTs ;;
# 42) Q24
42) link=https://www.youtube.com/watch?v=yZGc05q7ajA ;;
# 43) 100% Noticias
43) link=https://www.youtube.com/watch?v=rH2EAkpuusY ;;
## Canals  Vivo  de Televisia Regional 
# 44) Televisa del Bajio
44) link=https://www.youtube.com/watch?v=wmcA51ETCoo ;;
# 45) Televisa del Golfo
45) link=https://www.youtube.com/watch?v=r8K8nFKBGB8 ;;
# 46) Televisa Guadalajara
46) link=https://www.youtube.com/watch?v=4btUDfIjjbk ;;
# 47) Televisa del Noreste
47) link=https://www.youtube.com/watch?v=d2qjt-7KIUE ;;
# 48) Televisa Veracruz
48) link=https://www.youtube.com/watch?v=xDp59IK5u64 ;;
 # 49) GalaTV Morelos
49) link=https://www.youtube.com/watch?v=TDrgg9VJOq4 ;;
# 50) Televisa Puebla
50) link=https://www.youtube.com/watch?v=vGQReDz9-iQ ;;
# 51) GalaTV Queretaro
51) link=https://www.youtube.com/watch?v=AIPhfPslF0E ;;
# 52) Televisa Mexicali
52) link=https://www.youtube.com/watch?v=HLJH3C_7nnk ;;
# 53) GalaTV Chihuahua
53) link=https://www.youtube.com/watch?v=VloHUkS_Cn0 ;;
# 54) GalaTV Acapulco
54) link=https://www.youtube.com/watch?v=6MeD88060x8 ;;
# 55) GalaTV Zacatecas
55) link=https://www.youtube.com/watch?v=r1arJCFwz3o ;;
# 56) Televisa Campeche
56) link=https://www.youtube.com/watch?v=Kf5i1zEDEJQ ;;
# 57)  Televisa Hermosillo
57) link=https://www.youtube.com/watch?v=2jH6YinOabQ ;;
# 58)  GalaTV Laguna
58) link=https://www.youtube.com/watch?v=6SuhteXqf90 ;;
# 59) 1070 Noticias
59) link=https://www.youtube.com/watch?v=bfe9RLT9SBo ;;
# 60) Unknown 1
60) link=https://www.youtube.com/watch?v=fHhS2BElUF0 ;;
# 61) Unknown 2
61) link=https://www.youtube.com/watch?v=pTgYBW2cm5c ;;
###############  OTHER   ##############################
#  62) CCTV 4 Chinese
62) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw ;;

esac

mpv "$link" 

exit "$?"

######################     END OF PROGRAM      ####################################################