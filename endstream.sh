#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.31
# Revision Date: June 3, 2017
#
# Recent Changes: - +/- channel controls, + grab streams direct from upstream source
#                 - Channel grab overhaul fix Mother's Day Blackout Bug
#                 - Channel menu stays on previous selection + English Channel Rearrange
#                 - Rearanged + re add FilmOn channels + Fix Indian channels
#                 - Rearrange channels by language grouping
#                 - Add second menu screen with correct while loop + menu switching functions
#                 - grab cookie with curl + inifinite repeat for filmon.tv channels
#                 - Start in fullscreen mode
#                 - grab transient channels by channel name 
#####################################################################
# Dependencies: youtube-dl, mpv, read , firejail, curl
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
version="0.31"
rev_date="03/06/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   ==============================================================================="
   echo "||      ENGLISH       ||      FRANCAIS        ||       ESPANOL        ||      ASIAN / INDIAN  ||      ARABIC        ||    RUSSIAN/TURKISH   ||       OTHER        ||"
   echo "========================================================================================================================================================================"
   echo "1)France 24 English   41)France 24 Francais   80)Canal 2 San Vicente    119)TLTV              159)Tamil Live         198)Saudi Silver       236)Galatasaray   "    
   echo "2)Al Jazeera English  42)France Info TV       81)Excelsior TV Mexico    120)FLTV Taiwan       160)TOLO NEWS Afghan   199)Saudi Orange       237)A9 Televizyounu " 
   echo "3)TRT World Istanbul  43)France 24 Francais   82)TN Argentina           121)Guo Shiming TV    161)Dawn News Pakistan 200)Saudi Red          238)STerkTV Zindi   "  
   echo "4)SKY News London     44)Euronews Francais    83)La Nacion Argentina    122)Dolphin TV        162)DD News India      201)DMC Live           239)Ronahi TV Zindi   "             
   echo "5)ABC Australia       45)France Info          84)PSN Tijuna Mexico      123)SITTI 1           163)Public TV India    202)SKY Arabic         240)Number1 Turk FM"  
   echo "6)CGTN Beijing        46)France Inter         85)TV del Golfo Mexico    124)SITTI 2           164)REPORTER LIVE      203)CBC Egypt Drama    241)Action 24 Greek "  
   echo "7)Arirang TV Korea    47)Max FM 92.9          86)TV Veracruz Mexico     125)SITTI 3           165)Puthiya Thalaimurai204)eXtra News Egypt   242)Ionian Greek"
   echo "8)EuroNews English    48)M7 TV Mali           87)TV Matamoros Mexico    126)TzuChi DaAiVideo  166)AsiaNet News       205)CBC Egypt Sofra    243)Star Lamia Greek"
   echo "9)BBC News            49)France Inter         88)TV Zacatecas Mexico    127)TzuChi DaAiVideo2 167)V6 News            206)Saudi Ajyal Tv     244)Blue Sky Athens"
   echo "10)DW English         50)RTL En Direct        89)TV Puebla Mexico       128)Kiss Radio 1      168)Kalaignar TV       207)Mecca Kaaba        245)SKY NEWS Britain"
   echo "11)Russia Today       51)Journal TVLandes     90)TV Acapulco Mexico     129)Kiss Radio 2      169)News 9 Bangalore   208)DW Arabic          246)------------"
   echo "12)Africa News        52)CNEWS                91)TV Cuernavaca Mexico   130)Shirdi Sai Aarthi 170)ETV Andhra Pradesh  ===RUSSIA/UKRAINE===  247)Euronews Deutsch "
   echo "13)ANN7 South Africa  53)BMF TV               92)TV Leon Mexico         131)Shaski India      171)News 18 Tamilnadu  209)Вести FM           248)Euronews Magyar"
   echo "14)Arise News Nigeria 54)Europe 1             93)TV Queretaro Mexico    132)SunNews  India    172)Polimer TV         210)Vesti FM           249)DZMM Philippeans"
   echo "15)Channels 24 Nigeria55)i24 France           94)TV Gudalajera Mexico   133)TV 9 News India   173)Jaya Plus          211)POCCNR 24 Russia   250)DZRH Philippeans"  
   echo "16)TVC News Nigeria   56)France Info TV       95)TV Mexicali Mexico     134)Rajya Sabha TV    174)Neo TV India       212)Ukraine 5          251)DWIZ Philippeans"
   echo "17)KTN Kenya          57)France Info Radio    96)TV Toluca Mexico       135)TV9 Gujarat       175)Samaya News        213)Ukraine 112        252)PTV Philippeans  "
   echo "18)NTV Uganda         58)LCP FRANCE           97)TV Hermosillo Mexico   136)TV9 Marathi       176)Ekantipur Nepal    214)News 1 Ukraine     253)Adom TV "	
   echo "19)i24 News Israel    59)Public Senate        98)TV Toreon Mexico       137)Bol TV Pakistan   177)Nepal Mandal       215)Ecnpeco Ukraine    254)Bukkede TV  "
   echo "20)Saudi 2 English    60)Africa News Francais 99)TeleSur Venezuela      138)92 News Pakistan  178)TEZ TV             216)Thromadske Ukraine 255)TV Sendado Brazil"  
   echo "21)Press TV Iran      61)RFI Francais         100)Globovision Venezuela 139)News 7 Tamil      179)Dilli Aaj Tak      217)UA TV Ukraine      256)STF Brazil "
   echo "22)India Today        62)Mosaik TV            101)VPI TV Venezuela      140)T News Telugu     =======ARABIC=========  ======TURKISH=======  257)Euronews Portuguese"       
   echo "23)CVR English        63)Africa 24            102)Imagen Radio Mexico   141)24 News Pakistan  180)EuroNews Arabic    218)TRT Haber Turkey   258)CTV Vaticano"  
   echo "24)MSNBC USA          64)TLM Lyon France      103)Venevision            142)News 18 India     181)RT Arabic          219)NTV Canli          259)QVC Italian "
   echo "25)Bloomberg USA      65)La Republique        104)El Capitolio          143)Aaj Tak           182)ON E Arabic        220)Haber Turk TV      260)Euronews Italian " 
   echo "26)NEWSMAX USA        66)QVC Francais         ======ASIAN LANGUAGE===== 144)TV9 Live          183)ON E Sport         221)Star TV Turkey     261)Euronews Persian"
   echo "27)CBSN USA           ====SPANISH LANGUAGE=== 105)CCTV 4 China          145)NTV Telugu        184)ON Live            222)Fashion 1 Turk     262)BBC Persian "
   echo "28)ABC News           67)Magala24 Spain       106)Tai Li 119 Taiwan     146)ABN Telugu        185)Al Jazeera         223)CNN Turk           263)OnTV Hong Kong"
   echo "29)FOX 10 Phoenix     68)RT Espanol           107)EBC 51 Taiwan         147)Vanitha TV        186)France 24 Arabic   224)Ari TV Canali      264)------------"
   echo "30)FOX 23 Tulsa       69)DW Espanol           108)EBC Finance Taiwan    148)HMT Telugu        187)BBC Arabic         225)Ulusal Kanal       265)RSBN Feed 2  "    
   echo "31)FOX 25 Boston      70)NTN24 Venezuela      109)DaAi World Taiwan     149)TV5 News          188)Al Arabiya         226)KRT Kulture TV     266)RUPTLY "
   echo "32)FOX 30 Jacksonville71)Canal 8 San Juan     110)FTV Live Taiwan       150)Channel 24        189)Al Mayadeen        227)Tele 1 Kanali      267)DeporTV Sports"
   echo "33)VOA                72)Canal 6 San Rafael   111)TTV Taiwan            151)SAMAA TV Pakistan 190)Syrian Satellite   228)Turkmenelie FM     268)PBS NewsHour " 
   echo "34)Go News            73)Canal 7 Mendoza      112)CTV Taiwan            152)Survana News      191)ORTAS Syria        229)Turkmenelie TV     269)CBC The National "  
   echo "35)RT America         74)c5n Argentina        113)CTS World News Taiwan 153)ATN  Bangladesh   192)Bedya TV Arabic    230)La Legul TV        270)SABC South Africa   "
   echo "36)RT UK              75)A24 Argentina        114)SET Taiwan            154)No 1 News         193)Belqees TV Arabic  231)Number 1 TV        271)AP Top Stories  "
   echo "37)CSPAN 1            76)TelePacifico Colombia115)CTI Taiwan            155)i News            194)Saudi Blue News    232)Number 1 Turk      272)Democracy Now "
   echo "38)CNN Demo           77)Canal 8 Mar Plata    116)NEXT TV Taiwan        156)News 1 Kannada    195)Saudi Purple       233)TGRT Haber TV      273)Talking Tom Minis"	
   echo "39)TWC                78)HispanTV             117)Sinda Television      157)Jansari News      196)Saudi Green        234)TVNET Canali Yayin 274)Infowars"
   echo "40)TWN                79)Globovision Venezuela118)Cheng Sin TV          158)Media One         197)Saudi Gold         235)NEWSCHANNEL Zindi  275)TYT"
   echo "========================================================================================================================================================================"
echo " " 
}	

channel_matrix_2()
{
   echo "==================================================================      ENDSTREAM  "$version"   ================================================================================"
   echo "||      LOCATIONS         ||      SUPER       ||         ULTRA       ||       MEGA         ||      OK         ||        SAIAJIN        ||      GOD MODE     ||"
   echo "=========================================================================================================================================================================="
   echo "276)RSBN Auburn AL USA    316)Youing Japan    356)Parovi TV Serbia   396)Newsy USA         436)PAC-12 Arizona 476)Earthquake 24      516)CTV Vaticano "    
   echo "277)NASA ISS 1            317)Webcam NL 1     357)Biafra TV Africa   397)VOA               437)PAC-12 Bay Area477)KBS 24 Japan       517)EWTN Americas " 
   echo "278)NASA ISS 2            318)Webcam NL 2     358)Joy News Ghana     398)DVIDs             438)PAC-12 LA      478)TBS Live Korea     518)EWTN Ireland "  
   echo "279)Venice Italy Bridge   319)Webcam NL 3     359)i24 News Israel    399)America Thinks?   439)PAC-12 Mountain479)YTN DMB Korea      519)Amazing Facts"             
   echo "280)Venice Italy Port     320)Webcam NL 4     360)CGTN Beijing       400)Jupiter Broadcast 440)PAC-12 Oregon  480)YTN Life Korea     520)It's Supernatural!"  
   echo "281)Jackson Hole XSec     321)Webcam NL 5     361)TWiT               401)TWiT              441)PAC-12 Wash    481)YTN Science Korea  521)Sheppard's Chapel"  
   echo "282)Jackson Hole Square   322)Webcam NL 6     362)High Stakes Poker  402)NASA TV Education 442)Uni Arizona    482)Channel 23 Korea   522)IHOP"
   echo "283)Jackson Hole Rustic   323)Naman Tower     363)La Casacra         403)NASA TV Media     443)Uni LA         483)BSC 24 1 Japan     523)BVOVN"
   echo "284)Verona Italy          324)------------    364)100% Noticias      404)RT Documentary    444)Uni Mountain   484)BSC 24 2 Japan     524)3ABN"
   echo "285)Soggy Dollar BVI      325)------------    365)Number1 FM Radyo   405)CGTN Documentary  445)Uni Oregon     485)KBS World 24 Korea 525)TCT HD"
   echo "286)Amsterdam Netherlands 326)-------------   366)Rádio Justiça      406)HSN 1             446)Uni Wash       486)YTN 27 Korea       526)TCT SD"
   echo "287)SHIBUYA JAPAN         327)-------------   367)Rádio Justiça      407)HSN 2             447)BBC Arabic     487)QVC JAPAN          527)TCT Kids"
   echo "288)Akiba Japan           328)-------------   368)Euronews Espanol   408)QVC English       448)FOX News Talk  488)Sol!ve 24 Japan    528)Salt and Light"
   echo "289)Bridge Japan          329)-------------   369)EWTN Espanol       409)TCS               449)Adult Swim     489)Arirang Radio      529)LLBN TV"
   echo "290)Steamy Mount Japan    330)-------------   370)EWTN Deutsch       410)CPAC 1            450)Adult Swim Ani 490)AniBox             530)Harbor Light Radio"  
   echo "291)-------------         331)-------------   371)EWTN Africa        411)CPAC 1 Francais   451)Adult Swim Live491)Toonami            531)Hillsong"
   echo "292)Shizuoka Japan        332)-------------   372)EWTN Asia          412)CPAC 2            452)-----------    492)Talking Tom        532)Al Hayat TV Arabic"
   echo "293)Yokohama Japan        333)-------------   373)DW Arabic          413)CSPAN 2           453)-----------    493)Talking Tom Mini   533)Al Fady TV Arabic"	
   echo "294)Hokkido Japan         334)-------------   374)DW Espanol         414)CSPAN 3           454)PTV Pakistan   494)-------------      534)Aghapy TV"
   echo "295)Mt Fuji Japan         335)-------------   375)DW English         415)Tagessschau 24    455)Estudio Brasil 495)-------------      535)St. Mary's Coptic"  
   echo "296)--------------        336)-------------   376)CGTN Russian       416)W24 Wein Deutsch  456)TVES           496)-------------      536)Word of God Greek"
   echo "297)Florida Cam 1         337)-------------   377)CGTN French        417)CNN Chile         457)ORA News       497)-------------      537)CBN"       
   echo "298)Florida Cam 2         338)-------------   378)CGTN German        418)Life News Russia  458)Cultura Brasil 498)-------------      538)CBN News "  
   echo "299)Florida Cam 3         339)-------------   379)CGTN Espanol       419)Euronews Russian  459)Light Deutsch  499)-------------      539)NRB "
   echo "300)Florida Cam 4         340)-------------   380)CSPAN 1            420)Publica Moldova   460)Electrosound   500)-------------      540)Shalom TV"  
   echo "301)Durango Colorado      341)-------------   381)CSPAN 2            421)CTV News Canada   461)WGN 9 Chicago  501)-------------      541)Heaven TV"
   echo "302)Star Dot 1            342)-------------   382)CSPAN 3            422)Canale 7 Italy    462)ABC Stream 1   502)-------------      542)Rakshana TV"
   echo "303)-------------         343)-------------   383)------------       423)ABC 24 Albania    463)-----------    503)-------------      543)Powervision TV"
   echo "304)Star Dot 3            344)--------------  384)------------       424)SkyTG 24 Italian  464)Lombardia Italy504)-------------      544)KJV Bible Audio"
   echo "305)Star Dot 4            345)--------------  385)------------       425)Mekameleen Egypt  465)Cremona 1 Italy505)-------------      545)NIV Bible Audio"    
   echo "306)Star Dot 5            346)--------------  386)------------       426)ТРЕЙЛЕР 2 Russia  466)BYUTV          506)-------------      546)Quran English"
   echo "307)Star Dot 6            347)--------------  387)------------       427)Gong Francais     467)BYUTV INT      507)-------------      547)Quran Karim"
   echo "308)London 1              348)--------------  388)------------       428)Congreso Mexicano 468)ABC Stream 1   508)-------------      548)Temple Rodeph Torah" 
   echo "309)London 2              349)--------------  389)------------       429)Mediatv Romania   469)ABC Stream 2   509)-------------      549)Vatican "  
   echo "310)London 3              350)--------------  390)------------       430)О!2 ТВ Russia     470)ABC Stream 3   510)-------------      550)Temple Institute"
   echo "311)Berlin Airport        351)--------------  391)------------       431)BFM SPORT France  471)ABC Stream 4   511)-------------      551)TBN "
   echo "312)Osaka                 352)--------------  392)------------       432)London Live       472)ABC Stream 5   512)-------------      552)Mormon Tabernacle"
   echo "313)Port of Los Angeles   353)--------------  393)------------       433)Bloomberge Eur    473)NBC Stream 1   513)-------------      553)Saudi Gold"	
   echo "314)Osaka Skyline ITSCom  354)--------------  394)------------       434)WDR Deutsch       474)WBTV News      514)-------------      554)Makkha Live "
   echo "315)China Shoreline       355)--------------  395)------------       435)A+ Australia      475)WSJ Live       515)-------------      555)Saudi Silver"
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
entry="$1" 
elif [ "$1" == "" ]
then
channel_matrix
echo "Please Select a Number corresponding to a YouTube Live Stream:"

read entry

if [ "$entry" == "q" ]
then 
echo "Type endstream to open a new stream."
exit "$?"
elif [ "$entry" == "" ]
then
entry=1
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
1) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master.m3u8
link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
use_cookies="no"
chan_name="France 24 English";;
# 2) Al Jazeera
2) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
#  3) TRT World
3) 
keyword="TRT World LIVE"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
# link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 4) Sky News
4)
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
use_cookies="no"
chan_name="Sky News" ;;
# 5) ABC News Australia 
5) 
keyword="Watch ABC News Live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#link=https://abcnews24hls-lh.akamaihd.net/i/news24_1@3259/master.m3u8
use_cookies="no"
chan_name="ABC News Australia" ;;
# 6) CGTN China English
6) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 7) Arirang TV Korea
7) 
keyword="Arirang TV" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
    chan_name="Arirang TV Korea " ;;   
# 8) EuroNews English
8) 
keyword="برنامه زنده"
link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews English" ;; 

#chan_name="EuroNews Arabic" ;;
# Euronews English
#keyword="euronews"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#use_cookies="no"

# 9) BBC News
9) link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC News" ;; 
# 10) DW English
10) 
link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
use_cookies="yes"
chan_name="DW English" ;;
# 11) Russia Today
11) 
#link=http://rt-eng-live.hls.adaptive.level3.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index2500.m3u8
link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index1600.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index800.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index400.m3u8
# link=https://www.filmon.com/tv/russia-today-1
use_cookies="yes"
chan_name="Russia Today" ;;
# 12) Africa News Live
12) 
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 13) ANN7 South Africa
13) 
keyword="ANN7 TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ANN7 News South Africa" ;; 
# 14) Arise News Nigeria/London
14) 
keyword="Arise News Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria/London";;  
# 15) Channels 24 Nigeria
15) 
keyword="Channels Television - Multi Platform Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;   
# 16) TVC News Nigeria
16) 
keyword="TVC News Nigeria Live"
link=rtmp://77.92.76.135:1935/tvcnews/livestream
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 17)  KTN Kenya
17) 
keyword="KTN"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 18) NTV Uganda
18) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 19) i24 News Israel
19) 
keyword="Live"  
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=https://www.dailymotion.com/video/x29atae
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 20) Saudi 2 TV
20) 
keyword="Saudi 2 TV Live Stream"
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Saudi 2 English" ;;   
# 21) Press TV
21) 
link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/playlist.m3u8
# link=https://www.filmon.com/tv/press-tv
use_cookies="yes"
chan_name="Press TV" ;;  
# 22) India TODAY
22)
keyword="IndiaToday Live TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="India TODAY English" ;;   
# 23) CVR English India
23) 
keyword="CVR English Live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English India" ;;   
# 24) # MSNBC
24)
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  
use_cookies="no"
chan_name="MSNBC";;  
# 25) Bloomberg Business USA
25) 
keyword="Global News Coverage on Bloomberg TV"
link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 26) NEWSMAX USA
26) 
keyword="Live News Stream - Newsmax TV"
link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 27) CBSN 
27)
link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?iu=/8264/vaw-can/mobile_web/cbsnews_mobile
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="CBSN" ;;
# 28) ABC News USA
28)
#link=http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
use_cookies="no"
chan_name="ABC News USA" ;;
##### FOX
# 29) Fox News 10 Phoenix Arizona USA
29) 
keyword="\:"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep -ah "$keyword" | grep "watch?v=" | head -n 1 | cut -d \? -f 2 | cut -d \= -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 30) FOX 23 Tulsa Oklahoma
30) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224709/KOKI/904k/prog.m3u8 
use_cookies="no"
chan_name="FOX 23 Tulsa Oklahoma USA" ;;
# 31) FOX 25 Boston Massachusetts
31)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224671/WFXT/904k/prog.m3u8 
use_cookies="no"
chan_name="FOX 25 Boston Massachusetts" ;;
# 32) FOX 30 Jacksonville Florida
32)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224710/WFOX/904k/prog.m3u8
use_cookies="no"
chan_name="FOX 30 Jacksonville Florida" ;;
# 33) VOA
33)
link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
use_cookies="no"
chan_name="VOA" ;;
# 34) Go News
34) 
keyword="NEWS"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/mtyo0b/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Go News" ;;
# 35) RT America
35) 
link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index800.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index400.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 36) RT UK
36) 
link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index800.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index400.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index.m3u8
#link=http://rt-uk-live.hls.adaptive.level3.net/rt/uk/index.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
# 37) C-SPAN 1 HD
37)
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 1" ;;
# 38) CNN America Demo 
38)
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#http://cnn-lh.akamaihd.net/z/cnndotcomlive_2@409537/manifest.f4m?b=600-3500
#http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
use_cookies="no"
chan_name="CNN Demo" ;;
# 39) The Weather Network
39)
link=http://d383mxeq7zv96c.cloudfront.net/api/ott/getVideoStream/USNATIONAL/master.m3u8?country=us
use_cookies="no"
chan_name="The Weather Network" ;;
# 40) Weather Nation
40) 
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
use_cookies="no"
chan_name="Weather Nation" ;; 

#################    FRENCH   ###################################
# 41) France 24 
41) link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
use_cookies="no"
chan_name="France 24" ;;
# 42) France Info 
42) link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news 
use_cookies="no"
chan_name="France Info TV" ;;
# 43) France 24 Francais
43) 
keyword="FRANCE 24 en Direct" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Francais" ;;
# 44) Euronews Francais
44) 
keyword="euronews EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;                                                            
# 45) France Info
45) 
keyword="franceinfo - DIRECT TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Info" ;;
# 46) France Inter
46) 
keyword="France Inter en direct"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
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
# 60) Africa News Francais
60) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 61) RFI
61) 
keyword="RFI en Direct Vidéo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 62) Mosaik TV Francais
62)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 63) Africa24
63) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;;     
# 64) TLM Lyon Metro
64) 
keyword="TLM en Direct"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 65) Elyse.fr
65) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
use_cookies="no"
chan_name="Le Direct de la Presidence de la Republique" ;;
# 66) QVC Francais
66) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;      

###################  SPANISH  #################################
# 67) Magala TV Spain  Malaga,Andalusia,Spain
67)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Magala TV Spain" ;; 
# 68) RT Espanol
68) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RT Espanol" ;;
# 69) DW Espanol
69) 
keyword="DW Español en VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="DW Espanol" ;;
# 70) NTN24 Venezuela
70) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 71) Canal 8 San Juan Argentina
71) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 72) Canal 6 San Rafael Argentina
72) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 73) Canal 7 Mendoza Argentina
73) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 74) c5n Argentina
74) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="c5n Argentina" ;;
# 75) A24 Argentina
75) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 76) TelePacifico Colombia
76) 
keyword="Señal En Vivo - Telepacifico"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TelepacificoCanal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 
# 77) Canal 8 Mar del Plata
77) 
keyword="Emisión en vivo de Canal 8 de Mar del Plata"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 78) Hispan TV
78) 
keyword="HispanTV en vivo - FULL HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
# 79) Globovision Venezeula
79) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 80) Canal 2 Cablenet San Vicente Argentina
80)
keyword="Transmisión en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 81) Excelsior TV Mexico
81) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
# 82) Todo Noticias Argentina
82) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 83) La Nacion TV Argentina
83) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 84) PSN Tijuana Mexico
84) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";;
########### TELEVISIA REGIONALES MEXICO
# 85) Televisia del Golfo Mexico
85)  
keyword="BroadCast_del-golfo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.televisadelgolfo.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisa del Golfo Mexico" ;; 
# 86) Televisia Veracruz Mexico
86) 
keyword="veracruz"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisaveracruz.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Veracruz Mexico" ;; 
# 87) Televisia Matamoros Mexico
87)  
keyword="matamoros"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisanoreste.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Matamoros Mexico" ;; 
# 88) Televisia Zacatecas Mexico
88)  
keyword="zacatecas"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvzacatecas.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Zacatecas Mexico" ;; 
# 89) Televisia Puebla Mexico
89)  
keyword="puebla"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.televisapuebla.tv/video-en-vivo 
use_cookies="no" 
 chan_name="Televisia Puebla Mexico" ;;  
# 90) Televisia Acapuloco Mexico
90)  
keyword="acapulco"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvacapulco.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisia Acapulco Mexico" ;;   
# 91) Televisia Cuernavaca Mexico
91)  
keyword="cuernavaca"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.galatvmorelos.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisia Cuernavaca Mexico" ;;   
# 92) Televisia Leon Mexico
92) 
keyword="leon"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.televisaleon.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisia Leon Mexico" ;; 
# 93) Televisia Queretaro Mexico
93)  
keyword="queretaro"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Queretaro Mexico" ;; 
# 94) Televisa Gudalajera Mexico
94)  
keyword="guadalajara"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
 link=http://www.televisaguadalajara.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Gudalajera Mexico" ;; 
# 95) Televisia Mexicali Mexico
95)  
keyword="mexicali"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisamexicali.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Mexicali Mexico" ;;  
# 96) Televisia Toluca Mexico
96)  
keyword="toluca"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Toluca Mexico" ;;  
# 97) Televisia Hermosillo Mexico
97)  
keyword="hermosillo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Hermosillo Mexico" ;;  
# 98) Televisia Torreon Mexico
98)  
keyword="torreon"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Torreon Mexico" ;;  
##################
# 99) TeleSUR Venezuela
99) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 100)Globovision Venezeula Low Fi
100) 
link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no"
chan_name="Globovision Venezeula" ;; 
# 101) VPI TV Venezuela
101) 
keyword="VPI TV EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="VPI TV" ;;
# 102) Imagen Radio Mexico
102) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 103) Venevision Venezuela
103) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Venevision Venezuela" ;; 
# 104) El Capitolio Venezulana
104) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="El Capitolio Venezulana" ;;    
################ CHINESE MANDARIN CANTONESE  ####################
# 105) CCTV 4 Chinese
105) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;

############## TAIWAN TAIWANESE ##############################
# 106) 119 Live 電視台大立  Tai Li Taiwan
106)
keyword="大立119 網路直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Tai Li Taiwan" ;;
# 107) EBC 51 News Taiwan
107) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 108) EBC Finance Taiwan
108) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
#  109) TzuChi DaAi World Taiwan 
109) 
keyword="DaAi World HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 110) FTV Taiwan
110) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 111) TTV News Taiwan
111) 
keyword="台視新聞台HD直播｜TAIWAN TTV NEWS HD (Live)"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 112) CTV Taiwan
112) 
keyword="中視新聞台 LIVE直播｜Taiwan CTV news HD Live | 台湾のCTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 113) CTS World News HD Taiwan
113) 
keyword="華視新聞HD直播 | CTS Taiwan News Live HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 114) SET News Taiwan
114) 
keyword="三立新聞直播│SET News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 115) CTI Taiwan
115) 
keyword="CTI中天新聞24小時HD新聞直播 │ CTITV Taiwan News HD Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;  
# 116) NeXT TV Taiwan
116) 
keyword="台中壹新聞直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/eranewstest/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Next TV Taiwan" ;;
# 117) Sinda Television
117) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 118) Cheng Sin TV
118) 
keyword="現場直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 119) TLTV
119) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 120) FLTV Taiwan
120) 
keyword="現場直播LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 121) 郭世明
121) 
keyword="全大電視網路直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCdx4XBYPj9s6FZUhEQ9IWkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="郭世明 Guo Shiming";;
# 122) 海豚直播 Dolphin TV
122) 
keyword="海豚直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUz3LiE7QuRGDGZ2DYciIuA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="海豚直播 Dolphin TV";;
# 123) SITTI 1
123) 
keyword="桐瑛1台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 124) SITTI 2
124) 
keyword="桐瑛2台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 125) SITTI 3
125) 
keyword="桐瑛3台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 126) 大愛電視 Tzu Chi DaAiVideo 
126) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 127) 大愛一臺HD Live 直播
127)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;; 
# 128) Kiss Radio 1 Taiwan 
128)
keyword="收聽佔有率第一的流行音樂電台 KISSRADIO 大眾廣播 FM99.9"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 1 Taiwan" ;; 
# 129) Kiss Radio 2 Taiwan 
129)
keyword="南投廣播 FM99.7 /KISSRadio Live Streaming 24/7"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 2 Taiwan" ;; 


###### INDIAN, HINDI, URDU, DARI, PASHTUN##################

# 130) Shirdi Sai Aarthi LIVE
130) 
keyword="Shirdi Sai Aarthi LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Shirdi Sai Aarthi LIVE";;  

# 131) Shaski India
131) 
keyword="Sakshi TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 132) SunNews 
132) 
keyword="SUNNEWS LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 133) TV9 India Live
133) 
keyword="TV9 Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV9 Live India";;    
# 134) Rajya Sabha TV
134) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 135) TV9 Gujarat
135) 
keyword="Tv9 Gujarati LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 136) Tv9 Marathi
136) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9maharashtra/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Tv9 Marathi" ;; 
# 137) Bol TV Pakistan
137) 
keyword="Bol TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCl_yX1yxsnYAgDs2RFJSerg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bol News" ;;
# 138) 92 News Pakistan
138) 
keyword="92 News Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCsgC5cbz3DE2Shh34gNKiog/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="92 News Pakistan";; 
# 139) News 7 Tamil
139) 
keyword="News7 Tamil Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 140) T News Telegu
140)
keyword="T News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="T News Telegu" ;;
## 141) 24 News Pakistan HD
141) 
keyword="Watch Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="24 News Pakistan HD" ;;  
# 142) News 18 India
142) 
keyword="News18 India Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 18 India" ;;
# 143) Aaj Tak 
143) 
keyword="Aajtak Live TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;;
# 144) TV9 Telugu Live
144) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9live/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TV9 Live" ;;
# 145) NTV Telugu
145) 
keyword="NTV Telugu Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 146) ABN Telugu
146) 
keyword="ABN Telugu LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 147) Vanitha TV 
147) 
keyword="Vanitha TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 148) HMT Telugu
148) 
keyword="HMTV Telugu News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 149) TV5 News 
149) 
keyword="Live News Updates"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV5 News" ;;
# 150) Channel 24 India
150) 
keyword="CHANNEL 24 LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/channel24web/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 151) SAMAA TV
151) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV" ;;    
# 152) Survana News
152)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Survana News" ;;   
# 153) ATN News Bangladesh
153) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;     
# 154) No 1 News Telugu
154) 
keyword="No1 News Telugu Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCatI3KKoZyHntflwQIyo65g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="No 1 News" ;;
# 155)i News Telugu
155) 
keyword="I News Telugu Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="i News Telugu" ;; 
# 156) News 1 Kannada 
156)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 157)  Jansari News Kannada 
157)
keyword="News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/JanasriNewsKannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Jansari News Kannada" ;; 
# 158) Media One News
158)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Media One";;
# 159)  Tamil Live News
159) 
keyword="Thalaimurai TV LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Tamil Live News";;
## 160) TOLO NEWS AFGHANISTAN
160) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS";; 
## 161) Dawn News PAKISTAN
161) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dawn News" ;;
## 162) DD News
162) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
## 163) Public TV India
163) 
keyword="Public TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/publictvnewskannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Public TV Kannada" ;;
# 164) REPORTER LIVE
164) 
keyword="REPORTER LIVE Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 165) 
165)
keyword="Puthiya Thalaimurai TV LIVE Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Puthiya Thalaimurai" ;;
# 166) AsiaNet News
166) 
keyword="Asianet News Live TV" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 167)V6 News
167) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
 chan_name="V6 News" ;;
# 168) Kalaignar TV1
168) 
keyword="Kalaignar News LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar TV" ;;
# 169) News 9 Bangalore Karnataka
169)
keyword="news9 live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/news9tv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 9 Bangalore Karnataka" ;;  
# 170) ETV Andhra Pradesh
170) 
keyword="Pradesh Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/newsetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 171) News 18 Tamilnadu
171) 
keyword="News18 TamilNadu | Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 172) The Polimer TV
172) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC8Z-VjXBtDJTvq6aqkIskPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="The Polimer TV" ;;
# 173) Jaya Plus
173) 
keyword="Live Jaya Networks"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) "  
use_cookies="no"
chan_name="Jaya Plus" ;;
# 174) Neo TV India
174) 
keyword="Neo News Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCAsvFcpUQegneSh0QAUd64A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Neo TV India";;
# 175) Samaya News
175) 
keyword="Samaya News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCkOhL1zZGFgkAp3J4NNAT9Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Samaya News Kannada" ;;  
# 176)  The Ekantipur Nepal
176) 
keyword="Kantipur TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheEkantipur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="The Ekantipur Nepal" ;;  
# 177) NepalMandal TV
177) 
keyword="Nepalmandal TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCEorL1RapK1IWOzWAZzKeVw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="NepalMandal TV" ;;  
# 178) TEZ TV
178) 
keyword="Tez Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;  
# 179) Dilli Aaj Tak
179) 
keyword="Dilli Aajtak live TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
################## ARABIC  ##########################################
# 180) EuroNews Arabic
180) 
keyword="برنامه زنده"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Arabic" ;;
# 181) RT Arabic 
181) 
keyword="RT Arabic"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 182) ON E Live 
182) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
# 183)  ON E Sports
183) 
keyword="Live Stream" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCWLo4r-9_x4GCJCFShNFq0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E Sports" ;;   
# 184) ON Live
184) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON Live" ;;
# 185) Al Jazeera Arabic
185) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 186) France 24 Arabic
186) 
keyword="الأخبار "
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 187) BBC Arabic
187) 
keyword="BBC Arabic Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 188) Al Arabiya
188) 
keyword=" المباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya" ;;
# 189) Al Mayadeen
189) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen" ;;   
# 190) Syrian Satellite
190) 
keyword="لفضائية" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Satellite" ;;     
# 191) ORTAS Syrian Satellite
191) 
keyword="الاخبارية السورية"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ORTAS Syria" ;;
# 192) Bedya TV Arabic
192) 
keyword="Bedaya TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bedya TV Arabic" ;;
# 193) 
193)
keyword="قناة بلقيس "
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belqees TV Arabic" ;;
# 194) Saudi TV Blue
194) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Blue" ;;  
# 195) Saudi Finance TV Purple
195) 
keyword="بث مباشر بواسطة"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/EqtsaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Finance TV Purple" ;;
# 196) Saudi Channel 1 Green 
196) 
keyword="القناة" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 1 Green" ;;
# 197) Saudi TV Gold  Mecca Kabba
197) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Gold" ;; 
# 198) Saudi Sliver Educational
198) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Silver" ;; 
# 199) Saudi Cultural TV Orange
199) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Cultural TV Orange" ;;
# 200) Saudi Sports TV Red
200) 
keyword="القنوات"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Sports TV Red" ;;
# 201) DMC Live
201) 
keyword="dmc HD live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE" ;;
# 202) SKY Arabic
202) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic" ;;
# 203) CBC Egypt Arabic Drama 
203) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CBCDramaStream/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 204) eXtra News Egypt Arabic
204) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 205) CBC Egypt Sofra Arabic
205) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 206) Saudi Ajyal Kids Tv
206) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv" ;; 
# 207) Makkha Live (Mecca Kaaba) 
207) 
keyword="Makkah Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClIIopOeuwL8KEK0wnFcodw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mecca Kaaba Live" ;;
# 208)  DW Arabic
208) 
keyword="DW عربية مباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
############### RUSSIAN ################################
# 209) Вести FM Russia
209) 
keyword="Вести ФМ"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0th5BGbQ5l7wxlwGSwDirw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Вести FM Russia" ;;
# 210) Vesti FM Russia
210) 
keyword="Вести ФМ"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 211) Россия 24
211) 
keyword="24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 212) Ukraine Channel 5 
212) 
keyword="5 channel LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 213) Ukraine 112
213) 
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 214) News 1 Ukraine
214) 
keyword="прямого эфира"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 215) Еспресо Ukraine
215) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 216) Thromadske Ukraine
216) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 217) UA TV Ukraine
217) 
keyword="UATV. Прямой эфир - Пряма трансляція - Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Ukraine" ;;

################### TURKEY  ########################  
## 218) TRT Haber Turkey
218) 
keyword="TRTHABER CANLI YAYIN"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 219) NTV Turkey
219) 
keyword="NTV - Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 220) HaberTurk TV
220) 
keyword="Habertürk TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 221) Star TV  Turkish
221) 
keyword="Star TV - Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 222) Fashion 1 Turk TV
222)
keyword="Fashion"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fashion One TV";;
# 223) CNN Turk 
223) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 224) Ari TV Canali Turkish
224) 
keyword="Arti Tv Canlı izle"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzHQ4i-eD5DxjEljsQAoD7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name=" Ari TV Canali Turkish";;
# 225) Ulusal Kanal Turkish
225) 
keyword="Ulusal Kanal Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6T0L26KS1NHMPbTwI1L4Eg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ulusal Kanal";;
# 226) KRT Kulture TV
226) 
keyword="KRTKultur TV Canlı yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 227) Tele 1 Kanali
227) 
keyword="Tele1 TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCoHnRpOS5rL62jTmSDO5Npw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Tele 1 Kanali";;
# 228) Turkmenelie FM
228) 
keyword="Türkmeneli FM Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie FM";;
# 229) Turkmenelie TV
229) 
keyword="Türkmeneli TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie TV";;

# 230) La Legul TV
230) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 231)Number1 TV Canlı Yayın
231)
keyword="Number1 TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 232) Number1 Turk TV
232)
keyword="Number1 Türk"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 233) TGRT Haber TV
233) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 234) TVNET Canali Yayin
234) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 235)NEWSCHANNEL CANLI ( ZINDI )
235)
keyword="NEWSCHANNEL CANLI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCuGfQAjgRaUlmvOIb7yuIyA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="NEWSCHANNEL";;
# 236) Galatasaray 
236) 
keyword="GS TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/2galatasaray/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Galatasaray";;
# 237) A9 Televizyounu 
237) 
keyword="A9 TV Canlı Yayın İzle"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHHeyHIgmp5JEEg6cILSShg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="A9 Televizyounu";;
# 238) STerkTV Zindi 
238) 
keyword="STERKTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 239) Ronahi TV Zindi 
239) 
keyword="RonahiTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";;

# 240) Number1 Turk FM
240)
keyword="Number1 Türk FM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;

################### GREEK ######################################
## 241) Action 24 Greece 
241) 
link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
use_cookies="no"
chan_name="Action 24 Greek" ;;
## 242) Ionian TV
242) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
use_cookies="no"
chan_name="Ionian TV Greek" ;;
## 243) Star Lamia
243) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 244) Blue Sky TV Athens Greece
244) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
#########################################################################
###############    RESTRICTED TO EUROPE     ###########################
# 245) SKY NEWS
245) link=https://www.youtube.com/watch?v=y60wDzZt8yg 
use_cookies="no"
chan_name="SKY NEWS" ;; 
# 246) 
# 247)  EuroNews Deutsch
247) 
keyword="euronews LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;
# 248) Euronews Maygar Hugarian
248) 
keyword="euronews élőben" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsHungarian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Maygar Hungarian" ;;
################# TAGALOG FILIPINO #############################       
# 249) DZMM ABS-CBN Philippeans Radio
249) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 250) DZRH Philippeans
250) 
keyword="DZRH NEWS TELEVISION Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 251) DWIZ Philippeans
251) 
keyword="DWIZ 882 kHz TODONG LAKAS LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUWv18AQ-8k5m9_AEv5lzew/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DWIZ Philippeans" ;;
# 252) PTV Philippines
252) 
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ AFRICAN #################################
# 253) ADOM TV 
253) 
keyword="Adom TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV" ;;    
# 254) Bukedde TV
254) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Bukedde TV" ;;  
################ BRAZIL   ################################
# 255) TV Senado Brazil
255) 
keyword="20"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TVSenadoOficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TV Senado Brazil" ;;
# 256) STF Brazil
256)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 257) Euronews Portuguese
257)  
keyword=
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Portuguese" ;;  

# 257) TV Camara Brazil
# 257)  link=https://www.youtube.com/"$(curl "https://www.youtube.com/channel/UC-ZkSRh-7UEuwXJQ9UMCFJA/videos?&view=2" | grep "watch?v=" | head -n 1 |  cut -d / -f 2 | cut -d \" -f 1)"   
#use_cookies="no"
#chan_name="TV Camara Brazil" ;;  

##########################  Italian  #######################################################
# 258)CTV Vaticano
258) 
keyword="Centro Televisivo Vaticano"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ctvaticano/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CTV Vaticano" ;;
# 259) QVC Itallian
259) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;;
# 260) Euronews Italian ****
260) 
keyword="euronews in diretta"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Italian" ;;
################################## FARSI / PERSIAN  ###########################################################
# 261)  Euronews Persian
261) 
keyword="برنامه"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Persian";;
# 262)  BBC Persian
262) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
#################### TRANSIENT ######################################## 
# 263) OnTV Hong Kong
263) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 264) 
# 265) RSBN News Feed 2
265) 
keyword="LIVE STREAM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Cam 2" ;;
# 266) RUPTLY
266) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;; 
# 267) DeporTV
267)
keyword="DEPORTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCSmh3DFxBwFurMttT60PQ1g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DeporTV" ;; 
# 268) PBS NewsHour Video
268) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PBSNewsHour/videos?&view=0" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 269)  CBC The National
269) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 270) SABC Digital News South Africa
270) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;; 
# 271) AP Top Stories
271) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 272) Democracy Now Headlines 
272) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;    
# 274)  Infowars
274) 
keyword="Infowars"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheAlexJonesChannel/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
# 275) The Young Turks
275) 
keyword="Young Turks"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 

################################ MENU 2 ########################################################
###############    SPACE       ######################### 
# 276)RSBN Auburn Alabama USA
276) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA" ;;  
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
287) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 288) Akiba Japan Live
288) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
# 291) 
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
# 296)   
# 297) Florida Cam 1
297) 
keyword="LIVE Mallory Square Key West"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 1" ;; 
# 298) Florida Cam 2
298) 
keyword="LIVE Two Friends Roof Top"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 2" ;; 
# 299) Florida Cam 3
299) 
keyword="LIVE Marathon FL Cam"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 3" ;; 
# 300) Florida Cam 4
300) 
keyword="LIVE Mallory Square - Key West FL"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 4" ;; 
# 300) Florida Cam 5
300) 
keyword="LIVE Key West Seaport Cam"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 5" ;; 
# 301) Durango Colorado USA
301) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com//channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 302)Star Dot Cam 1
302) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;; 
# 303) 
# 304) Star Dot Cam 3
304) 
keyword="Buena Park"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 3 Buena Park California" ;; 
# 305) Star Dot Cam 4
305) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 306) Star Dot Cam 5
306) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 307) Star Dot Cam 6
307) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 308) Fine Cine London 1
308) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 309) Fine Cine London 2
309) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 310) Fine Cine London 3
310) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 311) Berlin Airport 
311) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 312) Osaka Japan  
312) 
keyword="ITM SKY CAM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/masato663/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Osaka Japan" ;; 
# 313) Port of Los Angeles  
313) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 314)  ITS COM STUDIO Japan  
314) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 315)  China Shoreline 
315) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;; 
# 316) Youing Japan Route 10
316) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 317) Netherlands live cams 6 of them 
317) 
keyword="www.bottercourant.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 1" ;; 
# 318) Netherlands live cams 6 of them 
318) 
keyword="www.vvvzandvoort.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 2" ;; 
# 319) Netherlands live cams 6 of them 
319) 
keyword="www.waddenhaventexel.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 3" ;; 
# 320) Netherlands live cams 6 of them 
320) 
keyword="www.webcamceeskatwijk.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 4" ;; 
# 321) Netherlands live cams 6 of them 
321) 
keyword="www.havenplein.net"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 5" ;; 
# 322) Netherlands live cams 6 of them 
322) 
keyword="https://hartbeach.nl/"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Web NL Cam 6" ;; 
# 323) Naman Seoul Tower South Korea  
323) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 

# 324) NASA ISS Earth Viewing
324)
link=http://iphone-streaming.ustream.tv/uhls/17074538/streams/live/iphone/playlist.m3u8
use_cookies="no"
chan_name=" NASA ISS Earth Viewing" ;;

################# ULTRA ###################################
# 356) Parovi 1 TV Serbian
356) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCQVxuhJGZNPwOwcAstbvX1A/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Parovi TV Serbian";;
# 357) Biafra TV Africa 
357) 
keyword="Biafra Television Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 358) Joy News Ghana
358) 
keyword="Joy News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 359) i24 News Israel
359) 
link=https://www.dailymotion.com/video/x29atae
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 360) CGTN Beijing
360) link=https://www.filmon.com/tv/cctv-news
use_cookies="yes"
chan_name="CGTN Beijing" ;; 
# 361) TWiT
361) link=https://www.twitch.tv/twit 
use_cookies="no"
chan_name="TWiT" ;; 
# 362) High Stakes Poker
362) link=https://www.twitch.tv/highstakespoke 
use_cookies="no"
chan_name="High Stakes Poker" ;; 
# 363) La Casacra TV  ******
363) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/lacascaravod/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="La Casacra TV" ;;
# 364) 100% Noticias Nicaragua  ******* 
364) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/canal15nicaragua100/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="100% Noticias Nicaragua" ;;  
# 365) Number1 Radyo Canlı Yayın
365)
keyword="Number1 FM Radyo Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Radyo Canlı Yayın";;
# 366) Rádio Justiça - Ao Vivo
366)  
keyword="Rádio Justiça - Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 367) Rádio Justiça - Ao Vivo
367)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
# 368) Euronews Espanol
368)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 369) EWTN Spanish 
369) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;;
# 370) EWTN German
370) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 371) EWTN Africa
371) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 372) EWTN Asia
372) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;
# 373) DW 2 Arabic
373)
link=http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8
use_cookies="no"
chan_name="DW Arabic" ;;
# 374) DW 3 Espanol
374)
link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
use_cookies="no"
chan_name="DW 3 Espanol" ;;
# 375) DW 4 English
375)
link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
use_cookies="no"
chan_name="DW English" ;;
# 376) CGTN Russian
376)
link=https://live.cgtn.com/cctv-r.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
# 377) CGTN French
377)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN French" ;;
# 378) CGTN Arabic
378)
link=https://live.cgtn.com/cctv-a.m3u8
use_cookies="no"
chan_name="CGTN German" ;;
# 379) CGTN Espanol
379)
link=https://live.cgtn.com/cctv-e.m3u8
use_cookies="no"
chan_name="CGTN Espanol" ;;
# 380) C-SPAN-1 Live Event
380)
link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN-1 Live Event" ;;
# 381) C-SPAN-2 Live Event
381)
link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN-2 Live Event" ;;
# 382) C-SPAN-3 Live Event
382)
link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN-3 Live Event" ;;

# 376) DW 5
# 376)
#link=http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8
#use_cookies="no"
#chan_name="DW 5" ;;
# 377) DW 6
# 377)
#link=http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8
#use_cookies="no"
#chan_name="DW 6" ;;

################ MEGA ##############################
# 396) Newsy
396) link=https://www.filmon.com/tv/newsy
use_cookies="yes"
chan_name="Newsy" ;;
# 383) VOA
397) link=https://www.filmon.com/tv/voa-english
use_cookies="yes"
chan_name="VOA" ;;
# 398) DVIDs TV
398) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
# 399)  What America Thinks
399) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 400)  Juptier Broadcasting 
400) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="yes"
chan_name="Jupiter Broadcasting" ;;
# 401) TWiT
401) 
keyword="TWiT Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT" ;;
# 402) NASA TV Public Education
402) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 403) NASA TV Media
403) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 404) RT Documentary
404) 
link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
use_cookies="no"
chan_name="RT Documentary" ;;
# 405) CGTN Documentary
405)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 406) HSN
406) 
keyword="HSN Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 407) HSN 2
407) 
keyword="HSN2 Livestream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 408)  QVC 
408) 
keyword="QVC Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 409) The Shopping Channel TSC
409)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 410) CPAC 1 Canada
410)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
# 411) CPAC 1 Francais
411)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
# 412) CPAC 2 Canada
412)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027997492001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
# 413) C-SPAN 2 HD
413)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 2" ;;
# 414) C-SPAN 3 HD
414)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 3" ;;
# 415) Tagessschau 24 Germany
415)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 416) W24 Wein Germany
416)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein Train Ride" ;;
# 417) CNN Chile
417)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
#  418) Life News Russia
418)
link=http://tv.life.ru/lifetv/360p/index.m3u8
use_cookies="no"
chan_name="Life News Russia" ;;
# 419) Euronews Russian
419)
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 420) TV Publica Moldova
420)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
# 421) CTV NEWS Canada
421)
link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#CTV NEWS HD
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News17.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News16.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News14.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News13.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News12.m3u8
#http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News11.m3u8
use_cookies="no"
chan_name="CTV News Canada" ;;
# 422) Canale 7 Italy
422)
link=http://wms.shared.streamshow.it/canale7/canale7/playlist.m3u8
use_cookies="no"
chan_name="Canle 7 Italy" ;;
# 423) ABC NEWS 24 Albania
423)
link=http://xabcalbaniax.api.channel.livestream.com/3.0/playlist.m3u8
use_cookies="no"
chan_name="ABC News 24 Albania" ;;
# 424) SkyTG 24 Italian
424)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 425) Mekameleen (Egypt)
425)
link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/playlist.m3u8
use_cookies="no"
chan_name="Mekameleen Egypt" ;;
# 426) ТВ-ТРЕЙЛЕР 2 Ukraine
426)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="ТВ-ТРЕЙЛЕР 2 Ukraine" ;;
# 427) Gong Asian Cinema Francais
427)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
chan_name="Gong Asian Cinema Francais" ;;
# 428) Canal del Congreso Mexico Spanish
428)
link=http://dl.canaldelcongreso.gob.mx:1935/ccongreso/mp4:congreso2b.mp4/playlist.m3u8
use_cookies="no"
chan_name="Canal del Congreso Mexico Spanish" ;;
# 429) Mediatv Romania
429)
link=http://mediatv.novanet.ro/mediatv/mediatv.m3u8
use_cookies="no"
chan_name="Mediatv Romania" ;;
# 430) О2 ТВ
430)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="Mediatv Romania" ;;
# 431) BFM SPORT Francais
431)
link=http://rmc-i.akamaihd.net/hls/live/218333/876630703001/BFMSPORT/master-4.m3u8
use_cookies="no"
chan_name="BFM Sport Francais" ;;
# 432) London Live 
432)
link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
use_cookies="no"
chan_name="London Live" ;;
# 433) Bloomberg Europe
433)
link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/primary.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 434) WDR Germany
434)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 435) A Plus Australia
435)
link=rtmp://118.97.183.196/jhos//aplus
use_cookies="no"
chan_name="A Plus Australia" ;;
# 436) PAC-12 Net. Arizona
436)
link=http://xrxs.net/video/live-p12ariz-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Arizona" ;;
# 437) PAC-12 Net. Bay Area
437)
link=http://xrxs.net/video/live-p12baya-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Bay Area" ;;
# 438) PAC-12 Net. Los Angeles
438)
link=http://xrxs.net/video/live-p12losa-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Los Angeles" ;;
# 439) PAC-12 Net. Mountain
439)
link=http://xrxs.net/video/live-p12moun-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Mountain" ;;
# 440) PAC-12 Net. Oregon
440)
link=http://xrxs.net/video/live-p12oreg-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Oregon" ;;
# 441) PAC-12 Net. Washington
441)
link=http://xrxs.net/video/live-p12wash-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Washington" ;;
# 442)USA-BASKET UNI Arizona
442)
link=http://xrxs.net/video/live-p12ariz-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Arizona" ;;
# 443)USA-BASKET UNI Los Angeles
443)
link=http://xrxs.net/video/live-p12losa-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Los Angeles" ;;
# 444)USA-BASKET UNI Mountain
444)
link=http://xrxs.net/video/live-p12moun-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Mountain" ;;
# 445)USA-BASKET UNI Oregon
445)
link=http://xrxs.net/video/live-p12oreg-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Oregon" ;;
# 446)USA-BASKET UNI Washington
446)
link=http://xrxs.net/video/live-p12wash-2328.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Washington" ;;
# 447)BBC Arabic
447)
link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
use_cookies="no"
chan_name="BBC Arabic" ;;
# 448)Fox News Talk
448)
link=http://fnurtmp-f.akamaihd.net/i/FNRADIOHDS_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;;
#  449) Adult Swim 
449) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
#  450) Adult Swim Animated Marathon 
450) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Animated Marathon" ;;
#  451) Adult Swim Live Action Marathon 
451) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/live-action-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Live Action Marathon" ;;
# 452)
# 453)
# 454)PTV Pakistan
454)
link=http://79.143.186.149:1935/live/PTVhome/player.m3u8
use_cookies="no"
chan_name="PTV Pakistan" ;;
# 455)TV Estúdio Brasil
455)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 456)TVES
456)
link=rtmp://cast.streamingconnect.tv:1935/tves2/tves2 
use_cookies="no"
chan_name="TVES" ;;
# 457)ORA News
457)
link=rtmp://81.7.13.162/oranews//oranews
use_cookies="no"
chan_name="ORA News" ;;
# 458)TV Cultura Brasil HD 
458)
link=http://wowza.catve.com.br:1935/live/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV Cultura Brasil HD" ;;
# 459)Light Channel DE
459)
link=rtmp://streamer1.streamhost.org/salive//lctvde
use_cookies="no"
chan_name="Light Channel DE" ;;
# 460) Electrosound TV
460)
link=rtmp://www.electrosound.tv/public/stream
use_cookies="no"
chan_name="Electrosound TV" ;;
# 461) WGN 9 Chicago
461) link=http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
# 462) ABC Live Stream 1
462) 
link=http://abclive.abcnews.com/i/abc_live1@136327/master.m3u8
use_cookies="no"
chan_name="ABC Live Stream 1" ;;
# 463) 
# 464) Telecolor Lombardia Italy
 464)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 465) Cremona 1 Italy
465)
link=http://cremona1.econcept.it/live/cremona1_high.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Cremona 1 Italy" ;;
# 466) BYUTV
466)
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
use_cookies="no"
chan_name="BYUTV" ;;
# 467) BYUTV International
467)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
# 468) ABC News Digital 1
468)
link=http://abclive.abcnews.com/i/abc_live1@136327/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 1" ;;
# 469) ABC News Digital 2
469)
link=http://abclive.abcnews.com/i/abc_live2@136328/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 2" ;;
# 470) ABC News Digital 3
470)
link=http://abclive.abcnews.com/i/abc_live3@136329/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 3" ;;
# 471) ABC News Digital 4
471)
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 4" ;;
# 472) ABC News Digital 5
472)
link=http://abclive.abcnews.com/i/abc_live5@136331/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 5" ;;
# 473) NBC News Live Event
473)
link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
use_cookies="no"
chan_name="NBC News Live Event" ;;
# 474) WBTV News
474)
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
use_cookies="no"
chan_name="WBTV News" ;;
# 475) WSJ Live
475)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
################### SAIAJIN #############################
# 476) Earthquake 24  
476) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 477) KBS Live 24 Japan  
477) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
# 478) TBS Live Korea  
478) 
keyword="tbs TV LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 479) YTN DMB Korea  
479) 
keyword="와이티엔 _DMB"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 480) YTN Life Korea  
480) 
keyword="YTN"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnweatherlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Life Korea" ;; 
# 481) YTN Science Korea  
481) 
keyword="YTN SCIENCE_LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnsciencelive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 482) Channel 23 Korea  
482) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 483) BSC 24 1
483) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 484) BSC 24 2
484) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 485) KBS World 24 Korea
485) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 486) YTN 27 Korea
486)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN 27 Korea" ;;   
#  487) QVC JAPAN SHOPPING CHANNEL
487) 
keyword="【QVCライブ】 24時間365日休まず生放送！！"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 488) Sol!ve 24 Japan
488) 
keyword="SOLiVE24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
#  489) Arirang Radio English 
489) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
#  490) ANIBOX 
490) 
keyword="ANI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCiFSWD-BKjiOgqo4gIBOBOg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANIBOX" ;;
#  491) Toonami 
491) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
use_cookies="no"
chan_name="Toonami" ;;
# 492) Talking Tom and Friends
492) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 493) Talking Tom and Friends Minis
493) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    

################# GOD MODE  ############################
# 516) CTV Vaticano
516) 
keyword="Centro Televisivo Vaticano"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ctvaticano/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CTV Vaticano" ;;
# 517) EWTN English
517) 
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283781001
use_cookies="no"
chan_name="EWTN America" ;;
# 518) EWTN Ireland 
518) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409261120001
use_cookies="no"
chan_name="EWTN Ireland" ;;
# 519) Amazing Facts TV (Christian)
519) 
keyword="AFTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 520) It's Supernatural! Network (Christian)
520) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 521) Sheppard's Chapel (Christian)
521) 
keyword="Chapel"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Sheppard's Channel" ;;
# 522) International House of Prayer (IHOP) (Christian)
522) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 523) Belivers Voice of Victory Network
523) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 524) Three Angels BroadCasting
524) 
keyword="Three Angels Broadcasting Network (3ABN) Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels BroadCasting" ;; 
# 525) TCT HD
525) 
keyword="TCT Network Live HD Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT HD" ;; 
# 526) TCT SD
526) 
keyword="TCT Network Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT SD" ;; 
# 527) TCT Kids
527) 
keyword="TCT Network Live TCTKids Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT Kids" ;; 
# 528) Salt and Light TV Portage Michigan
528) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 529) LLBN TV
529) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 530) Harbor Light Radio
530) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 531) Hillsong Channel
531)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 532) Al Hayat TV Arabic
532) 
keyword="Al Hayat TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/alhayatchanneltv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Hayat TV Arabic" ;; 
# 533) Al Fady TV Arabic
533) 
keyword="قناة الفادى الفضائية | قناة"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6CtFtvwAWQBLt3dx9l7arg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Fady TV Arabic" ;; 
# 534) Aghapy TV
534) 
keyword="Aghapy TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC97YtaFaO3lUTcG4dCmgr5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aghapy TV" ;; 
# 535) St. Marys Coptic
535) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 536) Word of God Greek
536) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 537) CBN
537)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 538)CBN News
538)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 539)NRB Network
539)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 540) Shalom TV
540) 
keyword="Shalom"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ShalomTelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shalom TV" ;; 
# 541) Heaven TV
541) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 542) Rakshana TV
542) 
keyword="Rakshana TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/jakkulaBenhur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rakshana" ;; 
# 543) Powervision TV
543) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 544) KJV Audio
544) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio" ;; 
# 545) NIV BIBLE
545) 
keyword="NIV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC5XDvksZ1ysCwHYt90oi2QQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 546) Quran English Arabic
546) 
keyword="Quran Hidayah English TV Channel"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 547) Quran Karim Arabic
547) 
keyword="القاهرة - بث"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzv6uVYjfvE8X-_F3cicWog/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran Karim Arabic" ;; 
# 548) Temple Rodeph Torah 
548) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCWVE8wQWqr0b7wU_ao41V0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Temple Rodeph Torah" ;; 
# 549) Vatican
549) 
keyword="201"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/vatican/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Vatican" ;; 
# 550) Temple Institute
550) 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
# 551) TBN
551)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 552) Mormon Tabernacle Choir 
552) 
keyword="Music"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/MormonTabChoir/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mormon Tabernacle Choir" ;;
# 553) Saudi TV Gold  Mecca Kabba
553) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Gold" ;; 
# 554) Makkha Live (Mecca Kaaba) 
554) 
keyword="Makkah Live HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClIIopOeuwL8KEK0wnFcodw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mecca Kaaba Live" ;;
# 555) Saudi Sliver Educational
555) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Silver" ;; 

esac
}

# initialize menu
menu="m"

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
menu="q"
elif [ "$input" == "n" ]
then 
menstat="yes"
menu="n"
elif [ "$input" == "m" ]
then
menstat="yes"
menu="m"
elif [ "$input" == "+" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "+++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "++++" ]
then
menstat="no"
chan_state="+"
elif [ "$input" == "-" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == "--" ]
then
menstat="no"
chan_state="-"
elif [ "$input" == " " ]
then
menstat="no"
chan_state="return"
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

num=1

menu_status $entry

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
else 
num="$entry"
fi


# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select "$num"
 echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
  
 menu_switch "$menu" 
 echo "You were watching "$chan_name" on Channel "$num" "
 chan_state="normal"
 read entry
 else 
 menu_switch "$menu"
 read entry
fi

while [ "$entry" != q ]
do
menu_status $entry

if [ "$chan_state" == "+" ]
then
num=$(expr "$num" + 1 )
elif [ "$chan_state" == "-" ]
then
num=$(expr "$num" - 1 )
elif [ "$chan_state" == "return" ]
then
num="$num"
else 
num="$entry"
fi

if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  menu_switch "$menu"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --no-resume-playback --cache="$cache_size" --fullscreen "$link" 
  fi
  
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
read entry
else 
menu_switch "$menu"
chan_state="normal"
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