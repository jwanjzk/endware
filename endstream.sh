#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.21
# Revision Date: April 8, 2017
#
# Recent Changes: - Added channels, fix some Arabic Channels
#                 - Rearrange channels by language grouping
#                 - Add second menu screen with correct while loop + menu switching functions
#                 - grab cookie with curl + inifinite repeat for filmon.tv channels
#                 - Start in fullscreen mode
#                 - grab transient channels by channel name 
#                 - Removed transient streams added some home shopping channels
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
version="0.22"
rev_date="11/04/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   =================================================================================="
   echo "||      ENGLISH       ||      FRANCAIS        ||         ESPANOL        ||      ASIAN / INDIAN    ||      ARABIC        ||        OTHER          ||       ULTRA      ||"
   echo "==========================================================================================================================================================================="
   echo "1) France 24 English   41) France 24 Francais   80) Tu Canal Panama        119) TLTV              159) Tamil Live         198) Saudi Silver       236) Galatasaray   "    
   echo "2) Al Jazeera English  42) France Info TV       81) Excelsior TV           120) FLTV Taiwan       160) TOLO NEWS          199) Saudi Orange       237) A9 Televizyounu " 
   echo "3) TRT World Istanbul  43) France 24 Francais   82) Cinevision Canal 19    121) Chinese 1         161) Dawn News          200) Saudi Red          238) STerkTV Zindi   "  
   echo "4) i24 News Israel     44) Euronews Francais    83) La Casacra TV          122) Dolphin TV        162) DD News            201) DMC Live           239) Ronahi TV Zindi   "             
   echo "5) NEWSMAX USA         45) France Info          84) 100%Noticias Nicaragua 123) SITTI 1           163) Public TV India    202) SKY Arabic         240) Action 24 Greek "  
   echo "6) ABC Australia       46) France Inter         85) Televisia del Golfo    124) SITTI 2           164) REPORTER LIVE      203) CBC Egypt Drama    241) Ionian Greek      "  
   echo "7) CGTN English        47) Max FM 92.9          86) Televisa Veracruz      125) SITTI 3           165) NTV Bangladesh     204) eXtra News Egypt   242) Star Lima Greek "
   echo "8) Africa News         48) M7 TV Mali           87) Televisia Matamoros    126) KBS World 24 Live 166) AsiaNet News       205) CBC Egypt Sofra    243) Parovi TV Serbian "
   echo "9) BBC News London     49) France Inter         88) Televisia Zacatecas    127) KBS World English 167) 10TV Telugu        206) Saudi Ajyal Tv     244) DW English       "
   echo "10) RT English         50) RTL En Direct        89) Televisia Puebla       128) KBS World TV      168) V6 News            207) Mecca Kaaba        245) SKY NEWS Britain "
   echo "11) Press TV Iran      51) Journal TVLandes     90) Televisia Acapulco     129) YTN 27 Korea      169) Kalaignar TV       208) DW Arabic          246) Euronews English   "
   echo "12) DW English         52) CNEWS                91) Televisia Cuernavaca   130) QVC JAPAN         170) News 92 Pakistan      ======RUSSIAN======  247) Euronews Deutche "
   echo "13) Bloomberg          53) BMF TV               92) Televisia Leon         131) SoL!ve 24 Japan   171) ETV Andhra Pradesh 209) Euronews Russian   248) Euronews Maygar"
   echo "14) i24 News Israel    54) Europe 1             93) Televisia Queretaro    132) SunNews  India    172) News 18 Tamilnadu  210) POCCNR 24 Russia   249) DZMM Philippeans"
   echo "15) Saudi 2 English    55) i24 France           94) Televisia Gudalajera   133) TV 9 News India   173) Polimer TV         211) Ukraine 5          250) DZRH Philippeans"  
   echo "16) Channels 24 Nigeria56) France Info TV       95) Televisa Mexicali      134) Rajya Sabha TV    174) Jaya Plus          212) Ukraine 112        251) DWIZ Philippeans"
   echo "17) India Today        57) France Info Radio    96) Televisa Toluca        135) TV9 Gujarat       175) Neo TV India       213) News 1 Ukraine     252) PTV Philippeans  "
   echo "18) CVR English        58) LCP FRANCE           97) Televisa Hermosillo    136) TV9 Marathi       176) Samaya News        214) Ecnpeco Ukraine    253) Adom TV "	
   echo "19) News 9 Bangalor    59) Public Senate        98) Televisa Toreon        137) Bol TV Pakistan   177) ------------       215) Thromadske Ukraine 254) Bukkede TV  "
   echo "20) KTN Kenya          60) Africa News French   99) TeleSur Venezuela      138) 92 News Pakistan  178) ------------       216) UA TV Ukraine      255) TV Sendado Brazil"  
   echo "21) TVC News Nigeria   61) RFI Francais         100) VTV Venezuela         139) News 7 Tamil      179) ------------       217) RTR Planeta        256) STF Brazil "
   echo "22) NTV Uganda         62) Mosaik TV            101) VPI TV Venezuela      140) T News Telegu     =========ARABIC=======  ========TURKISH=====    257) Euronews Portuguese"       
   echo "23) Arise News Nigeria 63) Afrique Media        102) Imagen Radio Mexico   141) 24 News Pakistan  180) EuroNews Arabic    218) TRT Haber Turkey   258) CTV Vaticano"  
   echo "24) SABC South Africa  64) TLM Lyon France      103) Venevision            142) News 18 India     181) RT Arabic          219) NTV Canli          259) QVC Italian "
   echo "25) FOX 10 Phoenix     65) La Republique        104) El Capitolio          143) Aaj Tak           182) ON E Arabic        220) Haber Turk TV      260) Euronews Italian " 
   echo "26) Newsy              66) QVC Francais           ====ASIAN LANGUAGE====   144) TV9 Live          183) ON E Sport         221) Star TV Turkey     261) Euronews Persian"
   echo "27) DVIDS               ====SPANISH LANGUAGE=== 105) CCTV 4 China          145) NTV Telugu        184) ON Live            222) Euronews Turkish   262) BBC Persian "
   echo "28) NASA TV Education  67) Euronews Espanol     106) 119                   146) ABN Telugu        185) Al Jazeera         223) CNN Turk           263) ------------"
   echo "29) NASA TV Media      68) RT Espanol           107) EBC 51 Taiwan         147) Vanitha TV        186) France 24 Arabic   224) Ari TV Canali      264) EWTN "
   echo "30) Arirang TV         69) DW Espanol           108) EBC Finance Taiwan    148) HMT Telugu        187) BBC Arabic         225) Ulusal Kanal       265) The Young Turks "    
   echo "31) TWiT               70) NTN24 Venezuela      109) Tzu Chi Da Ai Taiwan  149) TV5 News          188) Al Arabiya         226) KRT Kulture TV     266) RSBN Feed 1"
   echo "32) Amazing Facts      71) Canal 8 San Juan     110) FTV Live Taiwan       150) Channel 24        189) Al Mayadeen        227) Tele 1 Kanali      267) RSBN Feed 2 "
   echo "33) Its Supernatural   72) Canal 6 San Rafael   111) TTV Taiwan            151) SAMA TV           190) Syrian Satellite   228) Turkmenelie TV     268) Infowars " 
   echo "34) Sheppards Chapel   73) Canal Siete          112) CTV Taiwan            152) Survana News      191) ORTAS Syria        229) Medine TV          269) PBS NewsHour  "  
   echo "35) IHOP               74) c5n Argentina        113) CTS World News Taiwan 153) ATN  Bangladesh   192) Bedya TV Arabic    230) La Legul TV        270) CBC The National"
   echo "36) HSN                75) A24 Argentina        114) SET Taiwan            154) No 1 News         193) Belquees Arabic    231) Yasin TV           271) RUPTLY "
   echo "37) HSN 2              76) TelePacifico Colombia115) CTI Taiwan            155) i News            194) Saudi Blue News    232) Number1 TV         272) Globovision Venezuela"
   echo "38) QVC English        77) Canal 8 Mar Plata    116) NEXT TV Taiwan        156) APN News          195) Saudi Purple       233) TGRT Haber TV      273) ---------------- "	
   echo "39) -------------      78) HispanTV             117) Sinda Television      157) 4tv News          196) Saudi Green        234) TVNET Canali Yayin 274) Talking Tom Minis "
   echo "40) Talking Tom        79) Globovision Venezuela118) Cheng Sin TV          158) Media One         197) Saudi Gold         235) ShowTV Canali      275) Caillou "
   echo "========================================================================================================================================================================"
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      ENDSTREAM  "$version"   =================================================================================="
   echo "||      LOCATIONS         ||      SUPER         ||      DUPER             ||    MEGA        ||    SAIAJIN 1      ||    SAIAJIN 2         ||      GOD MODE     ||"
   echo "============================================================================================================================================================================"
   echo "276) NASA ISS Replay       316) CNN Live        356) ---------------      396) -----------     436) -----------       476) ------------       516) ------------- "    
   echo "277) NASA ISS 1            317) MSNBC           357) ---------------      397) -----------     437) -----------       477) ------------       517) ------------- " 
   echo "278) NASA ISS 2            318) MSNBC           358) ---------------      398) -----------     438) -----------       478) ------------       518) ------------- "  
   echo "279) Venice Italy Bridge   319) Youing Japan    359) ---------------      399) -----------     439) -----------       479) ------------       519) ------------- "             
   echo "280) Venice Italy Port     320) Webcam NL 1     360) ---------------      400) -----------     440) -----------       480) ------------       520) ------------- "  
   echo "281) Jackson Hole XSec     321) Webcam NL 2     361) ---------------      401) -----------     441) -----------       481) ------------       521) ------------- "  
   echo "282) Jackson Hole Square   322) Webcam NL 3     362) ---------------      402) -----------     442) -----------       482) ------------       522) ------------- "
   echo "283) Jackson Hole Rustic   323) Webcam NL 4     363) ---------------      403) -----------     443) -----------       483) ------------       523) ------------- "
   echo "284) Verona Italy          324) Webcam NL 5     364) ---------------      404) -----------     444) -----------       484) ------------       524) ------------- "
   echo "285) Soggy Dollar BVI      325) Webcam NL 6     365) ---------------      405) -----------     445) -----------       485) ------------       525) ------------- "
   echo "286) Amsterdam Netherlands 326) -------------   366) ---------------      406) -----------     446) -----------       486) ------------       526) ------------- "
   echo "287) SHIBUYA JAPAN         327) -------------   367) ---------------      407) -----------     447) -----------       487) ------------       527) ------------- "
   echo "288) Akiba Japan           328) -------------   368) ---------------      408) -----------     448) -----------       488) ------------       528) ------------- "
   echo "289) Bridge Japan          329) -------------   369) ---------------      409) -----------     449) -----------       489) ------------       529) ------------- "
   echo "290) Steamy Mount Japan    330) -------------   370) ---------------      410) -----------     450) -----------       490) ------------       530) ------------- "  
   echo "291) Tokyo Japan           331) -------------   371) ---------------      411) -----------     451) -----------       491) ------------       531) ------------- "
   echo "292) Shizuoka Japan        332) -------------   372) ---------------      412) -----------     452) -----------       492) -------------      532) ------------- "
   echo "293) Yokohama Japan        333) -------------   373) ---------------      413) -----------     453) -----------       493) -------------      533) ------------- "	
   echo "294) Hokkido Japan         334) -------------   374) ---------------      414) -----------     454) -----------       494) -------------      534) ------------- "
   echo "295) Mt Fuji Japan         335) -------------   375) ---------------      415) -----------     455) -----------       495) -------------      535) ------------- "  
   echo "296) BSC 24 Japan          336) -------------   376) ---------------      416) -----------     456) -----------       496) -------------      536) ------------- "
   echo "297) Florida Cam 1         337) -------------   377) ---------------      417) -----------     457) -----------       497) -------------      537) ------------- "       
   echo "298) Florida Cam 2         338) -------------   378) ---------------      418) -----------     458) -----------       498) -------------      538) ------------- "  
   echo "299) Florida Cam 3         339) -------------   379) ---------------      419) -----------     459) -----------       499) -------------      540) ------------- "
   echo "300) Florida Cam 4         340) -------------   380) ---------------      420) -----------     460) -----------       500) -------------      541) ------------- "  
   echo "301) Durango Colorado      341) -------------   381) ---------------      421) -----------     461) -----------       501) -------------      542) ------------- "
   echo "302) Star Dot 1            342) -------------   382) ---------------      422) -----------     462) ------------      502) -------------      543) ------------- "
   echo "303) Star Dot 2            343) -------------   383) ---------------      423) -----------     463) ------------      503) -------------      544) ------------- "
   echo "304) Star Dot 3            344) --------------  384) ---------------      424) -----------     464) ------------      504) -------------      545) ------------- "
   echo "305) Star Dot 4            345) --------------  385) ---------------      425) -----------     465) ------------      505) -------------      546) ------------- "    
   echo "306) Star Dot 5            346) --------------  386) ---------------      426) -----------     466) ------------      506) -------------      547) ------------- "
   echo "307) Star Dot 6            347) --------------  387) ---------------      427) -----------     467) ------------      507) -------------      548) ------------- "
   echo "308) London 1              348) --------------  388) ---------------      428) -----------     468) ------------      508) -------------      549) ------------- " 
   echo "309) London 2              349) --------------  389) ---------------      429) -----------     469) ------------      509) -------------      550) ------------- "  
   echo "310) London 3              350) --------------  390) ---------------      430) -----------     470) ------------      510) -------------      551) ------------- "
   echo "311) Berlin Airport        351) --------------  391) ---------------      431) -----------     471) ------------      511) -------------      552) ------------- "
   echo "312) Osaka                 352) --------------  392) ---------------      432) -----------     472) ------------      512) -------------      553) ------------- "
   echo "313) Port of Los Angeles   353) --------------  393) ---------------      433) -----------     473) ------------      513) -------------      554) ------------- "	
   echo "314) Osaka Skyline ITSCom  354) --------------  394) ---------------      434) -----------     474) ------------      514) -------------      555) ------------- "
   echo "315) China Shoreline       355) --------------  395) ---------------      435) -----------     475) ------------      515) -------------      556) ------------- "
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

read num

if [ "$num" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
elif [ "$num" == "" ]
then
num=1
fi

fi

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    MAIN  ENGLISH  ##################################
# 1) France 24 Anglais 
1) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/france24english/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
   use_cookies="no"
   chan_name="France 24 English";;
# 2) Al Jazeera
2) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
#  3) TRT World
3) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="TRT World";;   
# 4) i24 News Israel
4) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/i24News/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
 chan_name="i24 News Israel English" ;;
# 5) NEWSMAX
5) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
   chan_name="NEWSMAX";;
# 6) ABC News Australia 
6) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
     chan_name="ABC News Australia" ;;
# 7)  CGTN English
7) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CGTN English" ;;
# 8) Africa News Live
8) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
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
use_cookies="no"
   chan_name="Bloomberg";;     
# 14) i24 News Israel 
14) link=https://www.dailymotion.com/video/x29atae
use_cookies="no"
chan_name="i24 News Israel" ;;
# 15) Saudi 2 TV
15) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="Saudi 2 English" ;;
# 16) Channels 24 Nigeria
16) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"    
use_cookies="no"
    chan_name="Channels 24 Nigeria";;   
# 17) India TODAY
17) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="India TODAY English" ;;   
# 18) CVR English India
18) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English" ;;   
# 19) News 9 Bangalor India
19) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/news9tv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="News 9 Bangalor English" ;; 
# 20)  KTN Kenya
20) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 21) TVC News Nigeria
21) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 22) NTV Uganda
22) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;;
# 23) Arise News Nigeria
23) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria";;   
# 24) SABC Digital News South Africa
24) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "watch?v=" | head -n 2 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;; 
# 25) Fox News 10 Phoenix
25) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 26)  Newsy
26) link="https://www.filmon.com/tv/newsy"
use_cookies="yes"
chan_name="Newsy" ;; 
# 27) DVID Department of Defense Videos
27) link="https://www.filmon.com/tv/dvids-tv"
use_cookies="yes"
chan_name="DVIDS" ;;
# 28)   NASA TV Public Education
28) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
    chan_name="NASA TV Education" ;; 
# 29)   NASA TV Media
29) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
    chan_name="NASA TV Media" ;; 
# 30)  Arirang TV
30) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/arirang/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="Arirang TV (Korean Pride)" ;;
#  31) TWiT
31) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/twit/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
    chan_name="TWiT" ;;
# 32) Amazing Facts TV (Christian)
32) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="Amzaing Facts TV (Christian)" ;;
# 33) It's Supernatural! Network (Christian)
33) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="It's Supernatural! (Christian)" ;;
# 34) Sheppard's Chapel (Christian)
34) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="Sheppard's Channel" ;;
# 35) International House of Prayer (IHOP) (Christian)
35) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
    chan_name="International House of Prayer (Christian)" ;;
# 36) HSN
36)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
     chan_name="Home Shopping Network HSN" ;;
# 37) HSN 2
37) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 38) QVC 
38) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 39)
###################   ENTERTAINMENT   ##################################################
# 40)Talking Tom and Friends
40) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
#################    FRENCH   ###################################
# 41) France 24 
41) link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
use_cookies="no"
chan_name="France 24" ;;
# 42) France Info 
42) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news 
use_cookies="no"
chan_name="France Info TV" ;;
# 43) France 24 Francais
43) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/france24/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Francais" ;;
# 44) Euronews Francais
44) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;                                                            
# 45) France Info
45) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Info" ;;
# 46) France Inter
46) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;;
# 47) Max FM 92.9 
47) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
use_cookies="no"
    chan_name="Max FM 92.9" ;;
# 48) M7 Television
48) link=http://www.dailymotion.com/video/x59xxgx_live_music 
use_cookies="no"
chan_name="M7 TV Mali" ;;
# 49) France Inter
49) link=http://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
use_cookies="no"
chan_name="France Inter" ;;
# 50) RTL Endirect
50) link=http://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
use_cookies="no"
    chan_name="RTL En Direct" ;;
# 51) Direct Journal TVLandes    
51) link=http://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
chan_name="Direct Journal Tvlandes"  ;;      
# 52) CNEWS
52) link=http://www.dailymotion.com/video/x3b68jn_live-cnews_news 
use_cookies="no"
chan_name="CNEWS" ;;
# 53) BMF TV
53) link=http://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
use_cookies="no"
chan_name="BMF TV";;
# 54) Europe 1
54) link=http://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
chan_name="Europe 1" ;;
# 55) i24 News en Direct
55) link=http://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
chan_name="i24 Francais";;
# 56) France Info TV
56) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
use_cookies="no"
chan_name="France Info TV" ;;
# 57) France Info Radio
57) link=http://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
use_cookies="no"
chan_name="France Info Radio" ;;
# 58) La Chaine Parlementaire LCP
58) link=http://www.dailymotion.com/video/xji3qy_la-chaine-parlementaire-lcp-live-tnt_news
use_cookies="no"
chan_name="LCP France";;
# 59) Public Senate France
59) link=http://www.dailymotion.com/video/xkxbzc_live-public-senat_news 
use_cookies="no"
chan_name="Public Senate" ;;
# 60) Africa News
60) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
    chan_name="Africa News Francais" ;;
# 61) RFI
61) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"  
    chan_name="RFI Francais" ;;
# 62) Mosaik TV Francais
62) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no" 
    chan_name="Mosaik TV" ;;
# 63) Afrique Media
63) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCOBMhI7TtRLTAGpcTjNvYCw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
    chan_name="Afrique Media" ;;     
# 64) TLM Lyon Metro
64) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 65) Elyse.fr
65) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
use_cookies="no"
chan_name="Le Direct de la Presidence de la Republique" ;;
# 66) QVC Francais
66) link=https://www.youtube.com/watch?v=wsjO1NFA3Sw
use_cookies="no"
chan_name="QVC Francais" ;;      

###################  SPANISH  #################################
# 67) Euronews Espanol
67)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 68) RT Espanol
68) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RT Espanol" ;;
# 69) DW Espanol
69) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="DW Espanol" ;;
# 70) NTN24 Venezuela
70) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 71) Canal 8 San Juan Argentina
71) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 72) Canal 6 San Rafael Argentina
72) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"   
    chan_name="Canal 6 San Rafael Argentina" ;;
# 73) Canal 7 Mendoza Argentina
73) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="Canal 7 Mendoza Argentina" ;;
# 74) c5n Argentina
74) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="c5n Argentina" ;;
# 75) A24 Argentina
75) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="A24 Argentina";;
# 76) TelePacifico Colombia
76) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TelepacificoCanal/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="TelePacifico Colombia" ;; 
# 77) Canal 8 Mar del Plata
77) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"  
    chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 78) Hispan TV
78) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/hispantv/videos?view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
# 79) Globovision Venezeula
79) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 80) Tu Canal Panama
80) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"  
    chan_name="Tu Canal Panama" ;;
# 81) Excelsior TV Mexico
81) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
   chan_name="Excelsior TV Mexico" ;;
# 82) Cinevision Canal 19
82) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCKtx0aYvzIdoKlIfTyydx0g/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Cinevision Canal 19" ;; 
# 83) La Casacra TV 
83) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/lacascaravod/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="La Casacra TV" ;;
# 84) 100% Noticias Nicaragua 
84) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/canal15nicaragua100/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
 chan_name="100% Noticias Nicaragua" ;;   
########### TELEVISIA REGIONALES MEXICO
# 85) Televisa del Golfo
85)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
 chan_name="Televisa del Golfo" ;; 
# 86) Televisa Veracruz
86) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
    chan_name="Televisia Veracruz" ;; 
# 87) Televisa Matamoros
87)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"  
 chan_name="Televisa Matamoros" ;; 
# 88) Televisa Zacatecas
88)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 7 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"  
 chan_name="Televisa Zacatecas" ;; 
# 89) Televisa Puebla
89)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 9 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no" 
 chan_name="Televisa Puebla" ;;  
# 90) Televisa Alcapuloco
90)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?&view=2" | grep "watch?v=" | head -n 11 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Televisa Alcapulco" ;;   
# 91) Televisa Cuernavaca
91)  link=http://www.galatvmorelos.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisa Cuernavaca" ;;   
# 92) Televisa Leon
92)  link=http://www.televisaleon.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisa Leon" ;; 
# 93) Televisa Queretaro
93)  link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisa Queretaro" ;; 
 # 94) Televisa Gudalajera
94)  link=http://www.televisaguadalajara.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisa Gudalajera" ;; 
# 95) Televisa Mexicali
95)  link=http://www.televisamexicali.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisa Mexicali" ;;  
# 96) Televisa Toluca
96)  link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisa Toluca" ;;  
# 97) Televisa Hermosillo
97)  link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisa Hermosillo" ;;  
# 98) Televisa Torreon
98)  link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisa Torreon" ;;  
##################
# 99) TeleSUR Venezuela
99) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TeleSUR Espanol" ;;
# 100) VTV Venezuela
100) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/MultimedioVTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="VTV Venezuela" ;;  
# 101) VPI TV Venezuela
101) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="VPI TV" ;;
# 102) Imagen Radio Mexico
102) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 103) Venevision Venezuela
103) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Venevision Venezuela" ;; 
# 104) El Capitolio Venezulana
104) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="El Capitolio Venezulana" ;;    
################ CHINESE MANDARIN CANTONESE  ####################
# 105) CCTV 4 Chinese
105) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;
# 106) 119 Live 電視台大立
106) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立" ;;
############## TAIWAN TAIWANESE ##############################
# 107) EBC 51 News Taiwan
107) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/newsebc/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
    chan_name="EBC 51 News Taiwan" ;;
# 108) EBC Finance Taiwan
108) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/57ETFN/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
#  109) Tzu Chi Da Ai Taiwan 
109) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Tzu Chi Da Ai Taiwan" ;; 
# 110) FTV Taiwan
110) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 111) TTV News Taiwan
111) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 112) CTV Taiwan
112) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 113) CTS World News HD Taiwan
113) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 114) SET News Taiwan
114) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 115) CTI Taiwan
115) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTI Taiwan" ;;  
# 116) NeXT TV Taiwan
116) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/eranewstest/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Next TV Taiwan" ;;
# 117) Sinda Television
117) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 118) Cheng Sin TV
118) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Cheng Sin TV";;
# 119) TLTV
119) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TLTV";;
# 120) FLTV Taiwan
120) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 121) 郭世明
121) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCdx4XBYPj9s6FZUhEQ9IWkw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="郭世明";;
# 122) 海豚直播 Dolphin TV
122) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCUz3LiE7QuRGDGZ2DYciIuA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="海豚直播 Dolphin TV";;
# 123) SITTI 1
123) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="SITTI 1";;
# 124) SITTI 2
124) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="SITTI 2";;
# 125) SITTI 3
125) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "watch?v=" | head -n 6 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="SITTI 3";;
################ KOREAN  ###############################
#  126) KBS World 24 News
126) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/kbsworld/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
     chan_name="KBS World 24 News" ;;
# 127) KBS World English Sub
127) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/kbsworld/videos?&view=2" | grep "watch?v=" | head -n 1  | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
     chan_name="KBS 24 World English Sub" ;;
# 128) KBS World TV
128) link=https://www.youtube.com/watch?v=PUl4hiEOXSo
use_cookies="no"
chan_name="KBS World TV" ;;
#user/kbsworld
# 129) YTN 24 Korea
129) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ytnlive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN 27 Korea" ;;   
################ JAPANESE  ####################
#  130) QVC JAPAN SHOPPING CHANNEL
130) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 131) Sol!ve 24 Japan
131) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 132) SunNews 
132) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SunNews" ;; 
# 133) TV9 India Live
133) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9telugulive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV9 Live India";;    
# 134) Rajya Sabha TV
134) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 135) TV9 Gujarat
135) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 136) Tv9 Marathi
136) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9maharashtra/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Tv9 Marathi" ;; 
# 137) Bol TV Pakistan
137) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCl_yX1yxsnYAgDs2RFJSerg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bol News" ;;
# 138) 92 News Pakistan
138) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCsgC5cbz3DE2Shh34gNKiog/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="92 News Pakistan";; 
# 139) News 7 Tamil
139) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 140) T News Telegu
140) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TNews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="T News Telegu" ;;
## 141) 24 News Pakistan HD
141) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="24 News Pakistan HD" ;;  
# 142) News 18 India
142) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 18 India" ;;
# 143) Aaj Tak 
143) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Aaj Tak" ;;
# 144) TV9 Telugu Live
144) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tv9live/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TV9 Live" ;;
# 145) NTV Telugu
145) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "watch?v=" | head -n 1| cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 146) ABN Telugu
146) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 147) Vanitha TV 
147) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 148) HMT Telugu
148) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 149) TV5 News 
149) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV5 News" ;;
# 150) Channel 24 India
150) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/channel24web/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 151) SAMAA TV
151) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV" ;;    
# 152) Survana News
152) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Survana News" ;;   
# 153) ATN News Bangladesh
153) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/atnnewsltd/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;     
# 154) No 1 News Telugu
154) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCatI3KKoZyHntflwQIyo65g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="No 1 News" ;;
# 155)i News Telugu
155) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/inews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="i News Telugu" ;; 
# 156) APN News India
156) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/apnnewsindia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="APN News" ;;
# 157) 4tv News India
157) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/4tvindia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="4tv News" ;;   
# 158) Media One News
158) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Media One";;
# 159)  Tamil Live News
159) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "watch?v=" | head -n 2 | tail -n 1|  cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Tamil Live News";;
## 160) TOLO NEWS AFGHANISTAN
160) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS";; 
## 161) Dawn News PAKISTAN
161) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dawn News" ;;
## 162) DD News
162) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
## 163) Public TV India
163) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/publictvnewskannada/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Public TV Kannada" ;;
# 164) REPORTER LIVE
164) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 165) NTV Bangladesh
165) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Bangladesh" ;;
# 166) AsiaNet News
166) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 167) 10TV Telugu
167) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/10TVNewsChannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="10TV Telugu" ;;      
# 168)V6 News
168) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
 chan_name="V6 News" ;;
# 169) Kalaignar TV1
169) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Kalaignar TV" ;;
# 170) News 92 Pakistan
170) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCsgC5cbz3DE2Shh34gNKiog/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="News 92 Pakistan";; 
# 171) ETV Andhra Pradesh
171) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/etv2india/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 172) News 18 Tamilnadu
172) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 173) The Polimer TV
173) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ThePolimermedia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="The Polimer TV" ;;
# 174) Jaya Plus
174) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Jaya Plus" ;;
# 175) Neo TV India
175) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCAsvFcpUQegneSh0QAUd64A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Neo TV India";;
# 176) Samaya News
176) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SamayaNewsKannada/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Samaya News Kannada" ;;  
# 177)
# 178)
# 179)

################## ARABIC  ##########################################
# 180) EuroNews Arabic
180) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Arabic" ;;
# 181) RT Arabic 
181) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 182) ON E Live 
182) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
# 183)  ON E Sports
183) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCWLo4r-9_x4GCJCFShNFq0A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E Sports" ;;   
# 184) ON Live
184) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON Live" ;;
# 185) Al Jazeera Arabic
185) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 186) France 24 Arabic
186) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 187) BBC Arabic
187) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/BBCArabicNews/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 188) Al Arabiya
188) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya" ;;
# 189) Al Mayadeen
189) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen" ;;   
# 190) Syrian Satellite
190) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Satellite" ;;     
# 191) ORTAS Syrian Satellite
191) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ORTAS Syria" ;;
# 192) Bedya TV Arabic
192) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bedya TV Arabic" ;;
# 193) Belques TV Arabic
193) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belques TV Arabic" ;;
# 194) Saudi TV Blue
194) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Blue" ;;  
# 195) Saudi Finance TV Purple
195) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/EqtsaTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Finance TV Purple" ;;
# 196) Saudi Channel 1 Green 
196) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 1 Green" ;;
# 197) Saudi TV Gold  Mecca Kabba
197) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Gold" ;; 
# 198) Saudi Sliver Educational
198) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Silver" ;; 
# 199) Saudi Cultural TV Orange
199) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Cultural TV Orange" ;;
# 200) Saudi Sports TV Red
200) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Sports TV Red" ;;
# 201) DMC Live
201) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE" ;;
# 202) SKY Arabic
202) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic" ;;
# 203) CBC Egypt Arabic Drama 
203) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCDramaStream/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 204) eXtra News Egypt Arabic
204) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 205) CBC Egypt Sofra Arabic
205) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 206) Saudi Ajyal Kids Tv
206) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv" ;; 
# 207) Makkha Live (Mecca Kaaba) 
207) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UClIIopOeuwL8KEK0wnFcodw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mecca Kaaba Live" ;;
# 208)  DW Arabic
208) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
############### RUSSIAN ################################
# 209) Euronews Russian
209) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsru/videos?&view=2" | grep "watch?v=" | head -n 1  | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Euronews Russian" ;;
# 210) Россия 24
210) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 211) Ukraine Channel 5 
211) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/5channel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 212) Ukraine 112
212) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 213) News 1 Ukraine
213) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 214) Еспресо Ukraine
214) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 215) Thromadske Ukraine
215) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 216) UA TV Ukraine
216) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 217) RTR Planeta
217) link=https://www.filmon.com/tv/rtr-planeta
use_cookies="no"
chan_name="RTR Planeta" ;;
################### TURKEY  ########################  
## 218) TRT Haber Turkey
218) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 219) NTV Turkey
219) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ntv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 220) HaberTurk TV
220) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 221) Star TV  Turkish
221) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 222) Euronews Turkey
222) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewstr/videos?&view=2" | grep "watch?v=" | head -n 1  | cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Euronews Turkey" ;;  
# 223) CNN Turk 
223) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 224) Ari TV Canali Turkish
224) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCzHQ4i-eD5DxjEljsQAoD7w/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name=" Ari TV Canali Turkish";;
# 225) Ulusal Kanal Turkish
225) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6T0L26KS1NHMPbTwI1L4Eg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ulusal Kanal";;
# 226) KRT Kulture TV
226) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 227) Tele 1 Kanali
227) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCoHnRpOS5rL62jTmSDO5Npw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Tele 1 Kanali";;
# 228) Turkmenelie TV
228) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie TV";;
# 229) Medine TV
229) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCou5J1Vnhxnx-IeAqFItN0g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Medine TV";;
# 230) La Legul TV
230) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 231) Yasin TV
231) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCg7GnEktmfV1OH3NCWwLW0A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Yasin TV";;
# 232) Number1 TV
232) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 233) TGRT Haber TV
233) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 234) TVNET Canali Yayin
234) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 235) ShowTV Canali 
235) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ShowTVShowTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="ShowTV Canali";;
# 236) Galatasaray 
236) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/2galatasaray/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Galatasaray";;
# 237) A9 Televizyounu 
237) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCHHeyHIgmp5JEEg6cILSShg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="A9 Televizyounu";;
# 238) STerkTV Zindi 
238) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 239) Ronahi TV Zindi 
239) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";;
################### GREEK ######################################
## 240) Action 24 Greece 
240) link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
use_cookies="no"
chan_name="Action 24 Greek" ;;
## 241) Ionian TV
241) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
use_cookies="no"
chan_name="Ionian TV Greek" ;;
## 242) Star Lima
242) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lima Greek" ;;
## 243) Parovi 1 TV Serbian
243) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCQVxuhJGZNPwOwcAstbvX1A/videos?view=2" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d / -f 2 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Parovi TV Serbian";;
#########################################################################
###############    RESTRICTED TO EUROPE     ###########################
# 244) SKY NEWS
244) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
use_cookies="no"
chan_name="SKY NEWS" ;; 
# 245) DW English
245) link=https://www.youtube.com/watch?v=gNosnzCaS4I 
# link=http://www.dailymotion.com/video/xzgfm5_dw-live-stream_news
use_cookies="no"
chan_name="DW English" ;; 
# 246)  Euronews English
246) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews English" ;; 
# 247)  EuroNews Deutche
247) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "watch?v=" | head -n 4 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutche" ;;
# 248) Euronews Maygar Hugarian
248) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsHungarian/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Maygar Hungarian" ;;
################# TAGALOG FILIPINO #############################       
# 249) DZMM ABS-CBN Philippeans Radio
249) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 250) DZRH Philippeans
250) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 251) DWIZ Philippeans
251) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCUWv18AQ-8k5m9_AEv5lzew/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DWIZ Philippeans" ;;
# 252) PTV Philippines
252) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="PTV Philippines";;
################ AFRICAN #################################
# 253) ADOM TV 
253) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV" ;;    
# 254) Bukedde TV
254) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Bukedde TV" ;;  
################ BRAZIL   ################################
# 255) TV Senado Brazil
255) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TVSenadoOficial/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TV Senado Brazil" ;;
# 256) STF Brazil
256)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/STF/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  

# 257) Euronews Portuguese
257)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Portuguese" ;;  

# 257) TV Camara Brazil
# 257)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC-ZkSRh-7UEuwXJQ9UMCFJA/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
#use_cookies="no"
#chan_name="TV Camara Brazil" ;;  



##########################  Italian  #######################################################
# 258)CTV Vaticano
258) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ctvaticano/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CTV Vaticano" ;;
# 259) Euronews Italian
259) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewsit/videos?&view=2" | grep "watch?v=" | head -n 1  | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Italian" ;;
# 260) QVC Itallian
260) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "watch?v=" | head -n 1  | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;;
################################## FARSI / PERSIAN  ###########################################################
# 261)  Euronews Persian
261) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Persian";;
# 262)  BBC Persian
262) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
#################### TRANSIENT TALK SHOWS ######################################## 
# 263)

# 264) EWTN
264) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EWTN" ;;
# 265) The Young Turks
265) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
# 266) RSBN Office Live
266) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Cam 1" ;;
# 267) RSBN News Feed 2
267) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Cam 2" ;;
# 268) Infowars
268) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TheAlexJonesChannel/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
# 269) PBS NewsHour Video
269) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/PBSNewsHour/videos?&view=0" | grep "watch?v=" | grep "PBS NewsHour"| head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;    
# 270)  CBC The National
270) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 271) RUPTLY
271) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 272) Globovision Venezeula Low Fi
272) link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no"
chan_name="Globovision Venezeula" ;;
# 273) 

# 274) Talking Tom and Friends Mini
274) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Mini" ;;
# 275) Caillou
275) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC4yQCVlLhTmOqX5kUkAGr0g/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Caillou" ;;  

################################ MENU 2 ########################################################
###############    SPACE       ######################### 
# 276) NASA ISS REPLAY
276) link=https://www.youtube.com/watch?v=3Ruruhg6q1w
# user/ouramazingspace/videos
use_cookies="no"
chan_name="NASA ISS Replay" ;;
# 277) NASA ISS 1
277) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
# 278) NASA ISS 2
278) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
use_cookies="no"
chan_name="NASA ISS 2" ;;     
################## LOCATIONS #############################    
# 279) Venice Italy Bridge Cam Live
279) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 280) Venice Italy Port Cam Live
280) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
use_cookies="no"
chan_name="Venice Italy Port Cam" ;;
# 281) Jackson Hole Intersection
281) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
use_cookies="no"
chan_name="Jackson Hole Intersection" ;;
# 282) Jackson Hole Town Square
282) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 283) Jackson Hole Rustic Inn
283) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 284) Verona Italy
284) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
use_cookies="no"
chan_name="Verona Italy" ;;
# 285) Soggy Dollar Bar
285) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
use_cookies="no"
chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  286) Amsterdam Netherlands
286) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;;
# 287) Shibua Japan Community Crosswalk 
287) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 288) Akiba Japan Live
288) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 289) Yahoo Weather Japan
289) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 290) Yahoo Weather Steamy Mountains
290)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 291) Tokyo Weather Sky Cam
291) link=https://www.youtube.com/watch?v=Dx8Ba89UNis
use_cookies="no"
chan_name="Tokyo Weather Sky Cam" ;;
# 292) Shizuoka Bridge Japan
292) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 293) Yokohama Port Japan
293) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 294) Hokkido Weather Cams
294) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 295) Mount Fuji Japan
295) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 296) BSC 24 Japan
296) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"  
chan_name="BSC 24 Japan" ;;   
# 297) Florida Cam 1
297) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 1" ;; 
# 298) Florida Cam 2
298) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 2" ;; 
# 299) Florida Cam 2
299) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 3" ;; 
# 300) Florida Cam 2
300) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "watch?v=" | head -n 7 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 4" ;; 
# 300) Florida Cam 5
300) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "watch?v=" | head -n 9 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 5" ;; 
# 301) Durango Colorado USA
301) link=https://www.youtube.com/"$(curl "https://www.youtube.com//channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 1" ;; 
# 302)Star Dot Cam 1
302) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 1 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;; 
# 303) Star Dot Cam 2
303) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 2 Taiwan" ;; 
# 304) Star Dot Cam 3
304) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 3 Buena Park California" ;; 
# 305) Star Dot Cam 4
305) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 7 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 306) Star Dot Cam 5
306) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 9 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 307) Star Dot Cam 6
307) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "watch?v=" | head -n 11 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 308) Fine Cine London 1
308) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 309) Fine Cine London 2
309) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 310) Fine Cine London 3
310) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 311) Berlin Airport 
311) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 312) Osaka Japan  
312) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/masato663/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Osaka Japan" ;; 
# 313) Port of Los Angeles  
313) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 314)  ITS COM STUDIO Japan  
314) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 315)  China Shoreline 
315) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;; 

###########################################
# 316) CNN Live 
316) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCEGpbgwmS9pHXksqWrGIOgQ/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CNN Live" ;; 
# 317) MSNBC
317) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCPXSXjC_Vue6o1z3wJ9dTHA/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="MSNBC" ;; 
# 318) MSNBC 
318) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCRcWgXt93Fl_mKiKMckvSZg/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="MSNBC" ;; 

# 319) Youing Japan Route 10
319) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 

# 320) Netherlands live cams 6 of them 
320) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 1 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 1" ;; 

# 321) Netherlands live cams 6 of them 
321) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 3 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 2" ;; 

# 322) Netherlands live cams 6 of them 
322) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 5 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 3" ;; 

# 323) Netherlands live cams 6 of them 
323) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 7 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 4" ;; 

# 324) Netherlands live cams 6 of them 
324) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 9 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 5" ;; 

# 325) Netherlands live cams 6 of them 
325) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "watch?v=" | head -n 11 | tail -n 1 | cut -d / -f 2 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Web NL Cam 6" ;; 


# ON TV News Hong Kong 
# 100) link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UCU5cdjzARR1o9iUcg0Te8rQ/videos" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="ON TV News Hong Kong" ;;
## TWiT on Twitch   (BROKEN)
## 26) link=https://www.twitch.tv/twit 
##    chan_name="TWiT on Twitch" ;; 


# 263)Joy News Nigeria
# 263) link=https://www.youtube.com/"$(curl "https://www.youtube.com/user/multitvgh/videos?&view=2" | grep "watch?v=" | head -n 1 | cut -d / -f 2 | cut -d \" -f 1)"  
#use_cookies="no"
#chan_name="Joy News Nigeria";;

esac
}

# Function to check the menu status
menu_status()
{
input=$1
if [ "$input" == "" ]
then
menstat="no"
elif [ "$input" == "q" ]
then
menstat="yes"
elif [ "$input" == "n" ]
then 
menstat="yes"
elif [ "$input" == "m" ]
then
menstat="yes"
else
menstat="no"
fi
}

# function for m,n,q channel matrix display
menu_switch()
{
input=$1
case "$input" in
q) echo "Type endtv to restart program. Bye."
exit "$?" ;;
m) channel_matrix
echo "Please Select a Number corresponding to a YouTube Live Stream, press n for the next menu, or press q to quit:" ;;
n) channel_matrix_2
echo "Please Select a Number corresponding to a YouTube Live Stream, press m for the main menu, or press q to quit:" ;;
esac
}

menu_status $num

# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select $num
 echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
 channel_matrix 
 echo "You were watching "$chan_name" on Channel "$num" "
 echo "Please Select a Number corresponding to a YouTube Live Stream, press n for the next menu, or press q to quit:"
 read entry
 else 
 menu_switch $num
 read entry
fi

while [ "$entry" != q ]
do
menu_status $entry
if [ "$menstat" == "no" ]
then
channel_select $entry
echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop=inf --stream-lavf-o=timeout=10000000 --cookies --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  channel_matrix 
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --noroot --seccomp --protocol=unix,inet,inet6 mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
channel_matrix 
echo "You were watching "$chan_name" on Channel "$entry" "
echo "Please Select a Number corresponding to a YouTube Live Stream, press n for the next menu, or press q to quit:"
read entry
else 
menu_switch $entry
read entry
fi
done

echo "Type endstream to open a new stream."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

# --user-agent=<string>
# mpv --http-header-fields='Field1: value1','Field2: value2' 
# --tls-verify
# --referrer=<string>
# --cache-secs=<seconds>
# --cache-file-size=<kBytes>
# --cache-pause  --cache=<kBytes|yes|no|auto>
# https://mpv.io/manual/master/

######################     END OF PROGRAM      ####################################################

