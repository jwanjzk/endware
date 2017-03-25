#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.19
# Revision Date: March 19, 2017
#
# Change Log:  - grab cookie with curl + inifinite repeat for filmon.tv channels
#              - Start in fullscreen mode
#              - grab transient channels by channel name 
#              - Removed transient streams added some home shopping channels
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
version="0.19"
rev_date="25/03/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookie.tmp"
use_cookies=no

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   =================================================================================="
   echo "||      ENGLISH       ||      FRANCAIS        ||         ESPANOL        ||        INDIAN         ||      ARABIC         ||          OTHER          ||       ULTRA      ||"
   echo "============================================================================================================================================================================"
   echo "1) France 24 English   41) France 24 Francais   80) La Casacra TV          119) SunNews         159) EuroNews Arabic   198) Action 24 Greek      238) Tokyo Japan "    
   echo "2) Al Jazeera English  42) France Info TV       81) 100%Noticias Nicaragua 120) TV 9 News       160) RT Arabic         199) Ionian Greek         239) Shizuoka Japan " 
   echo "3) TRT World Istanbul  43) France 24 Francais   82) Televisia del Golfo    121) Rajya Sabha TV  161) ON E Arabic       200) Star Lima Greek      240) Yokohama Japan"  
   echo "4) i24 News Israel     44) Euronews Francais    83) Televisa Veracruz      122) TV9 Gujarat     162) ON E Sport        201) Parovi TV Serbian    241) Hokkido Japan "             
   echo "5) NEWSMAX             45) France Info          84) Televisia Matamoros    123) Tv9 Marathi     163) ON Live           202) TRT Haber Turkey     242) Mt Fuji Japan"  
   echo "6) ABC Australia       46) France Inter         85) Televisia Zacatecas    124) Bol TV Pakistan 164) Al Jazeera        203) NTV Canli            243) ---------- "  
   echo "7) CGTN English        47) Max FM 92.9          86) Televisia Puebla       125) 92 News Pakistan165) France 24 Arabic  204) Haber Turk TV        244) ---------- "
   echo "8) Africa News         48) M7 TV Mali           87) Televisia Acapulco     126) News 7 Tamil    166) BBC Arabic        205) Star TV Turkey       245) ---------- "
   echo "9) BBC News            49) France Inter         88) Televisia Cuernavaca   127) T News Telegu   167) Al Arabiya        206) Adom TV              246) ---------- "
   echo "10) RT English         50) RTL En Direct        89) Televisia Leon         128) 24 News Pakistan168) Al Mayadeen       207) Bukkede TV           247) Euronews Russian "
   echo "11) Press TV Iran      51) Journal TVLandes     90) Televisia Queretaro    129) News 18 India   169) Syrian Satellite  208) SKY NEWS Britain     248) Euronews Turkish "
   echo "12) DW English         52) CNEWS                91) Televisia Gudalajera   130) Aaj Tak         170) ORTAS Syria       209) DW English           249) Euronews Italian "
   echo "13) Bloomberg          53) BMF TV               92) Televisa Mexicali      131) TV9 Live        171) Bedya TV Arabic   210) Euronews Deutche     250) QVC Italian "
   echo "14) i24 News Israel    54) Europe 1             93) Televisa Toluca        132) NTV Telugu      172) Belquees Arabic   211) Talking Tom          251) Euronews English"
   echo "15) Saudi 2 English    55) i24 France           94) Televisa Hermosillo    133) ABN Telugu      173) Saudi Blue News   212) DZMM Philippeans     252) Euronews Maygar "  
   echo "16) Channels 24 Nigeria56) France Info TV       95) Televisa Toreon        134) Vanitha TV      174) Saudi Purple      213) DZRH Philippeans     253) ---------- "
   echo "17) India Today        57) France Info Radio    96) TeleSur Venezuela      135) HMT             175) Saudi Green       214) DZMM Philippeans     254) ---------"
   echo "18) CVR English        58) LCP FRANCE           97) ------------           136) TV5             176) Saudi Gold        215) --------------       255) Shirdi Sai"	
   echo "19) News 9 Bangalor    59) Public Senate        98) ------------           137) Channel 24      177) Saudi Silver      216) --------------       256) ETV Andhra Pradesh "
   echo "20) Newsy              60) Africa News French   =======ASIAN LANGUAGE===== 138) SAMA TV         178) Saudi Orange      217) --------------       257) News 7 Tamil "  
   echo "21) CNN                61) RFI Francais         99) CCTV 4 China           139) Survana News    179) Saudi Red         218) ---------------      258) News 18 Tamilnadu"
   echo "22) MSNBC              62) Mosaik TV            100) ON TV News Hong Kong  140) ATN Bangladesh  180) DMC Live          219) ---------------      259) Polimer TV "       
   echo "23) FOX NEWS           63) Afrique Media        101) ON TV Sports Hong Kong141) No 1 News       181) SKY Arabic        220) NASA ISS Replay      260) Jaya Plus"  
   echo "24) DVIDS              ====SPANISH LANGUAGE===  102) EBC 51 Taiwan         142) i News          182) CBC Egypt Drama   221) NASA ISS 1           261) TV Sendado Brazil  "
   echo "25) NASA TV Education  64)Globovision Venezuela 103) EBC Finance Taiwan    143) APN News        183) eXtra News Egypt  222) NASA ISS 2           262) TV Camara Brazil "  
   echo "26) NASA TV Media      65) RT Espanol           104) Tzu Chi Da Ai Taiwan  144) 4tv News        184) CBC Egypt Sofra   223) Okeanos Cam 1        263) STF Brazil  "
   echo "27) Arirang TV         66) DW Espanol           105) FTV Live Taiwan       145) Media One       185) ------------      224) Okeanos Cam 2        264) -------  "
   echo "28) TWiT               67) NTN24                106) TTV Taiwan            146) Tamil Live      186) ------------      225) Okeanos Cam 3        265) -------  "
   echo "29) TWiT Twitch        68) Canal 8 San Juan     107) CTV Taiwan            147) TOLO NEWS       187) ------------      226) Venice Italy Bridge  266) -------  "
   echo "30) High Stakes Poker  69) Canal 6 San Rafael   108) CTS World News Taiwan 148) Dawn News       188) ------------      227) Venice Italy Port    267) -------  "    
   echo "31) Amazing Facts      70) Canal Siete          109) SET Taiwan            149) DD News         189) ------------      228) Jackson Hole XSec    268) -------  "
   echo "32) Its Supernatural   71) c5n Argentina        110) CTI Taiwan            150) Public TV India =======RUSSIAN=======  229) Jackson Hole Square  269) -------  "
   echo "33) Sheppards Chapel   72) A24 Argentina        111) NEXT TV Taiwan        151) REPORTER LIVE   190) POCCNR 24 Russia  230) Jackson Hole Rustic  270) RSBN Feed 1 " 
   echo "34) IHOP               73) TelePacifico         112) Chinese Kareoke       152) NTV Bangladesh  191) Ukraine 5         231) Verona Italy         271) RSBN Feed 2 "  
   echo "35) HSN                74) Canal 8 Mar Plata    113) KBS World 24 Live     153) AsiaNet News    192) Ukraine 112       232) Soggy Dollar BVI     272) ----------"
   echo "36) HSN 2              75) HispanTV             114) KBS World English     154) 10TV Telugu     193) News 1 Ukraine    233) Amsterdam Netherlands273) Infowars "
   echo "37) QVC English        76)Globovision Venezuela 115) KBS World TV          155) ABN Telegu      194) Ecnpeco Ukraine   234) SHIBUYA JAPAN        274) Poker TV  "
   echo "38) The Young Turks    77) Tu Canal Panama      116) YTN 27 Korea          156) TV 5 News       195) Thromadske Ukraine235) Akiba Japan          275) ----------  "	
   echo "39) -----------        78) Excelsior TV         117) QVC JAPAN             157) V6 News         196) UA TV Ukraine     236) Bridge Japan         276) La Republic  "
   echo "40) ------------       79) Cinevision Canal 19  118) SoL!ve 24 Japan       158) Kalaignar TV    197) RTR Planeta       237) Steamy Mount Japan   277) QVC Francais "
   echo "========================================================================================================================================================================"
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
3) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="TRT World";;   
# 4) i24 News Israel
4) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/i24News/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="i24 News Isreal English" ;;
# 5) NEWSMAX
5) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
   chan_name="NEWSMAX";;
# 6) ABC News Australia 
6) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
     chan_name="ABC News Australia" ;;
# 7)  CGTN English
7) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="CGTN English" ;;
# 8) Africa News Live
8) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
   chan_name="Africa News English";;
# 9) BBC News
9) link="https://www.filmon.com/tv/bbc-news"
use_cookies=yes
chan_name="BBC News" ;;
# 10) RT English
10) link="https://www.filmon.com/tv/russia-today-2"
use_cookies=yes
chan_name="RT English" ;;
# 11) Press TV Iran
11) link=https://www.filmon.com/tv/press-tv
use_cookies="yes"
chan_name="Press TV Iran" ;; 
# 12) DW English
12) link=https://www.filmon.com/tv/dw-english
use_cookies=yes
chan_name="DW English" ;;
# 13) Bloomberg
13) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
   chan_name="Bloomberg";;     
# 14) i24 News Israel 
14) link=https://www.dailymotion.com/video/x29atae
chan_name="i24 News Israel" ;;
# 15) Saudi 2 TV
15) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Saudi 2 English" ;;
# 16) Channels 24 Nigeria
16) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"    
    chan_name="Channels 24 Nigeria";;   
# 17) India TODAY
17) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="India TODAY English" ;;   
# 18) CVR English India
18) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="CVR English" ;;   
# 19) News 9 Bangalor India
19) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/news9tv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="News 9 Bangalor English" ;; 
# 20)  Newsy
20) link="https://www.filmon.com/tv/newsy"
use_cookies=yes
chan_name="Newsy" ;; 
# 21) CNN Live
21) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCBvT9k2vaXrQ-AVxFJK5FCQ/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="CNN Live" ;;    
# 22) MSNBC
22)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCDY1X1WKNhL_Z-lOfCy5C4A/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="MSNBC" ;;    
# 23) FOX NEWS
23) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCNEpfZ_b1c3fQjX_Jiy5rcw/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="FOX NEWS" ;;   
# 24) DVID Department of Defense Videos
24) link="https://www.filmon.com/tv/dvids-tv"
use_cookies=yes
chan_name="DVIDS" ;;
# 25)   NASA TV Public Education
25) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"
    chan_name="NASA TV Education" ;; 
# 26)   NASA TV Media
26) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
    chan_name="NASA TV Media" ;; 
# 27)  Arirang TV
27) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/arirang/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="Arirang TV (Korean Pride)" ;;
#  28) TWiT
28) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/twit/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
    chan_name="TWiT" ;;
# 29) TWiT on Twitch
29) link=https://www.twitch.tv/twit 
    chan_name="TWiT on Twitch" ;;      
# 30) High Stakes Poker 
30) link=https://www.twitch.tv/highstakespoke 
     chan_name="High Stakes Poker" ;;      
# 31) Amazing Facts TV (Christian)
31) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Amzaing Facts TV (Christian)" ;;
# 32) It's Supernatural! Network (Christian)
32) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="It's Supernatural! (Christian)" ;;
# 33) Sheppard's Chapel (Christian)
33) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Sheppard's Channel" ;;
# 34) International House of Prayer (IHOP) (Christian)
34) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="International House of Prayer (Christian)" ;;
# 35) HSN
35)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="Home Shopping Network HSN" ;;
# 36) HSN 2
36) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="HSN2" ;;
# 37) QVC 
37) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="QVC English" ;;
# 38)  The Young Turks
38) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheYoungTurks/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="TYT The Young Turks" ;; 
# 39)
# 40)
#################    FRENCH   ###################################
# 41) France 24 
41) link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
chan_name="France 24" ;;
# 42) France Info 
42) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news 
chan_name="France Info TV" ;;
# 43) France 24 Francais
43) link=https://www.youtube.com/watch?v=vp-82gDggk4 
    chan_name="France 24 Francais" ;;
# 44) Euronews
44) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Euronews Francais" ;;                                                            
# 45) France Info
45) link=https://www.youtube.com/watch?v=SN7sncKzRq4 
    chan_name="France Info" ;;
# 46) France Inter
46) link=https://www.youtube.com/watch?v=59Rw7-8PRng 
    chan_name="France Inter" ;;
# 47) Max FM 92.9 
47) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
    chan_name="Max FM 92.9" ;;
# 48) M7 Television
48) link=http://www.dailymotion.com/video/x59xxgx_live_music 
    chan_name="M7 TV Mali" ;;
# 49) France Inter
49) link=http://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
    chan_name="France Inter" ;;
# 50) RTL Endirect
50) link=http://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
    chan_name="RTL En Direct" ;;
# 51) Direct Journal TVLandes    
51) link=http://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
chan_name="Direct Journal Tvlandes"  ;;      
# 52) CNEWS
52) link=http://www.dailymotion.com/video/x3b68jn_live-cnews_news 
chan_name="CNEWS" ;;
# 53) BMF TV
53) link=http://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
chan_name="BMF TV";;
# 54) Europe 1
54) link=http://www.dailymotion.com/video/xqjkfz_europe-1-live_news
chan_name="Europe 1" ;;
# 55) i24 News en Direct
55) link=http://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
chan_name="i24 Francais";;
# 56) France Info TV
56) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
chan_name="France Info TV" ;;
# 57) France Info Radio
57) link=http://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
chan_name="France Info Radio" ;;
# 58) La Chaine Parlementaire LCP
58) link=http://www.dailymotion.com/video/xji3qy_la-chaine-parlementaire-lcp-live-tnt_news
chan_name="LCP France";;
# 59) Public Senate France
59) link=http://www.dailymotion.com/video/xkxbzc_live-public-senat_news 
chan_name="Public Senate" ;;
# 60) Africa News
60) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Africa News Francais" ;;
# 61) RFI
61) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="RFI Francais" ;;
# 62) Mosaik TV Francais
62) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="Mosaik TV" ;;
# 63) Afrique Media
63) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCOBMhI7TtRLTAGpcTjNvYCw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Afrique Media" ;;  
###### TRANSIENT
# 67) TLM Lyon Metro
# 67) link=https://www.youtube.com/watch?v=aedZ5C0HcO0
#     chan_name="TLM Television Lyon Metro" ;;

###################  SPANISH  #################################
# 64) Globovision Venezeula
64) link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
chan_name="Globovision Venezeula" ;;
# 65) RT Espanol
65) link=https://www.youtube.com/watch?v=OALyNX4IbBI 
    chan_name="RT Espanol" ;;
# 66) DW Espanol
66) link=https://www.youtube.com/watch?v=wBDQlzVRMgU 
    chan_name="DW Espanol" ;;
# 67) NTN24 Venezuela
67) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="NTN24 Venezuela" ;;
# 68) Canal 8 San Juan Argentina
68) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="Canal 8 San Juan Argentina" ;;
# 69) Canal 6 San Rafael Argentina
69) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="Canal 6 San Rafael Argentina" ;;
# 70) Canal 7 Mendoza Argentina
70) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="Canal 7 Mendoza Argentina" ;;
# 71) c5n Argentina
71) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="c5n Argentina" ;;
# 72) A24 Argentina
72) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="A24 Argentina";;
# 73) TelePacifico Colombia
73) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TelepacificoCanal/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="TelePacifico Colombia" ;; 
# 74) Canal 8 Mar del Plata
74) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"    
    chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 75) Hispan TV
75) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/hispantv/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="HispanTV" ;;
# 76) Globovision Venezeula
76) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="Globovision Venezeula" ;;
# 77) Tu Canal Panama
77) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="Tu Canal Panama" ;;
# 78) Excelsior TV Mexico
78) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
   chan_name="Excelsior TV Mexico" ;;
# 79) Cinevision Canal 19
79) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCKtx0aYvzIdoKlIfTyydx0g/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="Cinevision Canal 19" ;; 
# 80) La Casacra TV 
80) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/lacascaravod/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="La Casacra TV" ;;
# 81) 100% Noticias Nicaragua 
81) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/canal15nicaragua100/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="100% Noticias Nicaragua" ;;   

########### TELEVISIA REGIONALES MEXICO
# 82) Televisa del Golfo
82)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Televisa del Golfo" ;; 
# 83) Televisa Veracruz
83) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="Televisia Veracruz" ;; 
# 84) Televisa Matamoros
84)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Televisa Matamoros" ;; 
# 85) Televisa Zacatecas
85)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 7 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Televisa Zacatecas" ;; 
# 86) Televisa Puebla
86)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 9 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Televisa Puebla" ;;  
# 87) Televisa Alcapuloco
87)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 11 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Televisa Alcapulco" ;;   
# 88) Televisa Cuernavaca
88)  link=http://www.galatvmorelos.tv/video-en-vivo  
 chan_name="Televisa Cuernavaca" ;;   
# 89) Televisa Leon
89)  link=http://www.televisaleon.tv/video-en-vivo  
 chan_name="Televisa Leon" ;; 
# 90) Televisa Queretaro
90)  link=http://www.galatvqueretaro.tv/video-en-vivo  
 chan_name="Televisa Queretaro" ;; 
 # 91) Televisa Gudalajera
91)  link=http://www.televisaguadalajara.tv/video-en-vivo  
 chan_name="Televisa Gudalajera" ;; 
 # 92) Televisa Mexicali
92)  link=http://www.televisamexicali.tv/video-en-vivo  
 chan_name="Televisa Mexicali" ;;  
 # 93) Televisa Toluca
93)  link=http://www.galatvedomex.tv/video-en-vivo  
 chan_name="Televisa Toluca" ;;  
 # 94) Televisa Hermosillo
94)  link=http://www.televisahermosillo.tv/video-en-vivo  
 chan_name="Televisa Hermosillo" ;;  
# 95) Televisa Torreon
95)  link=http://www.galatvlaguna.tv/video-en-vivo  
 chan_name="Televisa Torreon" ;;  
##################
# 96) TeleSUR Venezuela
96) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
    chan_name="TeleSUR Espanol" ;;


# 90) VPI TV Venezuela
# 90) link=https://www.youtube.com/watch?v=5GyfFhBnbhk 
#    chan_name="VPI TV" ;;
# 92) El Capitolo Venezulana
# 92) link=https://www.youtube.com/watch?v=tjYvi3tSbr0 
#    chan_name="El Capitolo Venezulana" ;;    
# 67) Imagine Radio
# 67) link=https://www.youtube.com/watch?v=OSOXIMOxpEw 
#    chan_name="Imagine Radio" ;;
   
################ CHINESE MANDARIN CANTONESE  ####################
# 99) CCTV 4 Chinese
99) link=https://www.youtube.com/watch?v=Y8Wy9LXCapw 
    chan_name="CCTV 4 China" ;;
#  100)  ON TV News Hong Kong 
100) link=https://www.youtube.com/watch?v=WrkVwCYvRPk
chan_name="ON TV News Hong Kong" ;;
# 101)  ON TV Sports Hong Kong 
101) link=https://www.youtube.com/watch?v=A7I0qYo2oLc
chan_name="ON TV Sports Hong Kong" ;;
############## TAIWAN TAIWANESE ##############################
# 102) EBC 51 News Taiwan
102) link=https://www.youtube.com/watch?v=yzE3bRtXIrI 
    chan_name="EBC 51 News Taiwan" ;;
# 103) EBC Finance Taiwan
103) link=https://www.youtube.com/watch?v=CUKpfr9tWBc
chan_name="EBC Finance News Taiwan" ;;
#  104) Tzu Chi Da Ai Taiwan 
104) link=https://www.youtube.com/watch?v=ESKjSwcswBM
chan_name="Tzu Chi Da Ai Taiwan" ;; 
# 105) FTV Taiwan
105) link=https://www.youtube.com/watch?v=XxJKnDLYZz4
chan_name="FTV Taiwan Live";;
# 106) TTV News Taiwan
106) link=https://www.youtube.com/watch?v=yk2CUjbyyQY
chan_name="TTV News Taiwan"  ;;
# 107) CTV Taiwan
107) link=https://www.youtube.com/watch?v=b3QIfgD--_E
chan_name="CTV Taiwan" ;;
# 108) CTS World News HD Taiwan
108) link=https://www.youtube.com/watch?v=1I6fxNSmQh4
chan_name="CTS World News HD" ;;
# 109) SET News Taiwan
109) link=https://www.youtube.com/watch?v=TgGyBF-7w8M
chan_name="SET News Taiwan" ;;
# 110) CTI Taiwan
110) link=https://www.youtube.com/watch?v=LKjJ0zNCBSs
chan_name="CTI Taiwan" ;;  
# 111) NeXT TV Taiwan
111) link=https://www.youtube.com/watch?v=KoZGabXeV74
chan_name="Next TV Taiwan" ;;
# 112) Chinese Kareokee 
112) link=https://www.youtube.com/watch?v=XA8-cqewOUs
chan_name="Chinese Kareoke" ;; 
################ KOREAN  ###############################
#  113) KBS World 24 News
113) link=https://www.youtube.com/watch?v=9nMuTuy5SIs 
     chan_name="KBS World 24 News" ;;
# 114) KBS World English Sub
114) link=https://www.youtube.com/watch?v=i-4Py1tCKMo 
     chan_name="KBS 24 World English Sub" ;;
# 115) KBS World TV
115) link=https://www.youtube.com/watch?v=PUl4hiEOXSo
chan_name="KBS World TV" ;;
# 116) YTN 24 Korea
116) link=https://www.youtube.com/watch?v=YwbpBIabRmo
chan_name="YTN 27 Korea" ;;  
################ JAPANESE  ####################
#  117) QVC JAPAN SHOPPING CHANNEL
117) link=https://www.youtube.com/watch?v=wMo3F5IouNs 
    chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 118) Sol!ve 24 Japan
118) link=https://www.youtube.com/watch?v=kfTq_A9nBM0
chan_name="Sol!ve 24 Japan";; 
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 119) SunNews 
119) link=https://www.youtube.com/watch?v=QpiEINgQa3I
chan_name="SunNews" ;; 
# 120) TV9 India Live
120) link=https://www.youtube.com/watch?v=aFU2xAWkRJ8 
chan_name="TV9 Live India";;    
# 121) Rajya Sabha TV
121) link=https://www.youtube.com/watch?v=oPpYUy__VaQ
chan_name="Rajya Sabha" ;;
# 122) TV9 Gujarat
122) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="TV 9 Gujarat" ;; 
# 123) Tv9 Marathi
123) link=https://www.youtube.com/watch?v=BremLDr3lgA 
     chan_name="Tv9 Marathi" ;; 
# 124) Bol TV Pakistan
124) link=https://www.youtube.com/watch?v=5U6PbikM86U
chan_name="Bol News" ;;
# 125) 92 News Pakistan
125) link=https://www.youtube.com/watch?v=jlJwIhmGONo
chan_name="92 News Pakistan";; 
# 126) News 7 Tamil
126) link=https://www.youtube.com/watch?v=KMReyf7MEmk
chan_name="News 7 Tamil" ;;
# 127) T News Telegu
127) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TNews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
# link=https://www.youtube.com/watch?v=p-a-Q2JCUZ4
 chan_name="T News Telegu" ;;
## 128) 24 News Pakistan HD
128) link=https://www.youtube.com/watch?v=sKTPacY9Aj4
chan_name="24 News Pakistan HD" ;;  
# 129) News 18 India
129) link=https://www.youtube.com/watch?v=gFMaxP6cHh8 
     chan_name="News 18 India" ;;
# 130) Aaj Tak 
130) link=https://www.youtube.com/watch?v=oMETNh3Tr0Q 
     chan_name="Aaj Tak" ;;
# 131) TV9 Telugu Live
131) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9live/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="TV9 Live" ;;
# 132) NTV Telugu
132) link=https://www.youtube.com/watch?v=T953eK1GXbA 
     chan_name="NTV Telugu" ;;
# 133) ABN Telugu
133) link=https://www.youtube.com/watch?v=QzQnFY6CioA 
     chan_name="ABN Telugu" ;;
# 134) Vanitha TV 
134) link=https://www.youtube.com/watch?v=ji7H-z506SA 
     chan_name="Vanitha TV" ;;
# 135) HMT Telugu
135) link=https://www.youtube.com/watch?v=qdi47ihDFCk 
     chan_name="HMT Telugu" ;;
# 136) TV5 News 
136) link=https://www.youtube.com/watch?v=MqDRh-Ysgdg 
     chan_name="TV5 News" ;;
# 137) Channel 24 India
137) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/channel24web/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
   chan_name="Channel 24 India";;
# 138) SAMAA TV
138) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
  chan_name="SAMAA TV" ;;    
# 139) Survana News
 139) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="Survana News" ;;   
# 140) ATN News Bangladesh
 140) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/atnnewsltd/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="ATN News Bangladesh";;     
# 141) No 1 News Telugu
141) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCatI3KKoZyHntflwQIyo65g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="No 1 News" ;;
# 142)i News Telugu
142) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/inews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="i News Telugu" ;; 
#  143) APN News India
143) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/apnnewsindia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="APN News" ;;
# 144) 4tv News India
144) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/4tvindia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="4tv News" ;;   
# 145) Media One News
145) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Media One";;
# 146)  Tamil Live News
 146) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "watch?v=" | head -n 2 | tail -n 1|  cut -d / -f 2 | cut -d \" -f 1)"
 chan_name="Tamil Live News";;
## 147) TOLO NEWS AFGHANISTAN
147) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="TOLO NEWS";; 
## 148) Dawn News PAKISTAN
148) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Dawn News" ;;
## 149) DD News
 149) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
 chan_name="DD News" ;; 
## 150) Public TV India
 150) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/publictvnewskannada/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
 chan_name="Public TV Kannada" ;;
# 151) REPORTER LIVE
 151) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Reporter Live" ;;
# 152) NTV Bangladesh
 152) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="NTV Bangladesh" ;;
# 153) AsiaNet News
 153) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="AsiaNet News" ;;     
# 154) 10TV Telugu
 154) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/10TVNewsChannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="10TV Telugu" ;;     
# 155) ABN Telegu
 155) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
  chan_name="ABN Telegu" ;;
# 156) TV 5 Telegu
156) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="TV 5 Telegu" ;;
# 157)V6 News
157) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="V6 News" ;;
# 158) Kalaignar TV1
158) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="Kalaignar TV" ;;

#############  TRANSIENT
#  145) Samaya News
# 145) link=https://www.youtube.com/watch?v=MmvnNOOt92Q
# chan_name="Samaya News" ;;  

################## ARABIC  ##########################################
# 159) EuroNews Arabic
159) link=https://www.youtube.com/watch?v=y6J0wW2If6Q
chan_name="EuroNews Arabic" ;;
# 160) RT Arabic 
160) link=https://www.youtube.com/watch?v=mFQA6sCQOU4 
     chan_name="RT Arabic" ;;
# 161) ON E Live 
161) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="ON E";;
# 162)  ON E Sports
162) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCWLo4r-9_x4GCJCFShNFq0A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="ON E Sports" ;;   
# 163) ON Live
163) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="ON Live" ;;
# 164) Al Jazeera Arabic
164) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
    chan_name="Al Jazeera Arabic" ;; 
# 165) France 24 Arabic
165) link=https://www.youtube.com/watch?v=UYi0sgVm5dM 
     chan_name="France 24 Arabic" ;;
# 166) BBC Arabic
166) link=https://www.youtube.com/watch?v=m0RMXgxMhs8 
     chan_name="BBC Arabic" ;;
# 167) Al Arabiya
167) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="Al Arabiya" ;;
# 168) Al Mayadeen
168) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
     chan_name="Al Mayadeen" ;;   
# 169) Syrian Satellite
169) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
     chan_name="Syrian Satellite" ;;     
# 170) ORTAS Syrian Satellite
170) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
chan_name="ORTAS Syria" ;;
# 171) Bedya TV Arabic
171) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Bedya TV Arabic" ;;
# 172) Belques TV Arabic
172) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Belques TV Arabic" ;;
# 173) Saudi TV Blue
173) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Saudi Blue" ;;  
# 174) Saudi Finance TV Purple
174) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/EqtsaTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Saudi Finance TV Purple" ;;
# 175) Saudi Channel 1 Green 
175) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="Saudi Channel 1 Green" ;;
# 176) Saudi TV Gold  Mecca Kabba
176) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="Saudi Gold" ;; 
# 177) Saudi Sliver Educational
177) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="Saudi Silver" ;; 
# 178) Saudi Cultural TV Orange
178) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="Saudi Cultural TV Orange" ;;
# 179) Saudi Sports TV Red
179) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="Saudi Sports TV Red" ;;
# 180) DMC Live
180) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="DMC LIVE" ;;
# 181) SKY Arabic
181) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="SKY Arabic" ;;
# 182) CBC Egypt Arabic Drama 
182) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCDramaStream/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="CBC Egypt Arabic Drama" ;;
# 183) eXtra News Egypt Arabic
183) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
 chan_name="eXtra News Egypt" ;;    
# 184) CBC Egypt Sofra Arabic
184) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="CBC Egypt Sofra" ;;

############### TRANSIENT
# 184) CBC Egypt Arabic Live
# 184) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
#      chan_name="CBC Egypt Arabic" ;;
# 154) Makkha Live (Mecca Kaaba)
# 154) link=https://www.youtube.com/watch?v=0b1IMR2H_7s
# chan_name="Mecca Kaaba Live" ;;
# 176) Saudi Kids
# 176) link=https://www.youtube.com/watch?v=uUPqVDf_0II
# chan_name="Saudi Kids" ;;
############### RUSSIAN ################################
# 190) Россия 24
190) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="POCCNR 24 Russia" ;;
# 191) Ukraine Channel 5 
191) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/5channel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Ukraine 5" ;;
# 192) Ukraine 112
192) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Ukraine 112" ;;
# 193) News 1 Ukraine
193) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="News 1 Ukraine" ;;
# 194) Еспресо Ukraine
194) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Ecnpeco Ukraine" ;;
# 195) Thromadske Ukraine
195) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="Thromadske Ukraine" ;;
# 196) UA TV Ukraine
196) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
chan_name="UA TV Ukraine" ;;
# 197) RTR Planeta
197) link=https://www.filmon.com/tv/rtr-planeta
chan_name="RTR Planeta" ;;
################### GREEK ######################################
## 198) Action 24 Greece 
198) link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
chan_name="Action 24 Greek" ;;
## 199) Ionian TV
199) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
chan_name="Ionian TV Greek" ;;
## 200) Star Lima
200) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
chan_name="Star Lima Greek" ;;
## 201) Parovi 1 TV Serbian
201) link=https://www.youtube.com/watch?v=DmRzk9MtRAc
chan_name="Parovi TV Serbian";;
################### TURKEY  ########################  
## 202) TRT Haber Turkey
202) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="TRT Haber Turkey";;
## 203) NTV Turkey
203) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="NTV Turkey";;
## 204) HaberTurk TV
204) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="HaberTurk TV";;
# 205) Star TV  Turkish
205) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Star TV Turkey";;
################ AFRICAN #################################
# 206) ADOM TV 
206) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="ADOM TV" ;;    
# 207) Bukedde TV
207) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Bukedde TV" ;;      
###############    RESTRICTED TO EUROPE     ###########################
# 208) SKY NEWS
208) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
    chan_name="SKY NEWS" ;; 
# 209) DW English
209) link=https://www.youtube.com/watch?v=gNosnzCaS4I 
# link=http://www.dailymotion.com/video/xzgfm5_dw-live-stream_news
    chan_name="DW English" ;; 
# 210)  EuroNews Deutche
210) link=https://www.youtube.com/watch?v=dYJ0kTqeu08 
    chan_name="EuroNews Deutche" ;;
################# ENTERTAINMENT  ##################################
# 211) Talking Tom and Friends
211) link=https://www.youtube.com/watch?v=Fe-fQbUWJwc 
     chan_name="Talking Tom and Friends" ;;
################# TAGALOG FILIPINO #############################       
# 212) DZMM ABS-CBN Philippeans Radio
212) link=https://www.youtube.com/watch?v=YTjNZrs5vvU
chan_name="DZMM Philippeans" ;;
# 213) DZRH Philippeans
213) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="DZRH Philippeans" ;;
# 214) DZMM Philippeans
214) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="DZMM Philippeans" ;;
###############    SPACE       ######################### 
# 220) NASA ISS REPLAY
220) link=https://www.youtube.com/watch?v=3Ruruhg6q1w
chan_name="NASA ISS Replay" ;;
# 221) NASA ISS 1
221) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
    chan_name="NASA ISS 1" ;;  
# 222) NASA ISS 2
222) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
    chan_name="NASA ISS 2" ;;
# 223) Okeanos Ocean Explorer Cam 1
223) link=https://www.youtube.com/watch?v=OobG-QkPODY
# link=https://www.youtube.com/watch?v=WvgEX_TuF2Y
chan_name="Okeanos Ocean Explorer Cam 1" ;;      
# 224) Okeanos Ocean Explorer Cam 2
224) link=https://www.youtube.com/watch?v=Ny7ktdZBZ7c
chan_name="Okeanos Ocean Explorer Cam 2" ;;  
# 225) Okeanos Ocean Explorer Cam 3
225) link=https://www.youtube.com/watch?v=VDGpFiBhagU
chan_name="Okeanos Ocean Explorer Cam 3" ;;              
################## LOCATIONS #############################    
# 226) Venice Italy Bridge Cam Live
226) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
     chan_name="Venice Italy Bridge Cam" ;;
# 227) Venice Italy Port Cam Live
227) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
     chan_name="Venice Italy Port Cam" ;;
# 228) Jackson Hole Intersection
228) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
     chan_name="Jackson Hole Intersection" ;;
# 229) Jackson Hole Town Square
229) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
     chan_name="Jackson Hole Town Square" ;;
# 230) Jackson Hole Rustic Inn
230) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
     chan_name="Jackson Hole Rustic Inn" ;;
# 231) Verona Italy
231) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
     chan_name="Verona Italy" ;;
# 232) Soggy Dollar Bar
232) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
     chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  233) Amsterdam Netherlands
233) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
     chan_name="Amsterdam Netherlands" ;;
# 234) Shibua Japan Community Crosswalk 
234) link=https://www.youtube.com/watch?v=_9pavMzUY-c 
    chan_name="Shibua Japan Crosswalk" ;;
# 235) Akiba Japan Live
235) link=https://www.youtube.com/watch?v=Yi_tX0C3yEs
chan_name="Akiba Live" ;;
# 236) Yahoo Weather Japan
236) link=https://www.youtube.com/watch?v=QbQREKdxGhM
chan_name="Yahoo Japan Bridge" ;;
# 237) Yahoo Weather Steamy Mountains
237)  link=https://www.youtube.com/watch?v=U83waNjv2bM
chan_name="Yahoo Japan Steamy Mountain" ;;
# 238) Tokyo Weather Sky Cam
238) link=https://www.youtube.com/watch?v=Dx8Ba89UNis
chan_name="Tokyo Weather Sky Cam" ;;
# 239) Shizuoka Bridge Japan
239) link=https://www.youtube.com/watch?v=cdJthnaGO6c
chan_name="Shizuoka Bridge Japan" ;;
# 240) Yokohama Port Japan
240) link=https://www.youtube.com/watch?v=vE58KB1AoiA
chan_name="Yokohama Port Japan" ;;
# 241) Hokkido Weather Cams
241) link=https://www.youtube.com/watch?v=ii_JukUbJG0
chan_name="Hokkido Weather Cams" ;;     
# 242) Mount Fuji Japan
242) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
chan_name="Mount Fuji Japan" ;;       
##########################################################################
# 247) Euronews Russian
247) link=https://www.youtube.com/watch?v=VUU9sJ8qRAA
chan_name="Euronews Russian" ;;
# 248) Euronews Turkey
248) link=https://www.youtube.com/watch?v=L-L2QG8Z8H0
chan_name="Euronews Turkey" ;;
# 249) Euronews Italian
249) link=https://www.youtube.com/watch?v=A5BHPktwSCY
chan_name="Euronews Italian" ;;
# 250) QVC Itallian
250) link=https://www.youtube.com/watch?v=E97hsB3Qbmk
chan_name="QVC Italian" ;;
# 251)  Euronews English
251) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Euronews/featured" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="Euronews English" ;; 
# 252) Euronews Maygar Hugarian
252) link=https://www.youtube.com/watch?v=lyuV6zRInOo
chan_name="Euronews Maygar Hungarian" ;;
# 253) 
# 254) 
######################### India Overflow ##############################
# 255) Shirdi Sai Aarti/Darshan
255) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9live/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="Shirdi Sai Aarti/Darshan Live" ;;
# 256) ETV Andhra Pradesh
256) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/etv2india/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="ETV Andhra Pradesh" ;;
# 257) News 7 TamilShirdi Sai Aarti/Darshan
257) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="News 7 Tamil" ;;
# 258) News 18 Tamilnadu
258) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="News 18 Tamilnadu" ;;
# 259) The Polimer TV
259) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ThePolimermedia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
chan_name="The Polimer TV" ;;
# 260) Jaya Plus
260) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="Jaya Plus" ;;

################# BRAZIL   ################################3
# 261) TV Senado Brazil
261) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TVSenadoOficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
 chan_name="TV Senado Brazil" ;;
# 262) TV Camara Brazil
262)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC-ZkSRh-7UEuwXJQ9UMCFJA/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
 chan_name="TV Camara Brazil" ;;  
 # 263) STF Brazil
263)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/STF/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
 chan_name="STF Brazil" ;;  


####################  INTERESTING   #########################################
# 270) RSBN Office Live
270) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="RSBN Right Side Broadcasting Cam 1" ;;
# 271) RSBN News Feed 2
 271) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
    chan_name="RSBN Right Side Broadcasting Cam 2" ;;
# 272) 
# 273) Infowars
273) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheAlexJonesChannel/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
     chan_name="Infowars" ;; 
# 274) Poker TV2
274) link=https://www.twitch.tv/pokerrtv 
    chan_name="Poker TV" ;;
# 275)
# 276) Elyse.fr
276) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
chan_name="Le Direct de la Presidence de la Republique" ;;
# 277) QVC Francais
277) link=https://www.youtube.com/watch?v=wsjO1NFA3Sw
chan_name="QVC Francais" ;;  
esac
}

channel_select $num


echo "$chan_name"

if [ "$use_cookies" == "yes" ]
then
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 curl --cookie-jar "$cookie" --silent "$link"  1&>2
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --loop=inf --cookies --cookies-file "$cookie" "$link" 
else
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen "$link" 
fi


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


if [ "$use_cookies" == "yes" ]
then
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 curl --cookie-jar "$cookie" --silent "$link"  1&>2
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --loop=inf  --cookies --cookies-file "$cookie" "$link" 
else
firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen "$link" 
fi


# echo "You were watching "$chan_name" on Channel "$entry" "

while [ "$entry" != "q" ]
do
  use_cookies="no"
  channel_matrix
  echo "You were watching "$chan_name" on Channel "$entry" "
  echo "Please Select a Number corresponding to a YouTube Live Stream or press q to quit:"

  read entry 

  channel_select $entry

  if [ "$entry" == "q" ]
  then 
  echo "Type endstream to open a new stream."
  exit "$?"
  else
  echo "$chan_name"

   if [ "$use_cookies" == "yes" ]
   then
   firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 curl --cookie-jar "$cookie" --silent "$link"  1&>2
   firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen --loop=inf  --cookies --cookies-file "$cookie" "$link" 
   else
   firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --fullscreen "$link" 
   fi
 
  fi

echo "" > "$cookie"

done

fi


echo "Type endstream to open a new stream."

rm "$cookie"

exit "$?"

######################     END OF PROGRAM      ####################################################
