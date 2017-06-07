#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.32
# Revision Date: June 4, 2017
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
version="0.33"
rev_date="04/06/2017"
branch="gnu/linux"
##################################################

chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   ======================================================================="
   echo "||      ENGLISH       ||      FRANCAIS        ||       ESPANOL      ||    ASIAN / INDIAN  ||     INDIAN/ARABIC   ||    ARABIC/TURKISH  ||      OTHER          ||"
   echo "================================================================================================================================================================="
   echo "1)France 24 English   41)France 24 Francais   80)Canal 2 San Vicente 119)Sinda Television 159)Media One          198)Saudi Silver      238)Euronews Deutsch"    
   echo "2)SKY News London     42)France Info TV       81)Excelsior TV Mexico 120)Cheng Sin TV     160)Tamil Live         199)Saudi Orange      239)Tagessschau 24 " 
   echo "3)BBC World News      43)Euronews Francais    82)TN Argentina        121)TLTV             161)TOLO NEWS Afghan   200)Saudi Red         240)W24 Wein Deutsch   "  
   echo "4)BBC News London     44)France Info Radio    83)La Nacion Argentina 122)FLTV Taiwan      162)Dawn News Pakistan 201)DMC Live          241)WDR Deutsch  "             
   echo "5)EuroNews English    45)France Inter         84)PSN Tijuna Mexico   123)Guo Shiming TV   163)DD News India      202)SKY Arabic        242)-------------"  
   echo "6)DW English          46)RTL En Direct        85)TV del Golfo Mexico 124)Dolphin TV       164)Public TV India    203)CBC Egypt Drama   243)Euronews Russian"  
   echo "7)Russia Today        47)Journal TVLandes     86)TV Veracruz Mexico  125)SITTI 1          165)REPORTER LIVE      204)eXtra News Egypt  244)Vesti FM"
   echo "8)CBSN USA            48)BMF TV               87)TV Matamoros Mexico 126)SITTI 2          166)Puthiya Thalaimurai205)CBC Egypt Sofra   245)Russia 24"
   echo "9)MSNBC USA           49)i24 France           88)TV Zacatecas Mexico 127)SITTI 3          167)AsiaNet News       206)Saudi Ajyal Tv    246)Ukraine 5 "
   echo "10)Bloomberg USA      50)Europe 1             89)TV Puebla Mexico    128)TzuChi DaAiVideo 168)V6 News            207)Mecca Kaaba       247)Ukraine 112"
   echo "11)NEWSMAX USA        51)Africa News Francais 90)TV Acapulco Mexico  129)TzuChi DaAiVideo2169)Kalaignar TV       208)DW Arabic         248)News 1 Ukraine"
   echo "12)ABC News           52)RFI                  91)TV Cuernavaca Mexico130)OnTV Hong Kong   170)ETV Andhra Pradesh 209)Mekameleen Egypt  249)Ecnpeco Ukraine"
   echo "13)CNN Demo           53)Mosaik TV            92)TV Leon Mexico      131)News 9 Bangalore 171)News 18 Tamilnadu  210)CGTN Arabic       250)Thromadske Ukraine"
   echo "14)Al Jazeera English 54)Africa24             93)TV Queretaro Mexico 132)India Today      172)Polimer TV         211)TRT Haber Turkey  251)UA TV Ukraine"
   echo "15)TRT World Istanbul 55)TLM Lyon Metro       94)TV Gudalajera Mexico133)CVR English      173)Jaya Plus          212)NTV Canli         252)CGTN Russian "  
   echo "16)i24 News Israel    56)CGTN Francais        95)TV Mexicali Mexico  134)Shaski India     174)Neo TV India       213)Haber Turk TV     253)Life News Russia"
   echo "17)Saudi 2 English    57)ICI RDI Canada       96)TV Toluca Mexico    135)SunNews  India   175)Ekantipur Nepal    214)Star TV Turkey    254)ТРЕЙЛЕР 2 Russia"
   echo "18)Press TV Iran      58)TV5 Monde            97)TV Hermosillo Mexico136)TV 9 News India  176)Nepal Mandal       215)Fashion 1 Turk    255)DZMM Philippeans"	
   echo "19)CGTN Beijing       59)TV5+ Monde           98)TV Toreon Mexico    137)Rajya Sabha TV   177)TEZ TV             216)CNN Turk          256)DZRH Philippeans"
   echo "20)ABC Australia      60)BFM Sport            99)TeleSur Venezuela   138)TV9 Gujarat      178)Dilli Aaj Tak      217)-------------     257)DWIZ Philippeans"  
   echo "21)NHK Japan          61)QVC Francais         100)Imagen Radio Mexico139)TV9 Marathi      179)PTV Pakistan       218)Ulusal Kanal      258)PTV Philippeans"
   echo "22)NewsAsia Singapore 62)Max FM 92.9          101)CNN Chile          140)Bol TV Pakistan  =======ARABIC========= 219)KRT Kulture TV    259)STF Brazil"       
   echo "23)Arirang Korea      63)Gong Cinema          102)TVES Spain         141)92 News Pakistan 180)EuroNews Arabic    220)Tele 1 Kanali     260)Estudio Brasil"  
   echo "24)CNN Phillippeans   64)M7 Mali              103)Congreso Mexicano  142)News 7 Tamil     181)RT Arabic          221)Turkmenelie FM    261)Cultura Brasil"
   echo "25)Africa News        65)CGTN Francais        104)El Capitolio       143)T News Telugu    182)ON E Arabic        222)Turkmenelie TV    262)Canale 7 Italy" 
   echo "26)ANN7 South Africa  66)Public Senate        105)EWTN Espanol       144)24 News Pakistan 183)ON E Sport         223)La Legul TV       263)SkyTG 24 Italy"
   echo "27)Arise News Nigeria ====SPANISH LANGUAGE=== 106)CGTN Espanol       145)News 18 India    184)ON Live            224)Number 1 TV       264)Lombardia Italy"
   echo "28)Channels 24 Nigeria67)Magala24 Spain       ====ASIAN LANGUAGE==== 146)Aaj Tak          185)Al Jazeera         225)Number 1 Turk     265)Cremona 1 Italy"
   echo "29)VOA                68)RT Espanol           107)CCTV 4 China       147)NTV Telugu       186)France 24 Arabic   226)TGRT Haber TV     266)QVC Italian "
   echo "30)CSPAN 1            69)DW Espanol           108)Tai Li 119 Taiwan  148)ABN Telugu       187)BBC Arabic         227)TVNET Canali Yayin267)Euronews Persian"    
   echo "31)RT America         70)NTN24 Venezuela      109)EBC 51 Taiwan      149)Vanitha TV       188)Al Arabiya         228)NEWSCHANNEL Zindi 268)BBC Persian"
   echo "32)RT UK              71)Canal 8 San Juan     110)EBC Finance Taiwan 150)HMT Telugu       189)Al Mayadeen        229)Galatasaray       269)RSBN Feed 2"
   echo "33)FOX 10 Phoenix     72)Canal 6 San Rafael   111)DaAi World Taiwan  151)TV5 News         190)Syrian Satellite   230)A9 Televizyounu   270)RUPTLY  " 
   echo "34)FOX 23 Tulsa       73)Canal 7 Mendoza      112)FTV Live Taiwan    152)Channel 24       191)ORTAS Syria        231)STerkTV Zindi     271)PBS NewsHour"  
   echo "35)FOX 25 Boston      74)c5n Argentina        113)TTV Taiwan         153)SAMAA TV Pakistan192)Bedya TV Arabic    232)Ronahi TV Zindi   272)CBC The National"
   echo "36)FOX 30 Jacksonville75)A24 Argentina        114)CTV Taiwan         154)Survana News     193)Belqees TV Arabic  233)Number1 Turk FM   273)SABC South Africa"
   echo "37)CBS 47 Jacksonville76)TelePacifico Colombia115)CTS Taiwan         155)ATN  Bangladesh  194)Saudi Blue News    234)Action 24 Greek   274)AP Top Stories "
   echo "38)WGN 9 Chicago      77)Canal 8 Mar Plata    116)SET Taiwan         156)i News           195)Saudi Purple       235)Ionian Greek      275)Democracy Now"	
   echo "39)Weather Channel    76)HispanTV             117)CTI Taiwan         157)News 1 Kannada   196)Saudi Green        236)Star Lamia Greek  276)Infowars"
   echo "40)Weather Nation     79)Globovision Venezuela118)NEXT TV Taiwan     158)Jansari News     197)Saudi Gold         237)Blue Sky Athens   277)TYT"
   echo "=============================================================================================================================================================="
}	               

channel_matrix_2()
{
   echo "==================================================================      ENDSTREAM  "$version"   ================================================================"
   echo "||      LOCATIONS       ||      SUPER       ||      ULTRA         ||       MEGA        ||    OK           ||        SAIAJIN      ||      GOD MODE      ||"
   echo "=========================================================================================================================================================="
   echo "278)NASA ISS             318)Youing Japan   358)Adom TV            398)Newsy USA        438)PAC-12 Arizona 478)Earthquake 24     518)CTV Vaticano "    
   echo "279)NASA ISS 1           319)Webcam NL 1    359)Biafra TV Africa   399)DVIDs            439)PAC-12 Bay Area479)KBS 24 Japan      519)EWTN Americas " 
   echo "280)NASA ISS 2           320)Webcam NL 2    360)Joy News Ghana     400)America Thinks?  440)PAC-12 LA      480)TBS Live Korea    520)EWTN Ireland "  
   echo "281)Venice Italy Bridge  321)Webcam NL 3    361)KTN Kenya          401)Jupiter Broadcast441)PAC-12 Mountain481)YTN DMB Korea     521)Amazing Facts"             
   echo "282)Venice Italy Port    322)Webcam NL 4    362)NTV Uganda         402)TWiT             442)PAC-12 Oregon  482)YTN Life Korea    522)It's Supernatural!"  
   echo "283)Jackson Hole XSec    323)Webcam NL 5    363)TVC Nigeria        403)NASA TV Education443)PAC-12 Wash    483)YTN Science Korea 523)Sheppard's Chapel"  
   echo "284)Jackson Hole Square  324)Webcam NL 6    364)High Stakes Poker  404)NASA TV Media    444)Uni Arizona    484)Channel 23 Korea  524)IHOP"
   echo "285)Jackson Hole Rustic  325)Naman Tower    365)Number1 FM Radyo   405)RT Documentary   445)Uni LA         485)BSC 24 1 Japan    525)BVOVN"
   echo "286)Verona Italy         326)The Church Chan366)Rádio Justiça      406)CGTN Documentary 446)Uni Mountain   486)BSC 24 2 Japan    526)3ABN"
   echo "287)Soggy Dollar BVI     327)Smile of Child 367)Rádio Justiça      407)HSN 1            447)Uni Oregon     487)KBS World 24 Korea527)TCT HD"
   echo "288)Amsterdam Netherlands328)NRB Network    368)Euronews Espanol   408)HSN 2            448)Uni Wash       488)YTN 27 Korea      528)TCT SD"
   echo "289)SHIBUYA JAPAN        329)JUCE TV        369)CSPAN 1            409)QVC English      449)FOX News Talk  489)QVC JAPAN         529)TCT Kids"
   echo "290)Akiba Japan          330)106.7 The Fan  370)CSPAN 2            410)TCS              450)Adult Swim     490)Sol!ve 24 Japan   530)Salt and Light"
   echo "291)Bridge Japan         331)105.7 The Fan  371)CSPAN 3            411)CPAC 1           451)Adult Swim Live491)Arirang Radio     531)LLBN TV"
   echo "292)Steamy Mount Japan   332)Family Freindly372)ICI RDI Canada     412)CPAC 1 Francais  452)ORA News       492)AniBox            532)Harbor Light Radio"  
   echo "293)-------------        333)Rap Resurection373)ICI CBVT Quebec    413)CPAC 2           453)Electrosound   493)Toonami           533)Hillsong"
   echo "294)Shizuoka Japan       334)Animal Planet  374)ICI CBOFT Ottawa   414)CSPAN 2          454)BYUTV          494)Talking Tom       534)Al Hayat TV Arabic"
   echo "295)Yokohama Japan       335)TRT Beleges    375)ICI CKTM Trois Riv 415)CSPAN 3          455)BYUTV INT      495)Talking Tom Mini  535)Al Fady TV Arabic"	
   echo "296)Hokkido Japan        336)Go News        376)ICI CJBR Rimouski  416)О!2 ТВ Russia    456)ABC Stream 1   496)Adult Swim Ani    536)Aghapy TV"
   echo "297)Mt Fuji Japan        337)------------   377)ICI CKTV Saguenay  417)Publica Moldova  457)ABC Stream 2   497)CTS Korea         537)St. Mary's Coptic"  
   echo "298)RSBN Auburn AL USA   338)------------   378)ICI CKSH Shearbroke418)Mediatv Romania  458)ABC Stream 3   498)-----------       538)Word of God Greek"
   echo "299)Florida Cam 1        339)-----------    379)ICI CBFT Montreal  419)Euronews Magyar  459)ABC Stream 4   499)-----------       539)CBN"       
   echo "300)Florida Cam 2        340)------------   380)Venevision         420)London Live      460)ABC Stream 5   500)------------      540)CBN News "  
   echo "301)Florida Cam 3        341)------------   381)Euronews           421)Bloomberge Eur   461)NBC Stream 1   501)-------------     541)NRB "
   echo "302)Florida Cam 4        342)-------------  382)-------------      422)A+ Australia     462)WBTV News      502)-------------     542)Shalom TV"  
   echo "303)Durango Colorado     343)-------------  383)------------       423)CTV News Canada  463)WSJ Live       503)-------------     543)Heaven TV"
   echo "304)Star Dot 1           344)-------------  384)--------------     424)---------------  464)Kiss Radio 1   504)-------------     544)Rakshana TV"
   echo "305)-------------        345)-------------  385)--------------     425)---------------  465)Kiss Radio 2   505)-------------     545)Powervision TV"
   echo "306)Star Dot 3           346)-------------- 386)--------------     426)---------------  466)------------   506)-------------     546)KJV Bible Audio"
   echo "307)Star Dot 4           347)-------------- 387)--------------     427)--------------   467)---------      507)-------------     547)NIV Bible Audio"    
   echo "308)Star Dot 5           348)-------------- 388)--------------     428)---------------  468)----------     508)-------------     548)Quran English"
   echo "309)Star Dot 6           349)-------------- 389)--------------     429)---------------  469)-----------    509)-------------     549)EWTN Deutsch"
   echo "310)London 1             350)-------------- 390)--------------     430)---------------  470)-----------    510)-------------     550)Temple Rodeph Torah" 
   echo "311)London 2             351)-------------- 391)------------       431)---------------  471)-----------    511)-------------     551)Vatican "  
   echo "312)London 3             352)-------------- 392)------------       432)-------------    472)-----------    512)-------------     552)Temple Institute"
   echo "313)Berlin Airport       353)-------------- 393)-----------        433)-------------    473)-----------    513)-------------     553)TBN"
   echo "314)Osaka                354)-------------- 394)-----------        434)-----------      474)-----------    514)-------------     554)Mormon Tabernacle"
   echo "315)Port of Los Angeles  355)-------------- 395)-------------      435)---------------  475)-----------    515)-------------     555)EWTN Spanish"	
   echo "316)Osaka Skyline ITSCom 356)-------------- 396)-----------        436)--------------   476)-----------    516)-------------     556)EWTN Africa"
   echo "317)China Shoreline      357)-------------- 397)----------         437)------------     477)-----------    517)-------------     557)EWTN Asia"
   echo "========================================================================================================================================================="
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

## Channel Selection function  (ADD CHANNELS HERE)
channel_select()
{

chan_num=$1

case $chan_num in 
################    ENGLISH     ##################################
################      EUROPE    #################################
# 1) France 24 Anglais 
1) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
use_cookies="no"
chan_name="France 24 English";;
# 2) Sky News
2)
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
use_cookies="no"
chan_name="Sky News" ;;
# 3) BBC World News
3) 
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_1.m3u8
#link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC World News" ;; 
# 4) BBC News London
4) 
#link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_1.m3u8
link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC News London" ;; 
# 5) EuroNews English
5) 
keyword="برنامه زنده"
link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews English" ;; 
# 6) DW English
6) 
link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
use_cookies="yes"
chan_name="DW English" ;;
# 7) Russia Today
7) 
#link=http://rt-eng-live.hls.adaptive.level3.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index2500.m3u8
link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index1600.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index800.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index400.m3u8
# link=https://www.filmon.com/tv/russia-today-1
use_cookies="yes"
chan_name="Russia Today" ;;
########################## USA MAINSTREAM ###################################################
# 8) CBSN 
8)
link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?iu=/8264/vaw-can/mobile_web/cbsnews_mobile
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="CBSN" ;;
# 9) # MSNBC
9)
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  
use_cookies="no"
chan_name="MSNBC";;  
# 10) Bloomberg Business USA
10) 
keyword="Global News Coverage on Bloomberg TV"
link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 11) NEWSMAX USA
11) 
keyword="Live News Stream - Newsmax TV"
link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 12) ABC News USA
12)
#link=http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
use_cookies="no"
chan_name="ABC News USA" ;;
# 13) CNN America Demo 
13)
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#http://cnn-lh.akamaihd.net/z/cnndotcomlive_2@409537/manifest.f4m?b=600-3500
#http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
use_cookies="no"
chan_name="CNN Demo" ;;
############################# MIDDLE EAST ##############################################################
# 14) Al Jazeera
14) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
# 15) TRT World
15) 
keyword="TRT World LIVE"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
# link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 16) i24 News Israel
16) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
format=hls-2362
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 17) Saudi 2 TV
17) 
keyword="Saudi 2 TV Live Stream"
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Saudi 2 English" ;;   
# 18) Press TV
18) 
link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/playlist.m3u8
# link=https://www.filmon.com/tv/press-tv
use_cookies="yes"
chan_name="Press TV" ;;  
#############################  ASIA-OCEANIA   ##################################################################
# 19) CGTN China English
19) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 20) ABC News Australia 
20) 
keyword="Watch ABC News Live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#link=https://abcnews24hls-lh.akamaihd.net/i/news24_1@3259/master.m3u8
use_cookies="no"
chan_name="ABC News Australia" ;;
# 21)NHK World Japan 
21) 
link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8
use_cookies="no"
chan_name="NHK World Japan" ;;
# 22)NewsAsia Singapore
22) 
link=http://imtcnai-lh.akamaihd.net/i/cnai_main@334572/master.m3u8
use_cookies="no"
chan_name="NewsAsia Singapore" ;;
# 23) Arirang TV Korea
23) 
keyword="Arirang" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Arirang TV Korea" ;;  
# 24) CNN PHILIPPINES
24)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
chan_name="CNN PHILIPPINES";;
########################### DEVELOPING NATIONS ############################################
# 25) Africa News Live
25) 
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 26) ANN7 South Africa
26) 
keyword="ANN7 TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ANN7 News South Africa" ;; 
# 27) Arise News Nigeria/London
27) 
keyword="Arise News Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria/London";;  
# 28) Channels 24 Nigeria
28) 
keyword="Channels Television - Multi Platform Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;   
################## AMERICAN GOVERNMENT ############################
# 29) VOA
29)
link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#link=https://www.filmon.com/tv/voa-english
use_cookies="no"
chan_name="VOA" ;;
# 30) C-SPAN 1 HD
30)
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 1" ;;
############################ RT Regional ######################################################
# 31) RT America
31)
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index400.m3u8 
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index800.m3u8
link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 32) RT UK
32) 
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index2500.m3u8
link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index800.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index400.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index.m3u8
#link=http://rt-uk-live.hls.adaptive.level3.net/rt/uk/index.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
########################## Local Stations #############################################
# 33) Fox News 10 Phoenix Arizona USA
33) 
keyword="\:"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep -ah "$keyword" | grep "watch?v=" | head -n 1 | cut -d \? -f 2 | cut -d \= -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 34) FOX 23 Tulsa Oklahoma
34) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224709/KOKI/904k/prog.m3u8 
use_cookies="no"
chan_name="FOX 23 Tulsa Oklahoma USA" ;;
# 35) FOX 25 Boston Massachusetts
35)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224671/WFXT/904k/prog.m3u8 
use_cookies="no"
chan_name="FOX 25 Boston Massachusetts" ;;
# 36) FOX 30 Jacksonville Florida
36)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224710/WFOX/904k/prog.m3u8
use_cookies="no"
chan_name="FOX 30 Jacksonville Florida" ;;
# 37) CBS 47 Jacksonville Florida
37)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224714/WJAX/904k/prog.m3u8
use_cookies="no"
chan_name="CBS 47 Jacksonville Florida" ;;
# 38) WGN 9 Chicago
38) 
link=http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
############################ Weather ###############################
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
41)
keyword="FRANCE 24 en Direct" 
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#format=hls-2362
chan_name="France 24" ;;
# 42) France Info TV
42) 
keyword="franceinfo"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=http://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
use_cookies="no"
chan_name="France Info TV" ;;
# 43) Euronews Francais
43) 
keyword="euronews EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;                                                            
# 44) France Info Radio
44) link=http://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
use_cookies="no"
chan_name="France Info Radio" ;;
# 45) France Inter
45) 
keyword="France Inter en direct"
link=http://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;;
# 46) RTL En direct
46) link=http://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
use_cookies="no"
format=hls-2362
chan_name="RTL En Direct" ;;
# 47) Direct Journal TVLandes    
47) link=http://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-2362
chan_name="Direct Journal Tvlandes"  ;;      
# 48) BMF TV
48) link=http://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
use_cookies="no"
format=hls-2362
chan_name="BMF TV";;
# 49) i24 News en Direct
49) link=http://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-2362
chan_name="i24 Francais";;
# 50) Europe 1
50) link=http://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
format=hls-2362
chan_name="Europe 1" ;;
# 51) Africa News Francais
51) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 52) RFI
52) 
keyword="RFI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 53) Mosaik TV Francais
53)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 54) Africa24
54) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;;     
# 55) TLM Lyon Metro
55) 
keyword="TLM en Direct"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 56) CGTN Francais
56)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;;
# 57) ICI RDI Canada
57)
link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
#link=http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_400_av-p.m3u8?sd=10&rebase=on
#link=http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_800_av-p.m3u8?sd=10&rebase=on
#link=http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on
#link=http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/master.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="ICI RDI Canada" ;;
# 58)TV5 monde 
58)
link=http://v3fbs247hls-i.akamaihd.net/hls/live/219079/v3fbs247hls/v3fbs247hls_1_1.m3u8
use_cookies="no"
chan_name="TV5 monde " ;;
# 59) TV5+ monde 
59)
link=http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_1.m3u8
use_cookies="no"
chan_name="TV5+ monde " ;;
# 60) BFM SPORT Francais
60)
link=http://rmc-i.akamaihd.net/hls/live/218333/876630703001/BFMSPORT/master-4.m3u8
use_cookies="no"
chan_name="BFM Sport Francais" ;;
# 61) QVC Francais
61) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;      
# 62) Max FM 92.9 
62) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
use_cookies="no"
format=hls-2362
chan_name="Max FM 92.9" ;;
# 63) Gong Asian Cinema Francais
63)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
chan_name="Gong Asian Cinema Francais" ;;
# 64) M7 Television
64) link=http://www.dailymotion.com/video/x59xxgx_live_music 
use_cookies="no"
chan_name="M7 TV Mali" ;;
# 65) CGTN Francais
65)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;;
# 66) Public Senate France
66) link=http://www.dailymotion.com/video/xkxbzc_live-public-senat_news 
use_cookies="no"
chan_name="Public Senate" ;;

# 65) La Chaine Parlementaire LCP
# 65) link=http://www.dailymotion.com/video/xji3qy_la-chaine-parlementaire-lcp-live-tnt_news
# use_cookies="no"
# chan_name="LCP France";;
# 67) Elyse.fr
# 67) link=http://www.dailymotion.com/video/xu30kq_le-direct-de-la-presidence-de-la-republique_news
# use_cookies="no"
# chan_name="Le Direct de la Presidence de la Republique" ;;
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
keyword="Telepacifico"
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
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
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
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisadelgolfo.tv/video-en-vivo 
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
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisanoreste.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Matamoros Mexico" ;; 
# 88) Televisia Zacatecas Mexico
88)  
keyword="zacatecas"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvzacatecas.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Zacatecas Mexico" ;; 
# 89) Televisia Puebla Mexico
89)  
keyword="puebla"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisapuebla.tv/video-en-vivo 
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
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisaleon.tv/video-en-vivo  
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
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisamexicali.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Mexicali Mexico" ;;  
# 96) Televisia Toluca Mexico
96)  
keyword="toluca"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Toluca Mexico" ;;  
# 97) Televisia Hermosillo Mexico
97)  
keyword="hermosillo"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Hermosillo Mexico" ;;  
# 98) Televisia Torreon Mexico
98)  
keyword="torreon"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Torreon Mexico" ;;  
##################
# 99) TeleSUR Venezuela
99) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 100) Imagen Radio Mexico
100) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 101) CNN Chile
101)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
# 102)TVES
102)
link=rtmp://cast.streamingconnect.tv:1935/tves2/tves2 
use_cookies="no"
chan_name="TVES" ;;
# 103) Canal del Congreso Mexico Spanish
103)
link=http://dl.canaldelcongreso.gob.mx:1935/ccongreso/mp4:congreso2b.mp4/playlist.m3u8
use_cookies="no"
chan_name="Canal del Congreso Mexico Spanish" ;;
# 104) El Capitolio Venezulana
104) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="El Capitolio Venezulana" ;;    
# 105) DW Espanol
105)
link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
use_cookies="no"
chan_name="DW Espanol" ;;
# 106) CGTN Espanol
106)
link=https://live.cgtn.com/cctv-e.m3u8
use_cookies="no"
chan_name="CGTN Espanol" ;;
################ CHINESE MANDARIN CANTONESE  ####################
# 107) CCTV 4 Chinese
107) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;

############## TAIWAN TAIWANESE ##############################
# 108) 119 Live 電視台大立  Tai Li Taiwan
108)
keyword="大立119 網路直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Tai Li Taiwan" ;;
# 109) EBC 51 News Taiwan
109) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 110) EBC Finance Taiwan
110) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
#  111) TzuChi DaAi World Taiwan 
111) 
keyword="DaAi World HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 112) FTV Taiwan
112) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 113) TTV News Taiwan
113) 
keyword="台視新聞台HD直播｜TAIWAN TTV NEWS HD (Live)"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 114) CTV Taiwan
114) 
keyword="中視新聞台 LIVE直播｜Taiwan CTV news HD Live | 台湾のCTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 115) CTS World News HD Taiwan
115) 
keyword="華視新聞HD直播 | CTS Taiwan News Live HD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 116) SET News Taiwan
116) 
keyword="三立新聞直播│SET News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 117) CTI Taiwan
117) 
keyword="CTI中天新聞24小時HD新聞直播 │ CTITV Taiwan News HD Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;  
# 118) NeXT TV Taiwan
118) 
keyword="台中壹新聞直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/eranewstest/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Next TV Taiwan" ;;
# 119) Sinda Television
119) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 120) Cheng Sin TV
120) 
keyword="現場直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 121) TLTV
121) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 122) FLTV Taiwan
122) 
keyword="現場直播LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 123) 郭世明
123) 
keyword="全大電視網路直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCdx4XBYPj9s6FZUhEQ9IWkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="郭世明 Guo Shiming";;
# 124) 海豚直播 Dolphin TV
124) 
keyword="海豚直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUz3LiE7QuRGDGZ2DYciIuA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="海豚直播 Dolphin TV";;
# 125) SITTI 1
125) 
keyword="桐瑛1台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 126) SITTI 2
126) 
keyword="桐瑛2台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 127) SITTI 3
127) 
keyword="桐瑛3台"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 128) 大愛電視 Tzu Chi DaAiVideo 
128) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 129) 大愛一臺HD Live 直播
129)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;; 
# 130) OnTV Hong Kong
130) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 131) News 9 Bangalore Karnataka
131)
keyword="NEWS9"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/news9tv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 9 Bangalore Karnataka" ;;  
# 132 India TODAY
132)
keyword="IndiaToday Live TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="India TODAY English" ;;   
# 133) CVR English India
133) 
keyword="CVR English Live" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English India" ;;   
# 134) Shaski India
134) 
keyword="Sakshi TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 135) SunNews 
135) 
keyword="SUNNEWS LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 136) TV9 India Live
136) 
keyword="TV9 Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV9 Live India";;    
# 137) Rajya Sabha TV
137) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 138) TV9 Gujarat
138) 
keyword="Tv9 Gujarati LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 139) Tv9 Marathi
139) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tv9maharashtra/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Tv9 Marathi" ;; 
# 140) Bol TV Pakistan
140) 
keyword="Bol TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCl_yX1yxsnYAgDs2RFJSerg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bol News" ;;
# 141) 92 News Pakistan
141) 
keyword="92 News Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCsgC5cbz3DE2Shh34gNKiog/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="92 News Pakistan";; 
# 142) News 7 Tamil
142) 
keyword="Tamil"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 143) T News Telegu
143)
keyword="T News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="T News Telegu" ;;
## 144) 24 News Pakistan HD
144) 
keyword="Watch Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="24 News Pakistan HD" ;;  
# 145) News 18 India
145) 
keyword="News18 India Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 18 India" ;;
# 146) Aaj Tak 
146) 
keyword="Aajtak Live TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;; 
# 147) NTV Telugu
147) 
keyword="NTV Telugu Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 148) ABN Telugu
148) 
keyword="ABN Telugu LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 149) Vanitha TV 
149) 
keyword="Vanitha TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 150) HMT Telugu
150) 
keyword="HMTV Telugu News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 151) TV5 News 
151) 
keyword="Live News Updates"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV5 News" ;;
# 152) Channel 24 India
152) 
keyword="CHANNEL 24 LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/channel24web/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 153) SAMAA TV
153) 
keyword="SAMAA"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV" ;;    
# 154) Survana News
154)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Survana News" ;;   
# 155) ATN News Bangladesh
155) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;     
# 156)i News Telugu
156) 
keyword="I News Telugu Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="i News Telugu" ;; 
# 157) News 1 Kannada 
157)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 158)  Jansari News Kannada 
158)
keyword="News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/JanasriNewsKannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Jansari News Kannada" ;; 
# 159) Media One News
159)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Media One";;
# 160)  Tamil Live News
160) 
keyword="Thalaimurai TV LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Tamil Live News";;
## 161) TOLO NEWS AFGHANISTAN
161) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS";; 
## 162) Dawn News PAKISTAN
162) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dawn News" ;;
## 163) DD News
163) 
keyword="DD"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
## 164) Public TV India
164) 
keyword="Public TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/publictvnewskannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Public TV Kannada" ;;
# 165) REPORTER LIVE
165) 
keyword="REPORTER LIVE Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 166) 
166)
keyword="Puthiya Thalaimurai TV LIVE Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Puthiya Thalaimurai" ;;
# 167) AsiaNet News
167) 
keyword="Asianet News Live TV" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 168)V6 News
168) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
 chan_name="V6 News" ;;
# 169) Kalaignar TV1
169) 
keyword="Kalaignar News LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar TV" ;;
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
# 175)  The Ekantipur Nepal
175) 
keyword="Kantipur TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheEkantipur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="The Ekantipur Nepal" ;;  
# 176) NepalMandal TV
176) 
keyword="Nepalmandal TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCEorL1RapK1IWOzWAZzKeVw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="NepalMandal TV" ;;  
# 177) TEZ TV
177) 
keyword="TEZ"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;  
# 178) Dilli Aaj Tak
178) 
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 179)PTV Pakistan
179)
link=http://79.143.186.149:1935/live/PTVhome/player.m3u8
use_cookies="no"
chan_name="PTV Pakistan" ;;
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
# 185) Al Jazeera Arabic Qatar
185) 
keyword="Live Stream"
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
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
keyword="dmc"
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
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
link=http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8
#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
# 209) Mekameleen (Egypt)
209)
link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/playlist.m3u8
use_cookies="no"
chan_name="Mekameleen Egypt" ;;
# 210) CGTN Arabic
210)
link=https://live.cgtn.com/cctv-a.m3u8
use_cookies="no"
chan_name="CGTN Arabic" ;;
################### TURKEY  ########################  
## 211) TRT Haber Turkey
211) 
keyword="TRTHABER CANLI YAYIN"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 212) NTV Turkey
212) 
keyword="NTV - Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 213) HaberTurk TV
213) 
keyword="Habertürk TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 214) Star TV  Turkish
214) 
keyword="Star TV - Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 215) Fashion 1 Turk TV
215)
keyword="Fashion"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fashion One TV";;
# 216) CNN Turk 
216) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 217) ---------------
# 218) Ulusal Kanal Turkish
218) 
keyword="Ulusal Kanal Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6T0L26KS1NHMPbTwI1L4Eg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ulusal Kanal";;
# 219) KRT Kulture TV
219) 
keyword="KRTKultur TV Canlı yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 220) Tele 1 Kanali
220) 
keyword="Tele1 TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCoHnRpOS5rL62jTmSDO5Npw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Tele 1 Kanali";;
# 221) Turkmenelie FM
221) 
keyword="Türkmeneli FM Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie FM";;
# 222) Turkmenelie TV
222) 
keyword="Türkmeneli TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie TV";;
# 223) La Legul TV
223) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 224)Number1 TV Canlı Yayın
224)
keyword="Number1 TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 225) Number1 Turk TV
225)
keyword="Number1 Türk"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 226) TGRT Haber TV
226) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 227) TVNET Canali Yayin
227) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 228)NEWSCHANNEL CANLI ( ZINDI )
228)
keyword="NEWSCHANNEL CANLI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCuGfQAjgRaUlmvOIb7yuIyA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="NEWSCHANNEL";;
# 229) Galatasaray 
229) 
keyword="GS TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/2galatasaray/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Galatasaray";;
# 230) A9 Televizyounu 
230) 
keyword="A9 TV Canlı Yayın İzle"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHHeyHIgmp5JEEg6cILSShg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="A9 Televizyounu";;
# 231) STerkTV Zindi 
231) 
keyword="STERKTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 232) Ronahi TV Zindi 
232) 
keyword="RonahiTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";;
# 233) Number1 Turk FM
233)
keyword="Number1 Türk FM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;
################### GREEK ######################################
## 234) Action 24 Greece 
234) 
link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
use_cookies="no"
chan_name="Action 24 Greek" ;;
## 235) Ionian TV
235) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
use_cookies="no"
chan_name="Ionian TV Greek" ;;
## 236) Star Lamia
236) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 237) Blue Sky TV Athens Greece
237) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
################  GERMAN   #######################################
# 238)EuroNews Deutsch
238) 
keyword="euronews LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;
# 239) Tagessschau 24 Germany
239)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 240) W24 Wein Germany
240)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein Train Ride" ;;
# 241) WDR Germany
241)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 242)
############### RUSSIAN ################################
# 243)  Euronews Russian
243)
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 244) Vesti FM Russia
244) 
keyword="Вести ФМ"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 245) Россия 24
245) 
keyword="24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
# 246) Ukraine Channel 5 
246) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 247) Ukraine 112
247) 
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 248) News 1 Ukraine
248) 
keyword="прямого эфира"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 249) Еспресо Ukraine
249) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 250) Thromadske Ukraine
250) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 251) UA TV Ukraine
251) 
keyword="UATV. Прямой эфир - Пряма трансляція - Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 252) CGTN Russian
252)
link=https://live.cgtn.com/cctv-r.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
#  253) Life News Russia
253)
link=http://tv.life.ru/lifetv/360p/index.m3u8
use_cookies="no"
chan_name="Life News Russia" ;;
# 254) ТВ-ТРЕЙЛЕР Russia
254)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="ТВ-ТРЕЙЛЕР 2 Russia" ;;
################# TAGALOG FILIPINO #############################       
# 255) DZMM ABS-CBN Philippeans Radio
255) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 256) DZRH Philippeans
256) 
keyword="DZRH NEWS TELEVISION Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 257) DWIZ Philippeans
257) 
keyword="DWIZ 882 kHz TODONG LAKAS LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCUWv18AQ-8k5m9_AEv5lzew/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DWIZ Philippeans" ;;
# 258) PTV Philippines
258)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ BRAZIL   ################################
# 259) STF Brazil
259)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 260) TV Estúdio Brasil
260)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 261) TV Cultura Brasil HD 
261)
link=http://wowza.catve.com.br:1935/live/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV Cultura Brasil HD" ;;
##########################  Italian  #######################################################
# 262) Canale 7 Italy
262)
link=http://wms.shared.streamshow.it/canale7/canale7/playlist.m3u8
use_cookies="no"
chan_name="Canle 7 Italy" ;;
# 263) SkyTG 24 Italian
263)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 264) Telecolor Lombardia Italy
264)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 265) Cremona 1 Italy
265)
link=http://cremona1.econcept.it/live/cremona1_high.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Cremona 1 Italy" ;;
# 266) QVC Itallian
266) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
################################## FARSI / PERSIAN  ###########################################################
# 267)  Euronews Persian
267) 
keyword="برنامه"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Persian";;
# 268)  BBC Persian
268) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
#################### TRANSIENT ######################################## 
# 269) RSBN News Feed 2
269) 
keyword="LIVE STREAM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Cam 2" ;;
# 270) RUPTLY
270) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;;  
######################## PODCAST ###########################################
# 271) PBS NewsHour Video
271) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/PBSNewsHour/videos?&view=0" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 272)  CBC The National
272) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 273) SABC Digital News South Africa
273) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;; 
# 274) AP Top Stories
274) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 275) Democracy Now Headlines 
275) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;    
###################      INFOTAINMENT     ################################################
# 276)  Infowars
276) 
keyword="Infowars"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheAlexJonesChannel/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
# 277) The Young Turks
277) 
keyword="Young Turks"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
################################ MENU 2 ########################################################
###############    SPACE       ######################### 
# 278) NASA ISS Earth Viewing
278)
link=http://d2ai41bknpka2u.cloudfront.net/live/iss.stream_source/chunklist.m3u8
#http://iphone-streaming.ustream.tv/uhls/17074538/streams/live/iphone/playlist.m3u8
use_cookies="no"
chan_name="NASA ISS Earth Viewing" ;;
# 279) NASA ISS 1
279) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
# 280) NASA ISS 2
280) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
use_cookies="no"
chan_name="NASA ISS 2" ;;     
################## LOCATIONS #############################    
# 281) Venice Italy Bridge Cam Live
281) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 282) Venice Italy Port Cam Live
282) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
use_cookies="no"
chan_name="Venice Italy Port Cam" ;;
# 283) Jackson Hole Intersection
283) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
use_cookies="no"
chan_name="Jackson Hole Intersection" ;;
# 284) Jackson Hole Town Square
284) link=https://www.youtube.com/watch?v=cyHBMTgTGfo 
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 285) Jackson Hole Rustic Inn
285) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 286) Verona Italy
286) link=https://www.youtube.com/watch?v=LT3IT2wt8Fw 
use_cookies="no"
chan_name="Verona Italy" ;;
# 287) Soggy Dollar Bar
287) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
use_cookies="no"
chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  288) Amsterdam Netherlands
288) link=https://www.youtube.com/watch?v=5FrCtTCYVWI 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;;
# 289) Shibua Japan Community Crosswalk 
289) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 290) Akiba Japan Live
290) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 291) Yahoo Weather Japan
291) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 292) Yahoo Weather Steamy Mountains
292)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 293) 
# 294) Shizuoka Bridge Japan
294) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 295) Yokohama Port Japan
295) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 296) Hokkido Weather Cams
296) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 297) Mount Fuji Japan
297) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 298) RSBN Auburn Alabama USA
298) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA" ;;    
# 299) Florida Cam 1
299) 
keyword="LIVE Mallory Square Key West"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 1" ;; 
# 300) Florida Cam 2
300) 
keyword="LIVE Two Friends Roof Top"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 2" ;; 
# 301) Florida Cam 3
301) 
keyword="LIVE Marathon FL Cam"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 3" ;; 
# 302) Florida Cam 4
302) 
keyword="LIVE Mallory Square - Key West FL"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 4" ;; 
# 303) Florida Cam 5
303) 
keyword="LIVE Key West Seaport Cam"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 5" ;; 
# 304) Durango Colorado USA
304) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com//channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 305)Star Dot Cam 1
305) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;  
# 306) Star Dot Cam 3
306) 
keyword="Buena Park"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 3 Buena Park California" ;; 
# 307) Star Dot Cam 4
307) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 308) Star Dot Cam 5
308) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 309) Star Dot Cam 6
309) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 310) Fine Cine London 1
310) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 311) Fine Cine London 2
311) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 312) Fine Cine London 3
312) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 313) Berlin Airport 
313) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 314) Osaka Japan  
314) 
keyword="ITM SKY CAM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/masato663/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Osaka Japan" ;; 
# 315) Port of Los Angeles  
315) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 316)  ITS COM STUDIO Japan  
316) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 317)  China Shoreline 
317) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;;

##################################### SUPER ##################################################################################### 
# 318) Youing Japan Route 10
318) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 319) Netherlands live cam 1  
319) 
keyword="www.bottercourant.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 1" ;; 
# 320) Netherlands live cam 2
320) 
keyword="www.vvvzandvoort.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 2" ;; 
# 321) Netherlands live cam 3 
321) 
keyword="www.waddenhaventexel.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 3" ;; 
# 322) Netherlands live cam 4 
322) 
keyword="www.webcamceeskatwijk.nl"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 4" ;; 
# 323) Netherlands live cam 5 
323) 
keyword="www.havenplein.net"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Web NL Cam 5" ;; 
# 324) Netherlands live cam 6 
324) 
keyword="https://hartbeach.nl/"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Web NL Cam 6" ;; 
# 325) Naman Seoul Tower South Korea  
325) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 
# 326) The Church Channel
326)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8
use_cookies="no"
chan_name="The Church Channel" ;;
# 327) Smile of a Child
327)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8
use_cookies="no"
chan_name=" Smile of a Child" ;;
# 328) NRB Network
328)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 329) JUCE TV
329)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8
use_cookies="no"
chan_name="JUCE TV" ;;
# 330) 106.7 The Fan
330)
link=http://cbslocalhls-i.akamaihd.net/hls/live/204776/WJFK-FM-IOS/wjfklive.m3u8
use_cookies="no"
chan_name="106.7 The Fan" ;;
# 331) 105.7 The Fan
331)
link=http://cbslocalhls-i.akamaihd.net/hls/live/219778/WJZFM-IOS/wjzfmlive.m3u8
use_cookies="no"
chan_name="105.7 The Fan" ;;
# 332) Family Friendly Entertainment
332)
link=http://54.225.64.228:1935/live/roku2/playlist.m3u8
use_cookies="no"
chan_name="Family Friendly Entertainment";;
# 333) Rap Resurrection
333)
link=http://edge2.tikilive.com:1935/unrestricted_tikilive/36008/amlst:amKEQ2Y2gYN4/playlist.m3u8
use_cookies="no"
chan_name="Rap Resurrection";;
# 334) Animal Planet HD
334)
link=http://iphone-streaming.ustream.tv/uhls/12762028/streams/live/iphone/playlist.m3u8
use_cookies="no"
chan_name="Animal Planet HD";;
# 335)
# 336) TRT BELGESEL HD
336)
link=http://trtcanlitv-lh.akamaihd.net/i/TRTBELGESEL_1@182145/index_600_av-p.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="TRT BELGESEL HD";;
# 337) Go News
337) 
keyword="NEWS"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/mtyo0b/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Go News" ;;
################# ULTRA ###################################

###################   AFRICA    ##############################################
# 358)  ADOM TV 
358) 
keyword="Adom TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV" ;;    
# 359) Biafra TV Africa 
359) 
keyword="Biafra Television Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 360) Joy News Ghana
360) 
keyword="Joy News Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 361)  KTN Kenya
361) 
keyword=":"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 362) NTV Uganda
362) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 363) TVC News Nigeria
363) 
keyword="TVC News Nigeria Live"
link=rtmp://77.92.76.135:1935/tvcnews/livestream
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
####################################################################################
# 364) High Stakes Poker
364) link=https://www.twitch.tv/highstakespoke 
use_cookies="no"
chan_name="High Stakes Poker" ;; 
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
# 369) C-SPAN-1 Live Event
369)
link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN-1 Live Event" ;;
# 370) C-SPAN-2 Live Event
370)
link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN-2 Live Event" ;;
# 371) C-SPAN-3 Live Event
371)
link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN-3 Live Event" ;;
# 372) ICI Radio Canada Quebec CBVT-DT
372)
link="http://hdflash_1-lh.akamaihd.net/i/cancbvt_1@93274/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI CBVT-DT" ;;
# 373) ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT
373)
link="http://hdflash_1-lh.akamaihd.net/i/cancboft_1@192896/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT" ;;
# 374) ICI Radio-Canada – Trois-Rivières – CKTM-DT
374)
link="http://hdflash_1-lh.akamaihd.net/i/cancktm_1@93276/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada Trois-Rivières – CKTM-DT" ;;
# 375) ICI Radio-Canada – Rimouski – CJBR-DT
375)
link="http://hdflash_1-lh.akamaihd.net/i/cancjbr_1@95882/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Rimouski – CJBR-DT" ;;
# 376) ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT
376)
link="http://hdflash_1-lh.akamaihd.net/i/cancktv_1@93272/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT" ;;
# 377) ICI Radio-Canada – Sherbrooke – CKSH-DT
377)
link="http://hdflash_1-lh.akamaihd.net/i/cancksh_1@93278/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Sherbrooke – CKSH-DT" ;;
# 378) ICI Radio-Canada – Montréal CBFT-DT
378)
link="http://hdflash_1-lh.akamaihd.net/i/cancbft_1@95875/master.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Montréal" ;;
# 379) Venevision Venezuela
379) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Venevision Venezuela" ;; 
# 380) Euronews 
380)
link=http://opus.re/euronews/9-live.m3u8
use_cookies="no"
chan_name="Euronews " ;;
################ MEGA ##############################
# 398) Newsy
398) link=https://www.filmon.com/tv/newsy
use_cookies="yes"
chan_name="Newsy" ;;
# 399) DVIDs TV
399) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
# 400)  What America Thinks
400) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 401)  Juptier Broadcasting 
401) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="yes"
chan_name="Jupiter Broadcasting" ;;
# 402) TWiT
402) 
keyword="TWiT Live"
link=https://www.twitch.tv/twit 
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT" ;;
# 403) NASA TV Public Education
403) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 404) NASA TV Media
404) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 405) RT Documentary
405) 
link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
use_cookies="no"
chan_name="RT Documentary" ;;
# 406) CGTN Documentary
406)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 407) HSN
407) 
keyword="HSN Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 408) HSN 2
408) 
keyword="HSN2 Livestream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 409)  QVC 
409) 
keyword="QVC Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 410) The Shopping Channel TSC
410)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 411) CPAC 1 Canada
411)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
# 412) CPAC 1 Francais
412)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
# 413) CPAC 2 Canada
413)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027997492001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
# 414) C-SPAN 2 HD
414)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 2" ;;
# 415) C-SPAN 3 HD
415)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 3" ;;
# 415) О2 ТВ Russia
415)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="O!2 TB Russia" ;;
# 416) TV Publica Moldova
416)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
# 417) Mediatv Romania
417)
link=http://mediatv.novanet.ro/mediatv/mediatv.m3u8
use_cookies="no"
chan_name="Mediatv Romania" ;;
# 418) ABC NEWS 24 Albania
418)
link=http://xabcalbaniax.api.channel.livestream.com/3.0/playlist.m3u8
use_cookies="no"
chan_name="ABC News 24 Albania" ;;
# 419) Euronews Maygar Hugarian
419) 
keyword="euronews élőben" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/euronewsHungarian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Maygar Hungarian" ;;
# 420) London Live 
420)
link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
use_cookies="no"
chan_name="London Live" ;;
# 421) Bloomberg Europe
421)
link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/primary.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 422) A Plus Australia
422)
link=rtmp://118.97.183.196/jhos//aplus
use_cookies="no"
chan_name="A Plus Australia" ;;
# 423) CTV NEWS Canada
423)
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
###############################   OK   ######################################################
# 438) PAC-12 Net. Arizona
438)
link=http://xrxs.net/video/live-p12ariz-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Arizona" ;;
# 439) PAC-12 Net. Bay Area
439)
link=http://xrxs.net/video/live-p12baya-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Bay Area" ;;
# 440) PAC-12 Net. Los Angeles
440)
link=http://xrxs.net/video/live-p12losa-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Los Angeles" ;;
# 441) PAC-12 Net. Mountain
441)
link=http://xrxs.net/video/live-p12moun-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Mountain" ;;
# 442) PAC-12 Net. Oregon
442)
link=http://xrxs.net/video/live-p12oreg-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Oregon" ;;
# 443) PAC-12 Net. Washington
443)
link=http://xrxs.net/video/live-p12wash-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Washington" ;;
# 444)USA-BASKET UNI Arizona
444)
link=http://xrxs.net/video/live-p12ariz-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Arizona" ;;
# 445)USA-BASKET UNI Los Angeles
445)
link=http://xrxs.net/video/live-p12losa-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Los Angeles" ;;
# 446)USA-BASKET UNI Mountain
446)
link=http://xrxs.net/video/live-p12moun-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Mountain" ;;
# 447)USA-BASKET UNI Oregon
447)
link=http://xrxs.net/video/live-p12oreg-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Oregon" ;;
# 448)USA-BASKET UNI Washington
448)
link=http://xrxs.net/video/live-p12wash-2328.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Washington" ;;
# 449)Fox News Talk
449)
link=http://fnurtmp-f.akamaihd.net/i/FNRADIOHDS_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;;
#  450) Adult Swim 
450) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
#  451) Adult Swim Live Action Marathon 
451) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/live-action-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Live Action Marathon" ;;
# 452)ORA News
452)
link=rtmp://81.7.13.162/oranews//oranews
use_cookies="no"
chan_name="ORA News" ;;
# 453) Electrosound TV
453)
link=rtmp://www.electrosound.tv/public/stream
use_cookies="no"
chan_name="Electrosound TV" ;;
# 454) BYUTV
454)
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
use_cookies="no"
chan_name="BYUTV" ;;
# 455) BYUTV International
455)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
# 456) ABC News Digital 1
456)
link=http://abclive.abcnews.com/i/abc_live1@136327/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 1" ;;
# 457) ABC News Digital 2
457)
link=http://abclive.abcnews.com/i/abc_live2@136328/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 2" ;;
# 458) ABC News Digital 3
458)
link=http://abclive.abcnews.com/i/abc_live3@136329/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 3" ;;
# 459) ABC News Digital 4
459)
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 4" ;;
# 460) ABC News Digital 5
460)
link=http://abclive.abcnews.com/i/abc_live5@136331/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 5" ;;
# 461) NBC News Live Event
461)
link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
use_cookies="no"
chan_name="NBC News Live Event" ;;
# 462) WBTV News
462)
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
use_cookies="no"
chan_name="WBTV News" ;;
# 463) WSJ Live
463)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 464) EuroSports
464)
link=http://esioslive6-i.akamaihd.net/hls/live/202874/AL_P_ESP1_INTER_ENG/playlist_1800.m3u8
use_cookies="no"
chan_name="EuroSports" ;;
# 465) EuroSports Francais
465)
link=http://esioslive6-i.akamaihd.net/hls/live/202892/AL_P_ESP1_FR_FRA/playlist_1800.m3u8
use_cookies="no"
chan_name="EuroSports Francais" ;;
# 466) Kiss Radio 1 Taiwan 
466)
keyword="收聽佔有率第一的流行音樂電台 KISSRADIO 大眾廣播 FM99.9"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 1 Taiwan" ;; 
# 467) Kiss Radio 2 Taiwan 
467)
keyword="南投廣播 FM99.7 /KISSRadio Live Streaming 24/7"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 2 Taiwan" ;; 
################### SAIAJIN #############################
# 478) Earthquake 24  
478) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 479) KBS Live 24 Japan  
479) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
# 480) TBS Live Korea  
480) 
keyword="tbs TV LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 481) YTN DMB Korea  
481) 
keyword="와이티엔 _DMB"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 482) YTN Life Korea  
482) 
keyword="YTN"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnweatherlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Life Korea" ;; 
# 483) YTN Science Korea  
483) 
keyword="YTN SCIENCE_LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnsciencelive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 484) Channel 23 Korea  
484) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 485) BSC 24 1
485) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 486) BSC 24 2
486) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 487) KBS World 24 Korea
487) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 488) YTN 27 Korea
488)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ytnlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN 27 Korea" ;;   
#  489) QVC JAPAN SHOPPING CHANNEL
489) 
keyword="【QVCライブ】 24時間365日休まず生放送！！"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 490) Sol!ve 24 Japan
490) 
keyword="SOLiVE24"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
#  491) Arirang Radio English 
491) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
#  492) ANIBOX 
492) 
keyword="ANI"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCiFSWD-BKjiOgqo4gIBOBOg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANIBOX" ;;
#  493) Toonami 
493) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
use_cookies="no"
chan_name="Toonami" ;;
# 494) Talking Tom and Friends
494) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 494) Talking Tom and Friends Minis
494) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
# 495) Adult Swim Animated Marathon 
495) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Animated Marathon" ;;
# 496)CTS 
496) 
link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/CTS_34312_200.sdp/playlist.m3u8
#link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/_definst_/CTS_34312_100.sdp/playlist.m3u8
use_cookies="no"
chan_name="CTS" ;;



################# GOD MODE  ############################
# 518) CTV Vaticano
518) 
keyword="Centro Televisivo Vaticano"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ctvaticano/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CTV Vaticano" ;;
# 519) EWTN English
519) 
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283781001
use_cookies="no"
chan_name="EWTN America" ;;
# 520) EWTN Ireland 
520) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409261120001
use_cookies="no"
chan_name="EWTN Ireland" ;;
# 521) Amazing Facts TV (Christian)
521) 
keyword="AFTV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 522) It's Supernatural! Network (Christian)
522) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 523) Sheppard's Chapel (Christian)
523) 
keyword="Chapel"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Sheppard's Channel" ;;
# 524) International House of Prayer (IHOP) (Christian)
524) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 525) Belivers Voice of Victory Network
525) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 526) Three Angels BroadCasting
526) 
keyword="Three Angels Broadcasting Network (3ABN) Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels BroadCasting" ;; 
# 527) TCT HD
527) 
keyword="TCT Network Live HD Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT HD" ;; 
# 528) TCT SD
528) 
keyword="TCT Network Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT SD" ;; 
# 529) TCT Kids
529) 
keyword="TCT Network Live TCTKids Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
format="best"
use_cookies="no"
chan_name="TCT Kids" ;; 
# 530) Salt and Light TV Portage Michigan
530) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 531) LLBN TV
531) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 532) Harbor Light Radio
532) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 533) Hillsong Channel
533)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 534) Al Hayat TV Arabic
534) 
keyword="Al Hayat TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/alhayatchanneltv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Hayat TV Arabic" ;; 
# 535) Al Fady TV Arabic
535) 
keyword="قناة الفادى الفضائية | قناة"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC6CtFtvwAWQBLt3dx9l7arg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Fady TV Arabic" ;; 
# 536) Aghapy TV
536) 
keyword="Aghapy TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC97YtaFaO3lUTcG4dCmgr5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aghapy TV" ;; 
# 537) St. Marys Coptic
537) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 538) Word of God Greek
538) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 539) CBN
539)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 540)CBN News
540)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 541)NRB Network
541)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 542) Shalom TV
542) 
keyword="Shalom"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/ShalomTelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shalom TV" ;; 
# 543) Heaven TV
543) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 544) Rakshana TV
544) 
keyword="Rakshana TV Live"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/jakkulaBenhur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rakshana" ;; 
# 545) Powervision TV
545) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 546) KJV Audio
546) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio Bible" ;; 
# 547) NIV Audio Bible
547) 
keyword="NIV"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UC5XDvksZ1ysCwHYt90oi2QQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NIV Audio Bible" ;; 
# 548) Quran English Arabic
548) 
keyword="Quran Hidayah English TV Channel"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 549)  EWTN German
549) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 550) Temple Rodeph Torah 
550) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCWVE8wQWqr0b7wU_ao41V0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Temple Rodeph Torah" ;; 
# 551) Vatican
551) 
keyword="201"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/vatican/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Vatican" ;; 
# 552) Temple Institute
552) 
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
# 553) TBN
553)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 554) Mormon Tabernacle Choir 
554) 
keyword="Music"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/MormonTabChoir/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mormon Tabernacle Choir" ;;
# 555) EWTN Spanish 
555) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;; 
# 556) EWTN Africa
556) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 557) EWTN Asia
557) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;

esac
}

# Function to check the menu status
menu_status()
{
input=$1
if [ "$input" == "" ]
then
chan_state="return"
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
elif [ "$input" -lt 600 ]
then
menstat="no"
chan_state="numeric"
else
menstat="no"
chan_state="alpha"
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
echo "Please Select a Number corresponding to a YouTube Live Stream, press + to increment, - to decrement, n for the next menu, or q to quit:" ;;
n) channel_matrix_2
echo "Please Select a Number corresponding to a YouTube Live Stream, press + to increment, - to decrement, m for the main menu, or q to quit:" ;;
esac
}
######################################## MAIN PROGRAM #####################################################################
# initialize menu
menu="m"
format="best"
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
num="$entry"

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
elif [ "$chan_state" == "numeric" ]
then 
num="$entry"
else
num="$num"
fi

# get the menu selection status

if [ "$menstat" == "no" ]
then
 channel_select "$num"
 echo "$chan_name Channel $num"
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
  fi
  
 menu_switch "$menu" 
 echo "You were watching "$chan_name" Channel "$num" "
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
elif [ "$chan_state" == "numeric" ]
then 
num="$entry"
else 
num="$num"
fi

format="best"

if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name Channel $num" 
  if [ "$use_cookies" == "yes" ]
  then
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies --cookies-file "$cookie" "$link" 
  # clear the cookie
  echo " " > "$cookie"
  menu_switch "$menu"
  else
  firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --loop-playlist=inf --fullscreen "$link" 
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
 )Saudi Gold