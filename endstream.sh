#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.06
# Revision Date: February 23, 2017
#
# Change Log:  - Rearanged the channels, added more channels
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
version="0.06"
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
echo "1) France 24 English         === FRENCH LANGUAGE ====    60) Televisa Puebla           91) NASA EARTH             121) CBC Arabic            "
echo "2) Al Jazeera English        31) France 24 Francais      61) GalaTV Queretaro          92) NASA ISS 1             122) Saudi 2 TV            " 
echo "3)  Fox News                 32) Euronews Francais       62) Televisa Mexicali         93) NASA ISS 2             123) Syrian Satellite      "
echo "4)  CNN 1                    33) Africa News             63) GalaTV Chihuahua          94) NASA TV                124) Al Mayadeen           "          
echo "5)  CNN 2                    34) Afrique Media           64) GalaTV Acapulco          ===ASIAN LANGUAGES===       125) Al Arabiya            "
echo "6)  i24 News                 35) France Info             65) GalaTV Zacatecas          95) CCTV 4 China           126) Al Jazeera            "
echo "7)  -------                  36) Mosaik TV               66) Televisa Campeche         96) EBC 51 Taiwan          127) France 24             "
echo "8)  MSNBC/CBSN               37) TLM                     67) Televisa Hermosillo       97) SHIBUYA NEWS JAPAN     128) BBC Arabic            "
echo "9)  NEWSMAX                  38) France Inter            68) GalaTV Laguna             98) QVC JAPAN              129) SKY News Arabic       "
echo "10) Bloomberg                39) RFI                     69) 1070 Noticias             99) KBS World 24 Live      130) RT Arabic             "
echo "11) Channels 24 Nigeria      ====SPANISH LANGUAGE====    70) GalaTV Toluca             100) Reporter              131) Россия 24             "
echo "12) Africa News              40) TeleSUR                 71) TelePacifico              101) Tugulu News           132) EuroNews Deutche      "
echo "13) GCTN English             41) RT Espanol              72) Noticias Agentina         102) Tv9 Marathi           133) NTV Uganda            "
echo "14) TRT World                42) DW Espanol              73) Cinevision Canal 19       103) Survana News          134) Hubble Telescope      "
echo "15) TWiT                     43) NTN24                   74) Canal 8 Mar del Plata     104) News 18 India         135) Talking TOM           "
echo "16) CNBC Africa              44) Canal 8 San Juan        75) Canal 44                  105) SAMAA TV              136) WWE RAW               "
echo "17) PBS News Hour            45) Canal 6 San Rafael      76) Tu Cana                   106) Aaj Tak               137) All News              "
echo "18) RSBN                     46) Canal Siete             77) VPI TV                    107) TV9 Telugu            138) ABC Australia         "
echo "19) Amazing Facts            47) HispanTV                78) 100% Noticias Nicaragua   108) NTV Telugu            139) CBC The National      "
echo "20) It's Supernatural        48) Globovision             79) c5n                       109) ABN Telugu            140) Infowars              "  
echo "21) IHOP                     49) Excelsior TV            80) El Capitolo Venezulana    110) Vanitha TV            141) TYT                   "
echo "22) HSN                      50) Imagine Radio           81) KBS World Latino          111) HMT                   142) Drunken Peasents      "      
echo "23) KTN Kenya English        51) Videos Directo          82) -----                     112) TV5                   143) Venice Bridge         " 
echo "24) Tom & Jerry              52) Q24                     83) -----                     113) 10TV Telugu           144) Venice Port           "
echo "25) WWE Smackdown            53) La Cáscara TV           84) -----                     114) AsiaNet               145) Jackson Hole          "
echo "26) Arirang TV               54) Televisa del Bajio      85) -----                     115) GMA Phillipeans       146) Jackson Hole          "
echo "27) India Today              55) Televisa del Golfo      86) -----                     116) Rapple Phillipeans    147) Jackson Hole          "
echo "====EUROZONE RESTRICTED===   56) Televisa Guadalajara    87) -----                     117) NTV Bangladesh        148) Verona Italy          "
echo "28) SKY NEWS Britain         57) Televisa del Noreste    88) -----                     118) ON E                  149) Soggy Dollar          "
echo "29) Euronews English         58) Televisa Veracruz       89) -----                     119) ON E Sport            150) Amsterdam Netherlands "
echo "30) DW English               59) GalaTV Morelos          90) -----                     120) Adom TV               151) Florida Eagle Cam     "
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
# 3) Fox News
3) link=https://www.youtube.com/watch?v=uoithfXKf70 ;;
# 4) CNN Stream 1
4) link=https://www.youtube.com/watch?v=hq9Mpmb80Kw ;;
# 5) CNN Stream 2
5) link=https://www.youtube.com/watch?v=5w5lmAgl5wU ;;
# 6) i24 News
6) link=https://www.youtube.com/watch?v=Cn1PPJyvlas ;;
# 7) 
# 8) CBS NEWS / MSNBC / NBC 
8) link=https://www.youtube.com/watch?v=xCeP1FmzVos ;;
# 9) NEWSMAX
9) link=https://www.youtube.com/watch?v=Qtq6EP2VvjE ;;
# 10) Bloomberg
10) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w ;;
# 11) Channels 24 Nigeria
11) link=https://www.youtube.com/watch?v=ANM-dq5USTc ;;
# 12) Africa News Live
12) link=https://www.youtube.com/watch?v=zcWWdvRaaSA ;;
# 13) GCTN English
13) link=https://www.youtube.com/watch?v=x4vdN0u9Ksw ;;
#  14) TRT World
14) link=https://www.youtube.com/watch?v=N7jfTZLkhms ;;
###############      OTHER ENGLISH          ##################################
#  15) TWiT
15) link=https://www.youtube.com/watch?v=Gthvw4Bevkg ;;
#  16) CNBC Africa
16) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI ;;
# 17) PBS News Hour
#17) link=https://www.youtube.com/watch?v=5eXOSZGe4Y8 ;;
17) link=https://www.youtube.com/watch?v=77tjdk941YU ;;
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
###############    RESTRICTED TO EUROPE     ###########################
# 28) SKY NEWS
28) link=https://www.youtube.com/watch?v=y60wDzZt8yg ;;
# 29) Euronews English Live
29) link=https://www.youtube.com/watch?v=Nxid1JTdfrk ;;
# 30) DW English
30) link=https://www.youtube.com/watch?v=gNosnzCaS4I ;;
#################    FRENCH   ###################################
# 31) France 24 Francais
31) link=https://www.youtube.com/watch?v=vp-82gDggk4 ;;
# 32) Euronews
32) link=https://www.youtube.com/watch?v=03O3ZyJW-Tc ;;
# 33) Africa News
33) link=https://www.youtube.com/watch?v=tUjOfmeLpHo ;;
# 34) Afrique Media
34) link=https://www.youtube.com/watch?v=rmTY6PCTvXM ;;
# 35) France Info
35) link=https://www.youtube.com/watch?v=SN7sncKzRq4 ;;
# 36) Mosaik TV Francais
36) link=https://www.youtube.com/watch?v=JcKSOnfoDRc ;;
# 37) TLM 
37) link=https://www.youtube.com/watch?v=vOLDMexUxpM ;;
# 38) France Inter
38) link=https://www.youtube.com/watch?v=59Rw7-8PRng ;;
# 39) RFI
39) link=https://www.youtube.com/watch?v=N8tHbVYKRBY ;;
###################  SPANISH  #################################
# 40) TeleSUR
40) link=https://www.youtube.com/watch?v=3fwfmhTYUZs ;;
# 41) RT Espanol
41) link=https://www.youtube.com/watch?v=OALyNX4IbBI ;;
# 42) DW Espanol
42) link=https://www.youtube.com/watch?v=wBDQlzVRMgU ;;
# 43) NTN24 
43) link=https://www.youtube.com/watch?v=-ukAwFoV9pY ;;
# 44) Canal 8 San Juan
44) link=https://www.youtube.com/watch?v=yiwJzHW123c ;;
# 45) Canal 6 San Rafael
45) link=https://www.youtube.com/watch?v=axnhmU97Ktg ;;
# 46) Canal Siete
46) link=https://www.youtube.com/watch?v=EUgiU4KZEPo ;;
# 47) HispanTV 
47) link=https://www.youtube.com/watch?v=kibgnmaJoAs ;;
# 48) Globovision
48) link=https://www.youtube.com/watch?v=Lm-AmFtPlc4 ;;
# 49) Excelsior TV
49) link=https://www.youtube.com/watch?v=NANvipRo_eE ;;
# 50) Imagine Radio
50) link=https://www.youtube.com/watch?v=OSOXIMOxpEw ;;
# 51) Videos Directo
51) link=https://www.youtube.com/watch?v=gxXvDDl4cTs ;;
# 52) Q24
52) link=https://www.youtube.com/watch?v=yZGc05q7ajA ;;
# 53) La Casacra TV 
53) link=https://www.youtube.com/watch?v=vEwpn57ip7w ;;
## Canals  Vivo  de Televisia Regional 
# 54) Televisa del Bajio
54) link=https://www.youtube.com/watch?v=wmcA51ETCoo ;;
# 55) Televisa del Golfo
55) link=https://www.youtube.com/watch?v=r8K8nFKBGB8 ;;
# 56) Televisa Guadalajara
56) link=https://www.youtube.com/watch?v=4btUDfIjjbk ;;
# 57) Televisa del Noreste
57) link=https://www.youtube.com/watch?v=d2qjt-7KIUE ;;
# 58) Televisa Veracruz
58) link=https://www.youtube.com/watch?v=xDp59IK5u64 ;;
# 59) GalaTV Morelos
59) link=https://www.youtube.com/watch?v=TDrgg9VJOq4 ;;
# 60) Televisa Puebla
60) link=https://www.youtube.com/watch?v=vGQReDz9-iQ ;;
# 61) GalaTV Queretaro
61) link=https://www.youtube.com/watch?v=AIPhfPslF0E ;;
# 62) Televisa Mexicali
62) link=https://www.youtube.com/watch?v=HLJH3C_7nnk ;;
# 63) GalaTV Chihuahua
63) link=https://www.youtube.com/watch?v=VloHUkS_Cn0 ;;
# 64) GalaTV Acapulco
64) link=https://www.youtube.com/watch?v=6MeD88060x8 ;;
# 65) GalaTV Zacatecas
65) link=https://www.youtube.com/watch?v=r1arJCFwz3o ;;
# 66) Televisa Campeche
66) link=https://www.youtube.com/watch?v=Kf5i1zEDEJQ ;;
# 67)  Televisa Hermosillo
67) link=https://www.youtube.com/watch?v=2jH6YinOabQ ;;
# 68)  GalaTV Laguna
68) link=https://www.youtube.com/watch?v=6SuhteXqf90 ;;
# 69) 1070 Noticias
69) link=https://www.youtube.com/watch?v=bfe9RLT9SBo ;;
# 70) GalaTV Estado de México Toluca
70) link=https://www.youtube.com/watch?v=fHhS2BElUF0 ;;
# 71) TelePacifico
71) link=https://www.youtube.com/watch?v=ZQnMKaGYu9Q ;;
# 72) Canal Noticias Argentina
72) link=https://www.youtube.com/watch?v=WJCIuoKvzi0 ;;
# 73) Cinevision Canal 19
73) link=https://www.youtube.com/watch?v=aBLbwbSycLU  ;;
# 74) Canal 8 Mar del Plata
74) link=https://www.youtube.com/watch?v=MbOpUZnOdNY  ;;
# 75) Canal 44
75) link=https://www.youtube.com/watch?v=5sdRSFaPycE ;;
# 76) Tu Canal
76) link=https://www.youtube.com/watch?v=NEF_sHYhio0 ;;
# 77) VPI TV 
77) link=https://www.youtube.com/watch?v=5GyfFhBnbhk ;;
# 78) 100% Noticias Nicaragua
78) link=https://www.youtube.com/watch?v=sFQqcQJhJnQ ;;
# 79) c5n SPANISH
79) link=https://www.youtube.com/watch?v=iPLHkyI1hr4 ;;
###############  OTHER   ##############################
# 80) El Capitolo Venezulana
80) link=https://www.youtube.com/watch?v=tjYvi3tSbr0 ;;
# 81) KBS World Latino
81) link=https://www.youtube.com/watch?v=mRUT78iMdLw ;;
# 82)
# 83)
# 84)
# 85)
# 86)
# 87)
# 88)
# 89) 
# 90) 
# 91) NASA LIVE STREAM
91) link=https://www.youtube.com/watch?v=SF7FUU7CThs ;;
# 92) NASA LIVE STREAM
92) link=https://www.youtube.com/watch?v=ddFvjfvPnqk ;;
# 93) NASA LIVE STREAM
93) link=https://www.youtube.com/watch?v=qzMQza8xZCc ;;
# 94)  NASA TV
94) link=https://www.youtube.com/watch?v=UdmHHpAsMVw ;; 
################ CHINESE MANDARIN CANTONESE  ####################
#  95) CCTV 4 Chinese
95) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw ;;
# 96) EBC 51 News
96) link=https://www.youtube.com/watch?v=yzE3bRtXIrI ;;
################ JAPANESE  ####################
#  97) Shibua Community News Japan
97) link=https://www.youtube.com/watch?v=_9pavMzUY-c ;;
#  98) QVC JAPAN SHOPPING CHANNEL
98) link=https://www.youtube.com/watch?v=wMo3F5IouNs ;;
################ KOREAN  ###############################
#  99) KBS World 24
99) link=https://www.youtube.com/watch?v=9nMuTuy5SIs ;;
##################### INDIAN / HINDI ########################################
# 100) REPORTER LIVE
100) link=https://www.youtube.com/watch?v=sub9CNuvjGA ;;
# 101) Telugu News
101) link=https://www.youtube.com/watch?v=kg48DXa4bKE ;;
# 102) Tv9 Marathi
102) link=https://www.youtube.com/watch?v=BremLDr3lgA ;;
# 103) Survana News
103) link=https://www.youtube.com/watch?v=xJqm4gxr7gs ;;
# 104) News 18 India
104) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 ;;
# 105) SAMAA TV
105) link=https://www.youtube.com/watch?v=qH2kZjv1CYM ;;
# 106) Aaj Tak 
106) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q ;;
# 107) TV9 Telugu
107) link=https://www.youtube.com/watch?v=-ZcgjH9MNtI ;;
# 108) NTV Telugu
108) link=https://www.youtube.com/watch?v=T953eK1GXbA ;;
# 109) ABN Telugu
109) link=https://www.youtube.com/watch?v=QzQnFY6CioA ;;
# 110) Vanitha TV 
110) link=https://www.youtube.com/watch?v=ji7H-z506SA ;;
# 111) HMT Telugu
111) link=https://www.youtube.com/watch?v=qdi47ihDFCk ;;
# 112) TV5 News 
112) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg ;;
# 113) 10TV Telugu
113) link=https://www.youtube.com/watch?v=UpNJQg567UU ;;
# 114) AsiaNet News
114) link=https://www.youtube.com/watch?v=YYqeFCJRBUg  ;;
# 115) GMA News
115) link=https://www.youtube.com/watch?v=CEqQ4P0MST4  ;;
# 116) Rappler
116) link=https://www.youtube.com/watch?v=ZeBAj1OB2gc ;;
# 117) NTV Bangladesh
117) link=https://www.youtube.com/watch?v=5pz4cXHd6TI ;;
################## ARABIC  ###########################################
# 118) ON E Live 
118) link=https://www.youtube.com/watch?v=mcsYSFZV4bw ;;
# 119)  ON E Sport
119) link=https://www.youtube.com/watch?v=ngalZ7mScqM ;;
# 120) ADOM TV 
120) link=https://www.youtube.com/watch?v=g5McawVm8Q4 ;;
# 121 CBC Arabic Live
121) link=https://www.youtube.com/watch?v=FFx5r-U9ryA ;;
# 122) Saudi 2 TV
122) link=https://www.youtube.com/watch?v=ryYlM0IDXoQ ;;
# 123) Syrian Satellite
123) link=https://www.youtube.com/watch?v=YfH6U8CNp58 ;; 
# 124) Al Mayadeen
124) link=https://www.youtube.com/watch?v=lUDZxObNzPI ;;
# 125) Al Arabiya
125) link=https://www.youtube.com/watch?v=1QFrtsu1JJg ;;
# 126) Al Jazeera Arabic
126) link=https://www.youtube.com/watch?v=elqcDJ3TXUs ;;
# 127) France 24 Arabic
127) link=https://www.youtube.com/watch?v=UYi0sgVm5dM ;;
# 128) BBC Arabic
128) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 ;;
# 129) SKY Arabic
129) link=https://www.youtube.com/watch?v=3GFowedvDiw ;;
# 130) RT Arabic 
130) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 ;;
################### EXTRA   ########################
# 131) Россия 24
131) link=https://www.youtube.com/watch?v=i_Q8N6ZSDXQ ;;
# 132) EuroNews Deutche
132) link=https://www.youtube.com/watch?v=VI0f9TkMo0g ;;
# 133) NTV Uganda
133) link=https://www.youtube.com/watch?v=CL8dsz9RRW8 ;;
# 134) Hubble Telescope
134) link=https://www.youtube.com/watch?v=TzpO54TuSXs ;;
# 135) Talking Tom and Friends
135) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc ;;
# 136) WWE RAW
136) link=https://www.youtube.com/watch?v=iu4X0XPH0X4 ;;
# 137) All News 
137) link=https://www.youtube.com/watch?v=3Pxrd2br83M ;;
# 138) ABC Australia 
138) link=https://www.youtube.com/watch?v=AUgAjy4lQec ;;
# 139) CBC The National
139) link=https://www.youtube.com/watch?v=CaHm4M8pGmc ;;
## 140) Infowars
140) link=https://www.youtube.com/watch?v=5NB8PEG63II ;;
#  141) TYT 
141) link=https://www.youtube.com/watch?v=VSxKAyzdenQ ;;
# 142) Drunken Peasents
142) link=https://www.youtube.com/watch?v=bK5_pGaVoi0 ;;
# 143) Venice Italy Bridge Cam Live
143) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys ;;
# 144) Venice Italy Port Cam Live
144) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc ;;
# 145) Jackson Hole Intersection
145) link=https://www.youtube.com/watch?v=psfFJR3vZ78 ;;
# 146) Jackson Hole Town Square
146) link=https://www.youtube.com/watch?v=cyHBMTgTGfo ;;
# 147) Jackson Hole Rustic Inn
147) link=https://www.youtube.com/watch?v=KdvHzgcElx0 ;;
# 148) Verona Italy
148) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw ;;
# 149) Soggy Dollar Bar
149) link=https://www.youtube.com/watch?v=IjGdi7z_B4U ;;
#  150) Amsterdam Netherlands
150) link=https://www.youtube.com/watch?v=5FrCtTCYVWI ;;
#  151) Florida Eagle Cam
151) link=https://www.youtube.com/watch?v=pCZeVTMEsik ;;
##########################################################################
esac

mpv "$link" 

exit "$?"

######################     END OF PROGRAM      ####################################################
