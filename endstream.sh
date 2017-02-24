#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.07
# Revision Date: February 23, 2017
#
# Change Log:  - Add channels, rearange, remove dead streams
#              - Rearanged the channels, added more channels
#              - File creation, testing, remove dead streams
#
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
version="0.07"
rev_date="23/02/2017"
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
   echo "ENDSTREAM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
 fi
done

echo "========================================================          ENDSTREAM          ========================================================"
echo "||       ENGLISH           ||          FRANCAIS        ||          ESPANOL           ||         OTHER         ||          EXTRA          ||  "
echo "============================================================================================================================================="
echo "1) France 24 English         === FRENCH LANGUAGE ====    61) Televisa Puebla           92) NASA EARTH             122) CBC Arabic            "
echo "2) Al Jazeera English        32) France 24 Francais      62) GalaTV Queretaro          93) NASA ISS 1             123) Saudi 2 TV            " 
echo "3)  CNN                      33) Euronews Francais       63) Televisa Mexicali         94) NASA ISS 2             124) Syrian Satellite      "
echo "4)  i24 News                 34) Africa News             64) GalaTV Acapulco           95) Hubble Telescope       125) Al Mayadeen           "          
echo "5)  Fox News                 35) Afrique Media           65) GalaTV Zacatecas          ===ASIAN LANGUAGES===      126) Al Arabiya            "
echo "6)  Fox News                 36) France Info             66) Televisa Hermosillo       96) CCTV 4 China           127) Al Jazeera            "
echo "7)  MSNBC/CBSN               37) Mosaik TV               67) GalaTV Laguna             97) EBC 51 Taiwan          128) France 24 Arabic      "
echo "8)  NEWSMAX                  38) TLM 30 Lyon             68) 1070 Noticias             98) SHIBUYA NEWS JAPAN     129) BBC Arabic            "
echo "9)  Bloomberg                39) France Inter            69) GalaTV Toluca             99) QVC JAPAN              130) SKY News Arabic       "
echo "10) Channels 24 Nigeria      40) RFI                     70) TelePacifico              100) KBS World 24 Live     131) RT Arabic             "
echo "11) Africa News              ====SPANISH LANGUAGE====    71) Cinevision Canal 19       101) KBS World English     132) POCCNR 24 Russia      "
echo "12) CGTN English             41) TeleSUR                 72) Canal 8 Mar del Plata     102) Tugulu News           133) ---------             "
echo "13) TRT World                42) RT Espanol              73) Tu Cana                   103) Tv9 Marathi           134) ---------             "
echo "14) ABS-CBN                  43) DW Espanol              74) VPI TV                    104) Survana News          135) ---------             "
echo "15) TWiT                     44) NTN24                   75) 100% Noticias Nicaragua   105) News 18 India         136) Talking TOM           "
echo "16) CNBC Africa              45) Canal 8 San Juan        76) El Capitolo Venezulana    106) SAMAA TV              137) WWE RAW               "
echo "17) NTV Uganda               46) Canal 6 San Rafael      77) -----                     107) Aaj Tak               138) All News              "
echo "18) RSBN                     47) Canal Siete             78) -----                     108) TV9 Telugu            139) ABC Australia         "
echo "19) Amazing Facts            48) HispanTV                79) -----                     109) NTV Telugu            140) CBC The National      "
echo "20) It's Supernatural        49) Globovision             80) -----                     110) ABN Telugu            141) Infowars              "  
echo "21) IHOP                     50) Excelsior TV            81) -----                     111) Vanitha TV            142) TYT                   "
echo "22) HSN                      51) Imagine Radio           82) -----                     112) HMT                   143) PBS News Hour         "      
echo "23) KTN Kenya English        52) Videos Directo          83) -----                     113) TV5                   144) Venice Bridge         " 
echo "24) Tom & Jerry              53) Q24                     84) -----                     114) 10TV Telugu           145) Venice Port           "
echo "25) WWE Smackdown            54) La Cáscara TV           85) -----                     115) AsiaNet               146) Jackson Hole          "
echo "26) Arirang TV               55) Televisa del Bajio      86) -----                     116) NTV Bangladesh        147) Jackson Hole          "
echo "27) India Today              56) Televisa del Golfo      87) -----                     117) PTV Phillipeans       148) Jackson Hole          "
echo "28) NASA TV                  57) Televisa Guadalajara    88) EuroNews Deutche          118) ------                149) Verona Italy          "
echo "29) ----------               58) Televisa del Noreste    89) DW English                119) ON E Arabic           150) Soggy Dollar          "
echo "30) ----------               59) Televisa Veracruz       90) Euronews English          120) ON E Sport            151) Amsterdam Netherlands "
echo "31) ----------               60) GalaTV Morelos          91) SKY NEWS Britain          121) Adom TV               152) Florida Eagle Cam     "
echo "============================================================================================================================================="
echo " " 
echo " Please Select a Number corresponding to a YouTube news live stream "

read n

case $n in 
################    MAIN  ENGLISH  ##################################
# 1) France 24 Anglais 
1) link=https://www.youtube.com/watch?v=1Ydto3Iyzic ;;
# 2) Al Jazeera
2) link=https://www.youtube.com/watch?v=pJC-vohDHl8 ;;
# 3) CNN 
3) link=https://www.youtube.com/watch?v=utHp6jQKta4 ;;
# 4) i24 News
4) link=https://www.youtube.com/watch?v=ArNFMKxtsxY ;;
# 5) Fox News
5) link=https://www.youtube.com/watch?v=Z7HSAnWCUQw ;;
# 6) Fox News
6) link=https://www.youtube.com/watch?v=lYbEYo5-b6U ;;
# 7) CBS NEWS / MSNBC / NBC 
7) link=https://www.youtube.com/watch?v=xCeP1FmzVos ;;
# 8) NEWSMAX
8) link=https://www.youtube.com/watch?v=Qtq6EP2VvjE ;;
# 9) Bloomberg
9) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w ;;
# 10) Channels 24 Nigeria
10) link=https://www.youtube.com/watch?v=ANM-dq5USTc ;;
# 11) Africa News Live
11) link=https://www.youtube.com/watch?v=zcWWdvRaaSA ;;
# 12) CGTN English
12) link=https://www.youtube.com/watch?v=GV1p3irkgi0 ;;
#  13) TRT World
13) link=https://www.youtube.com/watch?v=N7jfTZLkhms ;;
# 14) ABS-CBN
14) link=https://www.youtube.com/watch?v=3vYPyZywbZs ;;
###############      OTHER ENGLISH          ##################################
#  15) TWiT
15) link=https://www.youtube.com/watch?v=Gthvw4Bevkg ;;
#  16) CNBC Africa
16) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI ;;
# 17)  NTV Uganda
17) link=https://www.youtube.com/watch?v=CL8dsz9RRW8 ;; 
#  18) RSBN Live
18) link=https://www.youtube.com/watch?v=xEQEM7X7J4E ;;
# 19) Amazing Facts TV (Christian)
19) link=https://www.youtube.com/watch?v=JFLFK362vns ;;
# 20) It's Supernatural! Network
20) link=https://www.youtube.com/watch?v=TgYk_asWz_4 ;;
# 21) International House of Prayer (IHOP)
21) link=https://www.youtube.com/watch?v=dyD6lMY11wM ;;
# 22) HSN
22)  link=https://www.youtube.com/watch?v=J0022wscx0k ;;
# 23) KTN Kenya English
23) link=https://www.youtube.com/watch?v=YASZYb8UBs8 ;;
# 24) Tom and Jerry Cartoons
24) link=https://www.youtube.com/watch?v=49eA7hGeixM ;;
# 25) WWE Smackdown
25) link=https://www.youtube.com/watch?v=ZrN4K6bEzEg ;;
# 26)  Arirang TV
26) link=https://www.youtube.com/watch?v=JVr6yiZ9IMY ;;
# 27) India TODAY
27) link=https://www.youtube.com/watch?v=wXwYCWGpprc ;;
# 28)   NASA TV
28) link=https://www.youtube.com/watch?v=UdmHHpAsMVw ;; 
# 29)
# 30)
# 31)
#################    FRENCH   ###################################
# 32) France 24 Francais
32) link=https://www.youtube.com/watch?v=vp-82gDggk4 ;;
# 33) Euronews
33) link=https://www.youtube.com/watch?v=03O3ZyJW-Tc ;;
# 34) Africa News
34) link=https://www.youtube.com/watch?v=tUjOfmeLpHo ;;
# 35) Afrique Media
35) link=https://www.youtube.com/watch?v=GpHTBs6B7Zk ;;
# 36) France Info
36) link=https://www.youtube.com/watch?v=SN7sncKzRq4 ;;
# 37) Mosaik TV Francais
37) link=https://www.youtube.com/watch?v=JcKSOnfoDRc ;;
# 38) TLM 
38) link=https://www.youtube.com/watch?v=soT36gH86Fw ;;
# 39) France Inter
39) link=https://www.youtube.com/watch?v=59Rw7-8PRng ;;
# 40) RFI
40) link=https://www.youtube.com/watch?v=N8tHbVYKRBY ;;
###################  SPANISH  #################################
# 41) TeleSUR
41) link=https://www.youtube.com/watch?v=3fwfmhTYUZs ;;
# 42) RT Espanol
42) link=https://www.youtube.com/watch?v=OALyNX4IbBI ;;
# 43) DW Espanol
43) link=https://www.youtube.com/watch?v=wBDQlzVRMgU ;;
# 44) NTN24 
44) link=https://www.youtube.com/watch?v=-ukAwFoV9pY ;;
# 45) Canal 8 San Juan
45) link=https://www.youtube.com/watch?v=yiwJzHW123c ;;
# 46) Canal 6 San Rafael
46) link=https://www.youtube.com/watch?v=axnhmU97Ktg ;;
# 47) Canal Siete
47) link=https://www.youtube.com/watch?v=EUgiU4KZEPo ;;
# 48) HispanTV 
48) link=https://www.youtube.com/watch?v=kibgnmaJoAs ;;
# 49) Globovision
49) link=https://www.youtube.com/watch?v=Lm-AmFtPlc4 ;;
# 50) Excelsior TV
50) link=https://www.youtube.com/watch?v=NANvipRo_eE ;;
# 51) Imagine Radio
51) link=https://www.youtube.com/watch?v=OSOXIMOxpEw ;;
# 52) Videos Directo
52) link=https://www.youtube.com/watch?v=gxXvDDl4cTs ;;
# 53) Q24
53) link=https://www.youtube.com/watch?v=yZGc05q7ajA ;;
# 54) La Casacra TV 
54) link=https://www.youtube.com/watch?v=vEwpn57ip7w ;;
## Canals  Vivo  de Televisia Regional 
# 55) Televisa del Bajio
55) link=https://www.youtube.com/watch?v=wmcA51ETCoo ;;
# 56) Televisa del Golfo
56) link=https://www.youtube.com/watch?v=tctk186_31s ;;
# 57) Televisa Guadalajara
57) link=https://www.youtube.com/watch?v=4btUDfIjjbk ;;
# 58) Televisa del Noreste
58) link=https://www.youtube.com/watch?v=d2qjt-7KIUE ;;
# 59) Televisa Veracruz
59) link=https://www.youtube.com/watch?v=xDp59IK5u64 ;;
# 60) GalaTV Morelos
60) link=https://www.youtube.com/watch?v=TDrgg9VJOq4 ;;
# 61) Televisa Puebla
61) link=https://www.youtube.com/watch?v=vGQReDz9-iQ ;;
# 62) GalaTV Queretaro
62) link=https://www.youtube.com/watch?v=AIPhfPslF0E ;;
# 63) Televisa Mexicali
63) link=https://www.youtube.com/watch?v=HLJH3C_7nnk ;;
# 64) GalaTV Acapulco
64) link=https://www.youtube.com/watch?v=6MeD88060x8 ;;
# 65) GalaTV Zacatecas
65) link=https://www.youtube.com/watch?v=r1arJCFwz3o ;; 
# 66)  Televisa Hermosillo
66) link=https://www.youtube.com/watch?v=2jH6YinOabQ ;;
# 67)  GalaTV Laguna
67) link=https://www.youtube.com/watch?v=6SuhteXqf90 ;;
# 68) 1070 Noticias
68) link=https://www.youtube.com/watch?v=bfe9RLT9SBo ;;
# 69) GalaTV Estado de México Toluca
69) link=https://www.youtube.com/watch?v=fHhS2BElUF0 ;;
# 70) TelePacifico
70) link=https://www.youtube.com/watch?v=ZQnMKaGYu9Q ;; 
# 71) Cinevision Canal 19
71) link=https://www.youtube.com/watch?v=aBLbwbSycLU  ;;
# 72) Canal 8 Mar del Plata
72) link=https://www.youtube.com/watch?v=MbOpUZnOdNY  ;; 
# 73) Tu Canal
73) link=https://www.youtube.com/watch?v=NEF_sHYhio0 ;;
# 74) VPI TV 
74) link=https://www.youtube.com/watch?v=5GyfFhBnbhk ;;
# 75) 100% Noticias Nicaragua
75) link=https://www.youtube.com/watch?v=sFQqcQJhJnQ ;; 
# 76) El Capitolo Venezulana
76) link=https://www.youtube.com/watch?v=tjYvi3tSbr0 ;;
#####################  TRANSIENT FEEDS   #######################
# 77) 
# 78)
# 79)
# 80)
# 81)
# 82)
# 83) GalaTV Chihuahua
# 83) link=https://www.youtube.com/watch?v=VloHUkS_Cn0 ;;
# 84) Televisa Campeche BROKEN
# 84) link=https://www.youtube.com/watch?v=Kf5i1zEDEJQ ;;
# 85) Canal Noticias Argentina BROKEN
# 85) link=https://www.youtube.com/watch?v=WJCIuoKvzi0 ;;
# 86) Canal 44 BROKEN
# 86) link=https://www.youtube.com/watch?v=5sdRSFaPycE ;;
# 87) c5n SPANISH  BROKEN
# 87) link=https://www.youtube.com/watch?v=iPLHkyI1hr4 ;;
###############    RESTRICTED TO EUROPE     ###########################
# 88)  EuroNews Deutche
88) link=https://www.youtube.com/watch?v=dYJ0kTqeu08 ;;
# 89) SKY NEWS
89) link=https://www.youtube.com/watch?v=y60wDzZt8yg ;;
# 90) Euronews English Live
90) link=https://www.youtube.com/watch?v=Nxid1JTdfrk ;;
# 91) DW English
91) link=https://www.youtube.com/watch?v=gNosnzCaS4I ;;
# 92) NASA LIVE STREAM
92) link=https://www.youtube.com/watch?v=SF7FUU7CThs ;;
# 93) NASA LIVE STREAM
93) link=https://www.youtube.com/watch?v=ddFvjfvPnqk ;;
# 94) NASA LIVE STREAM
94) link=https://www.youtube.com/watch?v=qzMQza8xZCc ;;
# 95)Hubble Telescope
95) link=https://www.youtube.com/watch?v=TzpO54TuSXs ;;
################ CHINESE MANDARIN CANTONESE  ####################
# 96) CCTV 4 Chinese
96) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw ;;
# 97) EBC 51 News
97) link=https://www.youtube.com/watch?v=yzE3bRtXIrI ;;
################ JAPANESE  ####################
#  98) Shibua Community News Japan
98) link=https://www.youtube.com/watch?v=_9pavMzUY-c ;;
#  99) QVC JAPAN SHOPPING CHANNEL
99) link=https://www.youtube.com/watch?v=wMo3F5IouNs ;;
################ KOREAN  ###############################
#  100) KBS World 24
100) link=https://www.youtube.com/watch?v=9nMuTuy5SIs ;;
# 101) KBS World English Sub
101) link=https://www.youtube.com/watch?v=mRUT78iMdLw ;;
##################### INDIAN / HINDI ########################################
# 102) Telugu News
102) link=https://www.youtube.com/watch?v=kg48DXa4bKE ;;
# 103) Tv9 Marathi
103) link=https://www.youtube.com/watch?v=BremLDr3lgA ;;
# 104) Survana News
104) link=https://www.youtube.com/watch?v=xJqm4gxr7gs ;;
# 105) News 18 India
105) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 ;;
# 106) SAMAA TV
106) link=https://www.youtube.com/watch?v=qH2kZjv1CYM ;;
# 107) Aaj Tak 
107) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q ;;
# 108) TV9 Telugu
108) link=https://www.youtube.com/watch?v=-ZcgjH9MNtI ;;
# 109) NTV Telugu
109) link=https://www.youtube.com/watch?v=T953eK1GXbA ;;
# 110) ABN Telugu
110) link=https://www.youtube.com/watch?v=QzQnFY6CioA ;;
# 111) Vanitha TV 
111) link=https://www.youtube.com/watch?v=ji7H-z506SA ;;
# 112) HMT Telugu
112) link=https://www.youtube.com/watch?v=qdi47ihDFCk ;;
# 113) TV5 News 
113) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg ;;
# 114) 10TV Telugu
114) link=https://www.youtube.com/watch?v=UpNJQg567UU ;;
# 115) AsiaNet News
115) link=https://www.youtube.com/watch?v=YYqeFCJRBUg  ;;
# 116) NTV Bangladesh
116) link=https://www.youtube.com/watch?v=5pz4cXHd6TI ;;
# 117) PTV
117) link=https://www.youtube.com/watch?v=ltl9qs0HEAQ ;;
# 118)
################## ARABIC  ###########################################
# 119) ON E Live 
119) link=https://www.youtube.com/watch?v=mcsYSFZV4bw ;;
# 120)  ON E Sport
120) link=https://www.youtube.com/watch?v=ngalZ7mScqM ;;
# 121) ADOM TV 
121) link=https://www.youtube.com/watch?v=g5McawVm8Q4 ;;
# 122 CBC Arabic Live
122) link=https://www.youtube.com/watch?v=FFx5r-U9ryA ;;
# 123) Saudi 2 TV
123) link=https://www.youtube.com/watch?v=ryYlM0IDXoQ ;;
# 124) Syrian Satellite
124) link=https://www.youtube.com/watch?v=YfH6U8CNp58 ;; 
# 125) Al Mayadeen
125) link=https://www.youtube.com/watch?v=lUDZxObNzPI ;;
# 126) Al Arabiya
126) link=https://www.youtube.com/watch?v=1QFrtsu1JJg ;;
# 127) Al Jazeera Arabic
127) link=https://www.youtube.com/watch?v=elqcDJ3TXUs ;;
# 128) France 24 Arabic
128) link=https://www.youtube.com/watch?v=UYi0sgVm5dM ;;
# 129) BBC Arabic
129) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 ;;
# 130) SKY Arabic
130) link=https://www.youtube.com/watch?v=3GFowedvDiw ;;
# 131) RT Arabic 
131) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 ;;
################### EXTRA   ########################
# 132) Россия 24
132) link=https://www.youtube.com/watch?v=i_Q8N6ZSDXQ ;;
# 133) 
# 134) 
# 135)
# 136) Talking Tom and Friends
136) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc ;;
# 137) WWE RAW
137) link=https://www.youtube.com/watch?v=iu4X0XPH0X4 ;;
# 138) All News 
138) link=https://www.youtube.com/watch?v=3Pxrd2br83M ;;
# 139) ABC Australia 
139) link=https://www.youtube.com/watch?v=AUgAjy4lQec ;;
# 140) CBC The National
140) link=https://www.youtube.com/watch?v=U1yntyNAQv0 ;;
## 141) Infowars
141) link=https://www.youtube.com/watch?v=5NB8PEG63II ;;
#  142) TYT 
142) link=https://www.youtube.com/watch?v=VSxKAyzdenQ ;;
# 143) PBS NEWS 
143) link=https://www.youtube.com/watch?v=77tjdk941YU  ;;
# 144) Venice Italy Bridge Cam Live
144) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys ;;
# 145) Venice Italy Port Cam Live
145) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc ;;
# 146) Jackson Hole Intersection
146) link=https://www.youtube.com/watch?v=psfFJR3vZ78 ;;
# 147) Jackson Hole Town Square
147) link=https://www.youtube.com/watch?v=cyHBMTgTGfo ;;
# 148) Jackson Hole Rustic Inn
148) link=https://www.youtube.com/watch?v=KdvHzgcElx0 ;;
# 149) Verona Italy
149) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw ;;
# 150) Soggy Dollar Bar
150) link=https://www.youtube.com/watch?v=IjGdi7z_B4U ;;
#  151) Amsterdam Netherlands
151) link=https://www.youtube.com/watch?v=5FrCtTCYVWI ;;
#  152) Florida Eagle Cam
152) link=https://www.youtube.com/watch?v=pCZeVTMEsik ;;
##########################################################################
# BROKEN
### REPORTER LIVE BROKEN
# 100) link=https://www.youtube.com/watch?v=sub9CNuvjGA ;
## 143) Drunken Peasents
# 143) link=https://www.youtube.com/watch?v=bK5_pGaVoi0 ;;
#
#






esac

mpv "$link" 

exit "$?"

######################     END OF PROGRAM      ####################################################
