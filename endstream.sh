#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.52
# Revision Date: November 05, 2017
#
# Recent Changes: - Ajouter quelques Canals / Emissions Francais 
#                 - Add more Spanish Channels
#                 - Added more menus and menu switching
#                 - Add more dailymotion streams in Mixed
#                 - Reorg French Channels
#                 - Repair Asian Channels
#                 - Repair Spanish Channels
#                 - Channel reorganization
#                 - incorporate user-agents
#                 - +/- channel controls, + grab streams direct from upstream source
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
#  VERSION: 1.15
#  VERSION DATE: JULY 05, 2017
#  COPYRIGHT: THE ENDWARE DEVELOPMENT TEAM, 2016-2017
#      
#  WHAT CONSTITUTES "USE"? WHAT IS A "USER"?
#  0) a) Use of this program means the ability to study, possess, run, copy, modify, publish, distribute and sell the code as included in all lines of this file,
#        in text format or as a binary file constituting this particular program or its compiled binary machine code form, as well as the the performance 
#        of these aforementioned actions and activities. 
#  0) b) A user of this program is any individual who has been granted use as defined in section 0) a) of the LICENSE AGREEMENT, and is granted to those individuals listed in section 1.
#  WHO MAY USE THIS PROGRAM ?
#  1) a) This program may be used by any living human being, any person, any corporation, any company, and by any sentient individual with the willingness and ability to do so.
#  1) b) This program may be used by any citizen or resident of any country, and by any human being without citizenship or residency.
#  1) c) This program may be used by any civilian, military officer, government agent, private citizen, government official, sovereign, monarch, head of state,
#        dignitary, ambassador, legislator,congressional representative, member of parliament, senator, judicial official, judge, prosecutor, lawyer 
#        noble, commoner, clergy, laity, and generally all classes and ranks of people, persons, and human beings mentioned and those not mentioned.
#  1) d) This program may be used by any human being of any gender, including men, women, and any other gender not mentioned.       
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
version="0.52"
rev_date="05/11/2017"
branch="gnu/linux"
product="ENDSTREAM"
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
channel_matrix_0()
{
   echo "============================================================    "$product" "$version"   ======================================================================"
   echo "||      ENGLISH       ||     FRANCAIS      ||      ESPANOL     ||      ASIAN     ||     INDIAN      || URDU/FARSI/ARABIC ||TR/GR/IT/DE/NL/RO/MD/UA/RU||"
   echo "======================================================================================================================================================="
   echo "1)BBC World News      41)France 24 FR      81)RT Espanol       121)CCTV 4 China  161)News 9 Bangalore 201)92 News PK      241)TRT Haber Turkey"    
   echo "2)SKY News London     42)France Info TV    82)DW Espanol       122)ECB 51 TW     162)CVR English      202)SAMAA PK        242)NTV Turkey" 
   echo "3)BBC News London     43)BFM TV FR         83)CGTN Espanol     123)ECB Finance TW163)CVR NEWS         203)PTV PK          243)HaberTurk TV"  
   echo "4)RT UK               44)CNEWS FR          84)Hispan TV        124)TTV TW        164)Shaski India     204)Neo TV PK       244)Star TV Turkey"             
   echo "5)France 24 English   45)TV5+ Monde BE     85)CNN Espanol      125)CTV TW        165)SunNews          205)Dawn PK         245)Fashion 1 Turk"  
   echo "6)DW English          46)i24 France IL     86)Magala TV ES     126)FTV TW        166)TV9 India        206)Bol TV PK       246)CNN Turk"  
   echo "7)Russia Today        47)CGTN Francais     87)Guada TV ES      127)CTS World TW  167)Rajya Sabha      207)24 News PK      247)Ulusal Kanal"
   echo "8)Euronews English    48)RTS UN CH         88)Vorterix AR      128)SET News TW   168)TV9 Gujarat      208)Tolo AF         248)KRT Kulture"
   echo "9)CBSN USA            49)Africa24          89)UNITV AR         129)CTI TW        169)Tv9 Marathi      209)TOLO NEWS AF    249)Tele 1 Kanali"
   echo "10)MSNBC USA          50)Africa News       90)c5n AR           130)TzuChi DaAi TW170)News 7 Tamil     210)BBC Persian     250)Number 1 Dance"
   echo "11)Bloomberg USA      51)France 2          91)A24 AR           131)DaAiVideo TW  171)T News Telegu    211)RT Arabic       251)Number 1 Turk FM"
   echo "12)CNN USA            52)RTS DEUX CH       92)Todo Noticias AR 132)DaAi Live TW  172)News 18 India    212)ON E Live Egypt 252)La Legul TV"
   echo "13)RT America         53)France 3          93)La Nacion AR     133)NeXT TV TW    173)Aaj Tak          213)ON E Sports     253)Number1 Ask"
   echo "14)CGTN America       54)France O          94)TV Publica AR    134)TLTV TW       174)NTV Telugu       214)ON Live Egypt   254)Number1 Turk"
   echo "15)Newsy USA          55)ARTE Francais     95)KZO AR           135)FLTV TW       175)ABN Telugu       215)Al Jazeera Qatar255)TGRT Haber"  
   echo "16)ABC News USA       56)TLM Lyon Metro FR 96)Canal 6 AR       136)Sinda TV      176)Vanitha TV       216)France 24 Arabic256)TVNET Canali"
   echo "17)TRT World Istanbul 57)Alsace 20 FR      97)Canal 7 AR       137)Cheng Sin TV  177)HMT Telugu       217)BBC Arabic      257)Number1 Radyo"
   echo "18)i24 News Israel    58)Mosaik TV FR      98)Canal 8 AR       138)Guo Shiming   178)TV5 News         218)Al Arabiya      258)Show TV Turkey"	
   echo "19)Al Jazeera English 59)Journal TVLandes  99)Telediario AR    139)Dolphin TV TW 179)Channel 24 IN    219)Al Mayadeen     259)Star Lamia Greece"
   echo "20)Saudi 2 English    60)Canal Savoir CA   100)Showsport AR    140)SITTI 1 TW    180)Survana News     220)Syrian Satellite260)Blue Sky TV Athens"  
   echo "21)Press TV Iran      61)CPAC 1 CA         101)SuperCanal 3 AR 141)SITTI 2 TW    181)Dilli Aaj Tak    221)ORTAS Syria     261)Action 24 Greece"
   echo "22)India Today        62)Gong Cinema       102)Argentisima AR  142)SITTI 3 TW    182)i News Telugu    222)Bedya TV        262)SkyTG 24 Italy"       
   echo "23)NEWS X India       63)TV7 France        103)CN23 AR         143)Da Li TW      183)News 1 Kannada   223)Belqees TV      263)Lombardia Italy"  
   echo "24)CGTN Beijing       64)QVC Francais      104)UNITV AR        144)OnTV HK       184)Jansari Kannada  224)DMC Live        264)Cremona 1 Italy"
   echo "25)Arirang Korea      65)France Info Radio 105)TVeo Cordoba AR 145)CTS 2 TW      185)Tamil Live       225)Sky Arabic      265)QVC Italy" 
   echo "26)NHK World Japan    66)France Inter      106)ABC Paraguay    146)KISS FM TW    186)DD News          226)CBC Drama Egypt 266)Canal Italia"
   echo "27)NewsAsia Singapore 67)RTL FR            107)Abya Yala BO    147)TBS KR        187)REPORTER LIVE    227)Extra News Egypt267)RSI CH"
   echo "28)CNN Philippeans    68)Europe 1 FR       108)CNN Chile       148)YTN DMB KR    188)AsiaNet News     228)CBC Sofra Egypt 268)SRF CH"
   echo "29)ABC Australia      69)RFI FR            109)UFROVision CL   149)YTN Life KR   189)V6 News          229)Makka Live      269)IRANY HU"
   echo "30)ANN7 South Africa  70)MABI CA           110)Campo Abierto CL150)YTN Sci KR    190)Kalaignar TV     230)DW Arabic       270)W24 Wein AT"    
   echo "31)Arise News Nigeria 71)LCP FR            111)TelePacifico CO 151)Channel 23 KR 191)ETV AndhraPradesh231)Mekameleen Egypt271)WDR DE"
   echo "32)Channels 24 Nigeria72)Public Senate FR  112)CTV CO          152)KBS World24 KR192)News 18 Tamilnadu232)CGTN Arabic     272)Tirol TV DE"
   echo "33)Africa News        73)SIKKA Afrique     113)TeleSUR VE      153)YTN 27 KR     193)The Polimer      233)Saudi Green     273)DW Deutsch" 
   echo "34)VOA USA            74)ICI RDI           114)Globovision VE  154)ANN24 JP      194)Jaya Plus        234)Saudi Blue      274)ZDK InfoKanal"  
   echo "35)CSPAN 1 USA        75)Assemblee QC CA   115)NTN24 VE        155)Sol!ve 24 JP  195)TEZ TV           235)Saudi Red       275)AT5 NL"
   echo "36)CPAC 1 Canada      76)-------------     116)Conciencia VE   156)KBS 24 JP     196)Dili Aaj Tak     236)Saudi Purple    276)TV Publica Moldova"
   echo "37)NEWSMAX USA        77)-------------     117)Excelsior MX    157)QVC Japan     197)Ekantipur Nepal  237)Saudi Orange    277)UA TV Ukraine"
   echo "38)Free Speech TV     78)-------------     118)PSN Tijuana MX  158)BSC 24 1 JP   198)NepalMandal      238)Saudi Gold      278)Thromadske Ukraine"	
   echo "39)Infowars           79)--------------    119)Bloomberg MX    159)BSC 24 2 JP   199)Derana LK        239)Saudi Silver    279)Еспресо Ukraine"
   echo "40)TWIT               80)--------------    120)Imagen Radio MX 160)Earthquake 24 200)Swarnavahini LK  240)Saudi Kids      280)News 1 Ukraine"
   echo "======================================================================================================================================================"
}	             
 
channel_matrix_1()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "|| RU/PH/AFRICA     ||     LOCATIONS     ||    USA LOCAL NEWS   ||     EXTRA          ||    ENTERTAINMENT   ||    RELIGIOUS       ||    MIXED     ||"
   echo "======================================================================================================================================================"
   echo "281)Ukraine 112       321)NASA ISS          361)RSBN Auburn USA    401)ABC News USA    441)MLB Network      481)CTV Vaticano      521)Harbor Light"    
   echo "282)Ukraine 5         322)NASA ISS 1        362)News 12 Brooklyn   402)ABC News 1      442)106.7 The Fan    482)EWTN Americas     522)JUCE TV " 
   echo "283)Euronews Russian  323)NASA ISS 2        363)News 12 Long Island403)ABC News 2      443)106.7 The Fan    483)EWTN Ireland      523)Quaran English "  
   echo "284)Россия 24         324)Venice Bridge     364)FOX 25 Boston      404)ABC News 3      444)Heart TV         484)EWTN Africa       524)Congreso Mexico"             
   echo "285)RBC TV Russia     325)Venice Italy Port 365)WGN 9 Chicago      405)ABC News 5      445)Capital TV       485)EWTN Asia         525)KISS FM 2 TW"  
   echo "286)CGTN Russian      326)JacksonHole Xsec  366)FOX 23 Tulsa       406)MSNBC Online    446)California Music 486)EWTN Espanol      526)beIN 1 Arabic"  
   echo "287)ТВ-ТРЕЙЛЕР Russia 327)JacksonHole Square367)FOX 13 Memphis     407)WSJ Live        447)Music Choice Play487)EWTN Deutsch      527)beIN 2 Arabic"
   echo "288)Vesti FM Russia   328)JacksonHole Rustic368)FOX 30 Jacksonville408)C-SPAN-1        448)538 Netherlands  488)Catholic TV       528)----------"
   echo "289)Life News Russia  329)Aosta Sarre Italy 369)CBS 47 Jacksonville409)C-SPAN-2        449)CITY TV          489)CBN               529)----------"
   echo "290)Current Time VOA  330)Buenos Aires      370)ABC 9 Orlando      410)C-SPAN-3        450)О2 ТВ Russia     490)CBN News          530)----------"
   echo "291)RTR Planeta       331)Amsterdam NL      371)Fox 10 Phoenix     411)CNN Live 1      451)MTV AM Russia    491)NRB               531)----------"
   echo "292)Perviy RU         332)Shibua Japan      372)Fox 2 Bay Area     412)CNN Live 2      452)DJ Animation     492)Church Channel    532)----------"
   echo "293)Music Box RU      333)Akiba Japan       373)WTPC 16 Virginia   413)CPAC 2 CA       453)DJ Classic       493)TBN               533)----------"
   echo "294)-----------       334)Yahoo Japan       374)ATXN Austin        414)C-SPAN 2 HD     454)DJ Dancefloor    494)God TV            534)DW Deutsch +"
   echo "295)VietTV VN         335)Steamy Mountain   375)Seminole Florida   415)C-SPAN 3 HD     455)DJ Underground   495)Amazing Facts     535)Tagessschau 24 DE" 
   echo "296)DZMM ABS-CBN      336)Naman Seoul       376)Florida Channel    416)DIVIDs          456)M2O Music        496)It's Supernatural!536)STerkTV Zindi"
   echo "297)DZRH Philippeans  337)Shizuoka Japan    377)Weather Network    417)America Thinks  457)Virgin 2 Music   497)Sheppard's Chapel 537)Ronahi Zindi"
   echo "298)PTV Philippines   338)Yokohama Japan    378)Weather Nation     418)NASA TV Educate 458)Adult Swim       498)IHOP              538)----------"	
   echo "299)Net TV Jakarta ID 339)Hokkido Weather   379)Weather Channel    419)NASA TV Media   459)Insight TV       499)BVOVN             539)KNBC 4 Los Angeles"
   echo "300)-----------       340)Mount Fuji Japan  380)CBS 2 New York     420)RT Documentary  460)London Live      500)3ABN              540)ABC 3 Louisiana"  
   echo "301)TVC News          341)Hart Beach NL     381)NBC 4 New York     421)CGTN Documentary461)Yes TV           501)3ABN Kids         541)WPLG 10 Miami"
   echo "302)TVC Continental   342)Florida 1         382)CBS 4 Boston       422)Bloomberg Europe462)Smile of a Child 502)TCT HD            542)WJXT 4 Jacksonville"       
   echo "303)NTV Uganda        343)Florida 2         383)WVIT 30 Hartford   423)Bloomberg Asia  463)Toonami          503)TCT SD            543)NBC 6 South Florida"  
   echo "304)KTN Kenya         344)Florida 3         384)NBC 10 Philadelphia424)BYUTV           464)Adult Swim Ani   504)TCT Kids          544)WBLZ Bangor Maine"
   echo "305)Joy News Ghana    345)Florida 4         385)CBS 3 Michigan     425)BYUTV Int       465)Talking Tom      505)Salt and Light    545)--------------"  
   echo "306)ADOM Ghana        346)Port Du Quebec    386)NBC Nebraska       426)Arirang Radio   466)Talking Tom Mini 506)LLBN TV           546)EuroNews Francais"
   echo "307)Bukedde TV        347)Durango Colorado  387)CBS Nebraska       427)HSN             467)Adult Swim Live  507)Rap Resurrection  547)EuroNews Deutsch"
   echo "308)Qaranka Somalia   348)StarDot 1         388)News12 Wisconsin   428)HSN 2           468)Fashion Europe   508)Hillsong          548)Euronews Magyar "
   echo "309)EBC Ethiopia      349)Youing Japan      389)CBS 2 Salt Lake    429)QVC             469)Fashion 1 TV ES  509)Al Hayat TV Arabic549)Mediatv Romania"
   echo "310)SPARK Uganda      350)StarDot 4         390)CBS 5 Colorado     430)TSC             470)Mello TV JM      510)Al Fady TV Arabic 550)Made in Leeds"    
   echo "311)Biafra TV         351)StarDot 5         391)NBC 11 Bay Area    431)IdealWorld      471)Jasmin TV        511)Aghapy TV Arabic  551)Made in Tyne"
   echo "312)Walf Senegal **   352)StarDot 6         392)CBS 13 Stockton    432)CTV Live Event  472)TYT              512)St. Mary's Coptic 552)Made in Cardiff"
   echo "313)Afrique Media **  353)London 1          393)KCAL 9 Los Angeles 433)Jupiter Broad   473)SBS IN           513)Word of God Greek 553)TTB Network" 
   echo "314)SABC South Africa 354)London 2          394)WXXV Mississippi   434)CPAC Senate CA  474)KPOP Idol        514)Shalom TV         554)1TV Afghan"  
   echo "315)EriTV Eritrea     355)London 3          395)NBC 13 Albany NY   435)-----------     475)-----------      515)Heaven TV         555)ErbuTV Kenya"
   echo "316)RUPTLY            356)Berlin Airport    396)NBC 2 Florida      436)-----------     476)-----------      516)Rakshana TV       556)KTN Home"
   echo "317)PBS NewsHour      357)Osaka Japan       397)WSOC 9 Charlotte   437)-----------     477)-----------      517)Powervision TV    557)----------"
   echo "318)CBC The National  358)Los Angeles Port  398)WCCB Charlotte     438)-----------     478)-----------      518)KJV Bible         558)----------"	 
   echo "319)AP Top Stories    359)ITS COM Japan     399)7 News Boston      439)-----------     479)-----------      519)Temple Institute  559)----------"
   echo "320)Democracy Now     360)China Shoreline   400)Fox News Talk      440)-----------     480)-----------      520)Jewish Life       560)----------"
   echo "==================================================================================================================================================="
}

channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "|| Latino Extra    ||     Column 2       ||    Francais Extra     ||   Column      4     ||  Column 5         ||    Column 6        ||   Column 7    ||"
   echo "======================================================================================================================================================"
   echo "561)Gudalajera MX    601)STF Brazil        641)TV5 Monde BE      681)------------     721)------------       751)------------      791)------------"    
   echo "562)Acapuloco MX     602)TV Estúdio Brasil 642)ICI Seguenay CA   682)------------     722)------------       752)------------      792)------------" 
   echo "563)Puebla MX        603)Rádio Justiça     643)ICI Rimouski CA   683)------------     723)------------       753)------------      793)------------"  
   echo "564)Sonora MX        604)EXA FM Brasil     644)------------      684)------------     724)------------       754)------------      794)------------"             
   echo "565)Toluca MX        605)RIT TV BR         645)------------      685)------------     725)------------       755)------------      795)------------"  
   echo "566)Veracruz MX      606)------------      646)------------      686)------------     726)------------       756)------------      796)------------"  
   echo "567)Cuernavaca MX    607)------------      647)------------      687)------------     727)------------       757)------------      797)------------"
   echo "568)Torreon MX       608)------------      648)------------      688)------------     728)------------       758)------------      798)------------"
   echo "569)Queretaro MX     609)------------      649)------------      689)------------     729)------------       759)------------      799)------------"
   echo "570)Aguascalientes MX610)------------      650)------------      690)------------     720)------------       760)------------      800)------------"
   echo "571)Matamoros MX     611)------------      651)------------      691)------------     721)------------       761)------------      801)------------"
   echo "572)Monterrey MX     612)------------      652)------------      692)------------     722)------------       762)------------      802)------------"
   echo "573)Chihuahua MX     613)------------      653)------------      693)------------     723)------------       763)------------      803)------------"
   echo "574)Mexicali MX      614)------------      654)------------      694)------------     724)------------       764)------------      804)------------"
   echo "575)TV Regionales MX 615)------------      655)------------      695)------------     725)------------       765)------------      805)------------" 
   echo "576)TV Chihuahua MX  616)------------      656)------------      696)------------     726)------------       766)------------      806)------------"
   echo "577)3ABN Latino      617)------------      657)------------      697)------------     727)------------       767)------------      807)------------"
   echo "578)Logos TV espanol 618)------------      658)------------      698)------------     728)------------       768)------------      808)------------"	
   echo "579)EuroNews Espanol 619)------------      659)------------      699)------------     729)------------       769)------------      809)------------"
   echo "580)UCVTV            620)------------      660)------------      700)------------     730)------------       770)------------      800)------------"  
   echo "581)JN19 Catolicos   621)------------      661)------------      701)------------     731)------------       771)------------      801)------------"
   echo "582)Mega CL          622)------------      662)------------      702)------------     732)------------       772)------------      802)------------"       
   echo "583)Vorterix AR      623)------------      663)------------      703)------------     733)------------       773)------------      803)------------"  
   echo "584)VIVE VE          624)------------      664)------------      704)------------     734)------------       774)------------      804)------------"
   echo "585)VPItv VE         625)------------      665)------------      705)------------     735)------------       775)------------      805)------------"  
   echo "586)VTV VE           626)-------------     666)------------      706)------------     736)------------       776)------------      806)------------"
   echo "587)PDVSA VE         627)------------      667)------------      707)------------     737)------------       777)------------      807)------------"
   echo "588)Impacto USA      628)------------      668)------------      708)------------     738)------------       778)------------      808)------------"
   echo "589)Canal 2 AR ***   629)------------      669)------------      709)------------     739)------------       779)------------      809)------------"
   echo "590)Canal 13 AR ***  630)------------      670)------------      710)------------     740)------------       780)------------      810)------------"    
   echo "591)Telepin AR **    631)------------      671)------------      711)------------     741)------------       781)------------      811)------------"
   echo "592)Canal 8 MarPlata 632)------------      672)------------      712)------------     742)------------       782)------------      812)------------"
   echo "593)Canal 11 Salta AR633)------------      673)------------      713)------------     743)------------       783)------------      813)------------" 
   echo "594)Euronews PT      634)------------      674)------------      714)------------     744)------------       784)------------      814)------------"  
   echo "595)TV Assemblelia BR635)------------      675)------------      715)------------     745)------------       785)------------      815)------------"
   echo "596)TV Canaco Nova   636)------------      676)------------      716)------------     746)------------       786)------------      816)------------"
   echo "597)Igreja de Graca  637)------------      677)------------      717)------------     747)------------       787)------------      817)------------"
   echo "598)Assemblelia Ales 638)------------      678)------------      718)------------     748)------------       788)------------      818)------------"	
   echo "599)Boas Nova        639)------------      679)------------      719)-----------      749)------------       789)------------      819)------------"
   echo "600)Fundacao Nazzare 640)------------      680)------------      720)-----------      750)------------       790)------------      820)------------"
   echo "==================================================================================================================================================="
}	   

channel_matrix_3()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "|| Column 1         ||     Column 2        ||    Column 3       ||   Column      4     ||  Column 5         ||    Column 6        ||   Column 7    ||"
   echo "======================================================================================================================================================"
   echo "821)------------     861)------------      901)------------      941)------------     981)------------       1021)------------     1061)------------"    
   echo "822)------------     862)------------      902)------------      942)------------     982)------------       1022)------------     1062)------------" 
   echo "823)------------     863)------------      903)------------      943)------------     983)------------       1023)------------     1063)------------"  
   echo "824)------------     864)------------      904)------------      944)------------     984)------------       1024)------------     1064)------------"             
   echo "825)------------     865)------------      905)------------      945)------------     985)------------       1025)------------     1065)------------"  
   echo "826)------------     866)------------      906)------------      946)------------     986)------------       1026)------------     1066)------------"  
   echo "827)------------     867)------------      907)------------      947)------------     987)------------       1027)------------     1067)------------"
   echo "828)------------     868)------------      908)------------      948)------------     988)------------       1028)------------     1068)------------"
   echo "829)------------     869)------------      909)------------      949)------------     989)------------       1029)------------     1069)------------"
   echo "830)------------     870)------------      910)------------      950)------------     990)------------       1030)------------     1070)------------"
   echo "831)-------------    871)------------      911)------------      951)------------     991)------------       1031)------------     1071)------------"
   echo "832)-------------    872)------------      912)------------      952)------------     992)------------       1032)------------     1072)------------"
   echo "833)------------     873)------------      913)------------      953)------------     993)------------       1033)------------     1073)------------"
   echo "834)------------     874)------------      914)------------      954)------------     994)------------       1034)------------     1074)------------"
   echo "835)------------     875)------------      915)------------      955)------------     995)------------       1035)------------     1075)------------" 
   echo "836)------------     876)------------      916)------------      956)------------     996)------------       1036)------------     1076)------------"
   echo "837)------------     877)------------      917)------------      957)------------     997)------------       1037)------------     1077)------------"
   echo "838)------------     878)------------      918)------------      958)------------     998)------------       1038)------------     1078)------------"	
   echo "839)------------     879)------------      919)------------      959)------------     999)------------       1039)------------     1079)------------"
   echo "840)------------     880)------------      920)------------      960)------------     1000)------------      1040)------------     1080)------------"  
   echo "841)------------     881)------------      921)------------      961)------------     1001)------------      1041)------------     1081)------------"
   echo "842)------------     882)------------      922)------------      962)------------     1002)------------      1042)------------     1082)------------"       
   echo "843)------------     883)------------      923)------------      963)------------     1003)------------      1043)------------     1083)------------"  
   echo "844)------------     884)------------      924)------------      964)------------     1004)------------      1044)------------     1084)------------"
   echo "845)------------     885)------------      925)------------      965)------------     1005)------------      1045)------------     1085)------------"  
   echo "846)------------     886)-------------     926)------------      966)------------     1006)------------      1046)------------     1086)------------"
   echo "847)------------     887)------------      927)------------      967)------------     1007)------------      1047)------------     1087)------------"
   echo "848)------------     888)------------      928)------------      968)------------     1008)------------      1048)------------     1088)------------"
   echo "849)------------     889)------------      929)------------      969)------------     1009)------------      1049)------------     1089)------------"
   echo "850)------------     890)------------      930)------------      970)------------     1000)------------      1050)------------     1090)------------"    
   echo "851)------------     891)------------      931)------------      971)------------     1011)------------      1051)------------     1091)------------"
   echo "852)------------     892)------------      932)------------      972)------------     1012)------------      1052)------------     1092)------------"
   echo "853)------------     893)------------      933)------------      973)------------     1013)------------      1053)------------     1093)------------" 
   echo "854)------------     894)------------      934)------------      974)------------     1014)------------      1054)------------     1094)------------"  
   echo "855)------------     895)------------      935)------------      975)------------     1015)------------      1055)------------     1095)------------"
   echo "856)------------     896)------------      936)------------      976)------------     1016)------------      1056)------------     1096)------------"
   echo "857)------------     897)------------      937)------------      977)------------     1017)------------      1057)------------     1097)------------"
   echo "858)------------     898)------------      938)------------      978)------------     1018)------------      1058)------------     1098)------------"	
   echo "859)------------     899)------------      939)------------      979)-----------      1019)------------      1059)------------     1099)------------"
   echo "860)------------     900)------------      940)------------      980)-----------      1020)------------      1060)------------     1100)------------"
   echo "==================================================================================================================================================="
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
   echo "$ endstream --ua-tor       # use tor-browser user-agent"
   echo "$ endstream --ua-rand      # use random user-agent from user_agents.txt "
   echo "$ endstream --ua-ranstr    # use a random string as the user agent"
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
   channel_matrix_0
   sleep 2
   channel_matrix_1
   sleep 2
   channel_matrix_2
   sleep 2
   channel_matrix_3
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
# 1) BBC World News
1) 
#High
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_1.m3u8
#Medium
#link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_2.m3u8
#Low
#link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/BBCW/tu1_3.m3u8
#link=https://www.filmon.com/tv/bbc-news
use_cookies="no"
chan_name="BBC World News" ;; 
# 2) Sky News
2)
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/07.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/06.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/05.m3u8
link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/04.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/03.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/02.m3u8
#link=http://skydvn-nowtv-atv-prod.skydvn.com/atv/skynews/1404/live/01.m3u8
keyword="Sky"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCd6knJkq4XBNHZATKWFNmGQ/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sky News" ;;
# 3) BBC News London
3) 
keyword=":"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bbcnews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=https://www.filmon.com/tv/bbc-news
use_cookies="yes"
chan_name="BBC News London" ;; 
# 4) RT UK
4)
#link=https://www.rt.com/on-air/rt-uk-air/ 
#link=https://secure-streams.akamaized.net/rt-uk/index.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-uk/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
# 5) France 24 Anglais 
5) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link=http://f24hls-i.akamaihd.net/hls/live/221193/F24_EN_LO_HLS/master.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
#link=http://www.dailymotion.com/video/xigc8z
use_cookies="no"
chan_name="France 24 English";;
# 6) DW English
6) 
keyword="DW"
link=http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8
#link= http://dwstream1-lh.akamaihd.net/i/dwstream1_live@120422/master.m3u8
# link=https://www.filmon.com/tv/dw-english
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelleenglish/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="DW English" ;;
# 7) Russia Today
7)
#link=https://www.rt.com/on-air/ 
#link=https://secure-streams.akamaized.net/rt/index.m3u8
#link=https://secure-streams.akamaized.net/rt/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt/index1600.m3u8
link=https://secure-streams.akamaized.net/rt/index800.m3u8
#link=https://secure-streams.akamaized.net/rt/index400.m3u8
#link=https://secure-streams.akamaized.net/rt/indexaudio.m3u8
## link=https://www.filmon.com/tv/russia-today-1
use_cookies="no"
chan_name="Russia Today" ;;
# 8) EuroNews English
8) 
keyword="euronews"
link=http://www.dailymotion.com/video/x2j4h4m
#format=hls-1080
#format=hls-720
format=hls-480 
#format=hls-380 
#format=hls-240
#link=http://fr-par-iphone-2.cdn.hexaglobe.net/streaming/euronews_ewns/ipad_en.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspe/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/Euronews/videos?&view=2" | grep "watch?v=" | grep "$keyword" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/playlist.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_720p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_540p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_360p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_224p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_180p.m3u8
#link=http://euronews-en-p9-cdn.hexaglobe.net/b845277c2db60882a29551105a4bd53b/594807ba/euronews/euronews-euronews-website-web-responsive-2/ewnsabrenpri_eng.smil/ewnsabrenpri_eng_90p.m3u8
use_cookies="no"
chan_name="Euronews English" ;; 
########################## USA MAINSTREAM ###################################################
# 9) CBSN 
9)
keyword="LIVE"
#wget -O "$temp_pl" https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8
#link=$( grep "84" "$temp_pl"| head -n 2 | tail -n 1 )
#rm "$temp_pl"
#link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?iu=/8264/vaw-can/mobile_web/cbsnews_mobile
#link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2050400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
link=https://dai.google.com/linear/hls/event/Sid4xiTQTkCT1SLu6rjUSQ/master.m3u8?#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/ecda85b07d04103f3ca263c0ba45447a/bandwidth/2050400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2490400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d2d912cba6f550796732975cdced5d96/bandwidth/2490400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/8e1f7a0b0b497a068d03deb47580e51f/bandwidth/1390400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=840400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/4d0b0dfc2918a3cc7f47a0a730929d96/bandwidth/840400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=466400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/b50367378267629c864cd89d88c8fd95/bandwidth/466400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=202400,CODECS="avc1.4d400d,mp4a.40.2",RESOLUTION=320x180
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/3ccfbd78e5563dc27b4b641ea47d57df/bandwidth/202400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2050400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d775971050601257bb7c76251d270815/bandwidth/2050400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2490400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=1280x720
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/5c306911638efba6b41a97aace92a9b8/bandwidth/2490400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1390400,CODECS="avc1.4d001f,mp4a.40.2",RESOLUTION=960x540
#link=https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/d448eed23b33ac60ea2c306497c19b82/bandwidth/1390400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=840400,CODECS="avc1.77.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/08bc2b629496b8a03063028ed25a08b3/bandwidth/840400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=466400,CODECS="avc1.66.30,mp4a.40.2",RESOLUTION=640x360
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/bf31306f9670a41fe087269c2f6eb576/bandwidth/466400.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=202400,CODECS="avc1.4d400d,mp4a.40.2",RESOLUTION=320x180
#https://dai.google.com/linear/hls/p/event/Sid4xiTQTkCT1SLu6rjUSQ/stream/e674cda6-3052-4a2a-bb05-78db73f04343:CBF/variant/977e885c0d735a9b92ae9a4ef4d6c2ea/bandwidth/202400.m3u8

#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
#
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/CBSNewsOnline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
use_cookies="no"
chan_name="CBSN" ;;
# 10) # MSNBC
10)

#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/master.m3u8
#link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8

#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"  

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=496000,RESOLUTION=416x236,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_496_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=796000,RESOLUTION=640x360,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_796_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=796000,RESOLUTION=640x360,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_796_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1896000,RESOLUTION=960x540,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1896_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2596000,RESOLUTION=1280x720,CODECS="avc1.64001f, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_2596_av-b.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4296000,RESOLUTION=1920x1080,CODECS="avc1.640028, mp4a.40.2"
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_4296_av-b.m3u8?sd=10&rebase=on"

use_cookies="no"
chan_name="MSNBC";;  
# 11) Bloomberg Business USA
11) 
keyword="Bloomberg TV"
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  

#link="http://mediauseast.akamaized.net/us/us3_live.m3u8"
link="http://mediauseast.akamaized.net/us/us2_live.m3u8"
#Bloomberg US HD http://mediauseast.akamaized.net/us/us3_live.m3u8
#Bloomberg TV US http://mediauseast.akamaized.net/us/us1_live.m3u8
#Bloomberg TV US http://mediauseast.akamaized.net/us/us2_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us4_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us5_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us6_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us7_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us8_live.m3u8 
#Bloomberg TV US http://mediauseast.akamaized.net/us/us9_live.m3u8
#Bloomberg Europe HD http://mediaeuwest.akamaized.net/eu/EU2400kb_live.m3u8 
#Bloomberg Europe HD http://mediaeuwest.akamaized.net/eu/EU1800kb_live.m3u8 
#Bloomberg Europe HD http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8 
#Bloomberg TV Europe http://mediaeuwest.akamaized.net/eu/EU700kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 12) CNN America  
12)
rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
use_cookies="no"
chan_name="CNN Live" ;;
# 13) RT America
13)
#link=https://www.rt.com/on-air/rt-america-air/
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-usa/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 14) CGTN America
14)
link=https://api.new.livestream.com/accounts/7082210/events/7115682/live.m3u8
use_cookies="no"
chan_name="CGTN America" ;;
# 15) Newsy
15) 
link=http://www.newsy.com/live/
#link=https://www.filmon.com/tv/newsy
use_cookies="no"
chan_name="Newsy" ;;
# 16) ABC News USA 
16)
#link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_400_av-b.m3u8?sd=10&rebase=on"
link="http://abclive.abcnews.com/i/abc_live4@136330/index_800_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_2500_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
use_cookies="yes"
chan_name="ABC News USA" ;;
############################# MIDDLE EAST ##############################################################
# 17) TRT World
17) 
keyword="TRT"
#link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
#link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8?play-only=primary
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=650000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=818000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=972000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 18) i24 News Israel
18) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
#format=hls-1080
#format=hls-720
format=hls-480 
#format=hls-380 
#format=hls-240
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 19) Al Jazeera
19) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
# 20) Saudi 2 TV
20) 
keyword="Saudi 2"
#link=https://www.filmon.com/tv/saudi-arabian-tv-2
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="yes"
chan_name="Saudi 2 English" ;;   
# 21) Press TV
21)
# link=https://www.filmon.com/tv/press-tv
link=http://178.32.255.199:1935/live/ptven/playlist.m3u8
#link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/chunklist.m3u8
#link=http://efusion1-i.akamaihd.net/hls/live/252882/ptven/playlist.m3u8
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
# 23) NEWS X INDIA English
23) 
link=http://newsx.live-s.cdn.bitgravity.com/cdn-live/_definst_/newsx/live/newsxnew.smil/playlist.m3u8
use_cookies="no"
chan_name="NEWS X INDIA English" ;; 
###########################  ASIA-OCEANIA   ############################################
# 24) CGTN China English
24) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 25) Arirang TV Korea
25) 
keyword="Arirang" 
link=http://www.filmon.com/tv/arirang-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
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
use_cookies="no"
chan_name="Arirang TV Korea" ;; 
# 26)NHK World Japan 
26) 
link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8
use_cookies="no"
chan_name="NHK World Japan" ;;
# 27)NewsAsia Singapore
27) 
link=http://imtcnai-lh.akamaihd.net/i/cnai_main@334572/master.m3u8
use_cookies="no"
chan_name="NewsAsia Singapore" ;;
# 28) CNN PHILIPPINES
28)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
chan_name="CNN PHILIPPINES";;
# 29) ABC News Australia 
29) 
keyword="ABC" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsOnABC/videos?&view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
#link=https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/master.m3u8
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_250_av-p.m3u8?sd=10&rebase=on"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_450_av-p.m3u8?sd=10&rebase=on"
#link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_650_av-p.m3u8?sd=10&rebase=on"
link="https://abcnews24mha-lh.akamaihd.net/i/abcnews24nospe_1@70019/index_750_av-p.m3u8?sd=10&rebase=on"

#BANDWIDTH=295680
#link=http://iphonestreaming.abc.net.au/news24/news24_vlo.m3u8
#BANDWIDTH=398944
#link=http://iphonestreaming.abc.net.au/news24/news24_lo.m3u8
#BANDWIDTH=553888
#link=http://iphonestreaming.abc.net.au/news24/news24_med.m3u8
#0BANDWIDTH=708832
#link=http://iphonestreaming.abc.net.au/news24/news24_hi.m3u8
#BANDWIDTH=64000
#link=http://iphonestreaming.abc.net.au/news24/news24_vloaudio.m3u8
use_cookies="no"
chan_name="ABC News Australia" ;; 
########################### AFRICA ############################################
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
keyword="Arise"
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
# 33) Africa News Live
33)
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;
########################## AMERICAN GOVERNMENT ####################################################
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
########################## CANADIAN GOVERNMENT ###################################################
# 36) CPAC 1 Canada
36)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;
##################    ALTERNATIVE MEDIA  ##################################################
# 37) NEWSMAX USA
37) 
keyword="Newsmax"
link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
# "http://www.newsmaxtv.com/"
#link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 38)Free Speech TV
38) 
link=https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv.m3u8
use_cookies="no"
chan_name="Free Speech TV" ;;  
# 39)  Infowars
39) 
keyword="Infowars"
link=http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8
#link=http://www.infowars.com/show
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUJNY4nfdomMppNDZNZc4nA/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
###################      TECHNOLOGY    ################################################
# 40) TWiT
40) 
keyword="TWiT Live"
link=https://www.twitch.tv/twit 
#link=http://hls.twit.tv/flosoft/mp4:twitStream_540/playlist.m3u8
#link=http://hls.cdn.flosoft.biz/flosoft/mp4:twitStream_360/playlist.m3u8
#https://www.ustream.tv/channel/1524
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT" ;;

#################    FRENCH   ###################################
# 41) France 24 
41)
keyword="FRANCE 24 en Direct" 
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
#link=http://www.dailymotion.com/video/xigbvx_live-france-24_news
# link=http://static.france24.com/live/F24_FR_LO_HLS/live_ios.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="France 24" ;;
# 42) France Info TV
42) 
keyword="franceinfo"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/franceinfo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://www.dailymotion.com/video/x4rdeu6_live-franceinfo-tv_news
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
use_cookies="no"
chan_name="France Info TV" ;;                                                       
# 43) BFM TV
43) 
link=http://csm-e.dai.bfmtv.com/csm/live/109797390.m3u8
#link=https://www.dailymotion.com/video/xgz4t1_live-bfmtv_news
#link=link=https://www.filmon.com/tv/bfm-tv
use_cookies="no"
#format=hls-1080@60-0 
#format=hls-1080@60-1
#format=hls-720@60-0 
#format=hls-720@60-1 
#format=hls-480-0
#format=hls-480-1
#format=hls-380-0
#format=hls-380-1
#format=hls-240-0
#format=hls-240-1
chan_name="BFM TV";;
# 44) CNEWS France
44)
link=http://www.dailymotion.com/video/x3b68jn
use_cookies="no"
#format=hls-1080@60
#format=hls-720@60
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="CNEWS France" ;;
# 45) TV5+ monde 
45)
link=http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_1.m3u8
use_cookies="no"
chan_name="TV5+ monde " ;;
# 46) i24 News en Direct
46) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="i24 Francais";;
# 47) CGTN Francais
47)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;; 
# 48) RTS UN
48) 
link=https://www.filmon.com/tv/rts-un
use_cookies="yes" 
chan_name="RTS UN" ;;
# 49) Africa24
49) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;; 
# 50) Africa News Francais
50) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 51) FRANCE 2
51) 
link=https://www.filmon.com/tv/france-2
use_cookies="yes"
chan_name="France 2" ;;
# 52) RTS DEUX
52) 
link=https://www.filmon.com/tv/rts-deux
use_cookies="yes" 
chan_name="RTS DEUX" ;;
# 53) France 3 Rhone Alpes
53) 
link=https://www.filmon.com/tv/france-3-rhone-alpes
use_cookies="yes"
chan_name="France 3 Rhone Alps" ;;
# 54)France O
54) 
link=https://www.filmon.com/tv/france-0
use_cookies="yes"
chan_name="France O" ;;
# 55) ARTE FRANCAIS
55) 
link=https://www.filmon.com/tv/arte-francais
use_cookies="yes" 
chan_name="ARTE Francais" ;; 
# 56) TLM Lyon Metro
56) 
keyword="TLM en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 57) Alsace 20 France
57)
link="http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/master.m3u8"
use_cookies="no"
chan_name="Alsace 20 France" ;;
# 58) Mosaik TV Francais
58)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 59) Direct Journal TVLandes    
59) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Direct Journal Tvlandes"  ;;    
# 60)Canal Savoir Francais
60)
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
use_cookies="no"
chan_name="Canal Savoir Canada" ;;
# 61) CPAC 1 Francais
61)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
use_cookies="no"
chan_name="CPAC 1 Francais Canada" ;;
# 62) Gong Asian Cinema Francais
62)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
chan_name="Gong Asian Cinema Francais" ;;
# 63)TV 7 Francais
63)  
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV 7 Francais" ;;  
# 64) QVC Francais
64) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;  
# 65) France Info Radio
65) link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
format=hls-720
use_cookies="no"
chan_name="France Info Radio" ;;
# 66) France Inter
66) 
keyword="France Inter en direct"
link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
format=hls-720
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;;
# 67) RTL En direct
67) link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
# link=http://www.dailymotion.com/video/xl1km0
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
chan_name="RTL En Direct" ;;
# 68) Europe 1
68) link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Europe 1" ;;
# 69) RFI
69) 
keyword="RFI en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;
# 70) MABI TV Canada
70) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="MABI TV Canada" ;;
# 71)LCP Assemblee National France
71)
link=http://www.dailymotion.com/video/xji3qy
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="LCP Assemblee National France" ;;
# 72) Public Senate France
72)
link=http://www.dailymotion.com/video/xkxbzc
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="Public Senate France" ;;
# 73) SIKKA TV
73) 
keyword="SIKKA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SIKKA TV Afrique" ;; 

# 74) ICI RDI Canada
74)
# link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_400_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_800_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/master.m3u8?sd=10&rebase=on"
 use_cookies="no"
 chan_name="ICI RDI Canada" ;;
# 75) Assemblee Nationale du Quebec Francais
75)
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
use_cookies="no"
chan_name="Assemblee Nationale du Quebec Francais Canada" ;;
################### BROKEN / OFFLINE ###################################

# 79) ICI Radio-Canada – Sherbrooke – CKSH-DT
# 79)
# link="http://hdflash_1-lh.akamaihd.net/i/cancksh_1@93278/index_1200_av-b.m3u8"
# use_cookies="no"
# chan_name="ICI Radio-Canada – Sherbrooke – CKSH-DT" ;;
# 80) ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT
# 80)
# link="http://hdflash_1-lh.akamaihd.net/i/cancktv_1@93272/index_1200_av-b.m3u8"
# use_cookies="no"
# chan_name="ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT" ;;
# ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT
# 73)
# link="http://hdflash_1-lh.akamaihd.net/i/cancboft_1@192896/index_1200_av-b.m3u8"
# use_cookies="no"
# chan_name="ICI Radio-Canada – Ottawa-Gatineau – CBOFT-DT" ;;
# 74) ICI Radio-Canada – Montréal CBFT-DT
# 74)
# link="http://hdflash_1-lh.akamaihd.net/i/cancbft_1@95875/master.m3u8"
# use_cookies="no"
# chan_name="ICI Radio-Canada – Montréal" ;;
# 75) ICI Radio-Canada – Trois-Rivières – CKTM-DT
# 75)
# link="http://hdflash_1-lh.akamaihd.net/i/cancktm_1@93276/index_1200_av-b.m3u8"
# use_cookies="no"
# chan_name="ICI Radio-Canada Trois-Rivières – CKTM-DT" ;;
# ICI Radio Canada Quebec City Quebec CBVT-DT
# 61)
# link="http://hdflash_1-lh.akamaihd.net/i/cancbvt_1@93274/index_1200_av-b.m3u8"
# use_cookies="no"
# chan_name="ICI Radio Canada - Quebec City Quebec CBVT-DT" ;;


# 64) M7 Television
# 64) link=https://www.dailymotion.com/video/x59xxgx_live_music 
#use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
#chan_name="M7 TV Mali" ;;

# 64) BFM Business
# 64) link=https://www.filmon.com/tv/bfm-business
# use_cookies="no"
# chan_name="BFM Business" ;;

# 74) Max FM 92.9 
# 74) link=https://www.dailymotion.com/video/x532emn_maxfm-live-24-7_music 
#use_cookies="no"
#format=hls-480
#format=hls-380
#format=hls-240
# chan_name="Max FM 92.9" ;;
###################  SPANISH  #################################
# 81) RT Espanol
81) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEIhICHOQOonjE6V0SLdrHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=https://actualidad.rt.com/en_vivo2
use_cookies="no"
chan_name="RT Espanol" ;;
# 82) DW Espanol
82) 
keyword="DW Español en VIVO"
link=http://dwstream3-lh.akamaihd.net/i/dwstream3_live@124409/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DeutscheWelleEspanol/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="DW Espanol" ;;
# 83) CGTN Espanol
83)
link=https://live.cgtn.com/cctv-e.m3u8
use_cookies="no"
chan_name="CGTN Espanol" ;;
# 84) Hispan TV
84) 
keyword="HispanTV"
link=http://178.32.255.199:1935/live/hispantv/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
# 85) Senal de CNN en Espanol
85)  
keyword="CNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnenespanolcom/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal de CNN en Espanol" ;;
############## SPAIN ######################################
# 86) Magala TV Spain  Malaga,Andalusia,Spain
86)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Malaga24h/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Magala TV Spain" ;;  
# 87)  GUADA TV Guadalajara (España)
87) 
keyword="Guada"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oPWmhiUTekfM5vcWsORLg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Guada TV Spain" ;;
######################### ARGENTINA ##############################################
# 88) c5n Argentina
88) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
# link=http://www.c5n.com/
use_cookies="no"
chan_name="c5n Argentina" ;;
# 89) A24 Argentina
89) 
keyword="A24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 90) Todo Noticias Argentina
90) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 91) La Nacion TV Argentina
91) 
keyword="LN+"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 92) TV Publica Argentina
92)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TV Publica Argentina" ;;  
# 93) KZO En Vivo Canal 30
93) 
keyword="KZO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;; 
# 94) Canal 6 San Rafael Argentina
94) 
keyword="RAFAEL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 95) Canal 7 Mendoza Argentina
95) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 96) Canal 8 San Juan Argentina
96) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 97) Telediario AR  
97)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1-SmZtkXTg2ufhLMpwiRIg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telediario AR" ;;
# 98) Showsport Cordoba Argentina
98)  
keyword="Showsport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CanalShowsport/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Showsport Argentina" ;;  
# 99) Canal 3 SuperCanal Argentina
99)  
keyword="SuperCanal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/supercanal3oeste/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 3 SuperCanal Argentina" ;;  
# 100) Argentiisima Satelital Argentina
100)  
keyword="Argentinisima"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/argentinisimasat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Argentinisima Satelital Argentina" ;;  
# 101) CN23 Argentina
101)  
keyword="CN23"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CN23 Argentina" ;;   
# 102) UNITV Universidad Nacional de General Sarmiento AR
102)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWCJwDsCdRn_pwHNpLwEJcw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UNITV Universidad Nacional de General Sarmiento AR" ;;  
# 103) TVeo Canal 41 Cordoba AR
103)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9kgE-365dvz6zJEUX1dFiw/?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TVeo Canal 41 Cordoba AR" ;; 
# 104) UNITVE AR
104) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_NtgyVHyQJfy3YlM6XdQdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UNITVE AR" ;;
################## PARAGUAY #####################################
# 105) ABC TV Paraguay
105)  
keyword="ABC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalabctv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ABC TV Paraguay" ;;
################# BOLIVIA #####################################
# 106) Abya Yala Bolivia
106)  
keyword="Abya Yala"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYVYGzj8t64hFAz2T-udG5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Abya Yala Bolivia" ;;
############### CHILE#################################
# 107) CNN Chile
107)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
# 108) UFRO Vision Chile 
108)  
keyword="UFRO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5H9zdp-3M24xWWJunhLJmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UFRO Vision Chile" ;;  
# 109) CAMPO ABIERTO Santiago Chile
109) 
keyword="ABIERTO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCp7fI6azkQdBmsrdrrWphbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CAMPO ABIERTO Santiago Chile" ;;
################## Colombia ###################
# 110) TelePacifico Colombia
110) 
keyword="Telepacifico"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelepacificoCanal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 
# 111) CTV Barranquilla Colombia
111) 
keyword="CTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJWpMkOWNk3wlj565Q0lpzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTV Barranquilla Colombia" ;;
################# VENEZUELA
# 112) TeleSUR Venezuela
112) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
# link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 113) Globovision Venezeula
113) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 114) NTN24 Venezuela
114) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 115) CONSCIENCIA TV
115)  
keyword="CONCIENCIA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClUdUKaJ6qBoqe4o8qN9Bdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CONCIENCIA TV" ;;




#################### MEXICO #########################################################
# 117) Excelsior TV Mexico
117) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
# 118) PSN Tijuana Mexico
118) 
keyword="PSN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";; 
# 119) Bloomberg Financiero Mexico
119)  
keyword="Bloomberg"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FinancieroMexico/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bloomberg Financiero Mexico" ;; 
# 120) Imagen Radio Mexico
120) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;

################ CHINESE MANDARIN CANTONESE  ####################
# 121) CCTV 4 Chinese
121) 
keyword="CCTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ChineseInternatioify/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CCTV 4 China" ;;
############## TAIWAN TAIWANESE ##############################
# 122) EBC 51 News Taiwan
 122) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsebc/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EBC 51 News Taiwan" ;;
# 123) EBC Finance Taiwan
 123) 
keyword="EBC" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/57ETFN/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="EBC Finance News Taiwan" ;;
# 124) TTV News Taiwan  
 124) 
keyword="台視新聞台HD直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzZe-zMu-YgVFQfDmsFG_VQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TTV News Taiwan"  ;;
# 125) CTV Taiwan 
125) 
keyword="中視新聞台 LIVE直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmH4q-YjeazayYCVHHkGAMA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTV Taiwan" ;;
# 126) FTV Taiwan
126) 
keyword="台灣民視新聞HD直播 | Taiwan Formosa live news HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="FTV Taiwan Live";;
# 127) CTS World News HD Taiwan
127) 
keyword="國會頻道１ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD" ;;
# 128) SET News Taiwan
128) 
keyword="SET"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setnews159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SET News Taiwan" ;;
# 129) CTI Taiwan 
129) 
keyword="CTI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ctitv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="CTI Taiwan" ;;
#  130) TzuChi DaAi World Taiwan 
130) 
keyword="DaAi World HD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Tzu Chi DaAi World Taiwan" ;; 
# 131) 大愛電視 Tzu Chi DaAiVideo 
131) 
keyword="大愛一臺HD Live 直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 1" ;; 
# 132) 大愛一臺HD Live 直播
132)
keyword="大愛二臺HD Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DaAiVideo/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Tzu Chi DaAiVideo 2" ;;  
# 133) NeXT TV Taiwan
133) 
keyword="台中壹新聞直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/eranewstest/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Next TV Taiwan" ;; 
# 134) TLTV
134) 
keyword="天良電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVDgvpdyy8VbpsiXjc-kdGQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TLTV";;
# 135) FLTV Taiwan
135) 
keyword="直播LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfXY08An6l_o44W5PpkCApg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="FLTV Taiwan";;
# 136) Sinda Television
136) 
keyword="信大電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZIvbuuP-xGgMG-_0tLLadg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Sinda Television" ;; 
# 137) Cheng Sin TV
137) 
keyword="誠心衛星電視台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCiqQ09Js9wGNUo3QNNaiYgg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Cheng Sin TV";;
# 138) 郭世明
138)
keyword="全大電視網路直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdx4XBYPj9s6FZUhEQ9IWkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="郭世明 Guo Shiming";;
# 139) 海豚直播 Dolphin TV
139) 
keyword="海豚直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUz3LiE7QuRGDGZ2DYciIuA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="海豚直播 Dolphin TV";;
# 140) SITTI 1
140) 
keyword="桐瑛一台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 141) SITTI 2
141) 
keyword="桐瑛2台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 142) SITTI 3
142) 
keyword="桐瑛3台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC0_qynU6EFzciPwhuvRhTbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 143) 119 Live 電視台大立  Da Li Taiwan  **
143)
keyword="電視台大立即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Da Li Taiwan" ;;
# 144) OnTV Hong Kong
144) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 145) CTS World News HD 2 Taiwan
145) 
keyword="國會頻道２ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD 2" ;;
# 146) Kiss Radio 1 Taiwan 
146)
keyword="收聽佔有率第一的流行音樂電台 KISSRADIO 大眾廣播 FM99.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 1 Taiwan" ;; 
# 147) TBS Live Korea  
147) 
keyword="tbs TV LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 148) YTN DMB Korea  
148) 
keyword="와이티엔 _DMB"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 149) YTN Life Korea  
149) 
keyword="YTN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnweatherlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Life Korea" ;; 
# 150) YTN Science Korea  
150) 
keyword="YTN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnsciencelive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 151) Channel 23 Korea  
151) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 152) KBS World 24 Korea
152) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 153) YTN 27 Korea 
153)
keyword="YTN LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnnews24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN LIVE Korea" ;;   
# 154) ANN JapaNews 24 Japan
154) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ANNnewsCH/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANN News 24 Japan" ;;
# 155) Sol!ve 24 Japan
155) 
keyword="SOLiVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
# 156) KBS Live 24 Japan  
156) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
#  157) QVC JAPAN SHOPPING CHANNEL
157) 
keyword="QVC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;
# 158) BSC 24 1
158) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 159) BSC 24 2
159) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 160) Earthquake 24  
160) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 
# 160)

############## BROKEN / OFFLINE #########################
# 154) KBS World Korea  ***
# 154) 
# link=rtmp://118.97.183.196/jhos//kbs
# use_cookies="no"
# chan_name="KBS World Korea" ;;
# 153)CTS Korea   ***
# 153) 
# link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/CTS_34312_200.sdp/playlist.m3u8
#link=http://ctsnanum.rtsp.vercoop.com:1935/CTS/_definst_/CTS_34312_100.sdp/playlist.m3u8
# use_cookies="no"
# chan_name="CTS Korea" ;;
###### INDIAN, HINDI, URDU, DARI, PASHTUN##################
# 161) News 9 Bangalore Karnataka
161)
keyword="NEWS9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/news9tv/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 9 Bangalore Karnataka" ;;  
# 162) CVR English India
162) 
keyword="CVR English Live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVREnglishOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR English India" ;;   
# 163) CVR News India
163) 
keyword="CVR" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CVRNewsOfficial/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CVR News India" ;;  
# 164) Shaski India
164) 
keyword="Sakshi"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCQ_FATLW83q-4xJ2fsi8qAw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Shaski India" ;;
# 165) SunNews 
165) 
keyword="Sunnews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYlh4lH762HvHt6mmiecyWQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SunNews" ;; 
# 166) TV9 India Live
166) 
keyword="TV9"
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
keyword="TV9"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com//channel/UCFv8Oq8IXdUGoeryZtcqJ3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
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
keyword="Aaj"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Aaj Tak" ;; 
# 174) NTV Telugu
174) 
keyword="NTV"
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
keyword="HMTV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hmtvlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 3 | cut -d \" -f 1)"
use_cookies="no"
chan_name="HMT Telugu" ;;
# 178) TV5 News 
178) 
keyword="TV5"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TV5newschannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV5 News" ;;
# 179) Channel 24 India
179) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHLqIOMPk20w-6cFgkA90jw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Channel 24 India";;
# 180) Survana News
180)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Survana News" ;;   
# 181) ATN News Bangladesh
181) 
keyword="ATN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;    
# 182)i News Telugu
182) 
keyword="I News Telugu Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="i News Telugu" ;; 
# 183) News 1 Kannada 
183)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 184)  Jansari News Kannada 
184)
keyword="News Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/JanasriNewsKannada/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Jansari News Kannada" ;; 
# 185) Puthiyah Thalimurai Tamil Live News
185) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Puthiyah Thalimurai Tamil Live News";;
## 186) DD News
186) 
keyword="DD"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DDNewsofficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
 chan_name="DD News" ;; 
# 187) REPORTER LIVE
187) 
keyword="REPORTER LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 188) AsiaNet News
188) 
keyword="Asianet" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 189)V6 News
189) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
 chan_name="V6 News" ;;
# 190) Kalaignar TV1
190) 
keyword="Kalaignar News LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar TV" ;;
# 191) ETV Andhra Pradesh
191) 
keyword="Pradesh Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="ETV Andhra Pradesh" ;;
# 192) News 18 Tamilnadu
192) 
keyword="News18"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCat88i6_rELqI_prwvjspRA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="News 18 Tamilnadu" ;;
# 193) The Polimer TV
193) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC8Z-VjXBtDJTvq6aqkIskPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="The Polimer TV" ;;
# 194) Jaya Plus
194) 
keyword="Live Jaya Networks"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jayapluschennai/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) "  
use_cookies="no"
chan_name="Jaya Plus" ;;
# 195) TEZ TV
195) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/teztvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TEZ TV" ;;
# 196) Dilli Aaj Tak
196) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/DilliAajtak/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Dilli Aaj Tak";;
# 197)  The Ekantipur Nepal
197) 
keyword="Kantipur TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheEkantipur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="The Ekantipur Nepal" ;;  
# 198) NepalMandal TV
198) 
keyword="Nepalmandal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEorL1RapK1IWOzWAZzKeVw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="NepalMandal TV" ;;  
# 199) Derana Sri Lanka  
199)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvderanavideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Derana Sri Lanka" ;;  
# 200) Swarnavahini Sri Lanka 
200)
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCAH7R88V7gz7RqJv78nNOzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Swarnavahini Sri Lanka " ;;  



################### BROKEN / Offline
# Media One News
# 185)
# keyword="Live"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpt10lzibN9Ux-tFGVAnrBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
# use_cookies="no"
# chan_name="Media One";;
### 188)  Desi TV
# 188)  
# link=http://www.dailymotion.com/video/x5lt6jg
# use_cookies="no"
# chan_name="Desi TV" ;; 
# 185) Pilupu TV Telugu America
# 185) 
#link=http://www.dailymotion.com/video/x60vptw
#use_cookies="no"
#chan_name="Pilupu TV Telugu America" ;; 
#
##################### PAKISTAN  ############################
# 201)92 News Pakistan HD  
201) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2g8WrjKpUrUSEWJQoClzOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="92 News Pakistan HD" ;;  
# 202) SAMAA TV Pakistan
202) 
keyword="SAMAA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/samaatvnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SAMAA TV Pakistan" ;;    
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
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_N9--aBR-0Kwey8wNLGc6A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bol News" ;;
# 207) 24 News Pakistan HD  
207) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="24 News Pakistan HD" ;;  

# 201)Din TV Pakistan
# 201)
#link=http://www.dailymotion.com/video/x5ubgo9 
#use_cookies="no"
#chan_name="Din TV Pakistan" ;; 
################# AFGHANISTAN ######################################
# 207) Lemar TV Afghanistan   *** REMOVE on next check
# 207)
# link=http://www.dailymotion.com/video/x5disog 
# use_cookies="no"
#chan_name="Lemar TV Afghanistan" ;; 

# 208)Tolo TV Afghanistan 
208)
link=http://www.dailymotion.com/video/x5dtety 
use_cookies="no"
chan_name="Tolo TV Afghanistan" ;; 
## 209) TOLO NEWS AFGHANISTAN
209) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";; 
################################## FARSI / PERSIAN  ###########################################################
# 210)  BBC Persian
210) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
################## ARABIC  ##########################################
# 211) RT Arabic 
211) 
keyword="RT ARABIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 212) ON E Live 
212) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
# 213)  ON E Sports
213) 
keyword="Live" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWLo4r-9_x4GCJCFShNFq0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E Sports" ;;   
# 214) ON Live
214) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZghOmDezc6OCMzdPaL-j2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON Live" ;;
# 215) Al Jazeera Arabic Qatar
215) 
keyword="Live Stream"
link=http://aljazeera-ara-apple-live.adaptive.level3.net/apple/aljazeera/arabic/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/aljazeerachannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jazeera Arabic" ;; 
# 216) France 24 Arabic
216) 
keyword="الأخبار "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24arabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="France 24 Arabic" ;;
# 217) BBC Arabic
217) 
keyword="BBC Arabic Live"
link=http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCArabicNews/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Arabic" ;;
# 218) Al Arabiya
218) 
keyword="قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlArabiya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Arabiya" ;;
# 219) Al Mayadeen
219) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Mayadeentv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Mayadeen" ;;   
# 220) Syrian Satellite
220) 
keyword="لفضائية" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Satellite" ;;     
# 221) ORTAS Syrian Satellite
221) 
keyword="الاخبارية السورية"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCclXv4NFO2QTv9QgN3ZTMHw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ORTAS Syria" ;;
# 222) Bedya TV Arabic
222) 
keyword="Bedaya TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvbedaya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Bedya TV Arabic" ;;
# 223) Belqees TV Arabic
223)
keyword="قناة بلقيس "
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxA_zZwALQMmVMSZyLKC-Nw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belqees TV Arabic" ;;
# 224) DMC Live
224) 
keyword="dmc"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClWxVmz6anf2M58vK_LHZJg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC LIVE" ;;
# 225) SKY Arabic
225) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/skynewsarabia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SKY Arabic" ;;
# 226) CBC Egypt Arabic Drama 
226) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCDramaStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Arabic Drama" ;;
# 227) eXtra News Egypt Arabic
227) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC65F33K2cXk9hGDbOQYhTOw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="eXtra News Egypt" ;;    
# 228) CBC Egypt Sofra Arabic
228) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCSofraStream/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC Egypt Sofra" ;;
# 229) Makkha Live (Mecca Kaaba) 
229) 
keyword="Makkah Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIIopOeuwL8KEK0wnFcodw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Mecca Kaaba Live" ;;
# 230)  DW Arabic
230) 
keyword="DW عربية مباشر"
link=http://dwstream2-lh.akamaihd.net/i/dwstream2_live@124400/master.m3u8
#link=http://www.metafilegenerator.de/DWelle/tv-arabia/ios/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewellearabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Arabic" ;;
# 231) Mekameleen (Egypt)
231)
#link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/playlist.m3u8
link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/chunklist_w1503601403_b1800000.m3u8
#link=http://mn-i.mncdn.com/mekameleen_ios/smil:mekameleen_ios.smil/chunklist_w1503601403_b2500000.m3u8
use_cookies="no"
chan_name="Mekameleen Egypt" ;;
# 232) CGTN Arabic
232)
link=https://live.cgtn.com/cctv-a.m3u8
use_cookies="no"
chan_name="CGTN Arabic" ;;

############################## SAUDI TV   #########################################
# 233) Saudi Channel 1 Green 
233) 
keyword="القناة"
#link=https://www.filmon.com/tv/saudi-arabian-tv-1
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel1/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannelOne/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Saudi Channel 1 Green" ;;

# 234) Saudi Channel 3 Blue
234) 
keyword="القناة" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel3/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiNewsTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Saudi Channel 3 Blue" ;;  
# 235) Saudi Sports Channel 4 Red
235) 
keyword="القنوات"
#link=https://www.filmon.com/tv/saudi-arabian-tv-sports
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel4/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AlMalabTube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Saudi Sports Channel 4 Red" ;;
# 236) Saudi Finance Channel 5 Purple
236) 
keyword="بث مباشر بواسطة"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/EqtsaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel5/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel5/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel5/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel5/3.m3u8
use_cookies="no"
chan_name="Saudi Finance Channel 5 Purple" ;;
# 237) Saudi Cultural Channel 6 Orange
237) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiCulturalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel6/3.m3u8
use_cookies="no"
chan_name="Saudi Cultural Channel 6 Orange" ;;
# 238) Saudi TV Channel 7 Gold  Mecca Kabba
238) 
keyword="Live Stream"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiQuranTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel7/3.m3u8
use_cookies="no"
chan_name="Saudi Channel 7 Gold" ;; 
# 239) Saudi Sliver Educational Channel 8
239) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiSunnahTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel8/3.m3u8
use_cookies="no"
chan_name="Saudi Silver Channel 8" ;; 
# 240) Saudi Ajyal Kids TV Channel 9
240) 
keyword="بث مباشر"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiAjyalTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel9/3.m3u8
use_cookies="no"
chan_name="Saudi Ajyal Kids Tv Channel 9" ;; 
################### TURKEY  ########################  
## 241) TRT Haber Turkey 
241) 
keyword="TRT"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTHABERHD_1@181942/master.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/trthaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT Haber Turkey";;
## 242) NTV Turkey
242) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Turkey";;
## 243) HaberTurk TV
243) 
keyword="Habertürk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVhaberturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HaberTurk TV";;
# 244) Star TV  Turkish
244) 
keyword="Star"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STARTVSTAR/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star TV Turkey";;
# 245) Fashion 1 Turk TV
245)
keyword="Fashionone"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Fashionone TV";;
# 246) CNN Turk 
246) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 247) Ulusal Kanal Turkish
247) 
keyword="Ulusal Kanal Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6T0L26KS1NHMPbTwI1L4Eg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ulusal Kanal";;
# 248) KRT Kulture TV
248) 
keyword="KRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 249) Number 1 Ask 
249) 
keyword="Aşk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoHnRpOS5rL62jTmSDO5Npw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number 1 Kanali";;
# 250) Number1 Dance Turk TV
250)
keyword="Dance"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Damar TV";;
# 251) Number1 Turk FM
251)
keyword="Türk FM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;
# 252) La Legul TV
252) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 253)Number1 TV Canlı Yayın
253)
keyword="Number1 Tv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 254) Number1 Turk TV
254)
keyword="Türk Tv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Türk TV";;
# 255) TGRT Haber TV
255) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 256) TVNET Canali Yayin
256) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 257) Number1 Radyo Canlı Yayın 
257)
keyword="Number1 FM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 FM Radyo Canlı Yayın";;
# 258) Show TV Turkey
258) 
keyword="Show"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Show TV Turkey" ;;
################### GREEK ######################################
## 259) Star Lamia
259) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 260) Blue Sky TV Athens Greece
260) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
######################## BROKEN for removal
# 261) Action 24 Greece HD
 261) 
link=http://www.dailymotion.com/video/x61fbhs
use_cookies="no"
chan_name="Action 24 Greece HD" ;;
# 264) TRT Greece
# 264) 
#link=http://www.dailymotion.com/video/x5efqcl
#use_cookies="no"
#chan_name="TRT Greece" ;; 
############# KOSOVO
# 265)Arta Kosovo
# 265)
#link=http://www.dailymotion.com/video/x5zvbu0 
#use_cookies="no"
#chan_name="Arta Kosovo" ;; 
################ Albania
# 266)ORA News Albania   *** Not working 
# 266)
# link=rtmp://81.7.13.162/oranews//oranews
# use_cookies="no"
# chan_name="ORA News Albania" ;;
##########################  Italian  ####################################################### 
# 262) SkyTG 24 Italian
262)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 263) Telecolor Lombardia Italy
263)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 264) Cremona 1 Italy
264)
link=http://cremona1.econcept.it/live/cremona1_high.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Cremona 1 Italy" ;;
# 265) QVC Itallian
265) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
# 266)Canale Italia
266)
link=http://www.filmon.com/tv/canale-italia
use_cookies="yes"
chan_name="Canal Italia" ;;
################ SWISS
# 267) RSI LA CH
267)
link=http://www.filmon.com/tv/rsi-la-1
use_cookies="yes"
chan_name="RSI LA CH" ;;
# 268) SRF CH
268)
link=http://www.filmon.com/tv/srf-1
use_cookies="yes"
chan_name="SRF CH" ;;
###################  HUNGARY
# 269) IRANY TV
269)
link=http://www.filmon.com/tv/iranytv
use_cookies="yes"
chan_name="IRANY TV HU" ;;
################  Austria
# 270) W24 Wein Austria
270)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Train Ride, Wein, Austria" ;;

# 276) RTS Salzburg Austria
# 276)
#link=http://80.237.191.228:1935/live/_definst_/RTS2015/playlist.m3u8
#use_cookies="no"
# chan_name="RTS Salzburg Austria" ;;
################  GERMAN   #######################################
# 271) WDR Germany
271)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 272) Tirol TV German
272)
link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
use_cookies="no"
chan_name="Tirol TV German" ;;
# 273)DW Deutsch Welle 
273) 
keyword="DW"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8"   
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelle/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Deutsch Welle";;
# 274) ZDK InfoKanal
274)
link=http://www.filmon.com/tv/zdf-infokanal
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
################## DUTCH
# 275)AT5 NETHERLANDS
275)
link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/playlist.m3u8
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;
################# Moldova
# 276) TV Publica Moldova
276)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
############# 
######################### UKRAINE  ##################################
# 277) UA TV Ukraine
277) 
keyword="UATV. Прямой эфир - Пряма трансляція - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCt3igz3aIXfS108KV_jZsMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 278) Thromadske Ukraine
278) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 279) Еспресо Ukraine
279) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 280) News 1 Ukraine
280) 
keyword="эфир NewsOne"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
################################ MENU 2 ########################################################
# 281) Ukraine 112
281)
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
# 282) Ukraine Channel 5 
282) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
############### RUSSIAN ################################
# 283)  Euronews Russian
283)
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 284) Россия 24
284) 
keyword="24"
link=http://www.filmon.com/tv/rossiya-24
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Russia24TV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="POCCNR 24 Russia" ;;
# 285) RBC TV RUSSIA
285)
link=http://online.video.rbc.ru/online/rbctv_480p/index.m3u8
use_cookies="no"
chan_name="RBC TV Russia" ;;
# 286) CGTN Russian
286)
link=https://live.cgtn.com/cctv-r.m3u8
use_cookies="no"
chan_name="CGTN Russian" ;;
# 287) ТВ-ТРЕЙЛЕР Russia
287)
link=http://wse.planeta-online.tv:1935/live/channel_5/chunklist.m3u8
use_cookies="no"
chan_name="ТВ-ТРЕЙЛЕР 2 Russia" ;;
# 288) Vesti FM Russia
288) 
keyword="Вести ФМ"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
#  289) Life News Russia
289)
link=http://tv.life.ru/lifetv/360p/index.m3u8
use_cookies="no"
chan_name="Life News Russia" ;;
# 290)  Current Time VOA
290)
link=http://www.filmon.com/tv/current-time-tv
use_cookies="yes"
chan_name="Current Time VOA" ;;
# 291) RTR Planeta
291)
link=http://www.filmon.com/tv/rtr-planeta
use_cookies="yes"
chan_name="RTR Planeta" ;;
# 292) Perviy Kanal Europa
292)
link=http://www.filmon.com/tv/perviy-kanal-europa
use_cookies="yes"
chan_name="Perviy Kanal Europa" ;;
# 293) Music Box Russia
293)
link=http://www.filmon.com/tv/music-box-russia
use_cookies="yes"
chan_name="Music Box Russia" ;;

# 294)
############### Viet Nam  #####################################
# 295) VietTV VN
295)
link=http://www.filmon.com/tv/vtc-10
use_cookies="yes"
chan_name="VietTV VN" ;;
################# TAGALOG FILIPINO #############################       
# 296) DZMM ABS-CBN Philippeans Radio
296) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 297) DZRH Philippeans
297) 
keyword="DZRH NEWS"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 298) PTV Philippines
298)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ Indonesia  #########################################
# 299) Net TV Jakarta Indonesia
299) 
keyword="Net" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Net TV Jakarta Indonesia" ;;

###################   AFRICA    ##############################################
# 301)TVC News Nigeria
301) 
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 302) TVC Continental Nigeria
302) 
keyword="TVC Continental Nigeria"
link=http://77.92.76.135:1935/tvce/livestream/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC Continental Nigeria";;
# 303) NTV Uganda
303) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 304)  KTN Kenya
304) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 305) Joy News Ghana
305) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 306)  ADOM TV 
306) 
keyword="Adom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV Ghana" ;;    
# 307) Bukedde TV
307) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bukedde TV";;
# 308)Telefishinka Qaranka Soomaaliyeed LIVE STREAM
308) 
keyword="Qaranka"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCi5fZhV7tPitSjnhEHJirGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Telefishinka Qaranka Soomaaliyeed";;
# 309) EBC Ethiopia 
309) 
keyword="Ebc live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="EBC Ethiopia";;
# 310) SPARK TV Uganda
310) 
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SPARK TV Uganda" ;;  
# 311) Biafra TV Africa 
311) 
keyword="Biafra Television Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 312) Walf TV Senegal
312)  
link=http://www.dailymotion.com/video/x5s5vw3
use_cookies="no"
chan_name="Walf TV Senegal" ;; 
# 313) Afrique Media 
313) 
keyword="Afrique Media"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOBMhI7TtRLTAGpcTjNvYCw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Afrique Media" ;;  
# 314)SABC Digital News South Africa
314) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;;  
# 315) EriTV Eritrea
315)
link=http://www.filmon.com/tv/eri-tv
use_cookies="yes"
chan_name="EriTV Eritrea" ;;  

#################### TRANSIENT ######################################## 
# 316) RUPTLY
316) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;;  
######################## PODCAST ###########################################
# 317) PBS NewsHour Video
317) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 318)  CBC The National
318) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 319) AP Top Stories
319) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 320) Democracy Now Headlines 
320) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;    
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
# 330) Buenos Aires Four Seasons
330)
keyword="Buenos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCkRwmztPEvut3gpsgmCmzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Buenos Aires Four Seasons" ;;
#  331) Netherlands Amsterdam
331) 
keyword="amsterdam"
link=http://www.amsterdam-dam.com/webcam.html
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
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
keyword="hartbeach"
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
keyword="Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 2" ;; 
# 344) Florida Cam 3
344) 
keyword="Seaport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 3" ;; 
# 345) Florida Cam 4
345) 
keyword="Irma"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6RbL0ZAyA_rc__Acbqh2mw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Florida Cam 4" ;; 
# 346)  Port du Quebec
346) 
keyword="Port"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/portqc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Port du Quebec" ;; 
# 347) Durango Colorado USA
347) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
keyword="RSBN"
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
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
#link=rtmp://webcasting.thefloridachannel.org/live/tvweb1
link=http://webcasting.thefloridachannel.org/live/tvweb1/playlist.m3u8
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
# 379) The Weather Channel
379)
link=http://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
use_cookies="no"
chan_name="The Weather Channel" ;;
############################  TRANSIENT BROADCAST NEWS #############################################
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
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
#link=http://54.163.107.81/server/play/cbslocal-wbzx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 4 News, WBZ, Boston, Massachusetts" ;;
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
# 392) CBS 13 News Stockton California USA
392) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kovrx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 13 News Stockton California USA" ;;
# 393) KCAL 9 News Los Angeles
393) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kcal-dfp/master.m3u8
use_cookies="no"
chan_name="KCAL 9 News Los Angeles" ;;
# 394) WXXV25 24/7 Mississippi
394)
link=http://api.new.livestream.com/accounts/22998687/events/6864865/live.m3u8
use_cookies="no"
chan_name="WXXV25 24/7 Mississippi" ;; 
# 395) NBC News Channel 13 (WNYT-TV)
395)
link=http://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 WNYT-TV";;
# 396) NBC2 South West Florida
396)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NBC2swfl/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="NBC2 South West Florida" ;;  
# 397),WSOC 9 NEWS Charlotte, South Carolina
397)
link=http://cmghlslive-i.akamaihd.net:80/hls/live/224717/WSOC/904k/prog.m3u8
use_cookies="no"
chan_name="WSOC 9 Charlotte, South Carolina" ;;
# 398) WCCB Charlotte, South Carolina
398)
link=http://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB Charlotte, South Carolina" ;;
# 399)7 News (WHDH-TV) Boston
399)
link=http://bcoveliveios-i.akamaihd.net/hls/live/246496/4744899807001/livestream/master.m3u8
use_cookies="no"
chan_name="7 News (WHDH-TV) Boston" ;; 
# 400)Fox News Talk
400)
link=http://fnurtmp-f.akamaihd.net/i/FNRADIOHDS_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;;

################# ULTRA ###################################
# 401) ABC News USA   // intermitent service / broken
401)
#link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_400_av-b.m3u8?sd=10&rebase=on"
link="http://abclive.abcnews.com/i/abc_live4@136330/index_800_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_2500_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
use_cookies="yes"
chan_name="ABC News USA" ;;
# 402) ABC News Digital 1
402)
link=http://abclive.abcnews.com/i/abc_live1@136327/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 1" ;;
# 403) ABC News Digital 2
403)
link=http://abclive.abcnews.com/i/abc_live2@136328/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 2" ;;
# 404) ABC News Digital 3
404)
link=http://abclive.abcnews.com/i/abc_live3@136329/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 3" ;;
# 405) ABC News Digital 5
405)
link=http://abclive.abcnews.com/i/abc_live5@136331/master.m3u8
use_cookies="no"
chan_name="ABC News Digital 5" ;;
# 406) MSNBC ONLINE
406)
#link=http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/master.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=296000,RESOLUTION=416x234,CODECS="avc1.77.30, mp4a.40.2"
#link="http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/index_200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=896000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/index_800_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1296000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
link="http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/index_1200_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2595000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://msnbclive-lh.akamaihd.net/i/msnbc_live01@180610/index_2500_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="MSNBC Online" ;; 
# 407) WSJ Live
407)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 408) C-SPAN-1 Live Event
408)
link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN-1 Live Event" ;;
# 409) C-SPAN-2 Live Event
409)
link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN-2 Live Event" ;;
# 410) C-SPAN-3 Live Event
410)
link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN-3 Live Event" ;;
# 411) CNN Livestream 1
411)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 1" ;;
# 412) CNN Livestream 2
412)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 2" ;;
# 413) CPAC 2 Canada
413)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028033728001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
# 414) C-SPAN 2 HD
414)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 2 HD" ;;
# 415) C-SPAN 3 HD
415)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
use_cookies="no"
chan_name="C-SPAN 3 HD" ;;
# 416) DVIDs TV
416) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
# 417)What America Thinks
417) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 418) NASA TV Public Education
418) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 419) NASA TV Media
419) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 420) RT Documentary
420) 
#link=https://rtd.rt.com/on-air/
#link="https://secure-streams.akamaized.net/rt-doc/index.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index2500.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index1600.m3u8"
link="https://secure-streams.akamaized.net/rt-doc/index800.m3u8"
#link="https://secure-streams.akamaized.net/rt-doc/index400.m3u8"

#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index1600.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index2500.m3u8
#link=https://rt-usa-live-hls.secure.footprint.net/rt/doc/index800.m3u8
use_cookies="no"
chan_name="RT Documentary" ;;
# 421) CGTN Documentary
421)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 422) Bloomberg Europe
422)
#link=https://www.bloomberg.com/live/europe
#link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/master.m3u8
link=http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 423) Bloomberg Asia
423)
link=https://www.bloomberg.com/live/asia
use_cookies="no"
chan_name="Bloomberg Asia" ;;
# 424) BYUTV
424)
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
use_cookies="no"
chan_name="BYUTV" ;;
# 425) BYUTV International
425)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
#  426) Arirang Radio English 
426) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
# 427) HSN
427) 
keyword="Live Stream"
#link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
link=https://www.youtube.com"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | awk ' BEGIN { RS= ":"}{ print}' | grep "watch?v=" | head -n 1 | cut -d \" -f 2)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 428) HSN 2
428) 
keyword="HSN2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 429)  QVC 
429) 
keyword="QVC Live Stream"
link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 430) The Shopping Channel TSC
430)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 431) IdealWorld
431)
link=http://live.ccus.simplestreamcdn.com/live/isd_sdi3/bitrate1.isml/playlist.m3u8
use_cookies="no"
chan_name="IdealWorld" ;;
# 432)  CTV NEWS Canada
432)
#CTV NEWS HD
link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News18.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News17.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News16.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News15.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News14.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News13.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News12.m3u8
#link=http://ams-lp10.9c9media.com/hls-live/livepkgr/_definst_/liveNews/News11.m3u8
use_cookies="no"
chan_name="CTV News Canada" ;; 
# 433)  Juptier Broadcasting 
433) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="no"
chan_name="Jupiter Broadcasting" ;;
# 434) CPAC 3 Senate Canada
434)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028075832001
use_cookies="no"
chan_name="CPAC 2 Senate Canada" ;;



########### Broken ############################################
# 432) The Blaze
# 432)
# link=https://theblaze.global.ssl.fastly.net/live/theblaze/master.m3u8
# use_cookies="no"
# chan_name="The Blaze" ;;

# 433) Bringham Young University TV BYU 
# 433)  
# link=http://byuhd2-lh.akamaihd.net:80/i/byutvhd2_live@103136/index_1640_av-p.m3u8 
# use_cookies="no"
# chan_name="Bringham Young University TV" ;;  
# 434) Bringham Young University TV BYU Global
# 434) 
# link=http://byuhd2-lh.akamaihd.net:80/i/byutvglobalhd2_live@103134/index_1640_av-p.m3u8 
# use_cookies="no"
# chan_name="Bringham Young University Global TV" ;; 
# 435) Bringham Young University TV BYU International
# 435) 
#link=http://byuhd2-lh.akamaihd.net:80/i/byutvintporthd2_live@103132/index_1240_av-p.m3u8
# use_cookies="no"
# chan_name="Bringham Young University International TV" ;; 
# 436) Bringham Young University TV BYU International 2
# 436) 
#link=http://byuhd2-lh.akamaihd.net:80/i/byutvintspanhd2_live@103133/index_1240_av-p.m3u8 
#use_cookies="no"
#chan_name="Bringham Young University International 2 TV" ;; 

# 440)
###############################   SPORTS   ######################################################
# 441) MLB Network
441)
link=http://mlblive-akc.mlb.com/ls01/mlbam/mlb_network/NETWORK_LINEAR_1/master_wired.m3u8
use_cookies="no"
chan_name="MLB Network" ;;
# 442) 106.7 The Fan
442)
link=http://cbslocalhls-i.akamaihd.net/hls/live/204776/WJFK-FM-IOS/wjfklive.m3u8
use_cookies="no"
chan_name="106.7 The Fan" ;;
# 443) 105.7 The Fan
443)
link=http://cbslocalhls-i.akamaihd.net/hls/live/219778/WJZFM-IOS/wjzfmlive.m3u8
use_cookies="no"
chan_name="105.7 The Fan" ;;
################### Entertainment #############################
# 444) Heart TV
444)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/master.m3u8
use_cookies="no"
chan_name="Heart TV" ;;
# 445) Capital TV
445)
link=http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/index_1500_av-p.m3u8
use_cookies="no"
chan_name="Capital TV" ;;
# 446) California Music Channel
446)
link=http://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMCUSA/CCURstream0.m3u8
use_cookies="no"
chan_name="California Music Channel" ;;
# 447) Music Choice Play HD
447)
link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/playlist.m3u8
#link=http://edge.music-choice-play-chaina1.top.comcast.net/PlayMetadataInserter/play/chunklist.m3u8
use_cookies="no"
chan_name="Music Choice Play HD" ;;
# 448)538 TV NETHERLANDS
448)
link=http://538hls.lswcdn.triple-it.nl/content/538tv/538tv_1.m3u8
use_cookies="no"
chan_name="538 TV NETHERLANDS" ;;
# 449)CITY 
449)
link=http://nodeb.gocaster.net:1935/CGL/_definst_/mp4:TODAYFM_TEST2/stream.m3u8
use_cookies="no"
chan_name="CITY TV" ;;
# 450) О2 ТВ Russia
450)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="O!2 TB Russia" ;;
# 451) MTV AM Russia
451) 
#link=http://mtvam.ru/hlsam/playlist.m3u8
#BANDWIDTH=350000
#link=http://91.232.135.156/hlsam/low/playlist.m3u8
#BANDWIDTH=650000
link=http://91.232.135.156/hlsam/med/playlist.m3u8
#BANDWIDTH=950000
#link=http://91.232.135.156/hlsam/high/playlist.m3u8
#BANDWIDTH=1800000
#link=http://91.232.135.156/hlsam/lhigh/playlist.m3u8
#BANDWIDTH=3800000
#link=http://91.232.135.156/hlsam/hd/playlist.m3u8
use_cookies="no"
chan_name="MTV AM Russia" ;; 
# 452) DJING Animation HD 
452) 
link=http://www.djing.com/tv/a-05.m3u8
use_cookies="no"
chan_name="DJING Animation HD" ;;
# 453) DJING Classic HD 
453) 
link=http://www.djing.com/tv/i-05.m3u8
use_cookies="no"
chan_name="DJING Classic HD" ;;
# 454) DJING Dancefloor HD
454) 
link=http://www.djing.com/tv/d-05.m3u8
use_cookies="no"
chan_name="DJING Dancefloor HD" ;;
# 455)DJING Underground HD
455) 
link=http://www.djing.com/tv/u-05.m3u8
use_cookies="no"
chan_name="DJING Underground HD" ;;
# 456)M2O Music
456) 
link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_600_av-b.m3u8"
use_cookies="no"
chan_name="M2O Music" ;;
# 457) Virgin Music 2
457)
link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Music 2" ;;
#################### REALITY / LIVE ACTION #########################
#  458) Adult Swim 
458) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
# 459) Insight TV
459)
link=http://ooyalahd2-f.akamaihd.net/i/intv02_delivery@346464/master.m3u8
use_cookies="no"
chan_name="Insight TV" ;;
# 460) London Live 
460)
link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
use_cookies="no"
chan_name="London Live" ;;
# 461) Yes TV
461)
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/YES/tu1_1.m3u8
use_cookies="no"
chan_name="Yes TV" ;;
# 462) Smile of a Child
462)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8
use_cookies="no"
chan_name="Smile of a Child" ;;
################################################################################
##################### ANIMATION ##############################
#  463) Toonami 
463) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
use_cookies="no"
chan_name="Toonami" ;;
# 464) Adult Swim Animated Marathon 
464) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Animated Marathon" ;;
# 465) Talking Tom and Friends
465) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 466) Talking Tom and Friends Minis
466) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
#  467) Adult Swim Live Action Marathon 
467) 
link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/live-action-marathon.m3u8
use_cookies="no"
chan_name="Adult Swim Live Action Marathon" ;;
# 468) Fashion TV Europe
468)  
link=http://www.dailymotion.com/video/x3m6nld
use_cookies="no"
chan_name="Fashion TV Europe" ;; 
# 469) Fashion 1 Spain
469) 
link=http://www.dailymotion.com/video/x2t9nsf
use_cookies="no"
chan_name="Fashion 1 Spain" ;; 
# 470)  Mello TV English Jamaica
470)  
link=http://mellotvnew.tulix.tv/live/smil:mellotv.smil/chunklist_w1010732594_b1128000_sleng.m3u8
use_cookies="no"
chan_name="Mello TV English Jamaica" ;; 
# 471) Jasmin TV
471) 
link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8 
use_cookies="no"
chan_name="Jasmin TV" ;;  
# 472) The Young Turks
472)
keyword="17"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
# 473) SBS IN 
473) 
keyword="SBS-IN" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCBzkVegsFusO7ZMa_J8MZ7Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SBS-IN" ;;
# 474) KPOP IDOL
474) 
keyword="KPOP" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/imbcevery1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KPOP IDOL" ;;

###################### BROKEN /OFFLINE #################################################
# 458) High Stakes Poker
# 458) link=https://www.twitch.tv/highstakespoke 
# use_cookies="no"
# chan_name="High Stakes Poker" ;; 
# 453) Olympic Channel HD
# 453)
# link=http://ocs-live.hls.adaptive.level3.net/ocs/channel01/NBC_OCS1_VIDEO_7_6064000.m3u8
# use_cookies="no"
# chan_name="Olympic Channel HD" ;;
# 454) NFL Now
# 454)
# link=http://svglive3-event.level3.nfl.com/nflent3/live/now/NFLNOW.m3u8
# use_cookies="no"
# chan_name="NFL Now" ;;
# 473) Heavy Metal Television
# 476)
# link=http://70.166.98.130:1935/hmtv/myStream/playlist.m3u8
# use_cookies="no"
# chan_name="Heavy Metal Television" ;;
# 477)Kiss TV
# 477)
# link=http://tst.es.flash.glb.ipercast.net/tst.es-live/live/playlist.m3u8
# use_cookies="no"
# chan_name="Kiss TV" ;;
# 478) Family Friendly Entertainment
# 478)
# link=http://54.225.64.228:1935/live/roku2/playlist.m3u8
# use_cookies="no"
# chan_name="Family Friendly Entertainment";;
# 479)
# 480)
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
# 484) EWTN Africa
484) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267772001
use_cookies="no"
chan_name="EWTN Africa" ;;
# 485) EWTN Asia
485) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5405034951001
use_cookies="no"
chan_name="EWTN Asia" ;;
# 486) EWTN Spanish 
486) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409267805001
use_cookies="no"
chan_name="EWTN Espanol" ;; 
# 487)  EWTN German
487) 
link=http://players.brightcove.net/1675170007001/Hyo4oydd_default/index.html?videoId=5409283775001
use_cookies="no"
chan_name="EWTN Deutsch" ;;
# 488)Catholic TV (USA) 
488) 
link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/master.m3u8
# link=http://catholictvhd-lh.akamaihd.net:80/i/ctvhd_1@88148/index_1_av-p.m3u8 
use_cookies="no"
chan_name="Catholic TV (USA)" ;;
# 489) CBN
489)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 490)CBN News
490)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 491)NRB Network
491)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 492) The Church Channel
492)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8
use_cookies="no"
chan_name="The Church Channel" ;;
# 493) TBN
493)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 494)GOD TV (USA) 
494) 
link=http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/master.m3u8
use_cookies="no"
chan_name="GOD TV (USA)" ;;
# 495) Amazing Facts TV (Christian)
495) 
keyword="AFTV"
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1921345467.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 496) It's Supernatural! Network (Christian)
496) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 497) Sheppard's Chapel (Christian)
497) 
keyword="Chapel"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Sheppard's Channel" ;;
# 498) International House of Prayer (IHOP) (Christian)
498) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 499) Belivers Voice of Victory Network
499) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 500) Three Angels BroadCasting
500) 
keyword="Three Angels"
#link=http://moiptvus-lh.akamaihd.net:80/i/3abnlive_1@328342/index_800_av-p.m3u8 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels Broadcasting Network" ;; 
# 501) 3ABN KIDS 
501)  
link=http://moiptvus-lh.akamaihd.net:80/i/kidslive_1@328343/index_800_av-p.m3u8 
use_cookies="no"
chan_name="3 Angels Broadcast Network KIDS " ;;  
# 502) TCT HD
502) 
keyword="TCT Network Live HD Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT HD" ;; 
# 503) TCT SD
503) 
keyword="TCT Network Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TCT SD" ;; 
# 504) TCT Kids
504) 
keyword="TCT Network Live TCTKids Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TCTTVNet/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
format="best"
use_cookies="no"
chan_name="TCT Kids" ;; 
# 505) Salt and Light TV Portage Michigan
505) 
keyword="Salt"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 506) LLBN TV
506) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 507) Rap Resurrection
507)
link=http://edge2.tikilive.com:1935/unrestricted_tikilive/36008/amlst:amKEQ2Y2gYN4/playlist.m3u8
use_cookies="no"
chan_name="Rap Resurrection";;
# 508) Hillsong Channel
508)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 509) Al Hayat TV Arabic
509) 
keyword="Al Hayat TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alhayatchanneltv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Hayat TV Arabic" ;; 
# 510) Al Fady TV Arabic
510) 
keyword="قناة الفادى الفضائية | قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6CtFtvwAWQBLt3dx9l7arg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Fady TV Arabic" ;; 
# 511) Aghapy TV
511) 
keyword="Aghapy TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC97YtaFaO3lUTcG4dCmgr5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aghapy TV" ;; 
# 512) St. Marys Coptic
512) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 513) Word of God Greek
513) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 514) Shalom TV
514) 
keyword="Shalom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShalomTelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shalom TV" ;; 
# 515) Heaven TV
515) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 516) Rakshana TV
516) 
keyword="Rakshana TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jakkulaBenhur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rakshana" ;; 
# 517) Powervision TV
517) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 518) KJV Audio
518) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio Bible" ;; 
# 519) Temple Institute
519) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
# 520) Jewish Life TV (USA)
520) 
link=http://52.40.109.131:1935/rtplive/smil:jltv.smil/playlist.m3u8
use_cookies="no"
chan_name="Jewish Life TV (USA)" ;;
###################  MIXER    ###################
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
# 523)Quran English Arabic
523) 
keyword="Quran Hidayah"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 
# 524) Canal del Congreso Mexico Spanish
524)
link=http://dl.canaldelcongreso.gob.mx:1935/ccongreso/mp4:congreso2b.mp4/playlist.m3u8
use_cookies="no"
chan_name="Canal del Congreso Mexico Spanish" ;;
# 525)  Kiss Radio 2 Taiwan 
525)
keyword="南投廣播 FM99.7"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kissradio999/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no" 
chan_name="Kiss Radio 2 Taiwan" ;; 
# 526) beIN Sports Arabic 1
526)  
keyword="SPORTS"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/beinsports/videos/videos?&view=2" | grep "span" | grep "watch?v=" | head -n 1 | tail -n 1 | cut -d = -f 4 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="beIN Sports Channel 1" ;;  
# 527) beIN Sports Arabic 2
527)  
keyword="SPORTS"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/beinsports/videos/videos?&view=2" | grep "span" | grep "watch?v=" | head -n 2 | tail -n 1 | cut -d = -f 4 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="beIN Sports Channel 2" ;;  
# 528) 
# 531)  DW Deutsch +     GEOregion blocked
531) 
link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8" 
use_cookies="no"
chan_name="DW Deutsch +" ;;
# 535)  Tagessschau 24 Germany
535)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 536) STerkTV Zindi 
536) 
keyword="STERKTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 537) Ronahi TV Zindi 
537) 
keyword="RonahiTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";; 

# 539) KNBC 4 News (Los Angeles)
539) 
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;
# 540) ABC 3 News Louisiana
540) 
link=http://ktbs-lh.akamaihd.net/i/KTBS_1069@111925/master.m3u8
use_cookies="no"
chan_name="ABC 3 News (Louisiana)" ;;
# 541) WPLG 10 News Miami
541) 
link=http://play-prod1.live.anvato.net/server/play/pns-wplg-dfp/master.m3u8
use_cookies="no"
chan_name="WPLG 10 News Miami" ;;
# 542) WJXT News 4 Jacksonville
542) 
link=http://play-prod1.live.anvato.net/server/play/pns-wjxt-dfp/master.m3u8
use_cookies="no"
chan_name="WJXT News 4 Jacksonville" ;;
# 543) NBC 6 South Florida (WTVJ-TV)
543)
link=http://wtvjlive-f.akamaihd.net/i/wtvja1_1@19309/master.m3u8
use_cookies="no"
chan_name="NBC 6 South Florida WTVJ";;
# 544) WBLZ Bangor Maine
544)
link=http://wlbz-lh.akamaihd.net/i/WLBZ_Live_1@27474/master.m3u8
use_cookies="no"
chan_name="WLBZ Bangor Maine" ;; 

# 546) Euronews Francais
546) 
keyword="euronews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;     
# 547) EuroNews Deutsch
547) 
keyword="Union" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;
# 548)  Euronews Maygar Hugarian
548) 
keyword="euronews élőben" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/euronewsHungarian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Euronews Maygar Hungarian" ;;

############# Romanian #####################################
# 549) Mediatv Romania
549)
link=http://mediatv.novanet.ro/mediatv/mediatv.m3u8
use_cookies="no"
chan_name="Mediatv Romania" ;;
# 550) Made in Leeds
550)
link=http://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Leeds" ;;
# 551) Made in Tyne
551)
link=http://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Tyne" ;;
# 552) Made in Cardiff
552)
link=http://www.dailymotion.com/video/x5ev9xg
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Cardiff" ;;
# 553)TTB Network
553)
link=http://www.dailymotion.com/video/x14tgdi
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="TTB Network" ;;
# 554) 1TV Afghanistan
554)
link=http://www.dailymotion.com/video/x63qpkr
use_cookies="no"
#format=hls-720
#format=hls-480
format=hls-380
#format=hls-240
chan_name="1TV Afghan" ;;
# 555) ErbuTV Kenya
555)
link=http://www.dailymotion.com/video/x67n3k1
use_cookies="no"
#format=hls-720
#format=hls-480
format=hls-380
#format=hls-240
chan_name="ErbuTV Kenya" ;;
# 556 )KTN Home
556)
link=http://www.dailymotion.com/video/x67ck0p
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="KTN Home" ;;

# 557) DW English 
557) 
link="http://dwstream4-lh.akamaihd.net/i/dwstream4_live@131329/master.m3u8"
use_cookies="no"
chan_name="DW English" ;;


###################  MENU 3   #####################################
########### TELEVISIA REGIONALES MEXICO
# 561) Televisa Gudalajera Mexico
561)  
keyword="guadalajara"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisaguadalajara.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Gudalajera Mexico" ;; 
# 562) Televisia Acapuloco Mexico
562)  
keyword="acapulco"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvacapulco.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisia Acapulco Mexico" ;; 
# 563) Televisia Puebla Mexico
563)  
keyword="puebla"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisapuebla.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Puebla Mexico" ;;  
# 564) Televisia Sonora Mexico
564)  
keyword="sonora"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Sonora Mexico" ;;  
# 565) Televisia Toluca Mexico
565)  
keyword="toluca"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Toluca Mexico" ;;  
# 566) Televisia Veracruz Mexico
566) 
keyword="veracruz"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisaveracruz.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Veracruz Mexico" ;; 
# 567) Televisia Cuernavaca Mexico
567)  
keyword="cuernavaca"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvmorelos.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Cuernavaca Mexico" ;;   
# 568) Televisia Torreon Mexico
568)  
keyword="torreon"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Torreon Mexico" ;; 
# 569) Televisia Queretaro Mexico
569)  
keyword="queretaro"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Queretaro Mexico" ;; 
# 570) Televisia Aguascalientes Mexico
570)  
keyword="aguascalientes"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Aguascalientes Mexico" ;; 
# 571) Televisia Matamoros Mexico
571)  
keyword="matamoros"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Matamoros Mexico" ;; 
# 572) Televisia Monterrey Mexico
572)  
keyword="monterrey"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Monterrey Mexico" ;; 
# 573) Televisia Chihuahua Mexico
573)  
keyword="chihuahua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Chihuahua Mexico" ;; 
# 574) Televisia Mexicali Mexico
574)  
keyword="mexicali"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Chihuahua Mexico" ;; 
# 575) Televisia Regionales Directo
575)  
keyword="directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Regionales Mexico" ;; 
####################################
# 576) TV Regional Chihuahua
576)
keyword="Chihuahua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaWbH7M8-lRPwysXKVs_Odw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Regional Chihuahua Mexico" ;;
# 577) 3ABN Latino
577)  
keyword="3ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3abnlatino/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="3ABN Latino" ;;  
# 578) Logos TV Espanol
578)  
keyword="Logos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_L2lcJZlQ8oHQMgUNNDb-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Logos TV Espanol" ;;  
# 579) Euronews Espanol
579)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
############# EXTRA ESPANOL
# 580) UCVTV 
580)  
keyword="UCVTV EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV" ;;
# 581) JN19 Catolicos   
581)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canaljn19tv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="JN19 Catolicos" ;;
# 582) Senal Internacional Mega Chile
582)  
keyword="en vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/programasmega/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
# 583) VORTERIX AR
583)  
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="VORTERIX AR" ;;
# 584) VIVE Venezuela
584) 
keyword="VIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCg6uD_hL72AFeZuMJL5u07w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VIVE Venezuela" ;;
# 585) VPItv Venezuela
585) 
keyword="VPItv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VPItv Venezuela" ;;
# 586) VTV VE
586) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/MultimedioVTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VTV VE" ;;
# 587) Senal PDVSA Venezuela
587) 
keyword="PDVSA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PdvsaTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Senal PDVSA Venezuela" ;;
# 588) Impacto USA 
588)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/impactotv2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Impacto USA" ;;
# 589) Canal 2 Cablenet San Vicente Argentina   ***
589)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 590) Canal 13 San Juan Argentina   ***
590)  
keyword="Juan"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;; 
# 591) Canal 2 Telpintv Pinamar AR  **
591)  
keyword="Telpin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelpinVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 2 Telpintv Pinamar AR" ;;  
# 592) Canal 8 Mar del Plata
592) 
keyword="Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 593) Canal 11 de Salta Argentina
593)  
keyword="Salta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCy-r-BQ5BQRU6rzGS73-WBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 11 de Salta Argentina" ;;  

######################### Portuguese #########################
# 594) Euronews Portugues
594)
keyword="euronews em"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Euronews Portugues" ;;
################ BRAZIL   ################################
# 595) TV Assemblelia BR
595)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCIxlLEYzjWPLb_CXpc-e74w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Assemblelia" ;;
# 596) TV Canaco Nova
596)
keyword="Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvcancaonova/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Canaco Nova" ;;
# 597) TV Igreja Internacional de Graca
597)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_hwWljVyb_o3yzasx-bG2g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Igreja Internacional de Graca" ;;
# 598) TV Ales Assembleia Legeslativa
598)
keyword="Ales"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alescomunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Ales Assembleia Legeslativa" ;;
# 599) TV Boas Nova
599)
keyword="Play"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/boasnovasoficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Boas Nova" ;;
# 600) Fundacao Nazzare de Communicaco
600)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FNComunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Fundacao Nazzare de Communicaco" ;;
# 601) STF Brazil
601)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 602) TV Estúdio Brasil
602)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 603) Rádio Justiça - Ao Vivo  
603)  
keyword="Rádio Justiça"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Radio Justicia" ;;  
# 604) EXA FM 93.9
604)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
# 605) RIT TV BR
605)  
keyword="RIT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA0bOG0NUfJ855eDtHSxOkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="RIT TV BR" ;; 

#Milenio Mexico  ****
# #108)  
#keyword="MILENIO"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/MILENIO/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#use_cookies="no"
#chan_name="Milenio Mexico" ;; 
# 120) El Capitolio Venezulana
# 120) 
#keyword="EN VIVO"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCbSDz7_rVKXjZ9fRON16apQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
#use_cookies="no"
#chan_name="El Capitolio Venezulana" ;; 
# 604)CANAL SHOW DA FÉ  Portugese
# 604)
# link=http://nossatvhls02-lh.akamaihd.net:80/i/nossatv_hls@381916/index_600_av-p.m3u8 
# use_cookies="no"
# chan_name="CANAL SHOW DA FÉ Portugese" ;; 

###############
# 641) TV5 monde 
641)
link=http://v3fbs247hls-i.akamaihd.net/hls/live/219079/v3fbs247hls/v3fbs247hls_1_1.m3u8
use_cookies="no"
chan_name="TV5 monde" ;;
# 642) ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT
642)
link="http://hdflash_1-lh.akamaihd.net/i/cancktv_1@93272/index_1200_av-b.m3u8"
use_cookies="no"
chan_name="ICI Radio-Canada – Saguenay (lâ lâ) – CKTV-DT" ;;
# 643) ICI Radio-Canada – Rimouski – CJBR-DT
643)
 link="http://hdflash_1-lh.akamaihd.net/i/cancjbr_1@95882/index_1200_av-b.m3u8"
 use_cookies="no"
chan_name="ICI Radio-Canada – Rimouski – CJBR-DT" ;;


################### MENU 4 ########################################
###  821)





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
menu="$menu"
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
elif [ "$input" -lt 1100 ]
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
s) 
men_num="$men_num"
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + to increment, - to decrement, n for the next menu, or q to quit:" ;;
m)
men_num=$(expr 0)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + to increment, - to decrement, n for the next menu, or q to quit:" ;;
n) 
men_num=$(expr "$men_num" + 1)
men_num=$(expr "$men_num" % 4)
channel_matrix_"$men_num"
menu="s"
echo "Please Select a Number corresponding to a Media Stream, press + to increment, - to decrement, m for the main menu, n for the next menu, or q to quit:" ;;
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
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')" 
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
menu="s"
men_num=0
format="best"
if [ "$1" != "" ]
then
echo "$1"
# take channel input from command line
entry="$1" 
elif [ "$1" == "" ]
then
channel_matrix_"$men_num"
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
     UA="$( head -c "$bytes" /dev/urandom | base64 -i | tr -d "\n=+-\/" | tr -s " " | awk '{print $1}')" 
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

######################     END OF PROGRAM      ####################################################T
 