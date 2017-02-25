#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.08
# Revision Date: February 24, 2017
#
# Change Log:  - dailymotion + twitch livestream additions 
#              - Add channels, rearange, remove dead streams
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
version="0.08"
rev_date="24/02/2017"
branch="gnu/linux"
##################################################
for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo " ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl mpv using"
   echo "  Type in the terminal $ endstream "
   echo "  Now read the list and pick a number,input it and press enter."
   echo " $ endstream --help    "
   echo " $ endstream --version "
   echo " $ endstream           "  
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

echo "======================================================          ENDSTREAM          ============================================================"
echo "||       ENGLISH         ||          FRANCAIS        ||          ESPANOL           ||         OTHER         ||          EXTRA               || "
echo "==============================================================================================================================================="
echo "1) France 24 English       34) Africa News               69) Q24                     104) NASA EARTH          138) Al Arabiya                  "
echo "2) Al Jazeera English      35) Afrique Media             70) La Cáscara TV           105) NASA ISS 1          139) Al Jazeera                  " 
echo "3)  CGTN English           36) France Info               71) Televisa del Bajio      106) NASA ISS 2          140) France 24 Arabic            "
echo "4)  i24 News               37) Mosaik TV                 72) Televisa del Golfo      107) Hubble Telescope    141) BBC Arabic                  "           
echo "5)  Fox News               38) TLM 30 Lyon               73) Televisa Guadalajara     ===ASIAN LANGUAGES===   142) SKY News Arabic             "
echo "6)  Fox News               39) France Inter              74) Televisa del Noreste    108) CCTV 4 China        143) RT Arabic                   "
echo "7)  MSNBC/CBSN             40) RFI                       75) Televisa Veracruz       109) EBC 51 Taiwan       144) POCCNR 24 Russia            "
echo "8)  NEWSMAX                41) Max FM 92.9               76) GalaTV Morelos          110) SHIBUYA NEWS JAPAN  145) Talking TOM                 "
echo "9)  Bloomberg              42) M7 TV Mali                77) Televisa Puebla         111) QVC JAPAN           146) WWE RAW                     "
echo "10) Channels 24 Nigeria    43) France Inter              78) Cinevision Canal 19     112) KBS World 24 Live   147) Venice Bridge               "
echo "11) Africa News            44) RTL En Direct             79) GalaTV Queretaro        113) KBS World English   148) Venice Port                 "
echo "12) TRT World              45) STRACK DANCE              80) Televisa Mexicali       114) Tugulu News         149) Jackson Hole Intersection   "
echo "13) ABS-CBN                46) Direct Journal TVLandes   81) GalaTV Acapulco         115) Tv9 Marathi         150) Jackson Hole Town Square    "
echo "14) TWiT                   47) CNEWS                     82) GalaTV Zacatecas        116) Survana News        151) Jackson Hole Rustic Inn     "
echo "15) CNBC Africa            48) BMF TV                    83) Televisa Hermosillo     117) News 18 India       152) Verona Italy                "
echo "16) NTV Uganda             49) Europe 1                  84) GalaTV Laguna           118) SAMAA TV            153) Soggy Dollar BVI            "
echo "17) RSBN                   50) i24 France                85) 1070 Noticias           119) Aaj Tak             154) Amsterdam Netherlands       "
echo "18) Amazing Facts          51) France Info Radio         86) GalaTV Toluca           120) TV9 Telugu          155) ESL League of Legends       "
echo "19) It's Supernatural      52) France Info TV            87) TelePacifico            121) NTV Telugu          156) Poker TV                    "
echo "20) IHOP                   53) LCP FRANCE                88) Canal 8 Mar del Plata   122) ABN Telugu          157) High Stakes Poker           "  
echo "21) HSN                    54) Public Senate             89) Tu Cana                 123) Vanitha TV          158) All News                    "
echo "22) KTN Kenya English      55) Presidence de la Republic 90) VPI TV                  124) HMT                 159) ABC Australia               "      
echo "23) Tom & Jerry            56) Globovision               91) 100% Noticias Nicaragua 125) TV5                 160) CBC The National            " 
echo "24) WWE Smackdown          57) TeleSUR                   92) El Capitolo Venezulana  126) 10TV Telugu         161) Infowars                    "
echo "25) Arirang TV             58) RT Espanol                93) EuroNews Deutche        127) AsiaNet             162) TYT                         "
echo "26) India Today            59) DW Espanol                94) DW English              128) NTV Bangladesh      163) PBS News Hour               "
echo "27) NASA TV                60) NTN24                     95) Euronews English        129) PTV Phillipeans     164) ---------------             "
echo "28) TWiT Twitch            61) Canal 8 San Juan          96) SKY NEWS Britain        130) ------              165) ---------------             "
echo "29) ---------------        62) Canal 6 San Rafael        97) ----------------        131) ON E Arabic         166) ---------------             "
echo "=== FRENCH LANGUAGE ====   63) Canal Siete               98) ----------------        132) ON E Sport          167) ---------------             "
echo "30) France 24 Francais     64) HispanTV                  99) ----------------        133) Adom TV             168) ----------------            "
echo "31) France Info TV         65) Globovision               100) ---------------        134) CBC Arabic          169) ----------------            "
echo "32) France 24 Francais     66) Excelsior TV              101) ---------------        135) Saudi 2 TV          170) ----------------            " 
echo "32) France 24 Francais     67) Imagine Radio             102) ---------------        136) Syrian Satellite    171) ----------------            "
echo "33) Euronews Francais      68) Videos Directo            103) ---------------        137) Al Mayadeen         172) ----------------            "
echo "==============================================================================================================================================="
echo " " 
echo "Please Select a Number corresponding to a YouTube Live Stream:"

read n

case $n in 
################    MAIN  ENGLISH  ##################################
# 1) France 24 Anglais 
1) link=https://www.youtube.com/watch?v=1Ydto3Iyzic 
   chan_name="France 24 English";;
# 2) Al Jazeera
2) link=https://www.youtube.com/watch?v=pJC-vohDHl8 
   chan_name="Al Jazeera" ;;  
# 3) CGTN English
3) link=https://www.youtube.com/watch?v=GV1p3irkgi0 
   chan_name="CGTN English" ;;
# 4) i24 News
4) link=https://www.youtube.com/watch?v=ArNFMKxtsxY 
   chan_name="i24 Israel English" ;;
# 5) Fox News
5) link=https://www.youtube.com/watch?v=Z7HSAnWCUQw 
   chan_name="Fox News" ;;
# 6) Fox News
6) link=https://www.youtube.com/watch?v=lYbEYo5-b6U 
   chan_name="Fox News" ;;
# 7) CBS NEWS / MSNBC / NBC 
7) link=https://www.youtube.com/watch?v=xCeP1FmzVos 
   chan_name="MSNBC/CBSN";;
# 8) NEWSMAX
8) link=https://www.youtube.com/watch?v=Qtq6EP2VvjE 
   chan_name="NEWSMAX";;
# 9) Bloomberg
9) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w 
   chan_name="Bloomberg";;
# 10) Channels 24 Nigeria
10) link=https://www.youtube.com/watch?v=ANM-dq5USTc 
    chan_name="Channels 24 Nigeria";;
# 11) Africa News Live
11) link=https://www.youtube.com/watch?v=zcWWdvRaaSA 
    chan_name="Africa News English";;
#  12) TRT World
12) link=https://www.youtube.com/watch?v=N7jfTZLkhms 
    chan_name="TRT World";;
# 13) ABS-CBN Phillipeans
13) link=https://www.youtube.com/watch?v=3vYPyZywbZs 
    chan_name="ABS-CBN Phillipeans";;
###############      OTHER ENGLISH          ##################################
#  14) TWiT
14) link=https://www.youtube.com/watch?v=Gthvw4Bevkg 
    chan_name="TWiT" ;;
#  15) CNBC Africa
15) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI 
    chan_name="CNBC Africa" ;;
# 16)  NTV Uganda
16) link=https://www.youtube.com/watch?v=CL8dsz9RRW8 
    chan_name="NTV Uganda" ;; 
#  17) RSBN Live
17) link=https://www.youtube.com/watch?v=xEQEM7X7J4E 
    chan_name="RSBN Right Side Broadcasting News" ;;
# 18) Amazing Facts TV (Christian)
18) link=https://www.youtube.com/watch?v=JFLFK362vns 
    chan_name="Amzaing Facts TV (Christian)" ;;
# 19) It's Supernatural! Network
19) link=https://www.youtube.com/watch?v=TgYk_asWz_4 
    chan_name="It's Supernatural! (Christian)" ;;
# 20) International House of Prayer (IHOP)
20) link=https://www.youtube.com/watch?v=dyD6lMY11wM 
    chan_name="International House of Prayer (Christian)" ;;
# 21) HSN
21)  link=https://www.youtube.com/watch?v=J0022wscx0k 
     chan_name="Home Shopping Network HSN" ;;
# 22) KTN Kenya English
22) link=https://www.youtube.com/watch?v=YASZYb8UBs8 
    chan_name="KTN Kenya English" ;;
# 23) Tom and Jerry Cartoons
23) link=https://www.youtube.com/watch?v=49eA7hGeixM 
    chan_name="Tom & Jerry Cartoons" ;;
# 24) WWE Smackdown
24) link=https://www.youtube.com/watch?v=ZrN4K6bEzEg 
    chan_name="WWE Smackdown" ;;
# 25)  Arirang TV
25) link=https://www.youtube.com/watch?v=JVr6yiZ9IMY 
    chan_name="Arirang TV (Korean Pride)" ;;
# 26) India TODAY
26) link=https://www.youtube.com/watch?v=wXwYCWGpprc 
    chan_name="India TODAY English" ;;
# 27)   NASA TV
27) link=https://www.youtube.com/watch?v=UdmHHpAsMVw 
    chan_name="NASA TV" ;; 
# 28) TWiT on Twitch
28) link=https://www.twitch.tv/twit 
    chan_name="TWiT on Twitch" ;;
# 29
#################    FRENCH   ###################################
# 30) France 24 
30) link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
chan_name="France 24" ;;
# 31) France Info 
31) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news 
chan_name="France Info TV" ;;
# 32) France 24 Francais
32) link=https://www.youtube.com/watch?v=vp-82gDggk4 
    chan_name="France 24 Francais" ;;
# 33) Euronews
33) link=https://www.youtube.com/watch?v=03O3ZyJW-Tc 
    chan_name="Euronews Francais" ;;
# 34) Africa News
34) link=https://www.youtube.com/watch?v=tUjOfmeLpHo 
    chan_name="Africa News Francais" ;;
# 35) Afrique Media
35) link=https://www.youtube.com/watch?v=GpHTBs6B7Zk 
    chan_name="Afrique Media" ;;
# 36) France Info
36) link=https://www.youtube.com/watch?v=SN7sncKzRq4 
    chan_name="France Info" ;;
# 37) Mosaik TV Francais
37) link=https://www.youtube.com/watch?v=JcKSOnfoDRc 
    chan_name="Mosaik TV" ;;
# 38) TLM 
38) link=https://www.youtube.com/watch?v=soT36gH86Fw 
    chan_name="TLM Television Lyon Metro" ;;
# 39) France Inter
39) link=https://www.youtube.com/watch?v=59Rw7-8PRng 
    chan_name="France Inter" ;;
# 40) RFI
40) link=https://www.youtube.com/watch?v=N8tHbVYKRBY 
    chan_name="RFI Francais" ;;
# 41) Max FM 92.9 
41) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
    chan_name="Max FM 92.9" ;;
# 42) M7 Television
42) link=http://www.dailymotion.com/video/x59xxgx_live_music 
    chan_name="M7 TV Mali" ;;
# 43) France Inter
43) link=http://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
    chan_name="France Inter" ;;
# 44) RTL Endirect
44) link=http://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
    chan_name="RTL En Direct" ;;
# 45) STRACK DANCE MUSIC    
45) link=http://www.dailymotion.com/video/x4my0xq_live-du-studio-strackstation_music
    chan_name="STRACK DANCE" ;;
# 46) Direct Journal TVLandes    
46) link=http://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
chan_name="Direct Journal Tvlandes"  ;;      
# 47) CNEWS
47) link=http://www.dailymotion.com/video/x3b68jn_live-cnews_news 
chan_name="CNEWS" ;;
# 48) BMF TV
48) link=http://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
chan_name="BMF TV";;
# 49) Europe 1
49) link=http://www.dailymotion.com/video/xqjkfz_europe-1-live_news
chan_name="Europe 1" ;;
# 50) i24 News en Direct
50) link=http://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
chan_name="i24 Francais";;
# 51) France Info TV
51) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
chan_name="France Info TV" ;;
# 52) France Info Radio
52) link=http://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
chan_name="France Info Radio" ;;
# 53) La Chaine Parlementaire LCP
53) link=http://www.dailymotion.com/video/xji3qy_la-chaine-parlementaire-lcp-live-tnt_news
chan_name="LCP France";;
# 54) Public Senate France
54) link=http://www.dailymotion.com/video/xkxbzc_live-public-senat_news 
chan_name="Public Senate" ;;
# 55) Elyse.fr
55) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
chan_name="Le Direct de la Presidence de la Republique" ;;
###################  SPANISH  #################################
# 56) Globovision Espanol 
56) link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
chan_name="Globovision" ;;
# 57) TeleSUR
57) link=https://www.youtube.com/watch?v=3fwfmhTYUZs 
    chan_name="TeleSUR Espanol" ;;
# 58) RT Espanol
58) link=https://www.youtube.com/watch?v=OALyNX4IbBI 
    chan_name="RT Espanol" ;;
# 59) DW Espanol
59) link=https://www.youtube.com/watch?v=wBDQlzVRMgU 
    chan_name="DW Espanol" ;;
# 60) NTN24 
60) link=https://www.youtube.com/watch?v=-ukAwFoV9pY 
    chan_name="NTN24" ;;
# 61) Canal 8 San Juan
61) link=https://www.youtube.com/watch?v=yiwJzHW123c 
    chan_name="Canal 8 San Juan" ;;
# 62) Canal 6 San Rafael
62) link=https://www.youtube.com/watch?v=axnhmU97Ktg 
    chan_name="Canal 6 San Rafael" ;;
# 63) Canal Siete
63) link=https://www.youtube.com/watch?v=EUgiU4KZEPo 
    chan_name="Canal Siete" ;;
# 64) HispanTV 
64) link=https://www.youtube.com/watch?v=kibgnmaJoAs 
    chan_name="HispanTV" ;;
# 65) Globovision
65) link=https://www.youtube.com/watch?v=Lm-AmFtPlc4 
    chan_name="Globovision" ;;
# 66) Excelsior TV
66) link=https://www.youtube.com/watch?v=NANvipRo_eE 
    chan_name="Excelsior TV" ;;
# 67) Imagine Radio
67) link=https://www.youtube.com/watch?v=OSOXIMOxpEw 
    chan_name="Imagine Radio" ;;
# 68) Videos Directo
68) link=https://www.youtube.com/watch?v=gxXvDDl4cTs 
    chan_name="Videos Directo" ;;
# 69) Q24
69) link=https://www.youtube.com/watch?v=yZGc05q7ajA 
    chan_name="Q24";;
# 70) La Casacra TV 
70) link=https://www.youtube.com/watch?v=vEwpn57ip7w 
    chan_name="La Casacra TV" ;;
## Canals  Vivo  de Televisia Regional 
# 71) Televisa del Bajio
71) link=https://www.youtube.com/watch?v=wmcA51ETCoo 
    chan_name="Televisa del Bajio" ;;
# 72) Televisa del Golfo
72) link=https://www.youtube.com/watch?v=tctk186_31s 
    chan_name="Televisa del Golfo" ;;
# 73) Televisa Guadalajara
73) link=https://www.youtube.com/watch?v=4btUDfIjjbk 
    chan_name="Televisia Gudalajara" ;;
# 74) Televisa del Noreste
74) link=https://www.youtube.com/watch?v=d2qjt-7KIUE 
    chan_name="Televisia del Noreste" ;;
# 75) Televisa Veracruz
75) link=https://www.youtube.com/watch?v=xDp59IK5u64 
    chan_name="Televisia Veracruz" ;;
# 76) GalaTV Morelos
76) link=https://www.youtube.com/watch?v=TDrgg9VJOq4 
    chan_name="GalaTV Morelos" ;;
# 77) Televisa Puebla
77) link=https://www.youtube.com/watch?v=vGQReDz9-iQ 
    chan_name="Televisia Puebla" ;;
# 78) GalaTV Queretaro
78) link=https://www.youtube.com/watch?v=AIPhfPslF0E 
    chan_name="GalaTV Queretaro" ;;
# 79) Televisa Mexicali
79) link=https://www.youtube.com/watch?v=HLJH3C_7nnk 
    chan_name="Televisia Mexicali" ;;
# 80) GalaTV Acapulco
80) link=https://www.youtube.com/watch?v=6MeD88060x8 
    chan_name="GalaTV Acapulco" ;;
# 81) GalaTV Zacatecas
81) link=https://www.youtube.com/watch?v=r1arJCFwz3o 
    chan_name="GalaTV Zacatecas" ;; 
# 82)  Televisa Hermosillo
82) link=https://www.youtube.com/watch?v=2jH6YinOabQ 
    chan_name="Televisia Hermosillo" ;;
# 83)  GalaTV Laguna
83) link=https://www.youtube.com/watch?v=6SuhteXqf90 
    chan_name="GalaTV Laguna" ;;
# 84) 1070 Noticias
84) link=https://www.youtube.com/watch?v=bfe9RLT9SBo 
    chan_name="1070 Noticias" ;;
# 85) GalaTV Estado de México Toluca
85) link=https://www.youtube.com/watch?v=fHhS2BElUF0 
    chan_name="GalaTV Estado de Mexico Toluca" ;;
# 86) TelePacifico
86) link=https://www.youtube.com/watch?v=ZQnMKaGYu9Q 
    chan_name="TelePacifico" ;; 
# 87) Cinevision Canal 19
87) link=https://www.youtube.com/watch?v=aBLbwbSycLU  
    chan_name="Cinevision Canal 19" ;;
# 88) Canal 8 Mar del Plata
88) link=https://www.youtube.com/watch?v=MbOpUZnOdNY  
    chan_name="Canal 8 Mar del Plata" ;; 
# 89) Tu Canal
89) link=https://www.youtube.com/watch?v=NEF_sHYhio0 
    chan_name="Tu Canal" ;;
# 90) VPI TV 
90) link=https://www.youtube.com/watch?v=5GyfFhBnbhk 
    chan_name="VPI TV" ;;
# 91) 100% Noticias Nicaragua
91) link=https://www.youtube.com/watch?v=sFQqcQJhJnQ 
    chan_name="100% Noticias Nicaragua" ;; 
# 92) El Capitolo Venezulana
92) link=https://www.youtube.com/watch?v=tjYvi3tSbr0 
    chan_name="El Capitolo Venezulana" ;;
###############    RESTRICTED TO EUROPE     ###########################
# 93)  EuroNews Deutche
93) link=https://www.youtube.com/watch?v=dYJ0kTqeu08 
    chan_name="EuroNews Deutche" ;;
# 94) SKY NEWS
94) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
    chan_name="SKY NEWS" ;;
# 95) Euronews English Live
95) link=https://www.youtube.com/watch?v=Nxid1JTdfrk 
    chan_name="Euronews English" ;;
# 96) DW English
96) link=https://www.youtube.com/watch?v=gNosnzCaS4I 
    chan_name="DW English" ;;
###############     OTHER STREAMS   #####################################    
# 104) NASA LIVE STREAM 1
104) link=https://www.youtube.com/watch?v=SF7FUU7CThs 
    chan_name="NASA STREAM 1" ;;
# 105) NASA LIVE STREAM 2
105) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
    chan_name="NASA STREAM 2" ;;  
# 106) NASA LIVE STREAM 3
106) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
    chan_name="NASA STREAM 3" ;;
# 107)Hubble Telescope
107) link=https://www.youtube.com/watch?v=TzpO54TuSXs 
    chan_name="Hubble Telescope" ;;    
################ CHINESE MANDARIN CANTONESE  ####################
# 108) CCTV 4 Chinese
108) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw 
    chan_name="CCTV 4 Chinese" ;;
# 109) EBC 51 News
109) link=https://www.youtube.com/watch?v=yzE3bRtXIrI 
    chan_name="EBC 51 News Taiwan" ;;
################ JAPANESE  ####################
#  110) Shibua Community News Japan
110) link=https://www.youtube.com/watch?v=_9pavMzUY-c 
    chan_name="Shibua Japan Community News Crosswalk" ;;
#  111) QVC JAPAN SHOPPING CHANNEL
111) link=https://www.youtube.com/watch?v=wMo3F5IouNs 
    chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
################ KOREAN  ###############################
#  112) KBS World 24 News
112) link=https://www.youtube.com/watch?v=9nMuTuy5SIs 
     chan_name="KBS World 24 News" ;;
# 113) KBS World English Sub
113) link=https://www.youtube.com/watch?v=mRUT78iMdLw 
     chan_name="KBS 24 World English Sub" ;;
##################### INDIAN / HINDI ########################################
# 114) Telugu News
114) link=https://www.youtube.com/watch?v=kg48DXa4bKE 
     chan_name="Telugu News" ;;
# 115) Tv9 Marathi
115) link=https://www.youtube.com/watch?v=BremLDr3lgA 
     chan_name="Tv9 Marathi" ;;
# 116) Survana News
116) link=https://www.youtube.com/watch?v=xJqm4gxr7gs 
     chan_name="Survana News" ;;
# 117) News 18 India
117) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 
     chan_name="News 18 India" ;;
# 118) SAMAA TV
118) link=https://www.youtube.com/watch?v=qH2kZjv1CYM 
     chan_name="SAMAA TV" ;;
# 119) Aaj Tak 
119) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q 
     chan_name="Aaj Tak" ;;
# 120) TV9 Telugu
120) link=https://www.youtube.com/watch?v=-ZcgjH9MNtI 
     chan_name="TV9 Telugu" ;;
# 121) NTV Telugu
121) link=https://www.youtube.com/watch?v=T953eK1GXbA 
     chan_name="NTV Telugu" ;;
# 122) ABN Telugu
122) link=https://www.youtube.com/watch?v=QzQnFY6CioA 
     chan_name="ABN Telugu" ;;
# 123) Vanitha TV 
123) link=https://www.youtube.com/watch?v=ji7H-z506SA 
     chan_name="Vanitha TV" ;;
# 124) HMT Telugu
124) link=https://www.youtube.com/watch?v=qdi47ihDFCk 
     chan_name="HMT Telugu" ;;
# 125) TV5 News 
125) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg 
     chan_name="TV5 News" ;;
# 126) 10TV Telugu
126) link=https://www.youtube.com/watch?v=UpNJQg567UU 
     chan_name="10TV Telugu" ;;
# 127) AsiaNet News
127) link=https://www.youtube.com/watch?v=YYqeFCJRBUg  
     chan_name="AsiaNet News" ;;
# 128) NTV Bangladesh
128) link=https://www.youtube.com/watch?v=5pz4cXHd6TI 
     chan_name="NTV Bangladesh" ;;
# 129) PTV
129) link=https://www.youtube.com/watch?v=ltl9qs0HEAQ 
     chan_name="PTV Phillipeans" ;;
# 130)
################## ARABIC  ###########################################
# 131) ON E Live 
131) link=https://www.youtube.com/watch?v=mcsYSFZV4bw 
     chan_name="ON E";;
# 132)  ON E Sports
132) link=https://www.youtube.com/watch?v=ngalZ7mScqM 
     chan_name="ON E Sports" ;;
# 133) ADOM TV 
133) link=https://www.youtube.com/watch?v=g5McawVm8Q4 
     chan_name="ADOM TV" ;;
# 134) CBC Arabic Live
134) link=https://www.youtube.com/watch?v=FFx5r-U9ryA 
     chan_name="CBC Arabic" ;;
# 135) Saudi 2 TV
135) link=https://www.youtube.com/watch?v=ryYlM0IDXoQ 
     chan_name="Saudi 2 TV" ;;
# 136) Syrian Satellite
136) link=https://www.youtube.com/watch?v=YfH6U8CNp58 
     chan_name="Syrian Satellite" ;; 
# 137) Al Mayadeen
137) link=https://www.youtube.com/watch?v=lUDZxObNzPI 
     chan_name="Al Mayadeen" ;;
# 138) Al Arabiya
138) link=https://www.youtube.com/watch?v=1QFrtsu1JJg 
     chan_name="Al Arabiya" ;;
# 139) Al Jazeera Arabic
139) link=https://www.youtube.com/watch?v=elqcDJ3TXUs 
     chan_name="Al Jazeera Arabic" ;;
# 140) France 24 Arabic
140) link=https://www.youtube.com/watch?v=UYi0sgVm5dM 
     chan_name="France 24 Arabic" ;;
# 141) BBC Arabic
141) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 
     chan_name="BBC Arabic" ;;
# 142) SKY Arabic
142) link=https://www.youtube.com/watch?v=3GFowedvDiw 
     chan_name="SKY Arabic" ;;
# 143) RT Arabic 
143) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 
     chan_name="RT Arabic" ;;
################### EXTRA   ########################
# 144) Россия 24
144) link=https://www.youtube.com/watch?v=i_Q8N6ZSDXQ 
     chan_name=" PoccNR 24 Russia" ;;
# 145) Talking Tom and Friends
145) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc 
     chan_name="Talking Tom and Friends" ;;
# 146) WWE RAW
146) link=https://www.youtube.com/watch?v=iu4X0XPH0X4 
     chan_name="WWE RAW" ;;
# 147) Venice Italy Bridge Cam Live
147) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
     chan_name="Venice Italy Bridge Cam" ;;
# 148) Venice Italy Port Cam Live
148) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
     chan_name="Venice Italy Port Cam" ;;
# 149) Jackson Hole Intersection
149) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
     chan_name="Jackson Hole Intersection" ;;
# 150) Jackson Hole Town Square
150) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
     chan_name="Jackson Hole Town Square" ;;
# 151) Jackson Hole Rustic Inn
151) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
     chan_name="Jackson Hole Rustic Inn" ;;
# 152) Verona Italy
152) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
     chan_name="Verona Italy" ;;
# 153) Soggy Dollar Bar
153) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
     chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  154) Amsterdam Netherlands
154) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
     chan_name="Amsterdam Netherlands" ;;
# 155) ESL League of Legends TWITCH
155) link=https://www.twitch.tv/esl_lol 
     chan_name="ESL League of Legends" ;;  
# 156) Poker TV
156) link=https://www.twitch.tv/pokerrtv 
    chan_name="Poker TV" ;;
# 157) High Stakes Poker 
157) link=https://www.twitch.tv/highstakespoke 
     chan_name="High Stakes Poker" ;;               
# 158) All News 
158) link=https://www.youtube.com/watch?v=3Pxrd2br83M 
     chan_name="All News" ;;
# 159) ABC News Australia 
159) link=https://www.youtube.com/watch?v=AUgAjy4lQec 
     chan_name="ABC News Australia" ;;
# 160) CBC The National
160) link=https://www.youtube.com/watch?v=U1yntyNAQv0 
     chan_name="CBC The National" ;;
## 161) Infowars
161) link=https://www.youtube.com/watch?v=5NB8PEG63II 
     chan_name="Infowars" ;;
#  162) TYT 
162) link=https://www.youtube.com/watch?v=VSxKAyzdenQ 
     chan_name="TYT The Young Turks" ;;
# 163) PBS NEWS 
163) link=https://www.youtube.com/watch?v=77tjdk941YU  
     chan_name="PBS News hour" ;;     


##########################################################################
# BROKEN  / Transient
### REPORTER LIVE BROKEN
# 100) link=https://www.youtube.com/watch?v=sub9CNuvjGA ;
## 143) Drunken Peasents
# 143) link=https://www.youtube.com/watch?v=bK5_pGaVoi0 ;;
## 83) GalaTV Chihuahua
# 83) link=https://www.youtube.com/watch?v=VloHUkS_Cn0 ;;
# 84) Televisa Campeche BROKEN
# 84) link=https://www.youtube.com/watch?v=Kf5i1zEDEJQ ;;
# 85) Canal Noticias Argentina BROKEN
# 85) link=https://www.youtube.com/watch?v=WJCIuoKvzi0 ;;
# 86) Canal 44 BROKEN
# 86) link=https://www.youtube.com/watch?v=5sdRSFaPycE ;;
# 87) c5n SPANISH  BROKEN
# 87) link=https://www.youtube.com/watch?v=iPLHkyI1hr4 ;;
## 87) link=http://www.dailymotion.com/video/x2j4h4m_watch-the-euronews-live-stream_news
#chan_name="EuroNews English" ;;

esac


echo "$chan_name"
mpv "$link" 

echo "You were watching "$chan_name" on Channel "$n" "
echo "Type endstream to open a new stream."
exit "$?"

######################     END OF PROGRAM      ####################################################
