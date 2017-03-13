#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.16
# Revision Date: March 12, 2017
#
# Change Log:  - Removed transient streams added some home shopping channels
#              - Rearranged channels
#              - Added more streams from Taiwan and Japan
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
version="0.16"
rev_date="12/03/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   ================================================================================"
   echo "||      ENGLISH       ||      FRANCAIS        ||         ESPANOL        ||         OTHER         ||      EXTRA         ||          MEGA          ||       ULTRA      ||"
   echo "============================================================================================================================================================================"
   echo "1) France 24 English  38) France Inter        75) ------------           112) QVC JAPAN           ========ARABIC====== 185) UA TV Ukraine        222) Akiba Japan       "         
   echo "2) Al Jazeera English 39) RTL En Direct       76) ------------           113) SoL!ve 24 Japan   149) EuroNews Arabic    ========OTHER=========   223) Bridge Japan      " 
   echo "3) TRT World          40) Journal TVLandes    77) ------------           =====INDIA/PAKISTAN=== 150) RT Arabic         186) Action 24 Greek      224) Steamy Mount Japan"  
   echo "4) i24 News Israel    41) CNEWS               78) ------------           114) SunNews           151) ON E Arabic       187) Ionian Greek         225) Tokyo Japan"             
   echo "5) NEWSMAX            42) BMF TV              79) ------------           115) TV 9 News         152) ON E Sport        188) Star Lima Greek      226) Shizuoka Japan"  
   echo "6) ABC Australia      43) Europe 1            80) ------------           116) Rajya Sabha TV    153) ON Live           189) ------------         227) Yokohama Japan"  
   echo "7) Africa News        44) i24 France          81) ------------           117) Sandesh News      154) Al Jazeera        190) Star TV Turkey       228) Hokkido Japan"
   echo "8) Channels 24 Nigeria45) France Info TV      82) ------------           118) Tv9 Marathi       155) France 24 Arabic  191) Parovi 1 TV          229) Mt Fuji Japan"
   echo "9) Bloomberg          46) France Info Radio   83) ------------           119) Bol TV Pakistan   156) BBC Arabic        192) Adom TV              230) TYT "
   echo "10) TWiT              47) LCP FRANCE          84) ------------           120) 92 News Pakistan  157) CBC Egypt Sofra   193) -------------        231) Euronews Russian "
   echo "11) Amazing Facts     48) Public Senate       85) ------------           121) News 7 Tamil      158) Al Arabiya        194) SKY NEWS Britain     232) Euronews Turish "
   echo "12) Its Supernatural  49) La Republic         86) ------------           122) T News Telegu     159) Al Mayadeen       195) DW English           233) Euronews Italian "
   echo "13) Sheppards Chapel  50) QVC Francais        87) ------------           123) 24 News Pakistan  160) Syrian Satellite  196) Euronews Deutche     234) QVC Italian "
   echo "14) IHOP              51) -----------         88) ------------           124) News 18 India     161) ORTAS Syria       197) -------------        235) Sport in Oro Italian "
   echo "15) HSN               52) -----------         89) ------------           125) Aaj Tak           162) Bedya TV Arabic   198) Talking Tom          236) Euronews Maygar "  
   echo "16) Arirang TV        53) -----------         90) ------------           126) TV9 Live          163) Belquees Arabic   199) ---------            237) ------- "
   echo "17) India Today       54) -----------         91) ------------           127) NTV Telugu        164) Saudi Blue News   200) --------------       238) ------- "
   echo "18) NASA TV           55) -----------         92) ------------           128) ABN Telugu        165) Saudi Purple      201) --------------       239) ------- "	
   echo "19) TWiT Twitch       =====SPANISH LANGUAGE===93) ------------           129) Vanitha TV        166) Saudi Kids        202) --------------       240) ------- "
   echo "20) CVR English India 56) Globovision Low     =======ASIAN LANGUAGE===== 130) HMT               167) ------------      203) DZMM Philippeans     241) ------- "  
   echo "21) Saudi 2 English   57) RT Espanol          94) CCTV 4 China           131) TV5               168) ------------      204) ---------------      242) ------- "
   echo "22) News 9 Bangalor   58) DW Espanol          95) ON TV News Hong Kong   132) -----------       169) ------------      205) ---------------      243) -------  "       
   echo "23) EuroNews English  59) NTN24               96) ON TV Sports Hong Kong 133) -----------       170) ------------      206) NASA ISS Replay      244) -------  "  
   echo "24) BBC World News    60) Canal 8 San Juan    97) EBC 51 Taiwan          134) -----------       171) ------------      207) NASA ISS 1           245) -------  "
   echo "25) QVC English       61) Canal 6 San Rafael  98) EBC Finance Taiwan     135) -----------       172) ------------      208) NASA ISS 2           246) -------  "  
   echo "26) HSN 2             62) Canal Siete         99) Tzu Chi Da Ai Taiwan   136) -----------       173) ------------      209) Okeanos Cam 1        247) -------  "
   echo "27) Poker TV          63) c5n Argentina       100) FTV Live Taiwan       137) -----------       174) ------------      210) Okeanos Cam 2        248) -------  "
   echo "28) High Stakes Poker 64) A24                 101) TTV Taiwan            138) -----------       175) ------------      211) Okeanos Cam 3        249) -------  "
   echo "29) i24 News Israel   65) Televisa Guadalajara102) CTV Taiwan            139) -----------       176) ------------      212) Venice Italy Bridge  250) -------  "
   echo "====FRENCH LANGUAGE===66) Televisa Veracruz   103) CTS World News Taiwan 140) -----------       177) ------------      213) Venice Italy Port    251) -------  "    
   echo "30) France 24 Francais67) Televisa Mexicali   104) SET Taiwan            141) -----------       178) ------------      214) Jackson Hole XSec    252) -------  "
   echo "31) France Info TV    68) Televisa Hermosillo 105) CTI Taiwan            142) -----------       =======RUSSIAN=======  215) Jackson Hole Square  253) -------  "
   echo "32) France 24 Francais69) GalaTV Laguna       106) NEXT TV Taiwan        143) -----------       179) POCCNR 24 Russia  216) Jackson Hole Rustic  254) -------  " 
   echo "33) Euronews Francais 70) GalaTV Toluca       107) Chinese Kareoke       144) -----------       180) Ukraine 5         217) Verona Italy         255) -------  "  
   echo "34) France Info       71) TelePacifico        108) KBS World 24 Live     145) -----------       181) Ukraine 112       218) Soggy Dollar BVI     256) -------  "
   echo "35) France Inter      72) Canal 8 Mar Plata   109) KBS World English     146) -----------       182) News 1 Ukraine    219) Amsterdam Netherlands257) -------  "
   echo "36) Max FM 92.9       73) Sures TV Campeche   110) KBS World TV          147) -----------       183) Ecnpeco Ukraine   220) SHIBUYA JAPAN        258) -------  "
   echo "37) M7 TV Mali        74) ----------------    111) YTN 27 Korea          148) -----------       184) Thromadske Ukraine221) RSBN Live Cam        259) -------  "	
   echo "===================================================================================================================================================================="
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
   chan_name="Al Jazeera English" ;;  
#  3) TRT World
3) link=https://www.youtube.com/watch?v=N7jfTZLkhms 
    chan_name="TRT World";;   
# 4) i24 News Israel 
4) link=https://www.dailymotion.com/video/x29atae
chan_name="i24 News Israel" ;;
# 5) NEWSMAX
5) link=https://www.youtube.com/watch?v=pUt6SKxSE8Q
   chan_name="NEWSMAX";;
# 6) ABC News Australia 
6) link=https://www.youtube.com/watch?v=fzqQa5x7NLA  
     chan_name="ABC News Australia" ;;
# 7) Africa News Live
7) link=https://www.youtube.com/watch?v=hgCCpd9yjaw 
    chan_name="Africa News English";;
# 8) Channels 24 Nigeria
8) link=https://www.youtube.com/watch?v=ANM-dq5USTc 
    chan_name="Channels 24 Nigeria";;    
# 9) Bloomberg
9) link=https://www.youtube.com/watch?v=Ga3maNZ0x0w 
   chan_name="Bloomberg";;     
###############      OTHER ENGLISH          ##################################
#  10) TWiT
10) link=https://www.youtube.com/watch?v=Gthvw4Bevkg 
    chan_name="TWiT" ;;
# 11) Amazing Facts TV (Christian)
11) link=https://www.youtube.com/watch?v=JFLFK362vns 
    chan_name="Amzaing Facts TV (Christian)" ;;
# 12) It's Supernatural! Network (Christian)
12) link=https://www.youtube.com/watch?v=TgYk_asWz_4 
    chan_name="It's Supernatural! (Christian)" ;;
# 13) Sheppard's Chapel (Christian)
13) link=https://www.youtube.com/watch?v=Ogy9CLdOn2g 
    chan_name="Sheppard's Channel" ;;
# 14) International House of Prayer (IHOP) (Christian)
14) link=https://www.youtube.com/watch?v=dyD6lMY11wM 
    chan_name="International House of Prayer (Christian)" ;;
# 15) HSN
15)  link=https://www.youtube.com/watch?v=J0022wscx0k 
     chan_name="Home Shopping Network HSN" ;;
# 16)  Arirang TV
16) link=https://www.youtube.com/watch?v=JVr6yiZ9IMY 
    chan_name="Arirang TV (Korean Pride)" ;;
# 17) India TODAY
17) link=https://www.youtube.com/watch?v=wXwYCWGpprc 
    chan_name="India TODAY English" ;;
# 18)   NASA TV
18) link=https://www.youtube.com/watch?v=UdmHHpAsMVw 
    chan_name="NASA TV" ;; 
# 19) TWiT on Twitch
19) link=https://www.twitch.tv/twit 
    chan_name="TWiT on Twitch" ;;
# 20) CVR English India
20) link=https://www.youtube.com/watch?v=3S-vfmpCdCg
chan_name="CVR English" ;; 
# 21) Saudi 2 TV
21) link=https://www.youtube.com/watch?v=XJA3cBbQdcQ 
    chan_name="Saudi 2 English" ;;
# 22) News 9 Bangalor India
22) link=https://www.youtube.com/watch?v=FLl8PHf_L64
chan_name="News 9 Bangalor English" ;;
# 23) EuroNews English
23) link=https://www.youtube.com/watch?v=74HQqtSLJmk
chan_name="EuroNews English" ;;
# 24) BBC World News
24) link=https://www.youtube.com/watch?v=PcQHEX3v2L4
chan_name="BBC World News" ;;
# 25) QVC 
25) link=https://www.youtube.com/watch?v=2oG7ZbZnTcA
chan_name="QVC English" ;;
# 26) HSN 2
26) link=https://www.youtube.com/watch?v=1pepSUbkLVI
chan_name="HSN2" ;;
# 27) Poker TV
27) link=https://www.twitch.tv/pokerrtv 
    chan_name="Poker TV" ;;
# 28) High Stakes Poker 
28) link=https://www.twitch.tv/highstakespoke 
     chan_name="High Stakes Poker" ;;    
# 29)  i24 News Israel
29) link=https://www.youtube.com/watch?v=tI5H8OMx6f8
   chan_name="i24 News Isreal English" ;;
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
33) link=https://www.youtube.com/watch?v=Rm_Okp_zvt4 
    chan_name="Euronews Francais" ;;                                                            
# 34) France Info
34) link=https://www.youtube.com/watch?v=SN7sncKzRq4 
    chan_name="France Info" ;;
# 35) France Inter
35) link=https://www.youtube.com/watch?v=59Rw7-8PRng 
    chan_name="France Inter" ;;
# 36) Max FM 92.9 
36) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
    chan_name="Max FM 92.9" ;;
# 37) M7 Television
37) link=http://www.dailymotion.com/video/x59xxgx_live_music 
    chan_name="M7 TV Mali" ;;
# 38) France Inter
38) link=http://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
    chan_name="France Inter" ;;
# 39) RTL Endirect
39) link=http://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
    chan_name="RTL En Direct" ;;
# 40) Direct Journal TVLandes    
40) link=http://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
chan_name="Direct Journal Tvlandes"  ;;      
# 41) CNEWS
41) link=http://www.dailymotion.com/video/x3b68jn_live-cnews_news 
chan_name="CNEWS" ;;
# 42) BMF TV
42) link=http://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
chan_name="BMF TV";;
# 43) Europe 1
43) link=http://www.dailymotion.com/video/xqjkfz_europe-1-live_news
chan_name="Europe 1" ;;
# 44) i24 News en Direct
44) link=http://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
chan_name="i24 Francais";;
# 45) France Info TV
45) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
chan_name="France Info TV" ;;
# 46) France Info Radio
46) link=http://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
chan_name="France Info Radio" ;;
# 47) La Chaine Parlementaire LCP
47) link=http://www.dailymotion.com/video/xji3qy_la-chaine-parlementaire-lcp-live-tnt_news
chan_name="LCP France";;
# 48) Public Senate France
48) link=http://www.dailymotion.com/video/xkxbzc_live-public-senat_news 
chan_name="Public Senate" ;;
# 49) Elyse.fr
49) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
chan_name="Le Direct de la Presidence de la Republique" ;;
# 50) QVC 
50) link=https://www.youtube.com/watch?v=wsjO1NFA3Sw
chan_name="QVC Francais" ;;

###### TRANSIENT
# 34) Africa News
# 34) link=https://www.youtube.com/watch?v=tUjOfmeLpHo 
#    chan_name="Africa News Francais" ;;
# 35) Afrique Media
# 35) link=https://www.youtube.com/watch?v=GpHTBs6B7Zk 
#    chan_name="Afrique Media" ;;  
# 37) Mosaik TV Francais
# 37) link=https://www.youtube.com/watch?v=JcKSOnfoDRc 
#    chan_name="Mosaik TV" ;;
# 38) TLM Lyon Metro
# 38) link=https://www.youtube.com/watch?v=aedZ5C0HcO0
#    chan_name="TLM Television Lyon Metro" ;;
# 40) RFI
# 40) link=https://www.youtube.com/watch?v=N8tHbVYKRBY 
#    chan_name="RFI Francais" ;;
###################  SPANISH  #################################
# 56) Globovision Espanol 
56) link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
chan_name="Globovision" ;;
# 57) RT Espanol
57) link=https://www.youtube.com/watch?v=OALyNX4IbBI 
    chan_name="RT Espanol" ;;
# 58) DW Espanol
58) link=https://www.youtube.com/watch?v=wBDQlzVRMgU 
    chan_name="DW Espanol" ;;
# 59) NTN24 
59) link=https://www.youtube.com/watch?v=yuvZC1Ll7lA 
    chan_name="NTN24" ;;
# 60) Canal 8 San Juan
60) link=https://www.youtube.com/watch?v=yiwJzHW123c 
    chan_name="Canal 8 San Juan" ;;
# 61) Canal 6 San Rafael
61) link=https://www.youtube.com/watch?v=axnhmU97Ktg 
    chan_name="Canal 6 San Rafael" ;;
# 62) Canal Siete
62) link=https://www.youtube.com/watch?v=EUgiU4KZEPo 
    chan_name="Canal Siete" ;;
# 63) c5n Argentina
63) link=https://www.youtube.com/watch?v=YrynoTgahC4
chan_name="c5n Argentina" ;;
# 64) A24
64) link=https://www.youtube.com/watch?v=yZGc05q7ajA 
    chan_name="A24";;
# 65) Televisa Guadalajara
65) link=https://www.youtube.com/watch?v=4btUDfIjjbk 
    chan_name="Televisia Gudalajara" ;;
# 66) Televisa Veracruz
66) link=https://www.youtube.com/watch?v=xDp59IK5u64 
    chan_name="Televisia Veracruz" ;;
# 67) Televisa Mexicali
67) link=https://www.youtube.com/watch?v=HLJH3C_7nnk 
    chan_name="Televisia Mexicali" ;;
# 68)  Televisa Hermosillo
68) link=https://www.youtube.com/watch?v=2jH6YinOabQ 
    chan_name="Televisia Hermosillo" ;;
# 69)  GalaTV Laguna
69) link=https://www.youtube.com/watch?v=6SuhteXqf90 
    chan_name="GalaTV Laguna" ;;
# 70) GalaTV Estado de México Toluca
70) link=https://www.youtube.com/watch?v=fHhS2BElUF0 
    chan_name="GalaTV Estado de Mexico Toluca" ;;
# 71) TelePacifico
71) link=https://www.youtube.com/watch?v=ZQnMKaGYu9Q 
    chan_name="TelePacifico" ;; 
# 72) Canal 8 Mar del Plata
72) link=https://www.youtube.com/watch?v=MbOpUZnOdNY  
    chan_name="Canal 8 Mar del Plata" ;; 
# 73) Sures TV Campeche 
73) link=https://www.youtube.com/watch?v=6eJPGYK2N5M 
chan_name="Sures TV Campeche";;

############## TRANSIENT
# 57) TeleSUR
# 57) link=https://www.youtube.com/watch?v=3fwfmhTYUZs 
#    chan_name="TeleSUR Espanol" ;;
# 64) HispanTV 
# 64) link=https://www.youtube.com/watch?v=kibgnmaJoAs 
#    chan_name="HispanTV" ;;
# 65) Globovision
# 65) link=https://www.youtube.com/watch?v=Lm-AmFtPlc4 
#    chan_name="Globovision" ;;
# 66) Excelsior TV
# 66) link=https://www.youtube.com/watch?v=NANvipRo_eE 
#    chan_name="Excelsior TV" ;;
# 67) Imagine Radio
# 67) link=https://www.youtube.com/watch?v=OSOXIMOxpEw 
#    chan_name="Imagine Radio" ;;
# 70) La Casacra TV 
# 70) link=https://www.youtube.com/watch?v=vEwpn57ip7w 
#    chan_name="La Casacra TV" ;;
## Canals  Vivo  de Televisia Regional 
# 71) Televisa del Bajio
# 71) link=https://www.youtube.com/watch?v=wmcA51ETCoo 
#    chan_name="Televisa del Bajio" ;;
# 72) Televisa del Golfo
# 72) link=https://www.youtube.com/watch?v=VHkRgkCKW-0
#    chan_name="Televisa del Golfo" ;;
# 74) Televisa del Noreste
# 74) link=https://www.youtube.com/watch?v=d2qjt-7KIUE 
#    chan_name="Televisia del Noreste" ;;
# 76) GalaTV Morelos
# 76) link=https://www.youtube.com/watch?v=TDrgg9VJOq4 
#    chan_name="GalaTV Morelos" ;;
# 77) Televisa Puebla
# 77) link=https://www.youtube.com/watch?v=vGQReDz9-iQ 
#    chan_name="Televisia Puebla" ;;
# 78) GalaTV Queretaro
# 78) link=https://www.youtube.com/watch?v=AIPhfPslF0E 
#    chan_name="GalaTV Queretaro" ;;
# 80) GalaTV Acapulco
# 80) link=https://www.youtube.com/watch?v=6MeD88060x8 
#    chan_name="GalaTV Acapulco" ;;
# 81) GalaTV Zacatecas
# 81) link=https://www.youtube.com/watch?v=r1arJCFwz3o 
#    chan_name="GalaTV Zacatecas" ;; 
# 84) 1070 Noticias
# 84) link=https://www.youtube.com/watch?v=bfe9RLT9SBo 
#    chan_name="1070 Noticias" ;;   
# 87) Cinevision Canal 19
# 87) link=https://www.youtube.com/watch?v=aBLbwbSycLU  
#    chan_name="Cinevision Canal 19" ;; 
# 89) Tu Canal
# 89) link=https://www.youtube.com/watch?v=NEF_sHYhio0 
#    chan_name="Tu Canal" ;;
# 90) VPI TV 
# 90) link=https://www.youtube.com/watch?v=5GyfFhBnbhk 
#    chan_name="VPI TV" ;;
# 91) 100% Noticias Nicaragua
# 91) link=https://www.youtube.com/watch?v=sFQqcQJhJnQ 
#    chan_name="100% Noticias Nicaragua" ;; 
# 92) El Capitolo Venezulana
# 92) link=https://www.youtube.com/watch?v=tjYvi3tSbr0 
#    chan_name="El Capitolo Venezulana" ;;    
    
################ CHINESE MANDARIN CANTONESE  ####################
# 94) CCTV 4 Chinese
94) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw 
    chan_name="CCTV 4 China" ;;
#  95)  ON TV News Hong Kong 
95) link=https://www.youtube.com/watch?v=WrkVwCYvRPk
chan_name="ON TV News Hong Kong" ;;
# 96)  ON TV Sports Hong Kong 
96) link=https://www.youtube.com/watch?v=A7I0qYo2oLc
chan_name="ON TV Sports Hong Kong" ;;
############## TAIWAN TAIWANESE ##############################
# 97) EBC 51 News Taiwan
97) link=https://www.youtube.com/watch?v=yzE3bRtXIrI 
    chan_name="EBC 51 News Taiwan" ;;
# 98) EBC Finance Taiwan
98) link=https://www.youtube.com/watch?v=CUKpfr9tWBc
chan_name="EBC Finance News Taiwan" ;;
#  99) Tzu Chi Da Ai Taiwan 
99) link=https://www.youtube.com/watch?v=ESKjSwcswBM
chan_name="Tzu Chi Da Ai Taiwan" ;; 
# 100) FTV Taiwan
100) link=https://www.youtube.com/watch?v=XxJKnDLYZz4
chan_name="FTV Taiwan Live";;
# 101) TTV News Taiwan
101) link=https://www.youtube.com/watch?v=yk2CUjbyyQY
chan_name="TTV News Taiwan"  ;;
# 102) CTV Taiwan
102) link=https://www.youtube.com/watch?v=b3QIfgD--_E
chan_name="CTV Taiwan" ;;
# 103) CTS World News HD Taiwan
103) link=https://www.youtube.com/watch?v=1I6fxNSmQh4
chan_name="CTS World News HD" ;;
# 104) SET News Taiwan
104) link=https://www.youtube.com/watch?v=TgGyBF-7w8M
chan_name="SET News Taiwan" ;;
# 105) CTI Taiwan
105) link=https://www.youtube.com/watch?v=LKjJ0zNCBSs
chan_name="CTI Taiwan" ;;  
# 106) NeXT TV Taiwan
106) link=https://www.youtube.com/watch?v=KoZGabXeV74
chan_name="Next TV Taiwan" ;;
# 107) Chinese Kareokee 
107) link=https://www.youtube.com/watch?v=XA8-cqewOUs
chan_name="Chinese Kareoke" ;; 
################ KOREAN  ###############################
#  108) KBS World 24 News
108) link=https://www.youtube.com/watch?v=9nMuTuy5SIs 
     chan_name="KBS World 24 News" ;;
# 109) KBS World English Sub
109) link=https://www.youtube.com/watch?v=i-4Py1tCKMo 
     chan_name="KBS 24 World English Sub" ;;
# 110) KBS World TV
110) link=https://www.youtube.com/watch?v=PUl4hiEOXSo
chan_name="KBS World TV" ;;
# 111) YTN 24 Korea
111) link=https://www.youtube.com/watch?v=YwbpBIabRmo
chan_name="YTN 27 Korea" ;;  
################ JAPANESE  ####################
#  112) QVC JAPAN SHOPPING CHANNEL
112) link=https://www.youtube.com/watch?v=wMo3F5IouNs 
    chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 113) Sol!ve 24 Japan
113) link=https://www.youtube.com/watch?v=kfTq_A9nBM0
chan_name="Sol!ve 24 Japan";; 
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 114) SunNews 
114) link=https://www.youtube.com/watch?v=QpiEINgQa3I
chan_name="SunNews" ;; 
# 115) TV9 India Live
115) link=https://www.youtube.com/watch?v=aFU2xAWkRJ8 
chan_name="TV9 Live India";;    
# 116) Rajya Sabha TV
116) link=https://www.youtube.com/watch?v=oPpYUy__VaQ
chan_name="Rajya Sabha" ;;
# 117) Sandesh News
117) link=https://www.youtube.com/watch?v=qsl7g3hEx2U 
chan_name="Sandesh News" ;; 
# 118) Tv9 Marathi
118) link=https://www.youtube.com/watch?v=BremLDr3lgA 
     chan_name="Tv9 Marathi" ;; 
# 119) Bol TV Pakistan
119) link=https://www.youtube.com/watch?v=5U6PbikM86U
chan_name="Bol News" ;;
# 120) 92 News Pakistan
120) link=https://www.youtube.com/watch?v=jlJwIhmGONo
chan_name="92 News Pakistan";; 
# 121) News 7 Tamil
121) link=https://www.youtube.com/watch?v=KMReyf7MEmk
chan_name="News 7 Tamil" ;;
# 122) T News Telegu
122) link=https://www.youtube.com/watch?v=p-a-Q2JCUZ4
chan_name="T News Telegu" ;;
## 123) 24 News Pakistan HD
123) link=https://www.youtube.com/watch?v=sKTPacY9Aj4
chan_name="24 News Pakistan HD" ;;  
# 124) News 18 India
124) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 
     chan_name="News 18 India" ;;
# 125) Aaj Tak 
125) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q 
     chan_name="Aaj Tak" ;;
# 126) TV9 Telugu
126) link=https://www.youtube.com/watch?v=QWsESTCbIf0 
     chan_name="TV9 Telugu" ;;
# 127) NTV Telugu
127) link=https://www.youtube.com/watch?v=T953eK1GXbA 
     chan_name="NTV Telugu" ;;
# 128) ABN Telugu
128) link=https://www.youtube.com/watch?v=QzQnFY6CioA 
     chan_name="ABN Telugu" ;;
# 129) Vanitha TV 
129) link=https://www.youtube.com/watch?v=ji7H-z506SA 
     chan_name="Vanitha TV" ;;
# 130) HMT Telugu
130) link=https://www.youtube.com/watch?v=qdi47ihDFCk 
     chan_name="HMT Telugu" ;;
# 131) TV5 News 
131) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg 
     chan_name="TV5 News" ;;

# 132
# 134
# 135
# 136 
# 137
# 138
# 139
# 140
# 141
# 142
# 143
# 144
# 145
# 146
# 147
# 148
#### TRANSIENT ################
#  SAMAA TV
# 144) link=https://www.youtube.com/watch?v=qH2kZjv1CYM 
#      chan_name="SAMAA TV" ;;    
# 142) Survana News
# 142) link=https://www.youtube.com/watch?v=xJqm4gxr7gs 
#     chan_name="Survana News" ;;
# 140) ATN News Bangladesh
# 140) link=https://www.youtube.com/watch?v=F_oSYwhc9Rs
# chan_name="ATN News Bangladesh";;     
# No 1 News Telugu
# 137) link=https://www.youtube.com/watch?v=JMUtgBPIliM
# chan_name="No 1 News" ;;
# i News Telugu
# 136) link=https://www.youtube.com/watch?v=3xe2HCGvikI
# chan_name="i News Telugu" ;; 
#  APN News India
# 135) link=https://www.youtube.com/watch?v=O5WcuOYIaOQ
# chan_name="APN News" ;;
#  4tv News India
# 134) link=https://www.youtube.com/watch?v=GhRxbhMnyHU
# chan_name="4tv News" ;;    
#  Samaya News
# 133) link=https://www.youtube.com/watch?v=MmvnNOOt92Q
# chan_name="Samaya News" ;;     
# Media One News
# 131) link=https://www.youtube.com/watch?v=Fpp7C-XH2ac
# chan_name="Media One";;
# Tamil Live News
# 130) link=https://www.youtube.com/watch?v=47oy2A47Jjs
# chan_name="Tamil Live News";;
## TOLO NEWS AFGHANISTAN
# 127) link=https://www.youtube.com/watch?v=-CONWzwDqTA
# chan_name="TOLO NEWS";; 
## Dawn News PAKISTAN
# 126) link=https://www.youtube.com/watch?v=f0ZIpFKjpKU
# chan_name="Dawn News" ;;
## Telugu News
# 124) link=https://www.youtube.com/watch?v=kg48DXa4bKE 
#     chan_name="Telugu News" ;;  
## DD News
# 123) link=https://www.youtube.com/watch?v=23EG0wfvcYU
# chan_name="DD News" ;; 
## Public TV India
# 121) link=https://www.youtube.com/watch?v=dccFagg0tDU
# chan_name="Public TV India" ;;
## REPORTER LIVE
# 118) link=https://www.youtube.com/watch?v=WpyZ7xjx3hk 
#chan_name="Reporter Live" ;;
# NTV Bangladesh
# 116) link=https://www.youtube.com/watch?v=5pz4cXHd6TI 
#     chan_name="NTV Bangladesh" ;;
# AsiaNet News
# 115) link=https://www.youtube.com/watch?v=YYqeFCJRBUg  
#     chan_name="AsiaNet News" ;;     
# 10TV Telugu
# 114) link=https://www.youtube.com/watch?v=UpNJQg567UU 
#     chan_name="10TV Telugu" ;;     
     
################## ARABIC  ##########################################
# 149) EuroNews Arabic
149) link=https://www.youtube.com/watch?v=y6J0wW2If6Q
chan_name="EuroNews Arabic" ;;
# 150) RT Arabic 
150) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 
     chan_name="RT Arabic" ;;
# 151) ON E Live 
151) link=https://www.youtube.com/watch?v=vCKAnvpT79Y 
     chan_name="ON E";;
# 152)  ON E Sports
152) link=https://www.youtube.com/watch?v=PaEPidxFLhA 
     chan_name="ON E Sports" ;; 
# 153) ON Live
153) link=https://www.youtube.com/watch?v=9I8WtuLBYqI
chan_name="ON Live" ;;
# 154) Al Jazeera Arabic
154) link=https://www.youtube.com/watch?v=elqcDJ3TXUs 
     chan_name="Al Jazeera Arabic" ;;
# 155) France 24 Arabic
155) link=https://www.youtube.com/watch?v=UYi0sgVm5dM 
     chan_name="France 24 Arabic" ;;
# 156) BBC Arabic
156) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 
     chan_name="BBC Arabic" ;;
# 157) CBC Egypt Sofra Arabic
157) link=https://www.youtube.com/watch?v=LJzqXK3hB3I
chan_name="CBC Egypt Sofra" ;;
# 158) Al Arabiya
158) link=https://www.youtube.com/watch?v=1QFrtsu1JJg 
     chan_name="Al Arabiya" ;;
# 159) Al Mayadeen
159) link=https://www.youtube.com/watch?v=UBzkC6F2Lrc 
     chan_name="Al Mayadeen" ;;   
# 160) Syrian Satellite
160) link=https://www.youtube.com/watch?v=YfH6U8CNp58 
     chan_name="Syrian Satellite" ;; 
# 161) ORTAS Syrian Satellite
161) link=https://www.youtube.com/watch?v=BsJ7iZ7bRxA
chan_name="ORTAS Syria" ;;
# 162) Bedya TV Arabic
162) link=https://www.youtube.com/watch?v=8PMpmZcypt8
chan_name="Bedya TV Arabic" ;;
# 163) Belques TV Arabic
163) link=https://www.youtube.com/watch?v=Wp5lXYwQA5U
chan_name="Belques TV Arabic" ;;
# 164) Saudi TV Blue
164) link=https://www.youtube.com/watch?v=cCe0Hzqjhso
chan_name="Saudi Blue" ;;  
# 165) Saudi TV Purple
165) link=https://www.youtube.com/watch?v=2fji1-aeZcE
chan_name="Saudi Purple" ;;
# 166) Saudi Kids
166) link=https://www.youtube.com/watch?v=uUPqVDf_0II
chan_name="Saudi Kids" ;;

############### TRANSIENT
# 168) Saudi Red
# 168) link=https://www.youtube.com/watch?v=WkDnIzXDlNk
# chan_name="Saudi Red" ;;
# 173) Saudi TV Green 
# 173) link=https://www.youtube.com/watch?v=Bjk3yH_t1nI
# chan_name="Saudi Green" ;;
# 176) Saudi TV Orange
# 176) link=https://www.youtube.com/watch?v=UbPHJlFYvNc
# chan_name="Saudi Orange" ;;
# 177) Saudi Sliver Educational
# 177) link=https://www.youtube.com/watch?v=-WYI832cx5Q
# chan_name="Saudi Silver" ;;
# 178) Saudi TV Gold  Mecca Kabba
# 178) link=https://www.youtube.com/watch?v=Nxzeb_5LjtU
# chan_name="Saudi Gold" ;;
# 154) Makkha Live (Mecca Kaaba)
# 154) link=https://www.youtube.com/watch?v=0b1IMR2H_7s
# chan_name="Mecca Kaaba Live" ;;
# 152) SKY Arabic
# 152) link=https://www.youtube.com/watch?v=y8lsgZYxjGM 
#     chan_name="SKY Arabic" ;;
# 161) CBC Egypt Arabic Live
# 161) link=https://www.youtube.com/watch?v=FFx5r-U9ryA 
#      chan_name="CBC Egypt Arabic" ;;
# 162) CBC Egypt Arabic Drama 
# 162) link=https://www.youtube.com/watch?v=Gfqcb0grf1w
# chan_name="CBC Egypt Arabic Drama" ;;
# 164) eXtra News Egypt Arabic
# 164) link=https://www.youtube.com/watch?v=PX_Wp78KtWE
# chan_name="eXtra News Egypt" ;;    

############### RUSSIAN ################################
# 179) Россия 24
179) link=https://www.youtube.com/watch?v=i_Q8N6ZSDXQ 
     chan_name="POCCNR 24 Russia" ;;
# 180) Ukraine Channel 5 
180) link=https://www.youtube.com/watch?v=Rr2mpYY09dA
chan_name="Ukraine 5" ;;
# 181) Ukraine 112
181) link=https://www.youtube.com/watch?v=vGNm5IFXm8U
chan_name="Ukraine 112" ;;
# 182) News 1 Ukraine
182) link=https://www.youtube.com/watch?v=yA30K3z5PSw
chan_name="News 1 Ukraine" ;;
# 183) Еспресо Ukraine
183) link=https://www.youtube.com/watch?v=4xTbVaADR_8
chan_name="Ecnpeco Ukraine" ;;
# 184) Thromadske Ukraine
184) link=https://www.youtube.com/watch?v=FKVBsbuVt-I
chan_name="Thromadske Ukraine" ;;
# 185) UA TV Ukraine
185) link=https://www.youtube.com/watch?v=y6JaMn8bT-E
chan_name="UA TV Ukraine" ;;
################### GREEK ######################################
## 186) Action 24 Greece 
186) link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
chan_name="Action 24 Greek" ;;
## 187) Ionian TV
187) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
chan_name="Ionian TV Greek" ;;
## 188) Star Lima
188) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
chan_name="Star Lima Greek" ;;
################### TURKEY  ########################

# 189)
## 189) TRT Haber Turkey
# 189) link=https://www.youtube.com/watch?v=uN5fOYfl63s
#chan_name="TRT Haber Turkey";;
# 190) Star TV  Turkish
190) link=https://www.youtube.com/watch?v=jWP3ntl64I4
chan_name="Star TV Turkish" ;;   
## 191) Parovi 1 TV
191) link=https://www.youtube.com/watch?v=DmRzk9MtRAc
chan_name="Parovi 1";;
################ AFRICAN #################################
# 192) ADOM TV 
192) link=https://www.youtube.com/watch?v=g5McawVm8Q4 
     chan_name="ADOM TV" ;;
# 193)
# 193) Bukedde TV
# 193) link=https://www.youtube.com/watch?v=qu6yFRENQ1U
#chan_name="Bukedde TV" ;;      
###############    RESTRICTED TO EUROPE     ###########################
# 194) SKY NEWS
194) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
    chan_name="SKY NEWS" ;; 
# 195) DW English
195) link=https://www.youtube.com/watch?v=gNosnzCaS4I 
# link=http://www.dailymotion.com/video/xzgfm5_dw-live-stream_news
    chan_name="DW English" ;; 
# 196)  EuroNews Deutche
196) link=https://www.youtube.com/watch?v=dYJ0kTqeu08 
    chan_name="EuroNews Deutche" ;;
################# ENTERTAINMENT  ##################################
# 197)
# 198) Talking Tom and Friends
198) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc 
     chan_name="Talking Tom and Friends" ;;
# 199)
# 200)
# 201)
################# TAGALOG FILIPINO #############################       
# 202) 
# 203) DZMM ABS-CBN Philippeans Radio
203) link=https://www.youtube.com/watch?v=YTjNZrs5vvU
chan_name="DZMM Philippeans" ;;
###############    SPACE       ######################### 
# 205
# 204
# 206) NASA ISS REPLAY
206) link=https://www.youtube.com/watch?v=3Ruruhg6q1w
chan_name="NASA ISS Replay" ;;
# 207) NASA ISS 1
207) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
    chan_name="NASA ISS 1" ;;  
# 208) NASA ISS 2
208) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
    chan_name="NASA ISS 2" ;;
# 209) Okeanos Ocean Explorer Cam 1
209) link=https://www.youtube.com/watch?v=OobG-QkPODY
# link=https://www.youtube.com/watch?v=WvgEX_TuF2Y
chan_name="Okeanos Ocean Explorer Cam 1" ;;      
# 210) Okeanos Ocean Explorer Cam 2
210) link=https://www.youtube.com/watch?v=Ny7ktdZBZ7c
chan_name="Okeanos Ocean Explorer Cam 2" ;;  
# 211) Okeanos Ocean Explorer Cam 3
211) link=https://www.youtube.com/watch?v=VDGpFiBhagU
chan_name="Okeanos Ocean Explorer Cam 3" ;;              
################## LOCATIONS #############################    
# 212) Venice Italy Bridge Cam Live
212) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
     chan_name="Venice Italy Bridge Cam" ;;
# 213) Venice Italy Port Cam Live
213) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
     chan_name="Venice Italy Port Cam" ;;
# 214) Jackson Hole Intersection
214) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
     chan_name="Jackson Hole Intersection" ;;
# 215) Jackson Hole Town Square
215) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
     chan_name="Jackson Hole Town Square" ;;
# 216) Jackson Hole Rustic Inn
216) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
     chan_name="Jackson Hole Rustic Inn" ;;
# 217) Verona Italy
217) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
     chan_name="Verona Italy" ;;
# 218) Soggy Dollar Bar
218) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
     chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  219) Amsterdam Netherlands
219) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
     chan_name="Amsterdam Netherlands" ;;
# 220) Shibua Japan Community Crosswalk 
220) link=https://www.youtube.com/watch?v=_9pavMzUY-c 
    chan_name="Shibua Japan Crosswalk" ;;
# 221) RSBN Live
221) link=https://www.youtube.com/watch?v=xEQEM7X7J4E 
    chan_name="RSBN Right Side Broadcasting News" ;;
# 222) Akiba Japan Live
222) link=https://www.youtube.com/watch?v=Yi_tX0C3yEs
chan_name="Akiba Live" ;;
# 223) Yahoo Weather Japan
223) link=https://www.youtube.com/watch?v=QbQREKdxGhM
chan_name="Yahoo Japan Bridge" ;;
# 224) Yahoo Weather Steamy Mountains
224)  link=https://www.youtube.com/watch?v=U83waNjv2bM
chan_name="Yahoo Japan Steamy Mountain" ;;
# 225) Tokyo Weather Sky Cam
225) link=https://www.youtube.com/watch?v=Dx8Ba89UNis
chan_name="Tokyo Weather Sky Cam" ;;
# 226) Shizuoka Bridge Japan
226) link=https://www.youtube.com/watch?v=cdJthnaGO6c
chan_name="Shizuoka Bridge Japan" ;;
# 227) Yokohama Port Japan
227) link=https://www.youtube.com/watch?v=vE58KB1AoiA
chan_name="Yokohama Port Japan" ;;
# 228) Hokkido Weather Cams
228) link=https://www.youtube.com/watch?v=ii_JukUbJG0
chan_name="Hokkido Weather Cams" ;;     
# 229) Mount Fuji Japan
229) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
chan_name="Mount Fuji Japan" ;;       
##########################################################################
# 230) TYT 
230) link=https://www.youtube.com/watch?v=8x_PT1iNzTs 
     chan_name="TYT The Young Turks" ;;    
# 231 Euronews Russian
231) link=https://www.youtube.com/watch?v=VUU9sJ8qRAA
chan_name="Euronews Russian" ;;
# 232 Euronews Turkey
232) link=https://www.youtube.com/watch?v=L-L2QG8Z8H0
chan_name="Euronews Turkey" ;;
# 233 Euronews Italian
233) link=https://www.youtube.com/watch?v=A5BHPktwSCY
chan_name="Euronews Italian" ;;
# 234 QVC Itallian
234) link=https://www.youtube.com/watch?v=E97hsB3Qbmk
chan_name="QVC Italian" ;;
# 235 Sport in oro in dirreta
235) link=https://www.youtube.com/watch?v=Hgqx2yMjYQg
chan_name="Sport in Oro" ;;
# 236 Euronews Maygar Hugarian
236) link=https://www.youtube.com/watch?v=lyuV6zRInOo
chan_name="Euronews Maygar Hungarian" ;;


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
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback "$link" 
 
  fi

done

fi


echo "Type endstream to open a new stream."


exit "$?"

######################     END OF PROGRAM      ####################################################

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
# NTV Uganda
# 16) link=https://www.youtube.com/watch?v=CL8dsz9RRW8 
#    chan_name="NTV Uganda" ;; 
# CNBC Africa
# 12) link=https://www.youtube.com/watch?v=Ae6N5j_yUrI 
#    chan_name="CNBC Africa" ;;
# CBSN
# 24) link=https://www.youtube.com/watch?v=EgAK15lzgSA
#chan_name="CBSN" ;;
#Japan TV Live
# 97) link=https://www.youtube.com/watch?v=kDxsHqzwFdE
# chan_name="Japan TV Live" ;;
# 25) BBC World News
# 25) link=https://www.youtube.com/watch?v=qAEQGieNVYY
#chan_name="BBC World News" ;;
# 26) RT English
# 26) link=https://www.youtube.com/watch?v=uTmcDQGad1E
# chan_name="RT English" ;;
# KTN Kenya English
# 15) link=https://www.youtube.com/watch?v=olLOAay5VNw 
#    chan_name="KTN Kenya English" ;;
# 22) KTN Kenya
# 22) link=https://www.youtube.com/watch?v=ckmfiK0XpNU
# chan_name="KTN Kenya" ;;
