#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.13
# Revision Date: March 5, 2017
#
# Change Log:  - Added more streams from Taiwan and Japan
#              - Added a while loop to keep alive until user inputs q
#              - remove dead streams, channel listing function
#              - remove dead streams, rearrange channel listing and channels
#              - take channel input from console + --list-chans + more channelskf
#              - Add firejail before mpv, remove dead streams
#              - dailymotion + twitch + fix channel list
#              - Add channels, rearange, remove dead streams
#              - Rearanged the channels, added more channels
#              - File creation, testing, remove dead streams
#
#
#####################################################################
# Dependencies: youtube-dl, mpv, read , firejail
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
version="0.14"
rev_date="05/03/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   ==============================================================================="
   echo "||       ENGLISH         ||          FRANCAIS          ||          ESPANOL           ||         OTHER         ||            EXTRA             ||          MEGA          ||"
   echo "=========================================================================================================================================================================="
   echo "1) France 24 English       38) TLM 30 Lyon               75) Televisa Veracruz         111) Vanitha TV             148) Al Arabiya               182) SHIBUYA JAPAN        "         
   echo "2) Al Jazeera English      39) France Inter              76) GalaTV Morelos            112) HMT112) HMT            149) Al Jazeera               183) NASA EARTH           " 
   echo "3) i24 News                40) RFI                       77) Televisa Puebla           113) TV5                    150) France 24 Arabic         184) NASA ISS 1           "  
   echo "4) Bloomberg               41) Max FM 92.9               78) GalaTV Queretaro          114) 10TV Telugu            151) BBC Arabic               185) NASA ISS 2           "             
   echo "5) NEWSMAX                 42) M7 TV Mali                79) Televisa Mexicali         115) AsiaNet                152) SKY News Arabic          186) Hubble Telescope     " 
   echo "6) TRT World               43) France Inter              80) GalaTV Acapulco           116) NTV Bangladesh         153) RT Arabic                187) Ocean Explorer       " 
   echo "7) Channels 24 Nigeria     44) RTL En Direct             81) GalaTV Zacatecas          117) SunNews                154) Makkah Live               =======OTHER=======|     "
   echo "8) Africa News             45) ------------              82) Televisa Hermosillo       118) TV9 India Live         155) ON E Arabic              188) SKY NEWS Britain     "
   echo "9) --------                46) Direct Journal TVLandes   83) GalaTV Laguna             119) Reporter TV            156) ON E Sport               189) Euronews English     "
   echo "10) ABC Australia          47) CNEWS                     84) 1070 Noticias             120) Rajya Sabha TV          ==========AFRICAN==========  190) DW English           "
   echo "11) TWiT                   48) BMF TV                    85) GalaTV Toluca             121) Public TV India        157) TVC Nigeria              191) Euronews Deutche     "
   echo "12) Amazing Facts          49) Europe 1                  86) TelePacifico              122) Sandesh News           158) Adom TV                  192) Talking Tom          "
   echo "13) Its Supernatural       50) i24 France                87) Cinevision Canal 19       123) DD News India          159) Bukedde TV               193) ESL League of Legends "
   echo "14) Sheppards Chapel       51) France Info TV            88) Canal 8 Mar del Plata     124) Tugulu News            ==========RUSSIAN==========   194) Poker TV              "
   echo "15) IHOP                   52) France Info Radio         89) Tu Cana                   125) Tv9 Marathi            160) POCCNR 24 Russia         195) High Stakes Poker    "  
   echo "16) KTN Kenya English      53) LCP FRANCE                90) VPI TV                    126) Dawn News Pakistan     161) Ukraine 5                196) Star TV Turkey       "
   echo "17) HSN                    54) Public Senate             91) 100% Noticias Nicaragua   127) TOLO NEWS Afghan       162) Ukraine 112              197) DRHZ Philippeans     "
   echo "18) Arirang TV             55) Presidence de la Republic 92) El Capitolo Venezulana    128) Bol TV Pakistan        163) News 1 Ukraine           198) ABS-CBN Philippeans  "	
   echo "19) India Today             =====SPANISH LANGUAGE=====   93) Sures TV Campeche         129) 92 News Pakistan       164) Ecnpeco Ukraine          199) GMA News Philippeans "
   echo "20) NASA TV                56) Globovision Low           =======ASIAN LANGUAGE=====    130) Tamil Live News        165) Thromadske Ukraine       200) DZMM Philippeans     "  
   echo "21) TWiT Twitch            57) TeleSUR                   94) CCTV 4 China              131) Media One News         169) UA TV Ukraine            201) CTI Taiwan         "
   echo "22) RSBN                   58) RT Espanol                95) EBC 51 Taiwan             132) News 7 Tamil           =========OTHER==========      202) Tzu Chi Da Ai Taiwan "       
   echo "23) CVR English India      59) DW Espanol                96) SET Taiwan                133) Samaya News            166) Action 24 Greek          203) FTV Live Taiwan    "  
   echo "24) i24 News               60) NTN24                     97)  QVC JAPAN                134) 4tv News India         167) Ionian Greek             204) EBC Finance Taiwan "
   echo "25) CGTN China             61) Canal 8 San Juan          98)  SoL!ve 24 Japan          135) APN News India         168) Star Lima Greek          205) TTV Taiwan         "
   echo "26) Saudi 2 TV             62) Canal 6 San Rafael        99)  KBS World 24 Live        136) i News Telugu          170) ------------             206) ON TV Taiwan       "
   echo "27) ---------------        63) Canal Siete               100) KBS World English        137) No 1 News Telugu       171) ------------             207) CTV Taiwan         "
   echo "28) ---------------        64) HispanTV                  101) YTN 27 Korea             138) News 9 Bangalor        172) ------------             208) Parovi 1 TV        "
   echo "29) ---------------        65) Globovision High          102) TV Korea                 139) T News Telegu          173) -------------            209) TRT Haber Turkey   "
   echo "====FRENCH LANGUAGE=====   66) Excelsior TV              103) PTV Phillipeans          140) ATN Bangladesh         ==========LOCATIONS========== 210) 24 News Pakistan   "  
   echo "30) France 24 Francais     67) Imagine Radio             |==HINDI=URDU=DARI=PASHTU=|   =========ARABIC===========  174) Venice Italy Bridge      211) WWE RAW            "
   echo "31) France Info TV         68) c5n Argentina             104) Survana                  141) CBC Egypt              175) Venice Italy Port        212) Journalism Deutche "
   echo "32) France 24 Francais     69) Q24                       105) News 18 India            142) CBC Egypt Drama        176) Jackson Hole Intersection213) Plus Live Greek    " 
   echo "33) Euronews Francais      70) La Casacra TV             106) SAMAA TV                 143) CBC Egypt Sofra        177) Jackson Hole Town Square 214) Joy News           "  
   echo "34) Africa News            71) Televisa del Bajio        107) Aaj Tak                  144) eXtra News Egypt       178) Jackson Hole Rustic Inn  215) Japan TV Live      "
   echo "35) Afrique Media          72) Televisa del Golfo        108) TV9 Live                 145) ------------           179) Verona Italy             216) CTS World Taiwan   "
   echo "36) France Info            73) Televisa Guadalajara      109) NTV Telugu               146) Syrian Satellite       180) Soggy Dollar BVI         217) CNN                "
   echo "37) Mosaik TV              74) Televisa del Noreste      110) ABN Telugu               147) Al Mayadeen            181) Amsterdam Netherlands    218) TYT                "	
   echo "==========================================================================================================================================================================="
echo " " 
}	



for arg in $@
do 
 if [ "$arg" == "--help" ]
 then
   echo "ENDSTREAM: watch news live-streams in CLEARNET from youtube using youtube-dl mpv using"
   echo "Type in the terminal $ endstream "
   echo "Now read the list and pick a number,input it and press enter."
   echo ""
   echo "USAGE:"
   echo "$ endstream --help         # usage messages"
   echo "$ endstream --version      # print version information"
   echo "$ endstream --list-matrix  # channel list in matrix format"
   echo "$ endstream --list-all     # channel list in column format"
   echo "$ endstream  55            # use channel number in command line"  
   echo "$ endstream  "
   shift
   exit 0
   elif [ "$arg" == "--version" ]
   then
   echo "ENDSTREAM: version: "$version", branch: "$branch" , revision date: "$rev_date" " 
   echo "Copyright: The Endware Development Team, 2016"
   shift
   exit 0
   elif [ "$arg" == "--list-matrix" ]
   then 
   channel_matrix
   exit 0
   elif [ "$arg" == "--list-all" ]
   then
   more "$chan_columns"
   exit 0   
 fi
done


if [ "$1" != "" ]
then
echo "$1"
# take channel input from command line
num="$1" 
elif [ "$1" == "" ]
then
channel_matrix
echo "Please Select a Number corresponding to a YouTube Live Stream:"

############# DEFAULT SELECTION #######################
# in case of non-numeric entry 
 link=https://www.youtube.com/watch?v=1Ydto3Iyzic 
 chan_name="France 24 English"
#######################################################

read num

if [ "$num" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
fi

fi

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    MAIN  ENGLISH  ##################################
# 1) France 24 Anglais 
1) link=https://www.youtube.com/watch?v=1Ydto3Iyzic 
   chan_name="France 24 English";;
# 2) Al Jazeera
2) link=https://www.youtube.com/watch?v=pJC-vohDHl8 
   chan_name="Al Jazeera" ;;  
# 3) i24 News Israel 
3) link=https://www.dailymotion.com/video/x29atae
chan_name="i24 News Israel" ;;
# 4) Bloomberg
4) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w 
   chan_name="Bloomberg";;
# 5) NEWSMAX
5) link=https://www.youtube.com/watch?v=RZMpdhVZTa4
   chan_name="NEWSMAX";;
#  6) TRT World
6) link=https://www.youtube.com/watch?v=N7jfTZLkhms 
    chan_name="TRT World";;
# 7) Channels 24 Nigeria
7) link=https://www.youtube.com/watch?v=ANM-dq5USTc 
    chan_name="Channels 24 Nigeria";;
# 8) Africa News Live
8) link=https://www.youtube.com/watch?v=zcWWdvRaaSA 
    chan_name="Africa News English";;
# 9)
# 10) ABC News Australia 
10) link=https://www.youtube.com/watch?v=fzqQa5x7NLA 
     chan_name="ABC News Australia" ;;
###############      OTHER ENGLISH          ##################################
#  11) TWiT
11) link=https://www.youtube.com/watch?v=Gthvw4Bevkg 
    chan_name="TWiT" ;;
# 12) Amazing Facts TV (Christian)
12) link=https://www.youtube.com/watch?v=JFLFK362vns 
    chan_name="Amzaing Facts TV (Christian)" ;;
# 13) It's Supernatural! Network (Christian)
13) link=https://www.youtube.com/watch?v=TgYk_asWz_4 
    chan_name="It's Supernatural! (Christian)" ;;
# 14) Sheppard's Chapel (Christian)
14) link=https://www.youtube.com/watch?v=Ogy9CLdOn2g 
    chan_name="Sheppard's Channel" ;;
# 15) International House of Prayer (IHOP) (Christian)
15) link=https://www.youtube.com/watch?v=dyD6lMY11wM 
    chan_name="International House of Prayer (Christian)" ;;
# 16) KTN Kenya English
16) link=https://www.youtube.com/watch?v=YASZYb8UBs8 
    chan_name="KTN Kenya English" ;;
# 17) HSN
17)  link=https://www.youtube.com/watch?v=J0022wscx0k 
     chan_name="Home Shopping Network HSN" ;;
# 18)  Arirang TV
18) link=https://www.youtube.com/watch?v=JVr6yiZ9IMY 
    chan_name="Arirang TV (Korean Pride)" ;;
# 19) India TODAY
19) link=https://www.youtube.com/watch?v=wXwYCWGpprc 
    chan_name="India TODAY English" ;;
# 20)   NASA TV
20) link=https://www.youtube.com/watch?v=UdmHHpAsMVw 
    chan_name="NASA TV" ;; 
# 21) TWiT on Twitch
21) link=https://www.twitch.tv/twit 
    chan_name="TWiT on Twitch" ;;
#  22) RSBN Live
22) link=https://www.youtube.com/watch?v=xEQEM7X7J4E 
    chan_name="RSBN Right Side Broadcasting News" ;;
# 23) CVR English India
23) link=https://www.youtube.com/watch?v=3S-vfmpCdCg
chan_name="CVR English" ;;
# 24) i24 News
24) link=https://www.youtube.com/watch?v=2AvIbstRX8s 
   chan_name="i24 Israel English" ;;
# 25)CGTN China English 
25) link=https://www.youtube.com/watch?v=2QPp4snyEHY
chan_name="CGTN China English" ;;
# 26) Saudi 2 TV
26) link=https://www.youtube.com/watch?v=ryYlM0IDXoQ 
    chan_name="Saudi 2 TV" ;;
# 27)
# 28) 
# 29) 
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
# 38) TLM Lyon Metro
38) link=https://www.youtube.com/watch?v=aedZ5C0HcO0
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
# 45)
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
60) link=https://www.youtube.com/watch?v=yuvZC1Ll7lA 
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
# 68) c5n Argentina
68) link=https://www.youtube.com/watch?v=YrynoTgahC4
chan_name="c5n Argentina" ;;
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
72) link=https://www.youtube.com/watch?v=VHkRgkCKW-0
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
# 93) Sures TV Campeche 
93) link=https://www.youtube.com/watch?v=6eJPGYK2N5M 
chan_name="Sures TV Campeche";;

################ CHINESE MANDARIN CANTONESE  ####################
# 94) CCTV 4 Chinese
94) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw 
    chan_name="CCTV 4 Chinese" ;;
# 95) EBC 51 News Taiwan
95) link=https://www.youtube.com/watch?v=yzE3bRtXIrI 
    chan_name="EBC 51 News Taiwan" ;;
# 96) SET News Taiwan
96) link=https://www.youtube.com/watch?v=TgGyBF-7w8M
chan_name="SET News Taiwan" ;;

################ JAPANESE  ####################
#  97) QVC JAPAN SHOPPING CHANNEL
97) link=https://www.youtube.com/watch?v=wMo3F5IouNs 
    chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 98) Sol!ve 24 Japan
98) link=https://www.youtube.com/watch?v=kfTq_A9nBM0
chan_name="Sol!ve 24 Japan";; 
################ KOREAN  ###############################
#  99) KBS World 24 News
99) link=https://www.youtube.com/watch?v=9nMuTuy5SIs 
     chan_name="KBS World 24 News" ;;
# 100) KBS World English Sub
100) link=https://www.youtube.com/watch?v=mRUT78iMdLw 
     chan_name="KBS 24 World English Sub" ;;
# 101) YTN 24 Korea
101) link=https://www.youtube.com/watch?v=YwbpBIabRmo
chan_name="YTN 27 Korea" ;;  
################ TAGALOG ###############################
# 102) TV Korea 
102) link=https://www.youtube.com/watch?v=949QsKpHf_g
chan_name="TV Korea" ;;
# 103) PTV
103) link=https://www.youtube.com/watch?v=Y4SS0wEXCZY 
     chan_name="PTV Phillipeans" ;;
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 104) Survana News
104) link=https://www.youtube.com/watch?v=xJqm4gxr7gs 
     chan_name="Survana News" ;;
# 105) News 18 India
105) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 
     chan_name="News 18 India" ;;
# 106) SAMAA TV
106) link=https://www.youtube.com/watch?v=qH2kZjv1CYM 
     chan_name="SAMAA TV" ;;
# 107) Aaj Tak 
107) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q 
     chan_name="Aaj Tak" ;;
# 108) TV9 Telugu
108) link=https://www.youtube.com/watch?v=QWsESTCbIf0 
     chan_name="TV9 Telugu" ;;
# 109) NTV Telugu
109) link=https://www.youtube.com/watch?v=T953eK1GXbA 
     chan_name="NTV Telugu" ;;
# 110) ABN Telugu
110) link=https://www.youtube.com/watch?v=QzQnFY6CioA 
     chan_name="ABN Telugu" ;;
# 111) Vanitha TV 
111) link=https://www.youtube.com/watch?v=ji7H-z506SA 
     chan_name="Vanitha TV" ;;
# 112) HMT Telugu
112) link=https://www.youtube.com/watch?v=qdi47ihDFCk 
     chan_name="HMT Telugu" ;;
# 113) TV5 News 
113) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg 
     chan_name="TV5 News" ;;
# 114) 10TV Telugu
114) link=https://www.youtube.com/watch?v=UpNJQg567UU 
     chan_name="10TV Telugu" ;;
# 115) AsiaNet News
115) link=https://www.youtube.com/watch?v=YYqeFCJRBUg  
     chan_name="AsiaNet News" ;;
# 116) NTV Bangladesh
116) link=https://www.youtube.com/watch?v=5pz4cXHd6TI 
     chan_name="NTV Bangladesh" ;;
# 117) SunNews 
117) link=https://www.youtube.com/watch?v=QpiEINgQa3I
chan_name="SunNews" ;;
# 118) REPORTER LIVE
118) link=https://www.youtube.com/watch?v=WpyZ7xjx3hk 
chan_name="Reporter Live" ;;
# 119) TV9 India Live
119) link=https://www.youtube.com/watch?v=aFU2xAWkRJ8 
chan_name="TV9 Live India";;    
# 120) Rajya Sabha TV
120) link=https://www.youtube.com/watch?v=oPpYUy__VaQ
chan_name="Rajya Sabha" ;;
# 121) Public TV India
121) link=https://www.youtube.com/watch?v=dccFagg0tDU
chan_name="Public TV India" ;;
# 122 Sandesh News
122) link=https://www.youtube.com/watch?v=qsl7g3hEx2U 
chan_name="Sandesh News" ;;
# 123) DD News
123) link=https://www.youtube.com/watch?v=23EG0wfvcYU
chan_name="DD News" ;;  
# 124) Telugu News
124) link=https://www.youtube.com/watch?v=kg48DXa4bKE 
     chan_name="Telugu News" ;;  
#125 Tv9 Marathi
125) link=https://www.youtube.com/watch?v=BremLDr3lgA 
     chan_name="Tv9 Marathi" ;;
# 126) Dawn News PAKISTAN
126) link=https://www.youtube.com/watch?v=f0ZIpFKjpKU
chan_name="Dawn News" ;;
# 127) TOLO NEWS AFGHANISTAN
127) link=https://www.youtube.com/watch?v=-CONWzwDqTA
chan_name="TOLO NEWS";;    
# 128) Bol TV Pakistan
128) link=https://www.youtube.com/watch?v=5U6PbikM86U
chan_name="Bol News" ;;
# 129) 92 News Pakistan
129) link=https://www.youtube.com/watch?v=jlJwIhmGONo
chan_name="92 News Pakistan";; 
# 130) Tamil Live News
130) link=https://www.youtube.com/watch?v=47oy2A47Jjs
chan_name="Tamil Live News";;
# 131) Media One News
131) link=https://www.youtube.com/watch?v=Fpp7C-XH2ac
chan_name="Media One";;
# 132) News 7 Tamil
132) link=https://www.youtube.com/watch?v=KMReyf7MEmk
chan_name="News 7 Tamil" ;;
# 133) Samaya News
133) link=https://www.youtube.com/watch?v=MmvnNOOt92Q
chan_name="Samaya News" ;;
# 134) 4tv News India
134) link=https://www.youtube.com/watch?v=GhRxbhMnyHU
chan_name="4tv News" ;;
# 135) APN News India
135) link=https://www.youtube.com/watch?v=O5WcuOYIaOQ
chan_name="APN News" ;;
# 136) i News Telugu
136) link=https://www.youtube.com/watch?v=3xe2HCGvikI
chan_name="i News Telugu" ;;
# 137) No 1 News Telugu
137) link=https://www.youtube.com/watch?v=JMUtgBPIliM
chan_name="No 1 News" ;;
# 138) News 9 Bangalor India
138) link=https://www.youtube.com/watch?v=FLl8PHf_L64
chan_name="News 9 Bangalor English" ;;
# 139) T News Telegu
139) link=https://www.youtube.com/watch?v=p-a-Q2JCUZ4
chan_name="T News Telegu" ;;
# 140) ATN News Bangladesh
140) link=https://www.youtube.com/watch?v=F_oSYwhc9Rs
chan_name="ATN News Bangladesh";;
################## ARABIC  ##########################################
# 141) CBC Egypt Arabic Live
141) link=https://www.youtube.com/watch?v=FFx5r-U9ryA 
     chan_name="CBC Egypt Arabic" ;;
# 142) CBC Egypt Arabic Drama 
142) link=https://www.youtube.com/watch?v=J65S7swv0As
chan_name="CBC Egypt Arabic Drama" ;;
# 143) CBC Egypt Sofra Arabic
143) link=https://www.youtube.com/watch?v=LJzqXK3hB3I
chan_name="CBC Egypt Sofra" ;;
# 144) eXtra News Egypt Arabic
144) link=https://www.youtube.com/watch?v=B_zcpKXB1Ic
chan_name="eXtra News Egypt" ;;         
# 145) ON Live
145) link=https://www.youtube.com/watch?v=9I8WtuLBYqI
chan_name="ON Live" ;;
# 146) Syrian Satellite
146) link=https://www.youtube.com/watch?v=YfH6U8CNp58 
     chan_name="Syrian Satellite" ;; 
# 147) Al Mayadeen
147) link=https://www.youtube.com/watch?v=lUDZxObNzPI 
     chan_name="Al Mayadeen" ;;
# 148) Al Arabiya
148) link=https://www.youtube.com/watch?v=1QFrtsu1JJg 
     chan_name="Al Arabiya" ;;
# 149) Al Jazeera Arabic
149) link=https://www.youtube.com/watch?v=elqcDJ3TXUs 
     chan_name="Al Jazeera Arabic" ;;
# 150) France 24 Arabic
150) link=https://www.youtube.com/watch?v=UYi0sgVm5dM 
     chan_name="France 24 Arabic" ;;
# 151) BBC Arabic
151) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 
     chan_name="BBC Arabic" ;;
# 152) SKY Arabic
152) link=https://www.youtube.com/watch?v=wSfbKXa0aoo 
     chan_name="SKY Arabic" ;;
# 153) RT Arabic 
153) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 
     chan_name="RT Arabic" ;;
# 154) Makkha Live (Mecca Kaaba)
154) link=https://www.youtube.com/watch?v=0b1IMR2H_7s
chan_name="Mecca Kaaba Live" ;;
# 155) ON E Live 
155) link=https://www.youtube.com/watch?v=vCKAnvpT79Y 
     chan_name="ON E";;
# 156)  ON E Sports
156) link=https://www.youtube.com/watch?v=PaEPidxFLhA 
     chan_name="ON E Sports" ;; 
################ AFRICAN #################################
# 157) TVC Nigeria
157) link=https://www.youtube.com/watch?v=qRaDbwYys30 
 chan_name="TVC Nigeria" ;;
# 158) ADOM TV 
158) link=https://www.youtube.com/watch?v=g5McawVm8Q4 
     chan_name="ADOM TV" ;;
# 159) Bukedde TV
159) link=https://www.youtube.com/watch?v=2YBFFMTWIL4
chan_name="Bukedde TV" ;;      
############### RUSSIAN ################################
# 160) Россия 24
160) link=https://www.youtube.com/watch?v=i_Q8N6ZSDXQ 
     chan_name="POCCNR 24 Russia" ;;
# 161) Ukraine Channel 5 
161) link=https://www.youtube.com/watch?v=jPIlMhyDD50
chan_name="Ukraine 5" ;;
# 162) Ukraine 112
162) link=https://www.youtube.com/watch?v=vGNm5IFXm8U
chan_name="Ukraine 112" ;;
# 163) News 1 Ukraine
163) link=https://www.youtube.com/watch?v=yA30K3z5PSw
chan_name="News 1 Ukraine" ;;
# 164) Еспресо Ukraine
164) link=https://www.youtube.com/watch?v=YcaOOvexXAQ
chan_name="Ecnpeco Ukraine" ;;
# 165) Thromadske Ukraine
165) link=https://www.youtube.com/watch?v=FKVBsbuVt-I
chan_name="Thromadske Ukraine" ;;
# 166) UA TV Ukraine
166) link=https://www.youtube.com/watch?v=roMSU3WvRwY
chan_name="UA TV Ukraine" ;;
################### GREEK ######################################
## 167) Action 24 Greece 
167) link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
chan_name="Action 24 Greek" ;;
## 168) Ionian TV
168) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
chan_name="Ionian TV Greek" ;;
## 169) Star Lima
169) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
chan_name="Star Lima Greek" ;;
################### OTHER  ########################
# 170) 
# 171)
# 172)            
# 173) 
################## LOCATIONS #############################     
# 174) Venice Italy Bridge Cam Live
174) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
     chan_name="Venice Italy Bridge Cam" ;;
# 175) Venice Italy Port Cam Live
175) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
     chan_name="Venice Italy Port Cam" ;;
# 176) Jackson Hole Intersection
176) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
     chan_name="Jackson Hole Intersection" ;;
# 177) Jackson Hole Town Square
177) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
     chan_name="Jackson Hole Town Square" ;;
# 178) Jackson Hole Rustic Inn
178) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
     chan_name="Jackson Hole Rustic Inn" ;;
# 179) Verona Italy
179) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
     chan_name="Verona Italy" ;;
# 180) Soggy Dollar Bar
180) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
     chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  181) Amsterdam Netherlands
181) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
     chan_name="Amsterdam Netherlands" ;;
# 182) Shibua Japan Community Crosswalk 
182) link=https://www.youtube.com/watch?v=_9pavMzUY-c 
    chan_name="Shibua Japan Crosswalk" ;;
###############    SPACE       #########################    
# 183) NASA LIVE STREAM 1
183) link=https://www.youtube.com/watch?v=SF7FUU7CThs 
    chan_name="NASA STREAM 1" ;;
# 184) NASA LIVE STREAM 2
184) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
    chan_name="NASA STREAM 2" ;;  
# 185) NASA LIVE STREAM 3
185) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
    chan_name="NASA STREAM 3" ;;
# 186) Hubble Telescope
186) link=https://www.youtube.com/watch?v=TzpO54TuSXs 
    chan_name="Hubble Telescope" ;;   
# 187) Okeanos Ocean Explorer 
187) link=https://www.youtube.com/watch?v=WvgEX_TuF2Y
chan_name="Okeanos Ocean Explorer" ;;     
###############    RESTRICTED TO EUROPE     ###########################
# 188) SKY NEWS
188) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
    chan_name="SKY NEWS" ;; 
# 189) Euronews English Live
189) link=https://www.youtube.com/watch?v=Nxid1JTdfrk 
# link=http://www.dailymotion.com/video/x2j4h4m
    chan_name="Euronews English" ;;
# 190) DW English
190) link=https://www.youtube.com/watch?v=gNosnzCaS4I 
# link=http://www.dailymotion.com/video/xzgfm5_dw-live-stream_news
    chan_name="DW English" ;; 
# 191)  EuroNews Deutche
191) link=https://www.youtube.com/watch?v=dYJ0kTqeu08 
    chan_name="EuroNews Deutche" ;;
################# OTHER  ###############################################
# 192) Talking Tom and Friends
192) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc 
     chan_name="Talking Tom and Friends" ;;
# 193) ESL League of Legends TWITCH
193) link=https://www.twitch.tv/esl_lol 
     chan_name="ESL League of Legends" ;;  
# 194) Poker TV
194) link=https://www.twitch.tv/pokerrtv 
    chan_name="Poker TV" ;;
# 195) High Stakes Poker 
195) link=https://www.twitch.tv/highstakespoke 
     chan_name="High Stakes Poker" ;;   
# 196) Star TV  Turkish
196) link=https://www.youtube.com/watch?v=jWP3ntl64I4
chan_name="Star TV Turkish" ;;   
# 197) DZRH News Philippeans
197) link=https://www.youtube.com/watch?v=zVWQU4BFAEQ
chan_name="DZRH News Philippeans" ;;
# 198) ABS-CBN Philippeans
198) link=https://www.youtube.com/watch?v=LJsYBw5kY70
chan_name="ABS-CBN Philippeans" ;;
# 199) GMA NEWS Philippeans
199) link=https://www.youtube.com/watch?v=VlwnHg5Tp5U
chan_name="GMA News Philippeans";;
# 200) DZMM ABS-CBN Philippeans Radio
200) link=https://www.youtube.com/watch?v=YTjNZrs5vvU
chan_name="DZMM Philippeans" ;;
# 201) CTI China
201) link=https://www.youtube.com/watch?v=VsvZqiB2y1o
chan_name="CTI China" ;; 
#  202) Tzu Chi Da Ai Taiwan 
202) link=https://www.youtube.com/watch?v=ESKjSwcswBM
chan_name="Tzu Chi Da Ai Taiwan" ;; 
# FTV Taiwan
203) link=https://www.youtube.com/watch?v=XxJKnDLYZz4
chan_name="FTV Live";;
# 204) EBC Finance
204) link=https://www.youtube.com/watch?v=CUKpfr9tWBc
chan_name="EBC Finance News" ;;
# 205) TTV News Taiwan
205) link=https://www.youtube.com/watch?v=yk2CUjbyyQY
chan_name="TTV News Taiwan"  ;;
# 206) ON TV Chinese
206) link=https://www.youtube.com/watch?v=WrkVwCYvRPk
chan_name="ON TV China" ;;
# 207) CTV Taiwan
207) link=https://www.youtube.com/watch?v=b3QIfgD--_E
chan_name="CTV Taiwan" ;;
## 208) Parovi 1 TV
208) link=https://www.youtube.com/watch?v=DmRzk9MtRAc
chan_name="Parovi 1";;
## 209) TRT Haber Turkey
209) link=https://www.youtube.com/watch?v=uN5fOYfl63s
chan_name="TRT Haber Turkey";;
## 210) 24 News Pakistan HD
210) link=https://www.youtube.com/watch?v=sKTPacY9Aj4
chan_name="24 News Pakistan HD" ;;    
############## TRANSIENT #################################
## 211) WWE RAW
211) link=https://www.youtube.com/watch?v=G6ms43ia22I    
chan_name="WWE RAW" ;;
## 212) Competant Journalism Is Hard Work
212) link=https://www.youtube.com/watch?v=Y-bdnJZyqrk
chan_name="Journalism Deutche" ;;
## 213) Plus Live Greek
213) link=http://www.dailymotion.com/video/x43nkzp_plus-live-live_fun
chan_name="Plus Live" ;;
# 214) Joy News
214) link=https://www.youtube.com/watch?v=xB9J1_sm6Uc
chan_name="Joy News" ;;
# 215) Japan TV Live
215) link=https://www.youtube.com/watch?v=kDxsHqzwFdE
chan_name="Japan TV Live" ;;
# 216) CTS World News HD Taiwan
216) link=https://www.youtube.com/watch?v=1I6fxNSmQh4
chan_name="CTS World News HD" ;;
# 217) CNN
217) link=https://www.youtube.com/watch?v=qaHj0i_5eI0
chan_name="CNN" ;;
# 218) TYT 
218) link=https://www.youtube.com/watch?v=jFLafQ00Lfk 
     chan_name="TYT The Young Turks" ;;
# 219) NeXT TV Taiwan
219) link=https://www.youtube.com/watch?v=KoZGabXeV74
chan_name="Next TV Taiwan" ;;
# 220)  Chinese Kareokee 
220) link=https://www.youtube.com/watch?v=XA8-cqewOUs
chan_name="Chinese Kareoke" ;;
##########################################################################
# BROKEN  / Transient
## 83) GalaTV Chihuahua BROKEN
# 83) link=https://www.youtube.com/watch?v=VloHUkS_Cn0 ;;
# 85) Canal Noticias Argentina BROKEN
# 85) link=https://www.youtube.com/watch?v=WJCIuoKvzi0 ;;
# 86) Canal 44 BROKEN
# 86) link=https://www.youtube.com/watch?v=5sdRSFaPycE ;;
## Euronews
# 87) link=http://www.dailymotion.com/video/x2j4h4m_watch-the-euronews-live-stream_news
#chan_name="EuroNews English" ;;
# CGTN English
# 3) link=https://www.youtube.com/watch?v=GV1p3irkgi0 
#   chan_name="CGTN English" ;;
# NTV Uganda
# 16) link=https://www.youtube.com/watch?v=CL8dsz9RRW8 
#    chan_name="NTV Uganda" ;; 
# ABS-CBN Phillipeans
# 12) link=https://www.youtube.com/watch?v=3vYPyZywbZs 
#    chan_name="ABS-CBN Phillipeans";;
# CNBC Africa
# 12) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI 
#    chan_name="CNBC Africa" ;;
# CBSN
# 24) link=https://www.youtube.com/watch?v=EgAK15lzgSA
#chan_name="CBSN" ;;


esac

}

channel_select $num


echo "$chan_name"
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv "$link" 



entry="null"

channel_matrix
echo "You were watching "$chan_name" on Channel "$num" "
echo "Please Select a Number corresponding to a YouTube Live Stream:"
echo "Select a new stream number or press q to quit."

read entry 

if [ "$entry" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
else

channel_select $entry
echo "$chan_name"
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv "$link" 

# echo "You were watching "$chan_name" on Channel "$entry" "

while [ "$entry" != "q" ]
do

  channel_matrix
  echo "You were watching "$chan_name" on Channel "$entry" "
  echo "Please Select a Number corresponding to a YouTube Live Stream:"
  echo "Select a new stream number or press q to quit."

  read entry 

  channel_select $entry

  if [ "$entry" == "q" ]
  then 
  echo "Type endstream to open a new stream."
  exit "$?"
  else
  echo "$chan_name"
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv "$link" 
 
  fi

done

fi


echo "Type endstream to open a new stream."


exit "$?"

######################     END OF PROGRAM      ####################################################
 
