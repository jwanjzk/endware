#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.37
# Revision Date: June 21, 2017
#
# Recent Changes: - Channel reorganization
#                 - incorporate user-agents
#                 - +/- channel controls, + grab streams direct from upstream source
#                 - Channel grab overhaul fix Mother's Day Blackout Bug
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
version="0.37"
rev_date="21/06/2017"
branch="gnu/linux"
##################################################

temp_pl="$HOME/tmp/master.m3u8"
USERAGENTS="$HOME/bin/user_agents.txt"
chan_columns="$HOME/bin/streams.txt"
cookie="$HOME/bin/cookies.txt"
cache_size="4096"
use_cookies="no"
# define the current tor browser user agent
UA_torbrowser="Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0"
# define default headers
HEAD1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
HEAD2="Accept-Language: en-US,en;q=0.5"
HEAD3="Accept-Encoding: gzip, deflate"
HEAD4="Connection: keep-alive"
HEAD5="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"
uamode="off"
headmode="off"

### Define function for displaying channels  CHANGE MENU HERE
channel_matrix()
{
   echo "==================================================================      ENDSTREAM  "$version"   ==============================================================="
   echo "||      ENGLISH       ||     FRANCAIS      ||      ESPANOL       ||      ASIAN     ||     INDIAN       ||  INDIAN/ARABIC  ||TURK/GREEK/DEUTSCH/RUSSIAN||"
   echo "======================================================================================================================================================="
   echo "1)France 24 English   41)France 24 Francais81)Magala TV Spain    121)CCTV 4 China  161)News 9 Bangalore 201)Ekantipur Nepal 241)NTV Turkey"    
   echo "2)BBC World News      42)France Info TV    82)RT Espanol         122)Tai Li Taiwan 162)CVR NEWS         202)NepalMandal     242)HaberTurk TV" 
   echo "3)SKY News London     43)Euronews Francais 83)DW Espanol         123)EBC 51 Taiwan 163)CVR English      203)PTV Pakistan    243)Star TV  Turkish"  
   echo "4)BBC News London     44)France Info Radio 84)NTN24 Venezuela    124)EBC Finance TW164)Shaski India     204)Neo TV Pakistan 244)Fashion 1 Turk"             
   echo "5)RT UK               45)France Inter      85)Canal 8 Argentina  125)TzuChi DaAi TW165)SunNews          205)Dawn Pakistan   245)CNN Turk"  
   echo "6)EuroNews English    46)RTL En Direct     86)Canal 6 Argentina  126)FTV Taiwan    166)TV9 India        206)Bol TV Pakistan 246)Ulusal Kanal"  
   echo "7)DW English          47)Journal TVLandes  87)Canal 7 Argentina  127)TTV Taiwan    167)Rajya Sabha      207)92 News Pakistan247)KRT Kulture"
   echo "8)Russia Today        48)BMF TV            88)c5n Argentina      128)CTV Taiwan    168)TV9 Gujarat      208)24 News Pakistan248)Tele 1 Kanali"
   echo "9)CBSN USA            49)i24 France        89)A24 Argentina      129)CTS World TW  169)Tv9 Marathi      209)TOLO NEWS AFGHAN249)Turkmenelie FM"
   echo "10)MSNBC USA          50)Europe 1          90)TelePacifico       130)SET News TW   170)News 7 Tamil     210)RT Arabic       250)Turkmenelie TV"
   echo "11)Bloomberg USA      51)Africa News       91)Canal 8 Argentina  131)CTI Taiwan    171)T News Telegu    211)ON E Live Egypt 251)La Legul TV"
   echo "12)NEWSMAX USA        52)RFI               92)Hispan TV          132)NeXT TV Taiwan172)News 18 India    212)ON E Sports     252)Number1 TV Canlı"
   echo "13)ABC News           53)Mosaik TV         93)Globovision        133)Sinda TV      173)Aaj Tak          213)ON Live Egypt   253)Number1 Turk"
   echo "14)CNN USA            54)Africa24          94)Canal 2 Argentina  134)Cheng Sin TV  174)NTV Telugu       214)Al Jazeera Qatar254)TGRT Haber"
   echo "15)RT America         55)TLM Lyon Metro    95)Excelsior Mexico   135)TLTV Taiwan   175)ABN Telugu       215)France 24 Arabic255)TVNET Canali"  
   echo "16)Newsy USA          56)CGTN Francais     96)TN Argentina       136)FLTV Taiwan   176)Vanitha TV       216)BBC Arabic      256)NEWSCHANNEL CANLI"
   echo "17)Al Jazeera English 57)ICI RDI Canada    97)La Nacion Argentina137)Guo Shiming   177)HMT Telugu       217)Al Arabiya      257)Galatasaray"
   echo "18)TRT World Istanbul 58)TV5 Monde         98)PSN Tijuana Mexico 138)Dolphin TV    178)TV5 News         218)Al Mayadeen     258)A9 Televizyounu"	
   echo "19)i24 News Israel    59)TV5+ Monde        99)TV Golfo Mexico    139)SITTI 1       179)Channel 24 India 219)Syrian Satellite259)STerkTV Zindi"
   echo "20)Saudi 2 English    60)BFM Sport         100)TV Veracruz MX    140)SITTI 2       180)SAMAA TV         220)ORTAS Syria     260)Ronahi Zindi"  
   echo "21)Press TV Iran      61)QVC Francais      101)TV Matamoros MX   141)SITTI 3       181)Survana News     221)Bedya TV        261)Number1 Turk FM"
   echo "22)India Today        62)Max FM 92.9       102)TV Zacatecas MX   142)DaAiVideo TW  182)ATN Bangladesh   222)Belqees TV      262)Action 24 Greece"       
   echo "23)CGTN Beijing       63)Gong Cinema       103)TV Puebla MX      143)DaAi Live TW  183)i News Telugu    223)Saudi Blue      263)Ionian TV Greece"  
   echo "24)Arirang Korea      64)M7 Mali           104)TV Acapuloco MX   144)OnTV HK       184)News 1 Kannada   224)Saudi Purple    264)Star Lamia Greece"
   echo "25)NHK World Japan    65)CGTN Francais     105)TV Cuernavaca MX  145)TBS KR        185)Jansari Kannada  225)Saudi Green     265)Blue Sky TV Athens" 
   echo "26)NewsAsia Singapore 66)ICI Quebec City   106)TV Leon MX        146)YTN KR        186)Media One        226)Saudi Gold      266)EuroNews Deutsch"
   echo "27)CNN Philippeans    67)ICI OttawaGatineau107)TV Queretaro MX   147)YTN KR        187)Tamil Live       227)Saudi Silver    267)Tagessschau 24 Germany"
   echo "28)ABC Australia      68)ICI Montreal      108)TV Gudalajera MX  148)YTN Sci KR    188)DD News          228)Saudi Orange    268)W24 Wein Germany"
   echo "29)Africa News        69)ICI Trois Rivieres109)TV Mexicali MX    149)Channel 23 KR 189)Public TV India  229)Saudi Red       269)WDR Germany"
   echo "30)ANN7 South Africa  70)ICI Rimouski      110)TV Toluca MX      150)KBS World24 KR190)REPORTER LIVE    230)DMC Live        270)RTS Salzburg Austria"    
   echo "31)Arise News Nigeria 71)ICI Seguenay      111)TV Hermosillo MX  151)YTN 27 KR     191)Puthiyah Thali   231)Sky Arabic      271)Tirol TV Germany"
   echo "32)Channels 24 Nigeria72)ICI Sherbrooke    112)TV Torreon MX     152)CTS KR        192)AsiaNet News     232)CBC Drama Egypt 272)538 TV NETHERLANDS"
   echo "33)TVC Nigeria        73)Assemblee Quebec  113)TeleSUR Venezuela 153)BSC 24 1 JP   193)V6 News          233)Extra News Egypt273)AT5 NETHERLANDS" 
   echo "34)VOA                74)Canal Savoir      114)Imagen Radio MX   154)BSC 24 2 JP   194)Kalaignar TV1    234)CBC Sofra Egypt 274)ORA News Albania  "  
   echo "35)CSPAN 1            75)CPAC 1 Francais   115)CNN Chile         155)Earthquake 24 195)ETV AndhraPradesh235)Saudi Ajyal Kids275)ABC NEWS 24 Albania  "
   echo "36)DIVIDs             76)EuroSport Francais116)TVES              156)KBS 24 JP     196)News 18 Tamilnadu236)Makka Live      276)Mediatv Romania "
   echo "37)Jupiter Broadcast  77)France 0          117)Congreso Mexico   157)QVC Japan     197)The Polimer      237)DW Arabic       277)TV Publica Moldova"
   echo "38)TWiT               78)France 2          118)El Capitolio      158)Sol!ve 24 JP  198)Jaya Plus        238)Mekameleen Egypt278)Euronews Russian  "	
   echo "39)Infowars           79)France 3          119)Euronews Espanol  159)KBS World KR  199)TEZ TV           239)CGTN Arabic     279)Vesti FM Russia  "
   echo "40)TYT                80)RTS UN            120)CGTN Espanol      160)KISS FM TW    200)Dilli Aaj Tak    240)TRT Haber Turkey280)Россия 24  "
   echo "======================================================================================================================================================="
}	               

channel_matrix_2()
{
   echo "==================================================================      ENDSTREAM  "$version"   ============================================================"
   echo "|| RUSSIA/UKRAINE/OTHER||     LOCATIONS     ||    USA LOCAL NEWS   ||      ULTRA      ||  SPORTS/ENTERTAINMENT ||    RELIGIOUS      ||    MEGA     ||"
   echo "======================================================================================================================================================="
   echo "281)CGTN Russian      321)NASA ISS          361)RSBN Auburn USA    401)ABC News 1      441)PAC-12 Arizona     481)CTV Vaticano      521)Harbor Light"    
   echo "282)Life News Russia  322)NASA ISS 1        362)News 12 Brooklyn   402)ABC News 2      442)PAC-12 Bay Area    482)EWTN Americas     522)JUCE TV " 
   echo "283)ТВ-ТРЕЙЛЕР Russia 323)NASA ISS 2        363)News 12 Long Island403)ABC News 3      443)PAC-12 Los Angeles 483)EWTN Ireland      523)--------"  
   echo "284)Ukraine 5         324)Venice Bridge     364)FOX 25 Boston      404)ABC News 5      444)PAC-12 Mountain    484)Amazing Facts     524)--------"             
   echo "285)Ukraine 112       325)Venice Italy Port 365)WGN 9 Chicago      405)NBC News Live   445)PAC-12 Oregon      485)It's Supernatural!525)--------"  
   echo "286)News 1 Ukraine    326)JacksonHole Xsec  366)FOX 23 Tulsa       406)WSJ Live        446)PAC-12 Washington  486)Sheppard's Chapel 526)--------"  
   echo "287)Еспресо Ukraine   327)JacksonHole Square367)FOX 13 Memphis     407)C-SPAN-1        447)USA UNI Arizona    487)IHOP              527)--------"
   echo "288)Thromadske Ukraine328)JacksonHole Rustic368)FOX 30 Jacksonville408)C-SPAN-2        448)USA UNI Los Angeles488)BVOVN             528)--------"
   echo "289)UA TV Ukraine     329)Aosta Sarre Italy 369)CBS 47 Jacksonville409)C-SPAN-3        449)USA UNI Mountain   489)3ABN              529)--------"
   echo "290)DZMM ABS-CBN      330)SoggyDollar BVI   370)ABC 9 Orlando      410)CNN Live 1      450)USA UNI Oregon     490)TCT HD            530)--------"
   echo "291)DZRH Philippeans  331)Amsterdam NL      371)Fox 10 Phoenix     411)CNN Live 2      451)USA UNI Washington 491)TCT SD            531)--------"
   echo "292)DWIZ Philippeans  332)Shibua Japan      372)Fox 2 Bay Area     412)CPAC 1 Canada   452)EuroSports         492)TCT Kids          532)--------"
   echo "293)PTV Philippines   333)Akiba Japan       373)WTPC 16 Virginia   413)CPAC 2 Canada   453)Virgin 2 Music     493)Salt and Light    533)--------"
   echo "294)STF Brazil        334)Yahoo Japan       374)ATXN Austin        414)America Thinks  454)Olympic Channel    494)LLBN TV           534)--------"
   echo "295)TV Estúdio Brasil 335)Steamy Mountain   375)Seminole Florida   415)NASA TV Educate 455)NFL Now            495)Rap Resurrection  535)--------" 
   echo "296)TV Cultura Brasil 336)Naman Seoul       376)Florida Channel    416)NASA TV Media   456)MLB Network        496)Hillsong          536)--------"
   echo "297)Rádio Justiça     337)Shizuoka Japan    377)Weather Network    417)RT Documentary  457)106.7 The Fan      497)Al Hayat TV Arabic537)--------"
   echo "298)Rádio Justiça     338)Yokohama Japan    378)Weather Nation     418)CGTN Documentary458)105.7 The Fan      498)Al Fady TV Arabic 538)--------"	
   echo "299)Canale 7 Italy    339)Hokkido Weather   379)CBS 13 Stockton    419)HSN             459)High Stakes Poker  499)Aghapy TV         539)--------"
   echo "300)SkyTG 24 Italian  340)Mount Fuji Japan  380)CBS 2 New York     420)HSN 2           460)Toonami            500)St. Mary's Coptic 540)--------"  
   echo "301)Lombardia Italy   341)Hart Beach NL     381)NBC 4 New York     421)QVC             461)Talking Tom        501)Word of God Greek 541)--------"
   echo "302)Cremona 1 Italy   342)Florida 1         382)CBS 4 Boston       422)QVC Beauty UK   462)Talking Tom Mini   502)CBN               542)--------"       
   echo "303)QVC Itallian      343)Florida 2         383)WVIT 30 Hartford   423)QVC Style UK    463)Adult Swim Ani     503)CBN News          543)--------"  
   echo "304)Euronews Persian  344)Florida 3         384)NBC 10 Philadelphia424)TSC             464)Adult Swim         504)NRB               544)--------"
   echo "305)BBC Persian       345)Florida 4         385)CBS 3 Michigan     425)IdealWorld      465)Adult Swim Live    505)Shalom TV         545)--------"  
   echo "306)ADOM TV           346)-------------     386)NBC Nebraska       426)C-SPAN 2        466)Animal Planet      506)Heaven TV         546)--------"
   echo "307)Biafra TV         347)Durango Colorado  387)CBS Nebraska       427)C-SPAN 3        467)Insight TV         507)Rakshana TV       547)--------"
   echo "308)Joy News Ghana    348)StarDot 1         388)News12 Wisconsin   428)Euronews Maygar 468)--------           508)Powervision TV    548)--------"
   echo "309)KTN Kenya         349)Youing Japan      389)CBS 2 Salt Lake    429)Bloomberg Europe469)ANIBOX             509)KJV Bible         549)--------"
   echo "310)NTV Uganda        350)StarDot 4         390)CBS 5 News Colorado430)London Live     470)Music Choice Play  510)Catholic TV       550)--------"    
   echo "311)Number1 Radyo     351)StarDot 5         391)NBC 11 Bay Area    431)A+ Australia    471)MTV AM Russia      511)Quaran English    551)--------"
   echo "312)Venevision        352)StarDot 6         392)KCAL 9 Los Angeles 432)Yes TV          472)Capital TV         512)EWTN Deutsch      552)--------"
   echo "313)RSBN News         353)London 1          393)KNBC 4 Los Angeles 433)The Blaze       473)Heart TV           513)Jewish Life       553)--------" 
   echo "314)RUPTLY            354)London 2          394)ABC 3 Louisiana    434)Weather Channel 474)CITY TV            514)Church Channel    554)--------"  
   echo "315)PBS NewsHour      355)London 3          395)WPLG 10 Miami      435)TRT BELGESEL    475)Kiss TV            515)Temple Institute  555)--------"
   echo "316)CBC The National  356)Berlin Airport    396)WJXT 4 Jacksonville436)BYUTV           476)Country Music      516)TBN               556)--------"
   echo "317)SABC South Africa 357)Osaka Japan       397)CBS WBZ, Boston    437)BYUTV Int       477)Heavy Metal        517)God TV            557)--------"
   echo "318)AP Top Stories    358)Los Angeles Port  398)CTV NEWS Canada    438)Arirang Radio   478)О2 ТВ Russia       518)EWTN Espanol      558)--------"	
   echo "319)Democracy Now     359)ITS COM Japan     399)Fox News Talk      439)Go News         479)Smile of a Child   519)EWTN Africa       559)--------"
   echo "320)--------------    360)China Shoreline   400)-------------      440)Show TV Turkey  480)Family Friendly    520)EWTN Asia         560)--------"
   echo "===================================================================================================================================================="
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
   echo "$ endstream --ua-tor       # use tor-browser user-agent"
   echo "$ endstream --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endstream --ua-ranstr    # use a random string as the user agent"
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
   sleep 2
   channel_matrix2
   exit 0
   elif [ "$arg" == "--list-all" ]
   then
   more "$chan_columns"
   exit 0
   elif [ "$arg" == "--ua-rand" ]
   then
   uastate="rand"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-ranstr" ]
   then
   uastate="ranstr"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-tor" ]
   then
   uastate="tor"
   uamode="on"
   shift
   elif [ "$arg" == "--ua-row1" ]
   then
   uastate="row1"
   uamode="on"
   shift
   elif [ "$arg" == "--no-agent" ]
   then
   uamode="off"
   shift 
   elif [ "$arg" == "--no-header" ]
   then
   headmode="off"
   shift   
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
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
use_cookies="no"
chan_name="France 24 English";;
# 2) BBC World News
2) 
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_1.m3u8
#link=https://www.filmon.com/tv/bbc-news
use_cookies="no"
chan_name="BBC World News" ;; 
# 3) Sky News
3)
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/07.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/06.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/05.m3u8
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/03.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/02.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/01.m3u8
use_cookies="no"
chan_name="Sky News" ;;
# 4) BBC News London
4) 
keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC News London" ;; 
# 5) RT UK
5) 
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index2500.m3u8
link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index800.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index400.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/uk/index.m3u8
#link=http://rt-uk-live.hls.adaptive.level3.net/rt/uk/index.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
# 6) EuroNews English
6) 
keyword="برنامه زنده"
link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA""https://www.youtube.com/user/Euronews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 

#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_720p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_540p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_360p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_224p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_180p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_90p.m3u8

use_cookies="no"
chan_name="Euronews English" ;; 

# 7) DW English
7) 
link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
use_cookies="no"
chan_name="DW English" ;;
# 8) Russia Today
8) 
#link=http://rt-eng-live.hls.adaptive.level3.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index2500.m3u8
link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index1600.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index800.m3u8
#link=https://rt-eng-live-hls.secure.footprint.net/rt/eng/index400.m3u8
# link=https://www.filmon.com/tv/russia-today-1
use_cookies="no"
chan_name="Russia Today" ;;
########################## USA MAINSTREAM ###################################################
# 9) CBSN 
9)
#wget -O "$temp_pl" https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8
#link=$( grep "84" "$temp_pl"| head -n 2 | tail -n 1 )
#rm "$temp_pl"
link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?iu=/8264/vaw-can/mobile_web/cbsnews_mobile
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="CBSN" ;;
# 10) # MSNBC
10)
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  
use_cookies="no"
chan_name="MSNBC";;  
# 11) Bloomberg Business USA
11) 
keyword="Global News Coverage on Bloomberg TV"
link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl "-A "$UA" https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 12) NEWSMAX USA
12) 
keyword="Live News Stream - Newsmax TV"
link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 13) ABC News USA
13)
#link=http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
use_cookies="no"
chan_name="ABC News USA" ;;
# 14) CNN America  
14)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n 2 | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
#link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
#link=http://109.123.114.178:1935/Livenewson/Livenewson/playlist.m3u8
use_cookies="no"
chan_name="CNN Live" ;;
# 15) RT America
15)
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index400.m3u8 
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index800.m3u8
link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/usa/index.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 16) Newsy
16) 
link=http://www.newsy.com/live/
#link=https://www.filmon.com/tv/newsy
use_cookies="no"
chan_name="Newsy" ;;
############################# MIDDLE EAST ##############################################################
# 17) Al Jazeera
17) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
# 18) TRT World
18) 
keyword="TRT World LIVE"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 19) i24 News Israel
19) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
#format=hls-2362
format=hls-1472 
#format=hls-915 hls-514
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 20) Saudi 2 TV
20) 
keyword="Saudi 2 TV Live Stream"
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Saudi 2 English" ;;   
# 21) Press TV
21)
#link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/chunklist.m3u8
#link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/playlist.m3u8
#link=http://178.32.255.199:1935/live/ptven/playlist.m3u8
link=https://www.filmon.com/tv/press-tv
use_cookies="no"
chan_name="Press TV" ;;  
################### INDIA  ########################################
# 22) India TODAY
22)
keyword="IndiaToday Live TV"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://indiatoday.intoday.in/livetv.jsp
link="http://livestream.com/accounts/11965022/events/4086327/player"
use_cookies="no"
chan_name="India TODAY English" ;;  
################## AMERICAN GOVERNMENT ######
#############################  ASIA-OCEANIA   ##################################################################
# 23) CGTN China English
23) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 24) Arirang TV Korea
24) 
keyword="Arirang" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#BANDWIDTH=1728000,RESOLUTION=1280x720
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1728000_sleng.m3u8
#BANDWIDTH=1328000,RESOLUTION=960x540
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b1328000_sleng.m3u8
#BANDWIDTH=928000,RESOLUTION=850x480
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b928000_sleng.m3u8
#BANDWIDTH=528000,RESOLUTION=640x360
#link=http://amdlive.ctnd.com.edgesuite.net/arirang_1ch/smil:arirang_1ch.smil/chunklist_b528000_sleng.m3u8

#link=http://worldlive-ios.arirang.co.kr/arirang/arirangtvworldios.mp4.m3u8
#link=http://worldlive-ios.arirang.co.kr/cdnlive-hls/arirangwlive/_definst_/liveevent/tvworld2.m3u8
# 
use_cookies="no"
chan_name="Arirang TV Korea" ;; 
# 25)NHK World Japan 
25) 
link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8
use_cookies="no"
chan_name="NHK World Japan" ;;
# 26)NewsAsia Singapore
26) 
link=http://imtcnai-lh.akamaihd.net/i/cnai_main@334572/master.m3u8
use_cookies="no"
chan_name="NewsAsia Singapore" ;;
# 27) CNN PHILIPPINES
27)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
chan_name="CNN PHILIPPINES";;
# 28) ABC News Australia 
28) 
keyword="Watch ABC News Live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#BANDWIDTH=295680
#link=http://iphonestreaming.abc.net.au/news24/news24_vlo.m3u8
#BANDWIDTH=398944
#link=http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8
#BANDWIDTH=553888
#link=http://iphonestreaming.abc.net.au/news24/news24_med.m3u8
#BANDWIDTH=708832
#link=http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8
#BANDWIDTH=64000
#link=http://iphonestreaming.abc.net.au/news24/news24_vloaudio.m3u8
use_cookies="no"
chan_name="ABC News Australia" ;;
########################### AFRICA ############################################
# 29) Africa News Live
29) 
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
# 30) ANN7 South Africa
30) 
keyword="ANN7 TV Live Stream"
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/playlist.m3u8
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b250000.m3u8
link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b550000.m3u8
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b1300000.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ANN7 News South Africa" ;; 
# 31) Arise News Nigeria/London
31) 
keyword="Arise News Live Stream"
link=http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria/London";;  
# 32) Channels 24 Nigeria
32) 
keyword="Channels Television - Multi Platform Streaming"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;   
# 33) TVC News Nigeria
33) 
keyword="TVC News Nigeria Live"
link=rtmp://77.92.76.135:1935/tvcnews/livestream
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
########################## AMERICAN GOVERNMENT ###################################################
# 34) VOA
34)
link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#link=https://www.filmon.com/tv/voa-english
use_cookies="no"
chan_name="VOA" ;;
# 35) C-SPAN 1 HD
35)
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 1" ;;
# 36) DVIDs TV
36) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
###################      TECHNOLOGY    ################################################
# 37)  Juptier Broadcasting 
37) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="no"
chan_name="Jupiter Broadcasting" ;;
# 38) TWiT
38) 
keyword="TWiT Live"
link=http://hls.twit.tv/flosoft/mp4:twitStream_540/playlist.m3u8
#link=http://hls.cdn.flosoft.biz/flosoft/mp4:twitStream_360/playlist.m3u8
#link=https://www.twitch.tv/twit 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT" ;;
##################    INFOTAINMENT   ##################################################
# 39)  Infowars
39) 
keyword="Infowars"
link=http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheAlexJonesChannel/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
# 40) The Young Turks
40) 
keyword="17"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
#################    FRENCH   ###################################
# 41) France 24 
41)
keyword="FRANCE 24 en Direct" 
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#format=hls-2362
chan_name="France 24" ;;
# 42) France Info TV
42) 
keyword="franceinfo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
use_cookies="no"
chan_name="France Info TV" ;;
# 43) Euronews Francais
43) 
keyword="euronews EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;                                                            
# 44) France Info Radio
44) link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
use_cookies="no"
chan_name="France Info Radio" ;;
# 45) France Inter
45) 
keyword="France Inter en direct"
link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;;
# 46) RTL En direct
46) link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
use_cookies="no"
format=hls-2362
chan_name="RTL En Direct" ;;
# 47) Direct Journal TVLandes    
47) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-2362
chan_name="Direct Journal Tvlandes"  ;;      
# 48) BMF TV
48) link=https://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
use_cookies="no"
format=hls-2362
chan_name="BMF TV";;
# 49) i24 News en Direct
49) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-2362
chan_name="i24 Francais";;
# 50) Europe 1
50) link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
format=hls-2362
chan_name="Europe 1" ;;
# 51) Africa News Francais
51) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 52) RFI
52) 
keyword="RFI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 53) Mosaik TV Francais
53)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 54) Africa24
54) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;;     
# 55) TLM Lyon Metro
55) 
keyword="TLM en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
64) link=https://www.dailymotion.com/video/x59xxgx_live_music 
use_cookies="no"
chan_name="M7 TV Mali" ;;
# 65) CGTN Francais
65)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;;
# 66) ICI Radio Canada Quebec City Quebec CBVT-DT
66)
link="http://hdflash_1-lh.akamaihd.net/i/cancbvt_1@93274/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio Canada - Quebec City Quebec CBVT-DT" ;;
# 67) ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT
67)
link="http://hdflash_1-lh.akamaihd.net/i/cancboft_1@192896/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT" ;;
# 68) ICI Radio-Canada – Montréal CBFT-DT
68)
link="http://hdflash_1-lh.akamaihd.net/i/cancbft_1@95875/master.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Montréal" ;;
# 69) ICI Radio-Canada – Trois-Rivières – CKTM-DT
69)
link="http://hdflash_1-lh.akamaihd.net/i/cancktm_1@93276/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada Trois-Rivières – CKTM-DT" ;;
# 70) ICI Radio-Canada – Rimouski – CJBR-DT
70)
link="http://hdflash_1-lh.akamaihd.net/i/cancjbr_1@95882/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Rimouski – CJBR-DT" ;;
# 71) ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT
71)
link="http://hdflash_1-lh.akamaihd.net/i/cancktv_1@93272/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT" ;;
# 72) ICI Radio-Canada – Sherbrooke – CKSH-DT
72)
link="http://hdflash_1-lh.akamaihd.net/i/cancksh_1@93278/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Sherbrooke – CKSH-DT" ;;
# 73) Assemblee Nationale du Quebec Francais
73)
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
use_cookies="no"
chan_name="Assemblee Nationale du Quebec Francais" ;;
# 74)Canal Savoir Francais
74)
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
use_cookies="no"
chan_name="Canal Savoir Francais" ;;
# 75) CPAC 1 Francais
75)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
use_cookies="no"
chan_name="CPAC 1 Francais Canada" ;;
# 76) EuroSports Francais
76)
link=http://esioslive6-i.akamaihd.net/hls/live/202892/AL_P_ESP1_FR_FRA/playlist_1800.m3u8
use_cookies="no"
chan_name="EuroSports Francais" ;;
# 77)France 0
77) 
link=https://www.filmon.com/tv/france-0
use_cookies="yes"
chan_name="France 0" ;;
# 78) FRANCE 2
78) 
link=https://www.filmon.com/tv/france-2
use_cookies="yes"
chan_name="France 2" ;;
# 79) France 3 Rhone Alpes
79) 
link=https://www.filmon.com/tv/france-3-rhone-alpes
use_cookies="yes"
chan_name="France 3 Rhone Alps" ;;
# 80) RTS UN
80) 
link=https://www.filmon.com/tv/rts-un
use_cookies="yes" 
chan_name="RTS UN" ;;
###################  SPANISH  #################################
# 81) Magala TV Spain  Malaga,Andalusia,Spain
81)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Magala TV Spain" ;; 
# 82) RT Espanol
82) 
keyword="en directo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://actualidad.rt.com/en_vivo2
use_cookies="no"
chan_name="RT Espanol" ;;
# 83) DW Espanol
83) 
keyword="DW Español en VIVO"
link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="DW Espanol" ;;
# 84) NTN24 Venezuela
84) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 85) Canal 8 San Juan Argentina
85) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 86) Canal 6 San Rafael Argentina
86) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 87) Canal 7 Mendoza Argentina
87) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 88) c5n Argentina
88) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="c5n Argentina" ;;
# 89) A24 Argentina
89) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 90) TelePacifico Colombia
90) 
keyword="Telepacifico"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelepacificoCanal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 
# 91) Canal 8 Mar del Plata
91) 
keyword="Emisión en vivo de Canal 8 de Mar del Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 92) Hispan TV
92) 
keyword="HispanTV en vivo - FULL HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
# 93) Globovision Venezeula
93) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 94) Canal 2 Cablenet San Vicente Argentina
94)
keyword="Transmisión en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 95) Excelsior TV Mexico
95) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
# 96) Todo Noticias Argentina
96) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 97) La Nacion TV Argentina
97) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 98) PSN Tijuana Mexico
98) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";;
########### TELEVISIA REGIONALES MEXICO
# 99) Televisia del Golfo Mexico
99)  
keyword="BroadCast_del-golfo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisadelgolfo.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisa del Golfo Mexico" ;; 
# 100) Televisia Veracruz Mexico
100) 
keyword="veracruz"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisaveracruz.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Veracruz Mexico" ;; 
# 101) Televisia Matamoros Mexico
101)  
keyword="matamoros"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisanoreste.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Matamoros Mexico" ;; 
# 102) Televisia Zacatecas Mexico
102)  
keyword="zacatecas"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvzacatecas.tv/video-en-vivo
use_cookies="no"  
chan_name="Televisia Zacatecas Mexico" ;; 
# 103) Televisia Puebla Mexico
103)  
keyword="puebla"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisapuebla.tv/video-en-vivo 
use_cookies="no" 
 chan_name="Televisia Puebla Mexico" ;;  
# 104) Televisia Acapuloco Mexico
104)  
keyword="acapulco"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvacapulco.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisia Acapulco Mexico" ;;   
# 105) Televisia Cuernavaca Mexico
105)  
keyword="cuernavaca"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
# link=http://www.galatvmorelos.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisia Cuernavaca Mexico" ;;   
# 106) Televisia Leon Mexico
106) 
keyword="leon"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisaleon.tv/video-en-vivo  
use_cookies="no"
 chan_name="Televisia Leon Mexico" ;; 
# 107) Televisia Queretaro Mexico
107)  
keyword="queretaro"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Queretaro Mexico" ;; 
# 108) Televisa Gudalajera Mexico
108)  
keyword="guadalajara"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisaguadalajara.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Gudalajera Mexico" ;; 
# 109) Televisia Mexicali Mexico
109)  
keyword="mexicali"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisamexicali.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Mexicali Mexico" ;;  
# 110) Televisia Toluca Mexico
110)  
keyword="toluca"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Toluca Mexico" ;;  
# 111) Televisia Hermosillo Mexico
111)  
keyword="hermosillo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Hermosillo Mexico" ;;  
# 112) Televisia Torreon Mexico
112)  
keyword="torreon"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Torreon Mexico" ;;  
##################
# 113) TeleSUR Venezuela
113) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 114) Imagen Radio Mexico
114) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 115) CNN Chile
115)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
# 116)TVES
116)
link=rtmp://cast.streamingconnect.tv:1935/tves2/tves2 
use_cookies="no"
chan_name="TVES" ;;
# 117) Canal del Congreso Mexico Spanish
117)
link=http://dl.canaldelcongreso.gob.mx:1935/ccongreso/mp4:congreso2b.mp4/playlist.m3u8
use_cookies="no"
chan_name="Canal del Congreso Mexico Spanish" ;;
# 118) El Capitolio Venezulana
118) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
use_cookies="no"
chan_name="El Capitolio Venezulana" ;;    
# 119) Euronews Espanol
119)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 120) CGTN Espanol
120)
link=https://live.cgtn.com/cctv-e.m3u8
use_cookies="no"
chan_name="CGTN Espanol" ;;
################ CHINESE MANDARIN CANTONESE  ####################
# 121) CCTV 4 Chinese
121) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;
############## TAIWAN TAIWANESE ##############################
# 122) 119 Live 電視台大立  Tai Li Taiwan
122)
keyword="電視台大立即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Tai Li Taiwan" ;;
# 123) EBC 51 News Taiwan
123) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 124) EBC Finance Taiwan
124) 
keyword="Taiwan EBC 24h live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
#  125) TzuChi DaAi World Taiwan 
125) 
keyword="DaAi World HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 126) FTV Taiwan
126) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 127) TTV News Taiwan
127) 
keyword="台視新聞台HD直播｜TAIWAN TTV NEWS HD (Live)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 128) CTV Taiwan
128) 
keyword="中視新聞台 LIVE直播｜Taiwan CTV news HD Live | 台湾のCTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 129) CTS World News HD Taiwan
129) 
keyword="華視新聞HD直播 | CTS Taiwan News Live HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 130) SET News Taiwan
130) 
keyword="三立新聞直播│SET News Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 131) CTI Taiwan
131) 
keyword="CTI中天新聞24小時HD新聞直播 │ CTITV Taiwan News HD Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;  
# 132) NeXT TV Taiwan
132) 
keyword="台中壹新聞直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/eranewstest/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Next TV Taiwan" ;;
# 133) Sinda Television
133) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 134) Cheng Sin TV
134) 
keyword="現場直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 135) TLTV
135) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 136) FLTV Taiwan
136) 
keyword="現場直播LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 137) 郭世明
137) 
keyword="全大電視網路直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdx4XBYPj9s6FZUhEQ9IWkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="郭世明 Guo Shiming";;
# 138) 海豚直播 Dolphin TV
138) 
keyword="海豚直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUz3LiE7QuRGDGZ2DYciIuA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="海豚直播 Dolphin TV";;
# 139) SITTI 1
139) 
keyword="桐瑛1台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 140) SITTI 2
140) 
keyword="桐瑛2台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 141) SITTI 3
141) 
keyword="桐瑛3台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 142) 大愛電視 Tzu Chi DaAiVideo 
142) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 143) 大愛一臺HD Live 直播
143)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;; 
# 144) OnTV Hong Kong
144) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 145) TBS Live Korea  
145) 
keyword="tbs TV LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 146) YTN DMB Korea  
146) 
keyword="와이티엔 _DMB"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 147) YTN Life Korea  
147) 
keyword="YTN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnweatherlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Life Korea" ;; 
# 148) YTN Science Korea  
148) 
keyword="YTN SCIENCE_LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnsciencelive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 149) Channel 23 Korea  
149) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 150) KBS World 24 Korea
150) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 151) YTN 27 Korea
151)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN 27 Korea" ;;   
# 152)CTS Korea
152) 
link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/CTS_34312_200.sdp/playlist.m3u8
#link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/_definst_/CTS_34312_100.sdp/playlist.m3u8
use_cookies="no"
chan_name="CTS Korea" ;;
# 153) BSC 24 1
153) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 154) BSC 24 2
154) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 155) Earthquake 24  
155) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 156) KBS Live 24 Japan  
156) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
#  157) QVC JAPAN SHOPPING CHANNEL
157) 
keyword="【QVCライブ】 24時間365日休まず生放送！！"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 158) Sol!ve 24 Japan
158) 
keyword="SOLiVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 

# 159) KBS World Korea
159) 
link=rtmp://118.97.183.196/jhos//kbs
use_cookies="no"
chan_name="KBS World Korea" ;;


# 159) Kiss Radio 1 Taiwan 
# 159)
# keyword="收聽佔有率第一的流行音樂電台 KISSRADIO 大眾廣播 FM99.9"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#use_cookies="no" 
#chan_name="Kiss Radio 1 Taiwan" ;; 
# 160) Kiss Radio 2 Taiwan 
# 160)
#keyword="南投廣播 FM99.7 /KISSRadio Live Streaming 24/7"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#use_cookies="no" 
#chan_name="Kiss Radio 2 Taiwan" ;; 
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 161) News 9 Bangalore Karnataka
161)
keyword="NEWS9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news9tv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 9 Bangalore Karnataka" ;;  
# 162) CVR News India
162) 
keyword="CVR" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVRNewsOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR News India" ;;  
# 163) CVR English India
163) 
keyword="CVR English Live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English India" ;;   
# 164) Shaski India
164) 
keyword="live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 165) SunNews 
165) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 166) TV9 India Live
166) 
keyword="TV9 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9telugulive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV9 Live India";;    
# 167) Rajya Sabha TV
167) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rajyasabhatv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Rajya Sabha" ;;
# 168) TV9 Gujarat
168) 
keyword="Tv9 Gujarati LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9gujaratlive/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="TV 9 Gujarat" ;; 
# 169) Tv9 Marathi
169) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tv9maharashtra/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Tv9 Marathi" ;; 
# 170) News 7 Tamil
170) 
keyword="Tamil"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news7tamil/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 7 Tamil" ;;
# 171) T News Telegu
171)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tnewslivetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="T News Telegu" ;;
# 172) News 18 India
172) 
keyword="News18 India Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ibn7/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="News 18 India" ;;
# 173) Aaj Tak 
173) 
keyword="Aajtak Live TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;; 
# 174) NTV Telugu
174) 
keyword="NTV Telugu Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvteluguhd/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="NTV Telugu" ;;
# 175) ABN Telugu
175) 
keyword="ABN Telugu LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/abntelugutv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="ABN Telugu" ;;
# 176) Vanitha TV 
176) 
keyword="Vanitha TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/VanithaTvChannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Vanitha TV" ;;
# 177) HMT Telugu
177) 
keyword="HMTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 178) TV5 News 
178) 
keyword="Live News Updates"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV5 News" ;;
# 179) Channel 24 India
179) 
keyword="CHANNEL 24 LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channel24web/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 180) SAMAA TV
180) 
keyword="SAMAA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV" ;;    
# 181) Survana News
181)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Survana News" ;;   
# 182) ATN News Bangladesh
182) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;     
# 183)i News Telugu
183) 
keyword="I News Telugu Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="i News Telugu" ;; 
# 184) News 1 Kannada 
184)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 185)  Jansari News Kannada 
185)
keyword="News Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/JanasriNewsKannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Jansari News Kannada" ;; 
# 186) Media One News
186)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Media One";;
# 187)  Tamil Live News
187) 
keyword="Thalaimurai TV LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Tamil Live News";;
## 188) DD News
188) 
keyword="DD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
## 189) Public TV India
189) 
keyword="Public TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/publictvnewskannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Public TV Kannada" ;;
# 190) REPORTER LIVE
190) 
keyword="REPORTER LIVE Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 191) Puthiyah Thalimurai
191)
keyword="Puthiya Thalaimurai TV LIVE Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Puthiya Thalaimurai" ;;
# 192) AsiaNet News
192) 
keyword="Asianet News Live TV" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 193)V6 News
193) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
 chan_name="V6 News" ;;
# 194) Kalaignar TV1
194) 
keyword="Kalaignar News LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar TV" ;;
# 195) ETV Andhra Pradesh
195) 
keyword="Pradesh Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 196) News 18 Tamilnadu
196) 
keyword="News18 TamilNadu | Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 197) The Polimer TV
197) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC8Z-VjXBtDJTvq6aqkIskPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="The Polimer TV" ;;
# 198) Jaya Plus
198) 
keyword="Live Jaya Networks"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) "  
use_cookies="no"
chan_name="Jaya Plus" ;;
# 199) TEZ TV
199) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;  
# 200) Dilli Aaj Tak
200) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 201)  The Ekantipur Nepal
201) 
keyword="Kantipur TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheEkantipur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="The Ekantipur Nepal" ;;  
# 202) NepalMandal TV
202) 
keyword="Nepalmandal TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEorL1RapK1IWOzWAZzKeVw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="NepalMandal TV" ;;  
##################### PAKISTAN  ############################
# 203)PTV Pakistan
203)
link=http://79.143.186.149:1935/live/PTVhome/player.m3u8
use_cookies="no"
chan_name="PTV Pakistan" ;;
# 204) Neo TV Pakistan
204) 
keyword="Neo News Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCAsvFcpUQegneSh0QAUd64A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="Neo TV Pakistan";;


## 205) Dawn News PAKISTAN
205) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/dawnnewspakistan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dawn News" ;;
# 206) Bol TV Pakistan
206) 
keyword="Bol TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCl_yX1yxsnYAgDs2RFJSerg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bol News" ;;
# 207) 92 News Pakistan
207) 
keyword="92 News Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCsgC5cbz3DE2Shh34gNKiog/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="92 News Pakistan";; 
## 208) 24 News Pakistan HD
208) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="24 News Pakistan HD" ;;  
################# AFGHANISTAN ######################################
## 209) TOLO NEWS AFGHANISTAN
209) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS";; 
################## ARABIC  ##########################################
# 210) RT Arabic 
210) 
keyword="RT Arabic"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 211) ON E Live 
211) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
# 212)  ON E Sports
212) 
keyword="Live Stream" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWLo4r-9_x4GCJCFShNFq0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E Sports" ;;   
# 213) ON Live
213) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON Live" ;;
# 214) Al Jazeera Arabic Qatar
214) 
keyword="Live Stream"
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 215) France 24 Arabic
215) 
keyword="الأخبار "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 216) BBC Arabic
216) 
keyword="BBC Arabic Live"
link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 217) Al Arabiya
217) 
keyword=" المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya" ;;
# 218) Al Mayadeen
218) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen" ;;   
# 219) Syrian Satellite
219) 
keyword="لفضائية" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Satellite" ;;     
# 220) ORTAS Syrian Satellite
220) 
keyword="الاخبارية السورية"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ORTAS Syria" ;;
# 221) Bedya TV Arabic
221) 
keyword="Bedaya TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bedya TV Arabic" ;;
# 222) Belqees TV Arabic
222)
keyword="قناة بلقيس "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belqees TV Arabic" ;;
# 223) Saudi TV Blue
223) 
keyword="القناة" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Blue" ;;  
# 224) Saudi Finance TV Purple
224) 
keyword="بث مباشر بواسطة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EqtsaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Finance TV Purple" ;;
# 225) Saudi Channel 1 Green 
225) 
keyword="القناة" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 1 Green" ;;
# 226) Saudi TV Gold  Mecca Kabba
226) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Gold" ;; 
# 227) Saudi Sliver Educational
227) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Silver" ;; 
# 228) Saudi Cultural TV Orange
228) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Cultural TV Orange" ;;
# 229) Saudi Sports TV Red
229) 
keyword="القنوات"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Sports TV Red" ;;
# 230) DMC Live
230) 
keyword="dmc"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE" ;;
# 231) SKY Arabic
231) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic" ;;
# 232) CBC Egypt Arabic Drama 
232) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 233) eXtra News Egypt Arabic
233) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 234) CBC Egypt Sofra Arabic
234) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 235) Saudi Ajyal Kids Tv
235) 
keyword="بث مباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv" ;; 
# 236) Makkha Live (Mecca Kaaba) 
236) 
keyword="Makkah Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIIopOeuwL8KEK0wnFcodw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mecca Kaaba Live" ;;
# 237)  DW Arabic
237) 
keyword="DW عربية مباشر"
link=http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8
#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
# 238) Mekameleen (Egypt)
238)
#link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/playlist.m3u8
link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/chunklist_w1503601403_b1800000.m3u8
#link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/chunklist_w1503601403_b2500000.m3u8
use_cookies="no"
chan_name="Mekameleen Egypt" ;;
# 239) CGTN Arabic
239)
link=https://live.cgtn.com/cctv-a.m3u8
use_cookies="no"
chan_name="CGTN Arabic" ;;
################### TURKEY  ########################  
## 240) TRT Haber Turkey
240) 
keyword="TRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 241) NTV Turkey
241) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 242) HaberTurk TV
242) 
keyword="Habertürk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 243) Star TV  Turkish
243) 
keyword="Star"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 244) Fashion 1 Turk TV
244)
keyword="Fashion"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fashion One TV";;
# 245) CNN Turk 
245) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 246) Ulusal Kanal Turkish
246) 
keyword="Ulusal Kanal Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6T0L26KS1NHMPbTwI1L4Eg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ulusal Kanal";;
# 247) KRT Kulture TV
247) 
keyword="KRTKultur TV Canlı yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 248) Tele 1 Kanali
248) 
keyword="Tele1 TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoHnRpOS5rL62jTmSDO5Npw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Tele 1 Kanali";;
# 249) Turkmenelie FM
249) 
keyword="Türkmeneli FM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie FM";;
# 250) Turkmenelie TV
250) 
keyword="Türkmeneli TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbHJ9XnJL1qQef_zhdUXGmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Turkmenelie TV";;
# 251) La Legul TV
251) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 252)Number1 TV Canlı Yayın
252)
keyword="Number1 Tv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 253) Number1 Turk TV
253)
keyword="Number1 Türk TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Türk TV";;
# 254) TGRT Haber TV
254) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 255) TVNET Canali Yayin
255) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 256)NEWSCHANNEL CANLI ( ZINDI )
256)
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCuGfQAjgRaUlmvOIb7yuIyA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="News Channel";;
# 257) Galatasaray 
257) 
keyword="GS TV Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/2galatasaray/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Galatasaray";;
# 258) A9 Televizyounu 
258) 
keyword="A9 TV Canlı Yayın İzle"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHHeyHIgmp5JEEg6cILSShg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="A9 Televizyounu";;
# 259) STerkTV Zindi 
259) 
keyword="STERKTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 260) Ronahi TV Zindi 
260) 
keyword="RonahiTV ZINDI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";;
# 261) Number1 Turk FM
261)
keyword="Türk Fm"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" |grep "$keyword" |grep "watch?v=" | head -n 1 | cut -d \= -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;
################### GREEK ######################################
## 262) Action 24 Greece 
262) 
link=http://www.dailymotion.com/video/x2p626q_action-24-live_tv
use_cookies="no"
chan_name="Action 24 Greek" ;;
## 263) Ionian TV
263) link=http://www.dailymotion.com/video/x4hnjh6_ionian-channel-livestream_tv
use_cookies="no"
chan_name="Ionian TV Greek" ;;
## 264) Star Lamia
264) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 265) Blue Sky TV Athens Greece
265) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
################  GERMAN   #######################################
# 266)EuroNews Deutsch
266) 
keyword="euronews LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;
# 267) Tagessschau 24 Germany
267)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 268) W24 Wein Germany
268)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein Train Ride" ;;
# 269) WDR Germany
269)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 270) RTS Salzburg Austria
270)
link=http://80.237.191.228:1935/live/_definst_/RTS2015/playlist.m3u8
use_cookies="no"
chan_name="RTS Salzburg Austria" ;;
# 271) Tirol TV German
271)
link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
use_cookies="no"
chan_name="Tirol TV German" ;;
################## DUTCH
# 272) 538 TV NETHERLANDS
272)
link=http://538hls.lswcdn.triple-it.nl/content/538tv/538tv_1.m3u8
use_cookies="no"
chan_name="538 TV NETHERLANDS" ;;
# 273)AT5 NETHERLANDS
273)
link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/playlist.m3u8
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;
################ Albania
# 274)ORA News Albania
274)
link=rtmp://81.7.13.162/oranews//oranews
use_cookies="no"
chan_name="ORA News Albania" ;;
# 275) ABC NEWS 24 Albania
275)
link=http://xabcalbaniax.api.channel.livestream.com/3.0/playlist.m3u8
use_cookies="no"
chan_name="ABC News 24 Albania" ;;
############# Romanian #####################################
# 276) Mediatv Romania
276)
link=http://mediatv.novanet.ro/mediatv/mediatv.m3u8
use_cookies="no"
chan_name="Mediatv Romania" ;;
# 277) TV Publica Moldova
277)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
############### RUSSIAN ################################
# 278)  Euronews Russian
278)
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 279) Vesti FM Russia
279) 
keyword="Вести ФМ"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 280) Россия 24
280) 
keyword="24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="POCCNR 24 Russia" ;;
################################ MENU 2 ########################################################
# 281) CGTN Russian
281)
link=https://live.cgtn.com/cctv-r.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
#  282) Life News Russia
282)
link=http://tv.life.ru/lifetv/360p/index.m3u8
use_cookies="no"
chan_name="Life News Russia" ;;
# 283) ТВ-ТРЕЙЛЕР Russia
283)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="ТВ-ТРЕЙЛЕР 2 Russia" ;;
# 284) Ukraine Channel 5 
284) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 285) Ukraine 112
285)
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 286) News 1 Ukraine
286) 
keyword="эфир NewsOne"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 287) Еспресо Ukraine
287) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 288) Thromadske Ukraine
288) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 289) UA TV Ukraine
289) 
keyword="UATV. Прямой эфир - Пряма трансляція - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Ukraine" ;;

################# TAGALOG FILIPINO #############################       
# 290) DZMM ABS-CBN Philippeans Radio
290) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 291) DZRH Philippeans
291) 
keyword="DZRH NEWS TELEVISION Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 292) DWIZ Philippeans
292) 
keyword="DWIZ 882 kHz TODONG LAKAS LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUWv18AQ-8k5m9_AEv5lzew/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DWIZ Philippeans" ;;
# 293) PTV Philippines
293)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ BRAZIL   ################################
# 294) STF Brazil
294)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 295) TV Estúdio Brasil
295)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 296) TV Cultura Brasil HD 
296)
link=http://wowza.catve.com.br:1935/live/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV Cultura Brasil HD" ;;
# 297) Rádio Justiça - Ao Vivo
297)  
keyword="Rádio Justiça - Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 298) Rádio Justiça - Ao Vivo
298)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
##########################  Italian  #######################################################
# 299) Canale 7 Italy
299)
link=http://wms.shared.streamshow.it/canale7/canale7/playlist.m3u8
use_cookies="no"
chan_name="Canle 7 Italy" ;;
# 300) SkyTG 24 Italian
300)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 301) Telecolor Lombardia Italy
301)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 302) Cremona 1 Italy
302)
link=http://cremona1.econcept.it/live/cremona1_high.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Cremona 1 Italy" ;;
# 303) QVC Itallian
303) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
################################## FARSI / PERSIAN  ###########################################################
# 304)  Euronews Persian
304) 
keyword="برنامه"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Persian";;
# 305)  BBC Persian
305) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
###################   AFRICA    ##############################################
# 306)  ADOM TV 
306) 
keyword="Adom TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV" ;;    
# 307) Biafra TV Africa 
307) 
keyword="Biafra Television Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 308) Joy News Ghana
308) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 309)  KTN Kenya
309) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 310) NTV Uganda
310) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
####################################################################################
# 311) Number1 Radyo Canlı Yayın
311)
keyword="Number1 Fm Radyo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Radyo Canlı Yayın";;
# 312) Venevision Venezuela
 312) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Venevision Venezuela" ;; 
#################### TRANSIENT ######################################## 
# 313) RSBN News Feed 2
313) 
keyword="LIVE STREAM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Cam 2" ;;
# 314) RUPTLY
314) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;;  
######################## PODCAST ###########################################
# 315) PBS NewsHour Video
315) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=0" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 316)  CBC The National
316) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 317) SABC Digital News South Africa
317) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;; 
# 318) AP Top Stories
318) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 319) Democracy Now Headlines 
319) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;    

# 320)

###############    SPACE       ######################### 
# 321) NASA ISS Earth Viewing
321)
link=http://d2ai41bknpka2u.cloudfront.net/live/iss.stream_source/chunklist.m3u8
#http://iphone-streaming.ustream.tv/uhls/17074538/streams/live/iphone/playlist.m3u8
use_cookies="no"
chan_name="NASA ISS Earth Viewing" ;;
# 322) NASA ISS 1
322) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
# 323) NASA ISS 2
323) link=https://www.youtube.com/watch?v=qzMQza8xZCc 
use_cookies="no"
chan_name="NASA ISS 2" ;;     
################## LOCATIONS #############################    
# 324) Venice Italy Bridge Cam Live
324) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 325) Venice Italy Port Cam Live
325) link=https://www.youtube.com/watch?v=Hzn2eBdqYWc 
use_cookies="no"
chan_name="Venice Italy Port Cam" ;;
# 326) Jackson Hole Intersection
326) link=https://www.youtube.com/watch?v=psfFJR3vZ78 
use_cookies="no"
chan_name="Jackson Hole Intersection" ;;
# 327) Jackson Hole Town Square
327) 
keyword="Square"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEpDjqeFIGTqHwk-uULx72Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 328) Jackson Hole Rustic Inn
328) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 329) Aosta Sarre Italy
329)
keyword="Aosta Sarre Italy"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/camillimarco/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Aosta Sarre Italy" ;;
# 330) Soggy Dollar Bar
330) link=https://www.youtube.com/watch?v=IjGdi7z_B4U 
use_cookies="no"
chan_name="Soggy Dollar Bar British Virgin Islands" ;;
#  331) Netherlands Amsterdam
331) 
keyword="amsterdam"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;; 
# 332) Shibua Japan Community Crosswalk 
332) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 333) Akiba Japan Live
333) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 334) Yahoo Weather Japan
334) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 335) Yahoo Weather Steamy Mountains
335)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 336) Naman Seoul Tower South Korea  
336) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 
# 337) Shizuoka Bridge Japan
337) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 338) Yokohama Port Japan
338) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 339) Hokkido Weather Cams
339) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 340) Mount Fuji Japan
340) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 341) Netherlands Hart Beach
341) 
keyword="https://hartbeach.nl/"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Hart Beach Netherlands" ;; 
# 342) Florida Cam 1
342) 
keyword="LIVE Mallory Square Key West"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 1" ;; 
# 343) Florida Cam 2
343) 
keyword="LIVE Two Friends Roof Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 2" ;; 
# 344) Florida Cam 3
344) 
keyword="LIVE Marathon FL Cam"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 3" ;; 
# 345) Florida Cam 4
345) 
keyword="LIVE Mallory Square - Key West FL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 4" ;; 
# 346) 
# 347) Durango Colorado USA
347) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com//channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 348)Star Dot Cam 1
348) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;  
# 349) Youing Japan Route 10
349) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 350) Star Dot Cam 4
350) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 351) Star Dot Cam 5
351) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 352) Star Dot Cam 6
352) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 353) Fine Cine London 1
353) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 354) Fine Cine London 2
354) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 355) Fine Cine London 3
355) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 356) Berlin Airport 
356) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 357) Osaka Japan  
357) 
keyword="ITM SKY CAM"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/masato663/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Osaka Japan" ;; 
# 358) Port of Los Angeles  
358) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 359)  ITS COM STUDIO Japan  
359) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 360)  China Shoreline 
360) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;;

##################################### LOCAL NEWS USA #################################################################### 
# 361) RSBN Auburn Alabama USA
361) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rightsideradio/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="RSBN Right Side Broadcasting Auburn Alabama USA" ;;    
############################ LOCAL NEWS USA#############################################
# 362) News 12 Brooklyn @
362) 
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12KN
use_cookies="no"
chan_name="News 12 Brooklyn" ;;
# 363) News 12 Long Island @
363) 
link=http://hls.iptv.optimum.net/news12/nipadlive/index_new.m3u8?callsign=N12LI_WEST
use_cookies="no"
chan_name="News 12 Long Island" ;;
# 364) FOX 25 Boston Massachusetts @
364)
#link=http://cmghlslive-i.akamaihd.net:80/hls/live/224671/WFXT/904k/prog.m3u8 
link=http://cmghlslive-i.akamaihd.net/hls/live/224671/WFXT/904k/prog.m3u8
use_cookies="no"
chan_name="FOX 25 Boston Massachusetts" ;;
# 365) WGN 9 Chicago   @
365) 
link=http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
# 366) FOX 23 Tulsa Oklahoma @
366) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224709/KOKI/904k/prog.m3u8 
use_cookies="no"
chan_name="FOX 23 Tulsa Oklahoma USA" ;;
# 367) FOX 13 News Memphis @
367) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224672/WHBQ/2564k/prog.m3u8
use_cookies="no"
chan_name="FOX 13 News Memphis" ;;
# 368) FOX 30 Jacksonville Florida  @
368)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224710/WFOX/904k/prog.m3u8
use_cookies="no"
chan_name="FOX 30 Jacksonville Florida" ;;
# 369) CBS 47 Jacksonville Florida  @
369)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224714/WJAX/904k/prog.m3u8
use_cookies="no"
chan_name="CBS 47 Jacksonville Florida" ;;
# 370) ABC News 9 Orlando 
370) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224711/WFTV/master.m3u8
use_cookies="no"
chan_name="ABC News 9 Orlando" ;;
# 371) Fox News 10 Phoenix Arizona USA
371) 
keyword="\:"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep -ah "$keyword" | grep "watch?v=" | head -n 1 | cut -d \? -f 2 | cut -d \= -f 2 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 372) FOX 2 News KTVU  Bay Area
372) 
link=http://play-prod1.live.anvato.net/server/play/ktvutestctg/master.m3u8
use_cookies="no"
chan_name="Fox 2 News KTVU Bay Area" ;;
# 373) WTPC 16 Virginia
373) 
link=http://mplive.play.ebmcdn.net/eastbay-live-pull-camera-3/_definst_/mp4:camera.stream/chunklist_w1700328985.m3u8
use_cookies="no"
chan_name="WTPC 16 Virginia" ;;
# 374) ATXN Austin Texas
374) 
link=http://oflash.dfw.swagit.com/livecc02/austintx/smil:atx-16x9-1-b/chunklist_w1826702480_b878000.m3u8
use_cookies="no"
chan_name="ATXN Austin Texas" ;;
# 375) Seminole TV Florida
375) 
link=http://video.seminolecountyfl.gov:1935/live/SGTV/chunklist.m3u8
use_cookies="no"
chan_name="Seminole TV (Florida)" ;;
# 376)The Florida Channel
376) 
link=rtmp://webcasting.thefloridachannel.org/live/tvweb1
use_cookies="no"
chan_name="The Florida Channel" ;;
#################### NATIONAL / LOCAL Weather #####################################################
# 377) The Weather Network
377)
link=http://d383mxeq7zv96c.cloudfront.net/api/ott/getVideoStream/USNATIONAL/master.m3u8?country=us
use_cookies="no"
chan_name="The Weather Network" ;;
# 378) Weather Nation
378) 
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
use_cookies="no"
chan_name="Weather Nation" ;; 
############################  TRANSIENT BROADCAST NEWS #############################################
# 379) CBS 13 News Stockton California USA
379) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kovrx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 13 News Stockton California USA" ;;
# 380) CBS 2 News New York
380) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-wcbsx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 2 News New York" ;;
# 381) NBC 4 News (New York)
381) 
link=http://wnbclive-f.akamaihd.net/i/wnbca1_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC 4 News New York" ;;
# 382) CBS 4 News Boston
382) 
link=http://54.163.107.81/server/play/cbslocal-wbzx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 4 News Boston" ;;
# 383) WVIT 30 News Hartford
383) 
link=http://wvitlive-f.akamaihd.net/i/wvitb2_1@71164/master.m3u8
use_cookies="no"
chan_name="WVIT 30 News Hartford" ;;
# 384) NBC 10 News (Philadelphia)
384) 
link=http://wcaulive-f.akamaihd.net/i/wcaua1_1@13991/master.m3u8
use_cookies="no"
chan_name="NBC 10 News Philadelphia" ;;
# 385) CBS 3 News Michigan 
385) 
link=http://wjmn-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 3 News Michigan" ;;
# 386) NBC News Nebraska
386) 
link=http://play-prod1.live.anvato.net/server/play/gray-ksnb-dfp/master.m3u8
use_cookies="no"
chan_name="NBC News Nebraska" ;;
# 387) CBS News Nebraska
387) 
link=http://play-prod1.live.anvato.net/server/play/gray-koln-dfp/master.m3u8
use_cookies="no"
chan_name="CBS News Nebraska" ;;
# 388) WJFW Newswatch 12 (Wisconsin)
388) 
link=http://cdn.bimvidlive.com/wjfw1/wjfw1/master.m3u8
use_cookies="no"
chan_name="WJFW Newswatch 12 (Wisconsin)" ;;
# 389) CBS 2 Salt Lake City
389) 
link=http://ktvx-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 2 Salt Lake City" ;;
# 390) CBS 5 News Colorado/ FOX 4 Kansas 
390) 
link=http://krex-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 5 Colorado" ;;
# 391) NBC 11 Bay Area
391) 
link=http://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/index_1286_av-p.m3u8
use_cookies="no"
chan_name="NBC 11 Bay Area" ;;
# 392) KCAL 9 News Los Angeles
392) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kcal-dfp/master.m3u8
use_cookies="no"
chan_name="KCAL 9 News Los Angeles" ;;
# 393) KNBC 4 News (Los Angeles)
393) 
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;
# 394) ABC 3 News Louisiana
394) 
link=http://ktbs-lh.akamaihd.net/i/KTBS_1069@111925/master.m3u8
use_cookies="no"
chan_name="ABC 3 News (Louisiana)" ;;
# 395) WPLG 10 News Miami
395) 
link=http://play-prod1.live.anvato.net/server/play/pns-wplg-dfp/master.m3u8
use_cookies="no"
chan_name="WPLG 10 News Miami" ;;
# 396) WJXT News 4 Jacksonville
396) 
link=http://play-prod1.live.anvato.net/server/play/pns-wjxt-dfp/master.m3u8
use_cookies="no"
chan_name="WJXT News 4 Jacksonville" ;;
# 397) CBS WBZ, Boston, Massachusettss
397)
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
use_cookies="no"
chan_name=" CBS WBZ, Boston, Massachusetts" ;;
# 398) CTV NEWS Canada
398)
#CTV NEWS HD
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News17.m3u8
link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News16.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News14.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News13.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News12.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News11.m3u8
use_cookies="no"
chan_name="CTV News Canada" ;; 
# 399)Fox News Talk
399)
link=http://fnurtmp-f.akamaihd.net/i/FNRADIOHDS_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;;

# 400)
################# ULTRA ###################################
# 401) ABC News Digital 1
401)
link=http://abclive.abcnews.com/i/abc_live1@136327/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 1" ;;
# 402) ABC News Digital 2
402)
link=http://abclive.abcnews.com/i/abc_live2@136328/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 2" ;;
# 403) ABC News Digital 3
403)
link=http://abclive.abcnews.com/i/abc_live3@136329/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 3" ;;
# 404) ABC News Digital 5
404)
link=http://abclive.abcnews.com/i/abc_live5@136331/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 5" ;;
# 405) NBC News Live Event
405)
link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
use_cookies="no"
chan_name="NBC News Live Event" ;;
# 406) WSJ Live
406)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 407) C-SPAN-1 Live Event
407)
link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN-1 Live Event" ;;
# 408) C-SPAN-2 Live Event
408)
link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN-2 Live Event" ;;
# 409) C-SPAN-3 Live Event
409)
link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN-3 Live Event" ;;
# 410) CNN Livestream 1
410)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
use_cookies="no"
chan_name="CNN Livestream 1" ;;
# 411) CNN Livestream 2  
411)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
use_cookies="no"
chan_name="CNN Livestream 2" ;;
# 412) CPAC 1 Canada
412)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
# 413) CPAC 2 Canada
413)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027997492001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
# 414)What America Thinks
414) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 415) NASA TV Public Education
415) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 416) NASA TV Media
416) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 417) RT Documentary
417) 
link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
use_cookies="no"
chan_name="RT Documentary" ;;
# 418) CGTN Documentary
418)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 419) HSN
419) 
keyword="HSN Live Stream"
link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 420) HSN 2
420) 
keyword="HSN2 Livestream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 421)  QVC 
421) 
keyword="QVC Live Stream"
link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 422)  QVC Beauty UK
422)
link=http://llnw.live.qvc.simplestream.com/hera/remote/qvcuk_primary_sdi6/1/prog_index.m3u8
use_cookies="no"
chan_name="QVC Beauty UK" ;;
# 423)  QVC Style UK
423)
link=http://llnw.live.qvc.simplestream.com/hera/remote/qvcuk_primary_sdi8/3/prog_index.m3u8
use_cookies="no"
chan_name="QVC Style UK" ;;
# 424) The Shopping Channel TSC
424)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 425) IdealWorld
425)
link=http://live.ccus.simplestreamcdn.com/live/isd_sdi3/bitrate1.isml/playlist.m3u8
use_cookies="no"
chan_name="IdealWorld" ;;
# 426) C-SPAN 2 HD
426)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 2" ;;
# 427) C-SPAN 3 HD
427)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 3" ;;
# 428) Euronews Maygar Hugarian
428) 
keyword="euronews élőben" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/euronewsHungarian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Maygar Hungarian" ;;
# 429) Bloomberg Europe
429)
link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/primary.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 430) London Live 
430)
link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
use_cookies="no"
chan_name="London Live" ;;
# 431) A Plus Australia
431)
link=rtmp://118.97.183.196/jhos//aplus
use_cookies="no"
chan_name="A Plus Australia" ;;
# 432) Yes TV
432)
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/YES/tu1_1.m3u8
use_cookies="no"
chan_name="Yes TV" ;;
# 433) The Blaze
433)
link=https://theblaze.global.ssl.fastly.net/live/theblaze/master.m3u8
use_cookies="no"
chan_name="The Blaze" ;;
# 434) The Weather Channel
434)
link=http://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
use_cookies="no"
chan_name="The Weather Channel" ;;
# 435) TRT BELGESEL HD
435)
link=http://trtcanlitv-lh.akamaihd.net/i/TRTBELGESEL_1@182145/index_600_av-p.m3u8?sd=10&rebase=on
use_cookies="no"
chan_name="TRT BELGESEL HD";;
# 436) BYUTV
436)
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
use_cookies="no"
chan_name="BYUTV" ;;
# 437) BYUTV International
437)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
#  438) Arirang Radio English 
438) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
# 439) Go News
439) 
keyword="NEWS"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mtyo0b/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Go News" ;;
# 440) Show TV Turkey
440) 
keyword="Show"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Show TV Turkey" ;;

###############################   SPORTS   ######################################################
# 441) PAC-12 Net. Arizona
441)
link=http://xrxs.net/video/live-p12ariz-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Arizona" ;;
# 442) PAC-12 Net. Bay Area
442)
link=http://xrxs.net/video/live-p12baya-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Bay Area" ;;
# 443) PAC-12 Net. Los Angeles
443)
link=http://xrxs.net/video/live-p12losa-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Los Angeles" ;;
# 444) PAC-12 Net. Mountain
444)
link=http://xrxs.net/video/live-p12moun-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Mountain" ;;
# 445) PAC-12 Net. Oregon
445)
link=http://xrxs.net/video/live-p12oreg-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Oregon" ;;
# 446) PAC-12 Net. Washington
446)
link=http://xrxs.net/video/live-p12wash-4728.m3u8
use_cookies="no"
chan_name="PAC-12 Net. Washington" ;;
# 447)USA-BASKET UNI Arizona
447)
link=http://xrxs.net/video/live-p12ariz-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Arizona" ;;
# 448)USA-BASKET UNI Los Angeles
448)
link=http://xrxs.net/video/live-p12losa-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Los Angeles" ;;
# 449)USA-BASKET UNI Mountain
449)
link=http://xrxs.net/video/live-p12moun-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Mountain" ;;
# 490)USA-BASKET UNI Oregon
450)
link=http://xrxs.net/video/live-p12oreg-1164.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Oregon" ;;
# 451)USA-BASKET UNI Washington
451)
link=http://xrxs.net/video/live-p12wash-2328.m3u8
use_cookies="no"
chan_name="USA-BASKET UNI Washington" ;;
# 452) EuroSports
452)
link=http://esioslive6-i.akamaihd.net/hls/live/202874/AL_P_ESP1_INTER_ENG/playlist_1800.m3u8
use_cookies="no"
chan_name="EuroSports" ;;
# 453)Virgin Music 2
453)
link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Music 2" ;;
# 454) Olympic Channel HD
454)
link=http://ocs-live.hls.adaptive.level3.net/ocs/channel01/NBC_OCS1_VIDEO_7_6064000.m3u8
use_cookies="no"
chan_name="Olympic Channel HD" ;;
# 455) NFL Now
455)
link=http://svglive3-event.level3.nfl.com/nflent3/live/now/NFLNOW.m3u8
use_cookies="no"
chan_name="NFL Now" ;;
# 456) MLB Network
456)
link=http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/master_wired.m3u8
use_cookies="no"
chan_name="MLB Network" ;;
# 457) 106.7 The Fan
457)
link=http://cbslocalhls-i.akamaihd.net/hls/live/204776/WJFK-FM-IOS/wjfklive.m3u8
use_cookies="no"
chan_name="106.7 The Fan" ;;
# 458) 105.7 The Fan
458)
link=http://cbslocalhls-i.akamaihd.net/hls/live/219778/WJZFM-IOS/wjzfmlive.m3u8
use_cookies="no"
chan_name="105.7 The Fan" ;;
# 459) High Stakes Poker
459) link=https://www.twitch.tv/highstakespoke 
use_cookies="no"
chan_name="High Stakes Poker" ;; 
################### Entertainment #############################
#  460) Toonami 
460) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
use_cookies="no"
chan_name="Toonami" ;;
# 461) Talking Tom and Friends
461) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 462) Talking Tom and Friends Minis
462) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
# 463) Adult Swim Animated Marathon 
463) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Animated Marathon" ;;
#  464) Adult Swim 
464) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
#  465) Adult Swim Live Action Marathon 
465) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/live-action-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Live Action Marathon" ;;
# 466) Animal Planet HD
466)
link=http://iphone-streaming.ustream.tv/uhls/12762028/streams/live/iphone/playlist.m3u8
use_cookies="no"
chan_name="Animal Planet HD";;
# 467) Insight TV
467)
link=http://ooyalahd2-f.akamaihd.net/i/intv02_delivery@346464/master.m3u8
use_cookies="no"
chan_name="Insight TV" ;;
# 468) 
# 469) ANIBOX 
469) 
keyword="ANI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCiFSWD-BKjiOgqo4gIBOBOg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANIBOX" ;;
# 470) Music Choice Play HD
470)
link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/chunklist.m3u8
use_cookies="no"
chan_name="Music Choice Play HD" ;;
# 471) MTV AM Russia
471) 
link=http://mtvam.ru/hlsam/playlist.m3u8
use_cookies="no"
chan_name="MTV AM Russia" ;; 
# 472) Capital TV
472)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_1500_av-p.m3u8
use_cookies="no"
chan_name="Capital TV" ;;
# 473) Heart TV
473)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/master.m3u8
use_cookies="no"
chan_name="Heart TV" ;;
# 474)CITY 
474)
link=http://nodeb.gocaster.net:1935/CGL/_definst_/mp4:TODAYFM_TEST2/stream.m3u8
use_cookies="no"
chan_name="CITY TV" ;;
# 475)Kiss TV
475)
link=http://tst.es.flash.glb.ipercast.net/tst.es-live/live/playlist.m3u8
use_cookies="no"
chan_name="Kiss TV" ;;
# 476) Country Music Channel
476)
link=http://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMCUSA/CCURstream0.m3u8
use_cookies="no"
chan_name="Country Music Channel" ;;
# 477) Heavy Metal Television
477)
link=http://70.166.98.130:1935/hmtv/myStream/playlist.m3u8
use_cookies="no"
chan_name="Heavy Metal Television" ;;
# 478) О2 ТВ Russia
478)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="O!2 TB Russia" ;;
# 479) Smile of a Child
479)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8
use_cookies="no"
chan_name="Smile of a Child" ;;
# 480) Family Friendly Entertainment
480)
link=http://54.225.64.228:1935/live/roku2/playlist.m3u8
use_cookies="no"
chan_name="Family Friendly Entertainment";;

########################  RELIGIOUS PROGRAMMING   ############################
# 481) CTV Vaticano
481) 
keyword="Centro Televisivo Vaticano"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ctvaticano/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CTV Vaticano" ;;
# 482) EWTN English
482) 
#keyword="17"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EWTN/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283781001
use_cookies="no"
chan_name="EWTN America" ;;
# 483) EWTN Ireland 
483) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409261120001
use_cookies="no"
chan_name="EWTN Ireland" ;;
# 484) Amazing Facts TV (Christian)
484) 
keyword="AFTV"
link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1921345467.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 485) It's Supernatural! Network (Christian)
485) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 486) Sheppard's Chapel (Christian)
486) 
keyword="Chapel"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Sheppard's Channel" ;;
# 487) International House of Prayer (IHOP) (Christian)
487) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 488) Belivers Voice of Victory Network
488) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 489) Three Angels BroadCasting
489) 
keyword="Three Angels Broadcasting Network (3ABN) Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels BroadCasting" ;; 
# 490) TCT HD
490) 
keyword="TCT Network Live HD Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT HD" ;; 
# 491) TCT SD
491) 
keyword="TCT Network Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT SD" ;; 
# 492) TCT Kids
492) 
keyword="TCT Network Live TCTKids Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
format="best"
use_cookies="no"
chan_name="TCT Kids" ;; 
# 493) Salt and Light TV Portage Michigan
493) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 494) LLBN TV
494) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 495) Rap Resurrection
495)
link=http://edge2.tikilive.com:1935/unrestricted_tikilive/36008/amlst:amKEQ2Y2gYN4/playlist.m3u8
use_cookies="no"
chan_name="Rap Resurrection";;
# 496) Hillsong Channel
496)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 497) Al Hayat TV Arabic
497) 
keyword="Al Hayat TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alhayatchanneltv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Hayat TV Arabic" ;; 
# 498) Al Fady TV Arabic
498) 
keyword="قناة الفادى الفضائية | قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6CtFtvwAWQBLt3dx9l7arg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Fady TV Arabic" ;; 
# 499) Aghapy TV
499) 
keyword="Aghapy TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC97YtaFaO3lUTcG4dCmgr5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aghapy TV" ;; 
# 500) St. Marys Coptic
500) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 501) Word of God Greek
501) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 502) CBN
502)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 503)CBN News
503)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 504)NRB Network
504)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 505) Shalom TV
505) 
keyword="Shalom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShalomTelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shalom TV" ;; 
# 506) Heaven TV
506) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 507) Rakshana TV
507) 
keyword="Rakshana TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jakkulaBenhur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rakshana" ;; 
# 508) Powervision TV
508) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 509) KJV Audio
509) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio Bible" ;; 
# 510)Catholic TV (USA) 
510) 
link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/master.m3u8
use_cookies="no"
chan_name="Catholic TV (USA)" ;;
# 511) Quran English Arabic
511) 
keyword="Quran Hidayah English TV Channel"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 512)  EWTN German
512) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 513) Jewish Life TV (USA)
513) 
link=http://52.40.109.131:1935/rtplive/smil:jltv.smil/playlist.m3u8
use_cookies="no"
chan_name="Jewish Life TV (USA)" ;;
# 514) The Church Channel
514)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8
use_cookies="no"
chan_name="The Church Channel" ;;
# 515) Temple Institute
515) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
# 516) TBN
516)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 517)GOD TV (USA) 
517) 
link=http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/master.m3u8
use_cookies="no"
chan_name="GOD TV (USA)" ;;
# 518) EWTN Spanish 
518) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;; 
# 519) EWTN Africa
519) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 520) EWTN Asia
520) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;
###################  MEGA    ###################
# 521) Harbor Light Radio
521) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 522) JUCE TV
522)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8
use_cookies="no"
chan_name="JUCE TV" ;;

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
elif [ "$input" == "ua-tor" ]
then
menstat="yes"
menu="$menu"
uastate="tor"
uamode="on"
elif [ "$input" == "ua-row1" ]
then
menstat="yes"
menu="$menu"
uastate="row1"
uamode="on"
elif [ "$input" == "ua-rand" ]
then
menstat="yes"
menu="$menu"
uastate="rand"
uamode="on"
elif [ "$input" == "ua-ranstr" ]
then
menstat="yes"
menu="$menu"
uastate="ranstr"
uamode="on"
elif [ "$input" == "ua-off" ]
then
menstat="yes"
menu="$menu"qq
uastate="off"
uamode="off"
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

### Select the user agent
if [ "$uamode" == "on" ]
 then
   if [ "$uastate" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$uastate" == "ranstr" ]
   then 
     # make a random string as the user agent 
     bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | cut -d "=" -f 1 | cut -d "+" -f 1 | cut -d "/" -f 1 )"
   elif [ "$uastate" == "tor" ] 
   then
     UA="$UA_torbrowser" 
   elif [ "$uastate" == "row1" ] 
   then
     UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
     UA=""
   fi 
 fi


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
  
  if [ "$uamode" == "on" ]
  then 
  echo "$UA"
   
    if [ "$use_cookies" == "yes" ]
    then
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --user-agent="$UA" --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" == "yes" ]
    then
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
     
  fi
 menu_switch "$menu" 
 echo "You were watching "$chan_name" Channel "$num" "
 chan_state="normal"
 menstat="no"
 read entry
 else 
 menu_switch "$menu"
 chan_state="normal"
 menstat="no"
 read entry
fi

while [ "$entry" != q ]
do

### Select the user agent
if [ "$uamode" == "on" ]
 then
   if [ "$uastate" == "rand" ]
   then 
    # pick a random user agent
    UA=$( grep -v "#" "$USERAGENTS" | shuf -n 1 ) 
   elif [ "$uastate" == "ranstr" ]
   then 
     # make a random string as the user agent 
     bytes="$( expr 12 + $(head -c 2 /dev/urandom | od -A n -i) % 48 | awk '{print $1}')"
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | cut -d "=" -f 1 | cut -d "+" -f 1 | cut -d "/" -f 1 )"
   elif [ "$uastate" == "tor" ] 
   then
     UA="$UA_torbrowser" 
   elif [ "$uastate" == "row1" ] 
   then
     UA=$( grep -v "#" "$USERAGENTS" | head -n 1 )
   else 
     UA=""
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

format="best"

if [ "$menstat" == "no" ]
then
channel_select "$num"
echo "$chan_name Channel $num" 
  
  if [ "$uamode" == "on" ]
  then 
  echo "$UA"
   
    if [ "$use_cookies" == "yes" ]
    then
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl -A "$UA" --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --user-agent="$UA" --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
  else
   
    if [ "$use_cookies" == "yes" ]
    then
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet curl --cookie-jar "$cookie" --silent "$link"  >  /dev/null 2>&1
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --cache="$cache_size" --fullscreen --loop-playlist=inf --stream-lavf-o=timeout=10000000 --cookies  --cookies-file "$cookie" "$link" 
    # clear the cookie
    echo " " > "$cookie"
    else
    firejail --noprofile --caps.drop=all --netfilter --nonewprivs --nogroups --seccomp --protocol=unix,inet mpv --ytdl-format="$format" --no-resume-playback --loop-playlist=inf --cache="$cache_size" --fullscreen "$link" 
    fi
     
  fi
  
menu_switch "$menu"
echo "You were watching "$chan_name" on Channel "$num" "  
chan_state="normal"
read entry
else 
menu_switch "$menu"
chan_state="normal"
menstat="no"
read entry
fi
done

echo "Type endstream to open a new stream."

if [ -e "$cookie" ]
then
rm "$cookie"
fi 

exit "$?"

# mpv --http-header-fields='Field1: value1','Field2: value2' 
# --tls-verify
# --referrer=<string>
# --cache-secs=<seconds>
# --cache-file-size=<kBytes>
# --cache-pause  --cache=<kBytes|yes|no|auto>
# https://mpv.io/manual/master/

######################     END OF PROGRAM      ####################################################

