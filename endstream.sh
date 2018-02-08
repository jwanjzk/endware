#! /bin/sh
######################################################################
# Title: endstream.sh
# Description:  Clearnet streaming from youtube of selected news 
#               stations using mpv and youtube-dl
# Author: The Endware Development Team
# Copyright: 2017, The Endware Development Team
# Creation Date: February 21, 2017
# Version: 0.57
# Revision Date: February 3, 2018
#
# Recent Changes: - Added some Russian Streams, minor reorg
#                 - Repair streams
#                 - Ajouter quelques Canals / Emissions Francais 
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
version="0.57"
rev_date="03/02/2018"
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
   echo "||      ENGLISH       ||     FRANCAIS      ||      ESPANOL     ||      ASIAN     ||     INDIAN      || URDU/FARSI/ARABIC || TR/GR/IT/DE/NL/MD/UA ||"
   echo "======================================================================================================================================================="
   echo "1)BBC World News      41)France 24 FR      81)RT Espanol       121)CCTV 4 China  161)News 9 Bangalore 201)92 News PK      241)TRT Haber Turkey"    
   echo "2)SKY News London     42)France Info TV    82)DW Espanol       122)ECB 51 TW     162)CVR English      202)SAMAA PK        242)NTV Turkey" 
   echo "3)BBC News London     43)BFM TV FR         83)CGTN Espanol     123)ECB Finance TW163)CVR NEWS         203)DIN News PK     243)HaberTurk TV"  
   echo "4)RT UK               44)BFM Business FR   84)Hispan TV        124)TTV TW        164)Shaski India     204)Neo TV PK       244)Star TV Turkey"             
   echo "5)France 24 English   45)TV5+ Monde BE     85)Le Zap ES        125)CTV TW        165)SunNews          205)Dawn PK         245)CNN Turk"  
   echo "6)DW English          46)RT France         86)Magala TV ES     126)FTV TW        166)TV9 India        206)Bol TV PK       246)KRT Kulture"  
   echo "7)Russia Today        47)RTS UN CH         87)Guada TV ES      127)CTS World TW  167)Rajya Sabha      207)Waqt News PK    247)Number 1 Ask"
   echo "8)Euronews English    48)CGTN Francais     88)GRANADA TV ES    128)SET News TW   168)TV9 Gujarat      208)Geo News PK     248)Number1 Dance "
   echo "9)CBSN USA            49)i24 France IL     89)c5n AR           129)CTI TW        169)Tv9 Marathi      209)Tolo AF         249)Number1 TV"
   echo "10)MSNBC USA          50)Africa24          90)A24 AR           130)TzuChi DaAi TW170)News 7 Tamil     210)TOLO NEWS AF    250)Number1 Turk TV"
   echo "11)Bloomberg USA      51)Africa News       91)Todo Noticias AR 131)DaAiVideo TW  171)T News Telegu    211)BBC Persian     251)La Legul TV"
   echo "12)RT America         52)SIKKA Afrique     92)La Nacion AR     132)DaAi Live TW  172)News 18 India**  212)RT Arabic       252)TGRT Haber"
   echo "13)CGTN America       53)France 2          93)TV Publica AR    133)SET iNews TW  173)Aaj Tak          213)ON E Live Egypt 253)TVNET Canali"
   echo "14)Newsy USA          54)RTS DEUX CH       94)KZO AR           134)TLTV TW       174)NTV Telugu       214)ON Live Egypt   254)Show TV Turkey"
   echo "15)ABC News USA       55)France 3          95)Canal 6 AR       135)FLTV TW       175)ABN Telugu       215)Al Jazeera Qatar255)Number1 Turk FM"  
   echo "16)TRT World TK       56)France O          96)Canal 7 AR       136)Sinda TV      176)Vanitha TV       216)France 24 Arabic256)Number1 Radyo"
   echo "17)i24 News Israel    57)ARTE Francais     97)Canal 8 AR       137)Cheng Sin TV  177)HMT Telugu       217)BBC Arabic      257)Star Lamia Greece"
   echo "18)Al Jazeera English 58)BFM Paris FR      98)Canal 13 AR      138)Formosa TW    178)TV5 News         218)Al Arabiya      258)Blue Sky TV Athens"	
   echo "19)Press TV Iran      59)TLM Lyon Metro FR 99)Showsport AR     139)CTS 2 TW      179)Channel 24 IN    219)Al Mayadeen     259)Action 24 Greece"
   echo "20)India Today        60)Alsace 20 FR      100)SuperCanal 3 AR 140)SJTV TW       180)Survana News     220)Syrian Satellite260)SkyTG 24 Italy"  
   echo "21)NEWS X India       61)Mosaik TV FR      101)CN23 AR         141)SITTI 1 TW    181)ATN Bangladesh   221)ORTAS Syria **  261)Lombardia Italy"
   echo "22)NDTV IN            62)Journal TVLandes  102)Telepin AR      142)SITTI 2 TW    182)i News Telugu    222)Bedya TV        262)Cremona 1 Italy"       
   echo "23)CGTN Beijing       63)TV7 Bordeaux FR   103)Vorterix AR     143)SITTI 3 TW    183)News 1 Kannada   223)Belqees TV      263)QVC Italy"  
   echo "24)NHK World JP       64)Notele BE         104)TV Camara PY    144)Da Li TW      184)India TV         224)DMC Live        264)RSI CH"
   echo "25)CNN PH             65)8 Monte Blanc FR  105)Mega CL         145)SDTV TW       185)Tamil Live       225)Sky Arabic      265)SRF CH" 
   echo "26)ABC AU             66)RTC Liege BE      106)CNN CL          146)FANS TV TW    186)DD News          226)CBC Drama Egypt 266)W24 Wein AT"
   echo "27)ANN7 ZA            67)Azur TV Nice FR   107)Telemedeline CO 147)Hong Kong TV  187)REPORTER LIVE    227)Extra News Egypt267)Austria 24 ***"
   echo "28)Arise News NG      68)Canal Savoir CA   108)CTV CO          148)Arirang Korea 188)AsiaNet News     228)CBC Sofra Egypt 268)WDR DE"
   echo "29)VOA USA            69)CPAC 1 CA         109)TeleSUR VE      149)SBS IN KR     189)V6 News          229)Makka Live      269)Tirol TV DE"
   echo "30)RT Documentary     70)Assemblee QC CA   110)Globovision VE  150)TBS KR        190)News Nation      230)DW Arabic       270)DW Deutsch"    
   echo "31)CGTN Documentary   71)MABI CA           111)NTN24 VE        151)YTN DMB KR    191)ETV AndhraPradesh231)Mekameleen Egypt271)ZDK InfoKanal"
   echo "32)BYUTV USA          72)Gong Cinema       112)Conciencia VE   152)SBS News KR   192)News 18 Tamil ** 232)CGTN Arabic     272)Tagessschau DE"
   echo "33)Biz TV USA         73)GONG MAX          113)VPItv VE        153)YTN Sci KR    193)The Polimer      233)Saudi Green     273)EuroNews Deutsch" 
   echo "34)NEWSMAX USA        74)QVC Francais      114)PDVSA VE**      154)Channel 23 KR 194)Jaya Plus        234)Saudi Blue      274)AT5 NL"  
   echo "35)Free Speech TV     75)Antena Centre BE  115)Tu Canal Panama 155)KBS World24 KR195)TEZ TV           235)Saudi Red       275)TV Publica Moldova"
   echo "36)Infowars           76)IL TV FR          116)Excelsior MX    156)YTN 27 KR     196)Dili Aaj Tak     236)Saudi Purple    276)UA TV Ukraine"
   echo "37)C-SPAN 1 USA       77)BX1               117)Bloomberg MX    157)ANN24 JP      197)Ekantipur Nepal* 237)Saudi Orange    277)Thromadske UA"
   echo "38)CPAC 1 Canada      78)France Info Radio 118)Imagen Radio MX 158)Sol!ve 24 JP  198)Sagarmatha Nepal 238)Saudi Gold      278)Espresso UA"	
   echo "39)TWIT               79)Europe 1 FR       119)CNN Espanol     159)KBS 24 JP     199)Derana LK        239)Saudi Silver    279)News 1 UA"
   echo "40)Jupiter Broad      80)RFI FR            120)-------------   160)QVC Japan     200)Swarnavahini LK  240)Saudi Kids      280)Ukraine 112"
   echo "======================================================================================================================================================"
}	                   
 
channel_matrix_1()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||   UA/RU/PH/ID     ||     AFRICA      ||    USA LOCAL NEWS   ||     EXTRA          ||    ENTERTAINMENT   ||    RELIGIOUS       ||    MIXED     ||"
   echo "======================================================================================================================================================"
   echo "281)Ukraine 5          321)Channels 24 NG 361)RSBN Auburn USA    401)WSJ Live        441)MLB Network      481)Vatican Media     521)Vatican Media Eng"    
   echo "282)UATV Tartar UA     322)TVC News NG    362)News 12 Brooklyn   402)CNN Live 1      442)106.7 The Fan    482)EWTN Americas     522)DW Deutsch + **" 
   echo "283)Euronews Russian   323)TVC Continental363)News 12 Long Island403)CNN Live 2      443)106.7 The Fan    483)EWTN Ireland      523)------------"  
   echo "284)POCCNR 24          324)NTV Uganda     364)WGN 9 Chicago      404)CPAC 2 CA ***   444)Heart TV         484)EWTN Africa       524)------------"             
   echo "285)RBC TV Russia      325)KTN Kenya      365)ABC 9 Orlando      405)------------    445)Capital TV       485)EWTN Asia         525)STerkTV Zindi**"  
   echo "286)CGTN Russian       326)Joy News Ghana 366)Fox 10 Phoenix**   406)CNN USA         446)California Music 486)EWTN Espanol      526)Ronahi Zindi**"  
   echo "287)ТВ-ТРЕЙЛЕР Russia  327)ADOM Ghana     367)Fox 2 Bay Area     407)DIVIDs          447)Music Choice Play487)EWTN Deutsch      527)KNBC 4 Los Angeles"
   echo "288)Vesti FM Russia    328)Bukedde TV     368)ATXN Austin        408)America Thinks  448)538 Netherlands  488)Catholic TV       528)ABC 3 Louisiana"
   echo "289)Current Time VOA   329)Qaranka Somalia369)Seminole Florida   409)NASA TV Educate 449)О2 ТВ Russia     489)KtO Catholique    529)WPLG 10 Miami"
   echo "290)RTR Planeta        330)EBC Ethiopia   370)Florida Channel    410)NASA TV Media   450)MTV AM Russia    490)CBN               530)WJXT 4 Jacksonville"
   echo "291)Perviy RU          331)SPARK Uganda   371)Weather Nation     411)C-SPAN 2 USA    451)DJ Animation     491)CBN News          531)NBC 6 South Florida"
   echo "292)Music Box RU       332)Biafra TV **   372)Weather Channel    412)C-SPAN 3 USA    452)DJ Classic       492)NRB               532)WBLZ Bangor Maine"
   echo "293)Planeta 4 RU       333)Walf Senegal   373)CBS 2 New York     413)Bloomberg Europe453)DJ Dancefloor    493)Church Channel    533)EuroNews Francais***"
   echo "294)Planeta 6 RU       334)EriTV Eritrea  374)CBS 4 Boston       414)Bloomberg Asia  454)DJ Underground   494)TBN               534)TTB Network"
   echo "295)POCCNR 1 HD RU     335)EbruTV Kenya   375)WVIT 30 Hartford   415)------------    455)M2O Music        495)God TV            535)Vatican Deutsch" 
   echo "296)MOCKBA 24 RU       336)KTN Home       376)NBC 10 Philadelphia416)BYUTV Int       456)Virgin 1         496)Amazing Facts     536)Vatican Italiano"
   echo "297)5 Live RU          337)SABC ZA        377)CBS 3 Michigan     417)Arirang Radio   457)Virgin 2         497)It's Supernatural!537)OireachtasTV IE"
   echo "298)NTV RU             338)Africa News    378)CBS 2 Salt Lake    418)HSN             458)Clubbing TV      498)Sheppard's Chapel 538)RTE News NOW IE"	
   echo "299)TNT RU             339)-------------  379)CBS 5 Colorado     419)HSN 2           459)Radio Monte Carlo499)IHOP              539)Dail Eireann IE"
   echo "300)POCCNR K  RU       340)-------------  380)NBC 11 Bay Area    420)QVC             460)KPOP Idol KR     500)BVOVN             540)Senad Eireann IE"  
   echo "301)REN TV RU          341)-------------  381)CBS 13 Stockton    421)TSC             461)Adult Swim       501)3ABN              541)India TV IN"
   echo "302)Domanshiniy RU     342)-------------  382)KCAL 9 Los Angeles 422)CTV Live Event  462)Insight TV       502)3ABN Latino       542)BSC 24 1 JP "       
   echo "303)TV3 RU             343)-------------  383)WXXV Mississippi   423)CPAC Senate CA  463)Yes TV           503)Logos TV espanol  543)BSC 24 2 JP"  
   echo "304)TVC RU             344)-------------  384)NBC 13 Albany NY   424)RUPTLY          464)Smile of a Child 504)Salt and Light    544)Earthquake 24"
   echo "305)OTR RU             345)-------------  385)NBC 2 Florida      425)Made in Leeds   465)PJ Masks         505)LLBN TV           545)-----------"  
   echo "306)Karusel RU         346)-------------  386)WCCB Charlotte     426)Made in Tyne    466)Talking Tom      506)Rap Resurrection  546)-----------"
   echo "307)Zvezda RU          347)-------------  387)7 News Boston      427)Made in Cardiff 467)Talking Tom Mini 507)Hillsong          547)-----------"
   echo "308)MuzTV RU           348)-------------  388)--------------     428)Saudi 2 English 468)Fashion Europe   508)Al Fady TV Arabic 548)-----------"
   echo "309)MIR RU             349)-------------  389)--------------     429)Bloomberg Aus   469)Fashion 1 TV ES  509)Aghapy TV Arabic  549)-----------"
   echo "310)ORT 3 RU           350)-------------  390)--------------     430)Bloomberg USvnt 470)Jasmin TV USA    510)St. Mary's Coptic 550)-----------"    
   echo "311)-------------      351)-------------  391)--------------     431)Bloomberg Pol   471)TYT USA          511)Word of God Greek 551)-----------"
   echo "312)VietTV VN          352)-------------  392)--------------     432)Bloomberg EUvnt 472)DMC Sports       512)Heaven TV         552)-----------"
   echo "313)DZMM ABS-CBN       353)-------------  393)--------------     433)Bloomberg APvnt 473)Pitchoun         513)Rakshana TV       553)-----------" 
   echo "314)DZRH Philippeans   354)-------------  394)--------------     434)------------    474)NRJ Hits FR      514)Powervision TV    554)-----------"  
   echo "315)PTV Philippines    355)-------------  395)--------------     435)-----------     475)Steven Universe  515)KJV Bible         555)-----------"
   echo "316)Net TV Jakarta ID  356)-------------  396)--------------     436)-----------     476)Nature Vision    516)Harbor Light      556)-----------"
   echo "317)-------------      357)-------------  397)--------------     437)PBS NewsHour    477)Pursuit Channel  517)JUCE TV           557)----------"
   echo "318)-------------      358)-------------  398)--------------     438)CBC The National478)Music Vox TV     518)Temple Institute  558)----------"	 
   echo "319)-------------      359)-------------  399)--------------     439)AP Top Stories  479)H!T Music Channel519)Jewish Life       559)----------"
   echo "320)-------------      360)-------------  400)--------------     440)Democracy Now   480)Now Music TV     520)Quaran English    560)----------"
   echo "==================================================================================================================================================="
}

channel_matrix_2()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "|| Latino Extra    ||     Portugues      ||       Extra         ||    USA Local 2     ||     USA Local 3     ||    ARAB Extra      ||   Column 7    ||"
   echo "======================================================================================================================================================"
   echo "561)Gudalajera MX    601)Euronews PT       641)OnTV HK           681)FOX News Preview 721)KTVB               761)Al Jaeed          801)------------"    
   echo "562)Acapuloco MX     602)TV Assemblelia BR 642)Planeta 2 RU      682)Fox News Talk    722)Key TV             762)Alghad            802)------------" 
   echo "563)Puebla MX        603)TV Canaco Nova    643)Planeta 3 RU      683)STADIUM          723)KOB4 News          763)NTV Spor TK       803)------------"  
   echo "564)Sonora MX        604)Igreja de Graca   644)Crime District    684)NFL Now          724)KPNX Breaking      764)TRT 4K TK         804)------------"             
   echo "565)Toluca MX        605)Assemblelia Ales  645)MANGAS            685)RED BULL TV      725)KXAN News          765)AFAQ TV IRAQ      805)------------"  
   echo "566)Veracruz MX      606)Boas Nova         646)ANIMAUX           686)Olympics Channel 726)Laurel TV          766)PAL TV            806)------------"  
   echo "567)Cuernavaca MX    607)Fundacao Nazzare  647)Tout L'Histoire   687)Olympics 2       727)Miami TV           767)Palistine TV      807)------------"
   echo "568)Torreon MX       608)STF Brazil        648)ACTION            688)Olympics 3       728)KNTV-TV            768)Syria Nour Elsham 808)------------"
   echo "569)Queretaro MX     609)TV Estúdio Brasil 649)Vatican Media FR  689)Olympics 4       729)Traffic KNTV       769)Syrian Education  809)------------"
   echo "570)Aguascalientes MX610)Rádio Justiça     650)France Inter      690)Olympics 5       730)NBC2 News KTUU     770)------------      810)------------"
   echo "571)Matamoros MX     611)EXA FM Brasil     651)TV7 France        691)NBC News         731)News2 WCBD         771)------------      811)------------"
   echo "572)Monterrey MX     612)RIT TV BR         652)LCP FR            692)Shepard Smith    732)News4 WRC          772)------------      812)------------"
   echo "573)Chihuahua MX     613)Vatican Media PT  653)Public Senate FR  693)WUSA9 Breaking   733)News4 White House  773)------------      813)------------"
   echo "574)Mexicali MX      614)Venevision VE     654)RTL               694)WCNC Breaking    734)News5 WCYB         774)------------      814)------------"
   echo "575)Tijuana MX       615)Telediario AR     655)24 News PK        695)WCCB News        735)NewsWest 9 KWES TX 775)------------      815)------------" 
   echo "576)Del-Golfo MX     616)TVeo Cordoba AR   656)Image Channel IN  696)UGA TV           736)New Orleans TV     776)------------      816)------------"
   echo "577)Zacatecas MX     617)PSN Tijuana MX    657)AP1 Nepal         697)TVW Washington   737)NBC4 WNBC          777)------------      817)------------"
   echo "578)Univision USA    618)------------      658)Somoy TV BD       698)TVW2 Washington  738)NBC4 WNBC Traffic  778)------------      818)------------"	
   echo "579)-------------    619)------------      659)Ekattor TV        699)Action News KNVN 739)NBC5 WMAQ          779)------------      819)------------"
   echo "580)VTV VE           620)------------      660 Rtv IN            700)Alaska ASD       740)NBC 10 KTEN        780)------------      820)------------"  
   echo "581)VIVE VE          621)------------      661)PTTV IN           701)Atlanta Channel  741)NBC 12 WWBT        781)------------      821)------------"
   echo "582)Vatican Media ES 622)------------      662)PAK News PK       702)Beach TV         742)NBC 29 WVIR        782)------------      822)------------"       
   echo "583)Televen VE       623)------------      663)Aaj News IN       703)Panama City      743)NBC 13 WNYT        783)------------      823)------------"  
   echo "584)Impacto USA      624)------------      664)Aaj Tak PK        704)Pawleys Island   744)News 12 KTVZ7      784)------------      824)------------"
   echo "585)Canal 2 AR       625)------------      665)919FM TV Trinidad 705)Bowie TV         745)NewsWest 9 KWES DC 785)------------      825)------------"  
   echo "586)---------------  626)-------------     666)--------------    706)Buffalo TV       746)Orange TV          786)------------      826)------------"
   echo "587)Canal 8 MarPlata 627)------------      667)Kaliagnar News IN 707)Capital City     747)PGCPS              787)------------      827)------------"
   echo "588)Canal 11 Salta AR628)------------      668)1TV Afghanistan   708)Daytona Beach    748)RyeTV              788)------------      828)------------"
   echo "589)UCVTV CL         629)------------      669)Arirang News TV   709)DC Knowledge     749)Seattle Channel    789)------------      829)------------"
   echo "590)UNITVE AR        630)------------      670)Arirang TV KR     710)DC Network       750)Southeastern       790)------------      830)------------"    
   echo "591)ABC Paraguay     631)------------      671)RMC INFO FR       711)Escambia TV      751)Temple TV          791)------------      831)------------"
   echo "592)Abya Yala BO     632)------------      672)CNEWS FR          712)FiOS1New Jersey  752)Vienna HQ          792)------------      832)------------"
   echo "593)JN19 Catolica PE 633)------------      673)------------      713)FiOS1Long Island 753)TSTV               793)------------      833)------------" 
   echo "594)UFROVision CL    634)------------      674)------------      714)FiOS1HudsonValley754)------------       794)------------      834)------------"  
   echo "595)Campo Abierto CL 635)------------      675)------------      715)FOX 5 DC (WTTG)  755)------------       795)------------      835)------------"
   echo "596)TV Chihuahua MX  636)------------      676)------------      716)Garland TV       756)------------       796)------------      836)------------"
   echo "597)EuroNews Espanol 637)------------      677)------------      717)Greenbelt TV     757)------------       797)------------      837)------------"
   echo "598)Argentisima AR   638)------------      678)------------      718)House Represent  758)------------       798)------------      838)------------"	
   echo "599)UNITV AR         639)------------      679)------------      719)KRBC-TV          759)------------       799)------------      839)------------"
   echo "600)TelePacifico CO  640)------------      680)------------      720)KBVR TV          760)------------       800)------------      840)------------"
   echo "==================================================================================================================================================="
}	        

channel_matrix_3()	
{
   echo "============================================================    "$product"  "$version"   ==================================================================="
   echo "||  Locations        ||     Column 2        ||    Column 3       ||   Column      4     ||  Column 5         ||    Column 6        ||   Column 7    ||"
   echo "======================================================================================================================================================"
   echo "841)------------     881)------------      921)------------      961)------------     1001)------------      1041)------------     1081)------------"    
   echo "842)NASA ISS 1       882)------------      922)------------      962)------------     1002)------------      1042)------------     1082)------------" 
   echo "843)------------     883)------------      923)------------      963)------------     1003)------------      1043)------------     1083)------------"  
   echo "844)Venice Bridge    884)------------      924)------------      964)------------     1004)------------      1044)------------     1084)------------"             
   echo "845)------------     885)------------      925)------------      965)------------     1005)------------      1045)------------     1085)------------"  
   echo "846)------------     886)------------      926)------------      966)------------     1006)------------      1046)------------     1086)------------"  
   echo "847)JacksonHole Sq   887)------------      927)------------      967)------------     1007)------------      1047)------------     1087)------------"
   echo "848)JacksonHole Rust 888)------------      928)------------      968)------------     1008)------------      1048)------------     1088)------------"
   echo "849)Aosta Sarre Italy889)------------      929)------------      969)------------     1009)------------      1049)------------     1089)------------"
   echo "850)Buenos Aires     890)------------      930)------------      970)------------     1010)------------      1050)------------     1090)------------"
   echo "851)Amsterdam NL     891)------------      931)------------      971)------------     1011)------------      1051)------------     1091)------------"
   echo "852)Shibua Japan     892)------------      932)------------      972)------------     1012)------------      1052)------------     1092)------------"
   echo "853)Akiba Japan      893)------------      933)------------      973)------------     1013)------------      1053)------------     1093)------------"
   echo "854)Yahoo Japan      894)------------      934)------------      974)------------     1014)------------      1054)------------     1094)------------"
   echo "855)Steamy Mountain  895)------------      935)------------      975)------------     1015)------------      1055)------------     1095)------------" 
   echo "856)Naman Seoul      896)------------      936)------------      976)------------     1016)------------      1056)------------     1096)------------"
   echo "857)Shizuoka Japan   897)------------      937)------------      977)------------     1017)------------      1057)------------     1097)------------"
   echo "858)Yokohama Japan   898)------------      938)------------      978)------------     1018)------------      1058)------------     1098)------------"	
   echo "859)------------     899)------------      939)------------      979)------------     1019)------------      1059)------------     1099)------------"
   echo "860)Mount Fuji Japan 900)------------      940)------------      980)------------     1020)------------      1060)------------     1100)------------"  
   echo "861)Hart Beach NL    901)------------      941)------------      981)------------     1021)------------      1061)------------     1101)------------"
   echo "862)Port Du Quebec   902)------------      942)------------      982)------------     1022)------------      1062)------------     1102)------------"       
   echo "863)Durango Colorado 903)------------      943)------------      983)------------     1023)------------      1063)------------     1103)------------"  
   echo "864)StarDot 1        904)------------      944)------------      984)------------     1024)------------      1064)------------     1104)------------"
   echo "865)Youing Japan     905)------------      945)------------      985)------------     1025)------------      1065)------------     1105)------------"  
   echo "866)StarDot 4        906)-------------     946)------------      986)------------     1026)------------      1066)------------     1106)------------"
   echo "867)StarDot 5        907)------------      947)------------      987)------------     1027)------------      1067)------------     1107)------------"
   echo "868)StarDot 6        908)------------      948)------------      988)------------     1028)------------      1068)------------     1108)------------"
   echo "869)London 1         909)------------      949)------------      989)------------     1029)------------      1069)------------     1109)------------"
   echo "870)London 2         910)------------      950)------------      990)------------     1030)------------      1070)------------     1110)------------"    
   echo "871)London 3         911)------------      951)------------      991)------------     1031)------------      1071)------------     1111)------------"
   echo "872)Berlin Airport   912)------------      952)------------      992)------------     1032)------------      1072)------------     1112)------------"
   echo "873)-------------    913)------------      953)------------      993)------------     1033)------------      1073)------------     1113)------------" 
   echo "874)Los Angeles Port 914)------------      954)------------      994)------------     1034)------------      1074)------------     1114)------------"  
   echo "875)ITS COM Japan    915)------------      955)------------      995)------------     1035)------------      1075)------------     1115)------------"
   echo "876)China Shoreline  916)------------      956)------------      996)------------     1036)------------      1076)------------     1116)------------"
   echo "877)------------     917)------------      957)------------      997)------------     1037)------------      1077)------------     1117)------------"
   echo "878)------------     918)------------      958)------------      998)------------     1038)------------      1078)------------     1118)------------"	
   echo "879)------------     919)------------      959)------------      999)-----------      1039)------------      1079)------------     1119)------------"
   echo "880)------------     920)------------      960)------------      1000)-----------     1040)------------      1080)------------     1120)------------"
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
link=https://secure-streams.akamaized.net/rt-uk/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-uk/indexaudio.m3u8
#link=https://www.filmon.com/tv/russia-today-2
use_cookies="no"
chan_name="RT UK" ;;
# 5) France 24 Anglais 
5) 
keyword="FRANCE 24 Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/france24english/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
#link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master.m3u8
link=http://f24hls-i.akamaihd.net/hls/live/221193-b/F24_EN_LO_HLS/master_900.m3u8
#link=http://static.france24.com/live/F24_EN_LO_HLS/live_web.m3u8
# link=http://static.france24.com/live/F24_EN_LO_HLS/live_ios.m3u8
# link=http://www.dailymotion.com/video/xigc8z
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
link=https://secure-streams.akamaized.net/rt/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt/index800.m3u8
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

# link=https://www.cbsnews.com/common/video/dai_prod.m3u8
#
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/master.m3u8
#link=http://cbsnewshd-lh.akamaihd.net/i/CBSNHD_7@199302/index_2200_av-b.m3u8?sd=10&rebase=on
#
#link=https://www.youtube.com/watch?v=$(curl -A "$UA" "https://www.youtube.com/user/CBSNewsOnline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)
use_cookies="no"
chan_name="CBSN" ;;
# 10) # MSNBC
10)

link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/master.m3u8"
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
#link="http://tvemsnbc-lh.akamaihd.net/i/nbcmsnbc_1@122532/index_1296_av-b.m3u8?sd=10&rebase=on"
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
keyword="Bloomberg"
#link=https://www.bloomberg.com/live/us
#link="http://cdn3.videos.bloomberg.com/btv/us/master.m3u8?b?b*t$"
#link=http://cdn-videos.akamaized.net/btv/desktop/akamai/europe/live/primary.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Bloomberg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
link=https://liveproduseast.akamaized.net/us/Channel-USTV-AWS-virginia-1/Source-USTV-1000-1_live.m3u8
use_cookies="no"
chan_name="Bloomberg Business USA";;  
# 12) RT America
12)
#link=https://www.rt.com/on-air/rt-america-air/
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index2500.m3u8
link=https://secure-streams.akamaized.net/rt-usa/index1600.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-usa/indexaudio.m3u8
use_cookies="no"
chan_name="RT America" ;;
# 13) CGTN America
13)
link=https://api.new.livestream.com/accounts/7082210/events/7115682/live.m3u8
use_cookies="no"
chan_name="CGTN America" ;;
# 14) Newsy
14) 
#link=http://www.newsy.com/live/
link=https://content.jwplatform.com/players/hBmO7M6k
#link=https://www.filmon.com/tv/newsy
use_cookies="no"
chan_name="Newsy" ;;
############################# MIDDLE EAST ##############################################################
# 15)ABC News USA 
15)
link=http://abclive.abcnews.com/i/abc_live4@136330/master.m3u8
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_400_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_800_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_1200_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_2500_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
#link="http://abclive.abcnews.com/i/abc_live4@136330/index_4000_av-b.m3u8?sd=10&rebase=on"
use_cookies="yes"
chan_name="ABC News USA" ;;
# 16) TRT World
16) 
keyword="TRT"
link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8
#link=http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/master.m3u8?play-only=primary
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=650000,RESOLUTION=640x360,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_360p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=818000,RESOLUTION=852x480,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_480p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=972000,RESOLUTION=1280x720,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_720p_av-p.m3u8?sd=10&rebase=on"
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=4564000,RESOLUTION=1920x1080,CODECS="avc1.77.30, mp4a.40.2"
#link="http://trtcanlitv-lh.akamaihd.net/i/TRTWORLD_1@321783/index_1080p_av-p.m3u8?sd=10&rebase=on"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC7fWeaHhqgM4Ry-RMpM2YYw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="TRT World";;   
# 17) i24 News Israel
17) 
keyword="Live"  
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/i24News/videos?view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
link="https://www.dailymotion.com/video/x29atae"
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-4.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-3.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-2.m3u8
#link=https://stream-01.dc3.dailymotion.com/44/dm/3/x29atae/live-1.m3u8
#format=hls-1080
format=hls-720
#format=hls-480 
#format=hls-380 
#format=hls-240
use_cookies="no"
chan_name="i24 News Israel English" ;;
# 18) Al Jazeera
18) 
keyword="Al Jazeera English - Live" 
link=https://players.brightcove.net/665003303001/SkrZHHcl_default/index.html?videoId=4865263685001
#link=http://aljazeera-eng-apple-live.adaptive.level3.net/apple/aljazeera/english/800.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/AlJazeeraEnglish/videos?view=2" | grep "$keyword"  | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Al Jazeera English" ;;  
# 19) Press TV
19)
#link=https://www.filmon.com/tv/press-tv
link=http://107.189.40.49:1935/live/ptven/playlist.m3u8
use_cookies="yes"
chan_name="Press TV" ;;  
################### INDIA  ########################################
# 20) India TODAY
20)
keyword="IndiaToday Live TV"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYPvAwZP8pZhSMW8qs7cVCw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://indiatoday.intoday.in/livetv.jsp
link="http://livestream.com/accounts/11965022/events/4086327/player"
use_cookies="no"
chan_name="India TODAY English" ;;  
# 21) NEWS X INDIA English
21) 
keyword="Live"
link=http://newsx.live-s.cdn.bitgravity.com/cdn-live/_definst_/newsx/live/newsxnew.smil/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/newsxlive/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWS X INDIA English" ;; 
# 22) NDTV IN
22)
link=http://ndtv.live-s.cdn.bitgravity.com/cdn-live-b7/_definst_/ndtv/live/ndtv247live.smil/playlist.m3u8
use_cookies="no"
chan_name="NDTV India" ;;  
###########################  ASIA-OCEANIA   ############################################
# 23) CGTN China English
23) 
keyword="Live"
link=https://live.cgtn.com/manifest.m3u8
#link=https://www.filmon.com/tv/cctv-news
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CCTVNEWSbeijing/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="CGTN China English" ;;
# 24)NHK World Japan 
24) 
link=https://nhkwtvglobal-i.akamaihd.net/hls/live/263941/nhkwtvglobal/index_1180.m3u8
use_cookies="no"
chan_name="NHK World Japan" ;;
# 25) CNN PHILIPPINES
25)
link=rtmp://54.251.134.121/live/15273.sdp
use_cookies="no"
chan_name="CNN PHILIPPINES";;
# 26) ABC News Australia 
26) 
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
# 27) ANN7 South Africa
27) 
keyword="ANN7 TV Live Stream"
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/playlist.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=250000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=480x270
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b250000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=550000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=640x360
link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b550000.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1300000,CODECS="avc1.66.30,mp4a.40.5",RESOLUTION=1280x720
#link=http://46.4.25.213:1935/live-ann7/ann7.smil/chunklist_w799375146_b1300000.m3u8
#link=rtmp://46.4.25.213/live-ann7/ann7-mid.stream
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6gciFMFztxlRrO5f4K1xbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ANN7 News South Africa" ;; 
# 28) Arise News Nigeria/London
28) 
keyword="Arise"
link=http://contributionstreams.ashttp9.visionip.tv/live/visiontv-contributionstreams-arise-tv-hsslive-25f-16x9-SD/chunklist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCyEJX-kSj0kOOCS7Qlq2G7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Arise News Nigeria/London";;  
##################    DOCUMENTARY   ##################################################
# 29)VOA
29)
link=http://voa-lh.akamaihd.net/i/voa_mpls_tvmc6@320298/master.m3u8
#link=https://www.filmon.com/tv/voa-english
use_cookies="no"
chan_name="VOA" ;;
# 30) RT Documentary
30) 
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
# 31) CGTN Documentary
31)
link=https://live.cgtn.com/cctv-d.m3u8
use_cookies="no"
chan_name="CGTN Documentary" ;;
# 32)BYUTV
32)
link=https://byubhls-i.akamaihd.net/hls/live/267187/byutvhls/master.m3u8
use_cookies="no"
chan_name="BYUTV" ;;
##################    ALTERNATIVE MEDIA   ##################################################
# 33)Biz TV
33)
link=https://imavex2.mmdlive.lldns.net/imavex2/0b2f65006e0743bd9701cce1339a3b9f/manifest.m3u8
use_cookies="no"
chan_name="Biz TV USA" ;;
# 34) NEWSMAX USA
34) 
keyword="Newsmax"
link=http://cdnapi.kaltura.com/p/2216081/sp/221608100/playManifest/entryId/1_f19eeulz/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
# "http://www.newsmaxtv.com/"
# link=https://nmxlive.akamaized.net/hls/live/529965/Live_1/index.m3u8
#link="http://ooyalahd2-f.akamaihd.net/i/newsmax02_delivery@119568/master.m3u8"
# link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsmaxTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NEWSMAX USA";;
# 35)Free Speech TV
35) 
link=https://edge.free-speech-tv-live.top.comcast.net/out/u/fstv.m3u8
use_cookies="no"
chan_name="Free Speech TV" ;;   
# 36)  Infowars
36) 
keyword="Infowars"
link=http://infowarslive-lh.akamaihd.net/i/infowarslivestream_1@353459/master.m3u8
#link=http://www.infowars.com/show
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUJNY4nfdomMppNDZNZc4nA/videos?&view=2" |grep "watch?v=" | head -n 1 | cut -d = -f 4 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Infowars" ;; 
########################## AMERICAN GOVERNMENT ####################################################
# 37) C-SPAN 1 HD
37)
link="http://cspan1-lh.akamaihd.net/i/cspan1_1@304727/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan1nontve-lh.akamaihd.net/i/CSpan1NonTVE_1@312667/master.m3u8
use_cookies="no"
chan_name="C-SPAN 1" ;;

########################## CANADIAN GOVERNMENT ###################################################
# 38) CPAC 1 Canada
38)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027924874001
use_cookies="no"
chan_name="CPAC 1 Canada" ;;

###################      TECHNOLOGY    ################################################
# 39)TWiT
39) 
keyword="TWiT Live"
#Twitch
link=https://www.twitch.tv/twit 
#USTREAM
#https://r46932538-1-1524-channel-wss-live.ums.ustream.tv/1/ustream
#https://www.ustream.tv/channel/1524
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/twit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TWiT" ;;

# 40) Juptier Broadcasting 
40) link=http://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream/playlist.m3u8
# link=rtmp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
# link=rtsp://jblive.videocdn.scaleengine.net/jb-live/play/jblive.stream
use_cookies="no"
chan_name="Jupiter Broadcasting" ;;

#################    FRENCH   ###################################
# 41) France 24 
41)
keyword="FRANCE 24 en Direct" 
link=http://f24hls-i.akamaihd.net/hls/live/221192-b/F24_FR_LO_HLS/master.m3u8
#link=http://f24hls-i.akamaihd.net/hls/live/221192/F24_EN_LO_HLS/master_900.m3u8
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
link=https://players.brightcove.net/876450610001/HJeY2afE_default/index.html?videoId=5615950982001
#link=https://bfmtvalive1-a.akamaihd.net/8a3483ffeb9d40f0a738c1392f2bcc14/eu-central-1/876450610001/profile_1/87cd96eea0644453bd913833950774b0/chunklist_ssaiM.m3u8
#link=http://csm-e.dai.bfmtv.com/csm/live/109797390.m3u8
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

# 44) BFM BFM BUSINESS
44) 
### 
#link="https://players.brightcove.net/876450612001/HycrnmXI_default/index.html?videoId=1920204345001"
#https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_0_fra/audio_0_fra.m3u8
link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_3/video_3.m3u8
## link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_4_fra/audio_4_fra.m3u8
#link=https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_19/video_19.m3u8

### Merge Audio and Video with FFMPEG
##ffmpeg -i https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//video_3/video_3.m3u8 -i https://bfmbusisecure-i.akamaihd.net/hls/live/265375/876450612001/BFMBusinessS//audio_0_fra/audio_0_fra.m3u8 -c:v copy -c:a copy output.mkv 

use_cookies="no"
chan_name="BFM Busineess France" ;;

# "" data-video-id="1920204345001" data-account="876450612001" data-player="HycrnmXI" data-embed="default"

# 45) TV5+ monde 
45)
link=http://v3plusinfo247hls-i.akamaihd.net/hls/live/218877/v3plusinfo247hls/v3plusinfo247hls_1_1.m3u8
use_cookies="no"
chan_name="TV5+ monde " ;;
# 46) RT Francais
46)
#link=https://secure-streams.akamaized.net/rt-fr/index.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-fr/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-fr/indexaudio.m3u8
use_cookies="no"
chan_name="RT France" ;;
# 47) RTS UN
47) 
link=https://www.filmon.com/tv/rts-un
use_cookies="yes" 
chan_name="RTS UN" ;;
# 48) CGTN Francais
48)
link=https://live.cgtn.com/cctv-f.m3u8
use_cookies="no"
chan_name="CGTN Francais" ;; 
# 49) i24 News en Direct
49) link=https://www.dailymotion.com/video/x10358o_i24news-le-direct_tv
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="i24 Francais";;
# 50) Africa24
50) 
keyword="Africa24 Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Africa24/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="Africa24" ;; 
# 51) Africa News Francais
51) 
keyword="africanews (en français) EN DIRECT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC25EuGAePOPvPrUA5cmu3dQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Africa News Francais" ;;
# 52) SIKKA TV
52) 
keyword="SIKKA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCplwKOWLV8s2XZBMsimOjvg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SIKKA TV Afrique" ;; 
# 53) FRANCE 2
53) 
link=https://www.filmon.com/tv/france-2
use_cookies="yes"
chan_name="France 2" ;;
# 54) RTS DEUX
54) 
link=https://www.filmon.com/tv/rts-deux
use_cookies="yes" 
chan_name="RTS DEUX" ;;
# 55) France 3 Rhone Alpes
55) 
link=https://www.filmon.com/tv/france-3-rhone-alpes
use_cookies="yes"
chan_name="France 3 Rhone Alps" ;;
# 56)France O
56) 
link=https://www.filmon.com/tv/france-0
use_cookies="yes"
chan_name="France O" ;;
# 57) ARTE FRANCAIS
57) 
link=https://www.filmon.com/tv/arte-francais
use_cookies="yes" 
chan_name="ARTE Francais" ;; 
# 58) BFM Paris Francais
58)   
link=https://players.brightcove.net/5132998232001/H1bPo8t6_default/index.html?videoId=5152968636001
#link=http://bfmparishdslive-lh.akamaihd.net/i/DVMR_PARIS@429747/master.m3u8
use_cookies="no"
chan_name="BFM Paris Francais" ;;
# 59) TLM Lyon Metro
59) 
keyword="TLM en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telelyonmetropole/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
chan_name="TLM Television Lyon Metro" ;;
# 60) Alsace 20 France
60)
link="http://live.alsace20.fr/live/alsace20/ngrp:alsace20_all/master.m3u8"
use_cookies="no"
chan_name="Alsace 20 France" ;;
# 61) Mosaik TV Francais
61)
keyword="Diffusion en direct de mosaiktv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/mosaiktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no" 
chan_name="Mosaik TV" ;;
# 62) Direct Journal TVLandes    
62) link=https://www.dailymotion.com/video/x1z2d07_direct-journal-tvlandes_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Direct Journal Tvlandes"  ;;    
# 63) TV7 Bordeaux
63)
link=http://62.210.204.108:1935/livtv7vo/myStream.smil/playlist.m3u8
use_cookies="no"
chan_name="TV7 Bordeaux" ;;
# 64) Notele Tournai Belgium
64)
link=rtmp://streaming06.axeweb.be/live/direct.stream
use_cookies="no"
chan_name="Notele Tournai Belgium" ;;
# 65) 8 Mont Blanc FR
65)
link="http://www.dailymotion.com/video/x3wqv8b"
use_cookies="no"
chan_name="8 Mont Blanc FR" ;;
# 66) RTC Liege BE
66)
link=http://wowza.imust.org:1935/live/rtc-live/chunklist_w334395120.m3u8
use_cookies="no"
chan_name="RTC Liege BE" ;;
# 67) Azur TV Nice
67)
link=http://www.dailymotion.com/video/x13x1q2 
use_cookies="no"
chan_name="Azur TV Nice" ;;
# 68)Canal Savoir Francais
68)
link=http://stream.canalsavoir.tv/livestream/stream.m3u8
use_cookies="no"
chan_name="Canal Savoir Canada" ;;
# 69) CPAC 1 Francais
69)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5027941315001
use_cookies="no"
chan_name="CPAC 1 Francais Canada" ;;
# 70) Assemblee Nationale du Quebec Francais
70)
link=http://diffusionm4.assnat.qc.ca/canal9/250.sdp/playlist.m3u8
use_cookies="no"
chan_name="Assemblee Nationale du Quebec Francais Canada" ;;
# 71) MABI TV Canada
71) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC1LyPxWz4t2PGfIr2ETwPw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="MABI TV Canada" ;;
# 72) GONG Asian Cinema Francais
72)
link=http://ec.playmedia.fr/gong-base/live/playlist.m3u8
use_cookies="no"
chan_name="GONG Asian Cinema Francais" ;;
# 73) GONG MAX
73)
link=http://51.254.215.79/appflux/gongmax/GONGMAX/gongmax_1280/chunks.m3u8 
use_cookies="no"
chan_name="GONG MAX" ;;
# 74)QVC Francais
74) 
keyword="en direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCUgix0XhGdH0AThuPG-ALMA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Francais" ;;  
# 75) Antena Centre BE
75)
link=http://vm109.imust.org:1935/live/livestream/HasBahCa.m3u8 
use_cookies="no"
chan_name="Antena Centre BE" ;;
# 76) IL TV France
76)
link=rtmp://str81.creacast.com:80/iltv/high
use_cookies="no"
chan_name="IL TV" ;;
# 77) BX1 BE
77)
link=http://149.202.81.107:1935/stream/live/chunklist_w1279780159.m3u8 
use_cookies="no"
chan_name="BX1 BE" ;;
# 78) France Info Radio
78) link=https://www.dailymotion.com/video/x26eox4_live-franceinfo-direct-radio_news
format=hls-720
use_cookies="no"
chan_name="France Info Radio" ;;
# 79) Europe 1
79) link=https://www.dailymotion.com/video/xqjkfz_europe-1-live_news
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Europe 1" ;;
# 80) RFI
80) 
keyword="RFI en Direct"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/rfivideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"  
chan_name="RFI Francais" ;;

################### BROKEN / OFFLINE ###################################
# 75) ICI RDI Canada
# 75)
# link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
# link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_400_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_800_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/index_1200_av-p.m3u8?sd=10&rebase=on"
#link="http://hdflash_1-lh.akamaihd.net/i/canrdi_1@95877/master.m3u8?sd=10&rebase=on"
#use_cookies="no"
#chan_name="ICI RDI Canada" ;;
###################  SPANISH  #################################
# 81) RT Espanol
81) 
keyword="EN VIVO"
#link=https://secure-streams.akamaized.net/rt-esp/index.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index2500.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index1600.m3u8
link=https://secure-streams.akamaized.net/rt-esp/index800.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/index400.m3u8
#link=https://secure-streams.akamaized.net/rt-esp/indexaudio.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ActualidadRT/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
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
link=http://107.189.40.49:1935/live/hispantv/playlist.m3u8
#link=http://178.32.255.199:1935/live/hispantv/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/hispantv/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no" 
chan_name="HispanTV" ;;
############## SPAIN ######################################
# 85) Le Zap  ES
85)
link=http://a3live-lh.akamaihd.net/i/antena3_1@35248/index_2_av-b.m3u8?sd=10  
use_cookies="no"
chan_name="Le Zap ES" ;;
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
# 88) GRANADA TV ES
88)  
keyword="GRANADA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Steadycamline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="GRANADA TV ES" ;; 
######################### ARGENTINA ##############################################
# 89) c5n Argentina
89) 
keyword="en VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/c5n/videos?&view=2" | grep "watch?v=" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
# link=http://www.c5n.com/
use_cookies="no"
chan_name="c5n Argentina" ;;
# 90) A24 Argentina
90) 
keyword="A24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR9120YBAqMfntqgRTKmkjQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="A24 Argentina";;
# 91) Todo Noticias Argentina
91) 
keyword="TN en Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCj6PcyLvpnIRT_2W_mwa9Aw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Todo Noticias Argentina";;
# 92) La Nacion TV Argentina
92) 
keyword="LN+"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LaNacionTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="La Nacion TV Argentina";;
# 93) TV Publica Argentina
93)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TVPublicaArgentina/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TV Publica Argentina" ;;  
# 94) KZO En Vivo Canal 30
94) 
keyword="KZO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCv0zRACOVWmhu1Ilufm40-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KZO Canal 30 Cablevision" ;; 
# 95) Canal 6 San Rafael Argentina
95) 
keyword="RAFAEL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCwq0epWuoVUDbuBz3hpgGeg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"   
chan_name="Canal 6 San Rafael Argentina" ;;
# 96) Canal 7 Mendoza Argentina
96) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/webcanal7mendoza/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Canal 7 Mendoza Argentina" ;;
# 97) Canal 8 San Juan Argentina
97) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5UKMEIoqvNDMSDz2_6Sn9g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Canal 8 San Juan Argentina" ;;
# 98) Canal 13 San Juan Argentina  
98)  
keyword="Juan"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCnfpjpEMfxPXAI3Nc23MTWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 13 San Juan Argentina" ;; 
# 99) Showsport Cordoba Argentina
99)  
keyword="Showsport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CanalShowsport/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Showsport Argentina" ;;  
# 100) Canal 3 SuperCanal Argentina
100)  
keyword="SuperCanal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/supercanal3oeste/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 3 SuperCanal Argentina" ;;  
# 101) CN23 Argentina
101)  
keyword="CN23"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCC05qIa00qEB06CtCi01NbQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CN23 Argentina" ;;   
# 102) Canal 2 Telpintv Pinamar AR  
102)  
keyword="Telpin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TelpinVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 2 Telpintv Pinamar AR" ;;  
# 103) VORTERIX AR
103)  
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvCTWHCbBC0b9UIeLeNs8ug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="VORTERIX AR" ;;
################# PARAGUAY  #############################
# 104) TV Camara Paraguay
104) 
keyword="DIRECTO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCRVeQhiqhUAxRRUod7F-K3A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TV Camara Paraguay" ;;
######################       CHILE       #################################
# 105)Senal Internacional Mega Chile
105)  
keyword="en vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/programasmega/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal Internacional Mega Chile" ;;
# 106)  CNN Chile CNN Chile
106)
link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream1/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream2/playlist.m3u8
#link=http://unlimited1-us.dps.live/cnn/cnn.smil/cnn/livestream3/playlist.m3u8
use_cookies="no"
chan_name="CNN Chile" ;;
################## Colombia ###################
# 107)Telemedellin CO
107)  
keyword="Telemedellin"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCW_16ow2scNATL0NSxlBtPg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telemedellin CO" ;; 
# 108) CTV Barranquilla Colombia
108) 
keyword="CTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJWpMkOWNk3wlj565Q0lpzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTV Barranquilla Colombia" ;;
################# VENEZUELA
# 109) TeleSUR Venezuela
109) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/telesurtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"   
# link=http://cdn2.telesur.ultrabase.net/livecf/telesurLive/master.m3u8
use_cookies="no"
chan_name="TeleSUR Venezuela" ;;
# 110) Globovision Venezeula
110) 
keyword="Globovisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCfJtBtmhnIyfUB6RqXeImMw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
#link=http://www.dailymotion.com/video/xio7e2_senal-en-vivo_news
use_cookies="no" 
chan_name="Globovision Venezeula" ;;
# 111) NTN24 Venezuela
111) 
keyword="SEÑAL EN VIVO DE NTN24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalNTN24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NTN24 Venezuela" ;;
# 112) CONSCIENCIA TV
112)  
keyword="CONCIENCIA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClUdUKaJ6qBoqe4o8qN9Bdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="CONCIENCIA TV" ;;
# 113) VPItv Venezuela
113) 
keyword="VPItv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVFiIRuxJ2GmJLUkHmlmj4w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VPItv Venezuela" ;;
# 114) Senal PDVSA VE
114)
keyword="PDVSA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PdvsaTv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Senal PDVSA Venezuela" ;;

#################### CENTRAL AMERICA    ########################
# 115) Tu Canal Panama
115)  
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/elcanaldepanamatv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Tu Canal Panama" ;; 
#################### MEXICO #########################################################
# 116) Excelsior TV Mexico
116) 
keyword="Transmisión en directo de Excélsior TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClqo4ZAAZ01HQdCTlovCgkA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Excelsior TV Mexico" ;;
# 117) Bloomberg Financiero Mexico
117)  
keyword="Bloomberg"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FinancieroMexico/videos?live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Bloomberg Financiero Mexico" ;; 
# 118) Imagen Radio Mexico
118) 
keyword="En Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImagenNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Imagen Radio Mexico" ;;
# 119)Senal de CNN en Espanol
119)  
keyword="CNN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnenespanolcom/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Senal de CNN en Espanol" ;; 

# 120)

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
# 133) SET iNEWS Taiwan
133) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/setmoney159/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SET iNEWS Taiwan" ;; 
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
# 138) Formosa News HD Taiwan
138) 
keyword="Formosa"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UClIfopQZlkkSpM1VgCFLRJA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Formosa News HD Taiwan";;
# 139) CTS World News HD 2 Taiwan
139) 
keyword="國會頻道２ | Live直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA_hK5eRICBdSOLlXKESvEg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CTS World News HD 2" ;;
# 140) SJTV TW
140) 
keyword="SJTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SJTVonline/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="SJTV TW";;
# 141) SITTI 1
141) 
keyword="桐瑛二臺"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 1";;
# 142) SITTI 2
142) 
keyword="桐瑛二台"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 2";;
# 143) SITTI 3
143) 
keyword="桐瑛三臺"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV0ICYFwH29CVCWpYtGfdlw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="SITTI 3";;
# 144) 119 Live 電視台大立  Da Li Taiwan  
144)
keyword="大立電視台即時串流"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2nRKndta05aZZbjFUAcoFg/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="119 Live 電視台大立 Da Li Taiwan" ;;
# 145) SDTV 04CH Taiwan  
145)
keyword="04CH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCBWzi-vMywDa05QYA2jHxwQ/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="SDTV 04CH TW" ;;
# 146) Fanstelevision Taiwan  
146)
keyword="番薯衛星電視台現場直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC2UCHUxTWVkSqP6MILU5Bqw/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Fans TV TW" ;;
# 147) Hong Kong TV
147)
link=rtmp://live.hkstv.hk.lxdns.com/live/hks
use_cookies="no"
chan_name="Hong Kong TV" ;;
# 148) Arirang TV Korea English
148) 
keyword="Arirang" 
#link=http://www.filmon.com/tv/arirang-tv
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
use_cookies="no"
chan_name="Arirang TV Korea" ;; 
# 149)SBS IN 
149) 
keyword="SBS-IN" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCBzkVegsFusO7ZMa_J8MZ7Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SBS-IN" ;;
# 150) TBS Live Korea  
150) 
keyword="tbs TV LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5HSw5OY2vfVFSihpiB-AVQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TBS Live Korea" ;; 
# 151) YTN DMB Korea  
151) 
keyword="와이티엔 _DMB"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytndmb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN DMB Korea" ;; 
# 152) SBS News Live Korea  
152) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sbsnews8/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SBS News Korea" ;; 
# 153) YTN Science Korea  
153) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnscience/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="YTN Science Korea" ;; 
# 154) Channel 23 Korea  
154) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTHCOPwqNfZ0uiKOvFyhGwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Channel 23 Korea" ;; 
# 155) KBS World 24 Korea
155) 
keyword="On-Air"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/kbsworld/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS World 24 News" ;;
# 156) YTN 27 Korea 
156)
keyword="YTN LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ytnnews24/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="YTN LIVE Korea" ;;   
# 157) ANN JapaNews 24 Japan
157) 
keyword="JapaNews24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ANNnewsCH/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="ANN News 24 Japan" ;;
# 158) Sol!ve 24 Japan
158) 
keyword="SOLiVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNsidkYpIAQ4QaufptQBPHQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Sol!ve 24 Japan";; 
# 159) KBS Live 24 Japan  
159) 
keyword="KBSLIVE24"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChSodm7QfwnUqD63BpqZC6Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KBS Live 24 Japan" ;; 
#  160) QVC JAPAN SHOPPING CHANNEL
160) 
keyword="QVC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/QVCJapan/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="QVC JAPAN SHOPPING CHANNEL" ;;

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
keyword="CVR" 
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
keyword="SUN"
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
keyword="Rajya"
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
keyword="ABN"
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
# 180) Suvarna News
180)
keyword="SUVARNA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/suvarnanews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Suvarna News" ;;   
# 181) ATN News Bangladesh
181) 
keyword="ATN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKlhfq1ILoAFav7iw5iCnfA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ATN News Bangladesh";;    
# 182)i News Telugu
182) 
keyword="iNews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/inews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="iNews Telugu" ;; 
# 183) News 1 Kannada 
183)
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCTvL-zDcTSHSxEVZ6N3Kn1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News 1 Kannada" ;; 
# 184) India TV IN
184) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IndiaTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="India TV IN" ;;  
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
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFx1nseXKTc1Culiu3neeSQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Reporter Live" ;;
# 188) AsiaNet News
188) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/asianetnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AsiaNet News" ;;     
# 189)V6 News
189) 
keyword="Telugu Live News"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/V6NewsTelugu/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="V6 News" ;;
# 190) News Nation TV IN
190) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NewsNationTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="News Nation TV IN" ;;  
# 191) ETV Andhra Pradesh
191) 
keyword="ETV"
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
# 197)  The Ekantipur Nepal  **
197) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCirNuhIwaKwx3hs9bvro9gg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="The Ekantipur Nepal" ;;  
# 198) Sagarmatha Nepal
198) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sagarmathatvnepal/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Sagramatha Nepal" ;;  
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
# 203)Din News PK
203) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCKh7t3sgs671fSeqsXjlN0A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.dailymotion.com/video/x5ubgo9 
use_cookies="no"
chan_name="Din News PK" ;;  
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
# 206) BOL PK
206) 
keyword="BOL"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCV6-CUNsfe2-STYfYkd7bBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BOL PK" ;; 
# 207) Waqt News PK
207) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/waqtnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Waqt News PK" ;;   
# 208) Geo News PK
208) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/geonews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Geo News PK" ;;   

################# AFGHANISTAN ######################################
# 207) Lemar TV Afghanistan   *** REMOVE on next check
# 207)
# link=http://www.dailymotion.com/video/x5disog 
# use_cookies="no"
#chan_name="Lemar TV Afghanistan" ;; 

# 209)Tolo TV Afghanistan 
209)
link=http://www.dailymotion.com/video/x5dtety 
use_cookies="no"
chan_name="Tolo TV Afghanistan" ;; 
## 210) TOLO NEWS AFGHANISTAN
210) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TOLOnewsLive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="TOLO NEWS AFGHANISTAN";; 

################################## FARSI / PERSIAN  ###########################################################
# 211)  BBC Persian
211) 
keyword="پخش زنده"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/BBCPersian/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="BBC Persian";;
################## ARABIC  ##########################################
# 212) RT Arabic 
212) 
keyword="RT ARABIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/RTarabic/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
quse_cookies="no"
chan_name="RT Arabic" ;;
# 213) ON E Live 
213) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ONtveg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ON E";;
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
keyword="البث المباشر" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcGUVmG2x7hqwv6WMMW_6bA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Syrian Satellite" ;;     
# 221) ORTAS Syrian News 
221) 
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC8Wc4apR4Tx-N3h9CnPIDWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
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
# 245) CNN Turk 
245) 
keyword="CNN TÜRK CANLI YAYINI"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/cnnturk/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="CNN Turk";;
# 246) KRT Kulture TV
246) 
keyword="KRT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCVKWwHoLwUMMa80cu_1uapA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="KRT Kulture TV";;
# 247) Number 1 Ask 
247) 
keyword="Number1 Aşk"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Aşk Kanali";;
# 248) Number1 Dance Turk TV
248)
keyword="Number1 Dance"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Dance TV";;
# 249)Number1 TV Canlı Yayın
249)
keyword="Number1 Tv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 TV";;
# 250) Number1 Turk TV
250)
keyword="Türk Tv"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Türk TV";;
# 251) La Legul TV
251) 
keyword="Lâlegül TV Canlı Yayın Akışı"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC4oXxmnXX0EMlDCm18X2szw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="La Legul TV";;
# 252) TGRT Haber TV
252) 
keyword="TGRT Haber TV - Canlı Yayın - Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzgrZ-CndOoylh2_e72nSBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TGRT Haber TV";;
# 253) TVNET Canali Yayin
253) 
keyword="TVNET Canlı Yayın"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvnethaber/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVNET Canali Yayin";;
# 254) Show TV Turkey
254) 
keyword="Show"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ShowTVShowTV/videos?flow=grid&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Show TV Turkey" ;;
# 255) Number1 Turk FM
255)
keyword="Türk FM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 Turk FM";;
# 256) Number1 Radyo Canlı Yayın 
256)
keyword="1 FM"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG5ClB8btAurdKWaGksUV1A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Number1 FM Radyo Canlı Yayın";;
################### GREEK ######################################
## 257) Star Lamia
257) link=http://www.dailymotion.com/video/xqjey2_star-lamia-live-streaming_news
use_cookies="no"
chan_name="Star Lamia Greek" ;;
# 258) Blue Sky TV Athens Greece
258) 
keyword="BLUE SKY TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/blueskyathens/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Blue Sky TV Athens Greece";;
# 259) Action 24 Greece HD
259) 
link=http://www.dailymotion.com/video/x61fbhs
use_cookies="no"
chan_name="Action 24 Greece HD" ;;
######################## BROKEN for removal
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
# 260) SkyTG 24 Italian
260)
link=http://skyianywhere2-i.akamaihd.net/hls/live/200275/tg24/playlist.m3u8
use_cookies="no"
chan_name="Sky TG 24 Italian" ;;
# 261) Telecolor Lombardia Italy
261)
link=http://telecolor.econcept.it/live/telecolor.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Telecolor Lombardia" ;;
# 262) Cremona 1 Italy
262)
link=http://cremona1.econcept.it/live/cremona1_high.isml/manifest\(format=m3u8-aapl\).m3u8
use_cookies="no"
chan_name="Cremona 1 Italy" ;;
# 263) QVC Itallian
263) 
keyword="QVC in diretta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/qvcitalia/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC Italian" ;; 
################ SWISS
# 264) RSI LA CH
264)
link=http://www.filmon.com/tv/rsi-la-1
use_cookies="yes"
chan_name="RSI LA CH" ;;
# 265) SRF CH
265)
link=http://www.filmon.com/tv/srf-1
use_cookies="yes"
chan_name="SRF CH" ;;
################  Austria
# 266) W24 Wein Austria
266)
link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream3.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream1.m3u8
#link=http://ms01.w24.at/hls-live/livepkgr/_definst_/liveevent/livestream2.m3u8
use_cookies="no"
chan_name="W24 Wein, Austria" ;;
# 267) Austria 24
267)
#link=rtmp://streaming.austria24.tv/live/stream_360p
#link=rtmp://streaming.austria24.tv/live/stream_720p
link=rtmp://streaming.austria24.tv/live/stream_1080p
use_cookies="no"
chan_name="Austria 24" ;;
################  GERMAN   #######################################
# 268) WDR Germany
268)
link=http://wdr_fs-lh.akamaihd.net/i/wdrfs_weltweit@112033/master.m3u8
use_cookies="no"
chan_name="WDR Germany" ;;
# 269) Tirol TV German
269)
link=http://lb.hd-livestream.de:1935/live/TirolTV/playlist.m3u8
use_cookies="no"
chan_name="Tirol TV German" ;;
# 270)DW Deutsch Welle 
270) 
keyword="DW"
#link="http://dwstream6-lh.akamaihd.net/i/dwstream6_live@123962/master.m3u8"   
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/deutschewelle/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="DW Deutsch Welle";;
# 271) ZDK InfoKanal
271)
link=http://www.filmon.com/tv/zdf-infokanal
use_cookies="yes"
chan_name="ZDK InfoKanal Deutsch";;
# 272)  Tagessschau 24 Germany
272)
link=http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8
use_cookies="no"
chan_name="Tagessschau 24 Germany" ;;
# 273) EuroNews Deutsch
273) 
keyword="LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsde/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="EuroNews Deutsch" ;;
################## DUTCH
# 274)AT5 NETHERLANDS
274)
link=http://lb-at5-live.cdn.streamgate.nl/at5/video/at5.smil/playlist.m3u8
use_cookies="no"
chan_name="AT5 TV NETHERLANDS" ;;
################# Moldova
# 275) TV Publica Moldova
275)
link=http://livebeta.publika.md/LIVE/P/6810.m3u8
use_cookies="no"
chan_name="TV Publica Moldova" ;;
############# 
######################### UKRAINE  ##################################
# 276) UA TV Ukraine 
276) 
keyword="UATV"
link=https://ua-tv-hls3.cosmonova.net.ua/hls/ua-tv_ua_mid/index.m3u8
use_cookies="no"
chan_name="UA TV Ukraine" ;;
# 277) Thromadske Ukraine
277) 
keyword="#Громадське (Наживо)"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HromadskeTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Thromadske Ukraine" ;;
# 278) Еспресо Ukraine
278) 
keyword="Еспресо.TV - LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/espresotv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ecnpeco Ukraine" ;;
# 279) News 1 Ukraine
279) 
keyword="эфир NewsOne"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9oI0Du20oMOlzsLDTQGfug/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="News 1 Ukraine" ;;
# 280) Ukraine 112
280)
keyword="канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCu-YOzNvZpU6KRoSrgsru2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 112" ;;
################################ MENU 2 ########################################################
# 281) Ukraine Channel 5 
281) 
keyword="5.ua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/5channel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Ukraine 5" ;;
# 282) UA TV Ukraine Tartar
282) 
keyword="UATV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC-ni_mzd-eCHgkIMY2jOEoA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UA TV Qirimatarca Ukraine" ;;
############### RUSSIAN ################################
# 283)  Euronews Russian
283)
#link=http://evronovosti.mediacdn.ru/sr1/evronovosti/playlist.m3u8
link=http://evronovosti.mediacdn.ru/sr1/evronovosti/chunklist_b2658304.m3u8
use_cookies="no"
chan_name="Euronews Russian" ;;
# 284) Россия 24
284) 
keyword="24"
link=http://live.russia.tv/index/index/channel_id/3
#link=http://www.filmon.com/tv/rossiya-24
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
link=http://live.russia.tv/index/index/channel_id/199
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vestifm/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vesti FM Russia" ;;
# 289)  Current Time VOA
289)
keyword="НАСТОЯЩЕЕ ВРЕМЯ"
link=http://www.filmon.com/tv/current-time-tv
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/currenttimetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Current Time VOA" ;;
# 290) RTR Planeta
290)
link=http://live.russia.tv/index/index/channel_id/82
#link=http://www.filmon.com/tv/rtr-planeta
use_cookies="yes"
chan_name="RTR Planeta" ;;
# 291) Perviy Kanal Europa
291)
link=http://www.filmon.com/tv/perviy-kanal-europa
use_cookies="yes"
chan_name="Perviy Kanal Europa" ;;
# 292) Music Box Russia
292)
link=http://www.filmon.com/tv/music-box-russia
use_cookies="yes"
chan_name="Music Box Russia" ;;
# 293) Planeta Channel 4 Russia
293)
link=http://wse.planeta-online.tv:1935/live/channel_4/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 4 Russia" ;;
# 294) Planeta Channel 6 Russia
294)
link=http://wse.planeta-online.tv:1935/live/channel_6/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 6 Russia" ;;
# 295) POCCNR 1 HD RU
295)
link=http://live.russia.tv/index/index/channel_id/86
#link=http://live.russia.tv/index/index/channel_id/1
use_cookies="no"
chan_name="POCCNR 1 HD RU" ;; 
# 296) MOSCKVA 24 RU
296)
link=http://live.russia.tv/index/index/channel_id/76
#link=http://www.ontvtime.ru/live/moskva24.html
use_cookies="no"
chan_name="MOSCKVA 24 RU" ;; 
# 297) 5 RU
297)
keyword="Пятого канала"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGM8ZTtduKll7X8RiGe6N8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
#link=http://www.ontvtime.ru/general/channel5.html
use_cookies="no"
chan_name="5 Live RU" ;;
# 298) NTV RU
298)
link=http://www.ontvtime.ru/general/ntv-6.html
use_cookies="no"
chan_name="NTV RU" ;;
# 299)  TNT RU  
299)
link=http://www.ontvtime.ru/general/tnt.html
use_cookies="no"
chan_name="TNT RU" ;;
# 300)  POCCNR K RU
300)
link=http://www.ontvtime.ru/live/russiak-2.html
use_cookies="no"
chan_name="POCCNR K RU" ;;
# 301)  REN TV RU
301)
link=http://www.ontvtime.ru/general/rentv.html
use_cookies="no"
chan_name="REN TV RU" ;;
# 302)  Domanshiniy RU
302)
link=http://www.ontvtime.ru/general/domashniy.html
use_cookies="no"
chan_name="Domanshiniy RU" ;;
# 303)  TV3 RU
303)
link=http://www.ontvtime.ru/general/tv3.html
use_cookies="no"
chan_name="TV3 RU" ;;
# 304)  TVC RU
304)
link=http://www.ontvtime.ru/general/tvc.html
use_cookies="no"
chan_name="TVC RU" ;;
# 305)  OTR RU
305)
link=http://www.ontvtime.ru/live/otr.html
use_cookies="no"
chan_name="OTR RU" ;;
# 306)  Karusel RU
306)
link=http://www.ontvtime.ru/live/karusel-2.html
use_cookies="no"
chan_name="Karusel RU" ;;
# 307) Zvezda RU
307)
link=http://www.ontvtime.ru/live/zvezda.html
use_cookies="no"
chan_name="Zvezda RU" ;;
# 308) Muztv RU
308)
link=http://www.ontvtime.ru/live/muztv.html
use_cookies="no"
chan_name="Muztv RU" ;;
# 309) MIR RU
309)
link=http://www.ontvtime.ru/live/mir.html
use_cookies="no"
chan_name="MIR RU" ;;
# 310) ORT 3 RU
310)
link=http://www.ontvtime.ru/general/ort-3.html
use_cookies="no"
chan_name="ORT 3 RU" ;;

# 311)
# http://tv.life.ru/lifetv/720p/index.m3u8

############### Viet Nam  #####################################
# 312) VietTV VN
312)
link=http://www.filmon.com/tv/vtc-10
use_cookies="yes"
chan_name="VietTV VN" ;;
################# TAGALOG FILIPINO #############################       
# 313) DZMM ABS-CBN Philippeans Radio
313) 
keyword="DZMM Audio Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCs_VNu-FQ0WcJnD4QkmIL5w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZMM Philippeans" ;;
# 314) DZRH Philippeans
314) 
keyword="DZRH"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcTiBX8js_djhSSlmJRI99A/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DZRH Philippeans" ;;
# 315) PTV Philippines
315)
keyword="PTV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTVPhilippines/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"
chan_name="PTV Philippines";;
################ Indonesia  #########################################
# 316) Net TV Jakarta Indonesia
316) 
keyword="Net" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/NetTVInsight/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="yes"
chan_name="Net TV Jakarta Indonesia" ;;
###################   AFRICA    ##############################################
# 321) Channels 24 Nigeria
321) 
keyword="Channels Television"
#link=http://31.24.231.140/mchannels/channelstv.m3u8
#link=http://31.24.228.207:1935/live/smil:channelstv.smil/playlist.m3u8
#link=http://31.24.228.207:1935/live/mobile_240p/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/channelsweb/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"    
use_cookies="no"
chan_name="Channels 24 Nigeria";;
# 322)TVC News Nigeria
322) 
keyword="TVC News Nigeria"
#link=http://77.92.76.135:1935/tvcnews/livestream/playlist.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC News Nigeria";;
# 323) TVC Continental Nigeria
323) 
keyword="TVC Continental Nigeria"
link=http://77.92.76.135:1935/tvce/livestream/playlist.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgp4A6I8LCWrhUzn-5SbKvA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="TVC Continental Nigeria";;
# 324) NTV Uganda
324) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Uganda" ;; 
# 325)  KTN Kenya
325) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/standardgroupkenya/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KTN Kenya" ;; 
# 326) Joy News Ghana
326) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/myjoyonlinetube/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Joy News Ghana";;
# 327)  ADOM TV 
327) 
keyword="Adom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/adomtvtube/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ADOM TV Ghana" ;;    
# 328) Bukedde TV
328) 
keyword="Bukedde"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bukeddetv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Bukedde TV";;
# 329)Telefishinka Qaranka Somalia
329) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCi5fZhV7tPitSjnhEHJirGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Telefishinka Qaranka Somalia";;
# 330) EBC Ethiopia 
330) 
keyword="live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCOhrz3uRCOHmK6ueUstw7_Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="EBC Ethiopia";;
# 331) SPARK TV Uganda
331) 
keyword="TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvuganda/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SPARK TV Uganda" ;;  
# 332) Biafra TV Africa 
332) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCG1mxHbW_qvMfrNLj3D2ffA/videos?view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Biafra TV";;
# 333) Walf TV Senegal
333)  
link=http://www.dailymotion.com/video/x5s5vw3
use_cookies="no"
chan_name="Walf TV Senegal" ;; 
# 334) EriTV Eritrea
334)
link=http://www.filmon.com/tv/eri-tv
use_cookies="yes"
chan_name="EriTV Eritrea" ;;  
# 335) EbruTV Kenya  
335)
link=http://www.dailymotion.com/video/x67n3k1
use_cookies="no"
#format=hls-720
#format=hls-480
#format=hls-380
format=hls-240
chan_name="EbruTV Kenya" ;;
# 336)KTN Home Kenya
336)
link=http://www.dailymotion.com/video/x67ck0p
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="KTN Home Kenya" ;;
# 337)SABC Digital News South Africa
337) 
keyword="Newsroom"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sabcdigitalnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="SABC News South Africa" ;;  
# 338) Africa News Live
338)
keyword="africanews Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1_E8NeF5QHY2dtdLRBCCLA/videos?&view=2" |  grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Africa News English";;

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
# 364) WGN 9 Chicago   @
364) 
link=http://wgntribune-lh.akamaihd.net/i/WGNPrimary_1@304622/master.m3u8
use_cookies="no"
chan_name="WGN 9 Chicago" ;;
# 365) ABC News 9 Orlando 
365) 
link=http://cmghlslive-i.akamaihd.net/hls/live/224711/WFTV/master.m3u8
use_cookies="no"
chan_name="ABC News 9 Orlando" ;;
# 366) Fox News 10 Phoenix Arizona USA **** REMOVE
366) 
keyword="\:"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJg9wBPyKMNA5sRDnvzmkdg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fox News 10 Phoenix Arizona USA";; 
# 367) FOX 2 News KTVU  Bay Area
367) 
link=http://play-prod1.live.anvato.net/server/play/ktvutestctg/master.m3u8
use_cookies="no"
chan_name="Fox 2 News KTVU Bay Area" ;;
# 368) ATXN Austin Texas
368) 
link=http://oflash.dfw.swagit.com/livecc02/austintx/smil:atx-16x9-1-b/chunklist_w1826702480_b878000.m3u8
use_cookies="no"
chan_name="ATXN Austin Texas" ;;
# 369) Seminole TV Florida
369) 
link=http://video.seminolecountyfl.gov:1935/live/SGTV/chunklist.m3u8
use_cookies="no"
chan_name="Seminole TV (Florida)" ;;
# 370)The Florida Channel
370) 
#link=rtmp://webcasting.thefloridachannel.org/live/tvweb1
link=http://webcasting.thefloridachannel.org/live/tvweb1/playlist.m3u8
use_cookies="no"
chan_name="The Florida Channel" ;;
#################### NATIONAL / LOCAL Weather #####################################################
# 371) Weather Nation
371) 
link=http://cdnapi.kaltura.com/p/931702/sp/93170200/playManifest/entryId/1_oorxcge2/format/applehttp/protocol/http/uiConfId/28428751/a.m3u8
use_cookies="no"
chan_name="Weather Nation" ;; 
# 372) The Weather Channel
372)
link=http://weather-lh.akamaihd.net/i/twc_1@92006/master.m3u8
use_cookies="no"
chan_name="The Weather Channel" ;;
############################  TRANSIENT BROADCAST NEWS #############################################
# 373) CBS 2 News New York
373) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-wcbsx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 2 News New York" ;;
# 374) CBS 4 News Boston
374) 
link=http://cbslocaltv-i.akamaihd.net/hls/live/221461/WBZTV/master.m3u8
#link=http://54.163.107.81/server/play/cbslocal-wbzx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 4 News, WBZ, Boston, Massachusetts" ;;
# 375) WVIT 30 News Hartford
375) 
link=http://wvitlive-f.akamaihd.net/i/wvitb2_1@71164/master.m3u8
use_cookies="no"
chan_name="WVIT 30 News Hartford" ;;
# 376) NBC 10 News (Philadelphia)
376) 
link=http://wcaulive-f.akamaihd.net/i/wcaua1_1@13991/master.m3u8
use_cookies="no"
chan_name="NBC 10 News Philadelphia" ;;
# 377) CBS 3 News Michigan 
377) 
link=http://wjmn-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 3 News Michigan" ;;
# 378) CBS 2 Salt Lake City
378) 
link=http://ktvx-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 2 Salt Lake City" ;;
# 379) CBS 5 News Colorado/ FOX 4 Kansas 
379) 
link=http://krex-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="CBS 5 Colorado" ;;
# 380) NBC 11 Bay Area
380) 
link=http://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/index_1286_av-p.m3u8
use_cookies="no"
chan_name="NBC 11 Bay Area" ;;
# 381) CBS 13 News Stockton California USA
381) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kovrx-dfp/master.m3u8
use_cookies="no"
chan_name="CBS 13 News Stockton California USA" ;;
# 382) KCAL 9 News Los Angeles
382) 
link=http://play-prod1.live.anvato.net/server/play/cbslocal-kcal-dfp/master.m3u8
use_cookies="no"
chan_name="KCAL 9 News Los Angeles" ;;
# 383) WXXV25 24/7 Mississippi
383)
link=http://api.new.livestream.com/accounts/22998687/events/6864865/live.m3u8
use_cookies="no"
chan_name="WXXV25 24/7 Mississippi" ;; 
# 384) NBC News Channel 13 (WNYT-TV)
384)
link=http://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 WNYT-TV";;
# 385) NBC2 South West Florida
385)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NBC2swfl/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="NBC2 South West Florida" ;;  
# 386) WCCB Charlotte, South Carolina
386)
link=http://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB Charlotte, South Carolina" ;;
# 387)7 News (WHDH-TV) Boston
387)
link=http://bcoveliveios-i.akamaihd.net/hls/live/246496/4744899807001/livestream/master.m3u8
use_cookies="no"
chan_name="7 News (WHDH-TV) Boston" ;; 


################# EXTRA ###################################
# 401) WSJ Live
401)
link=http://wsjlivehls-lh.akamaihd.net/i/events1_1@174990/master.m3u8
use_cookies="no"
chan_name="WSJ Live" ;;
# 402) CNN Livestream 1
402)
link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253953/dotcomlive_1/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 1" ;;
# 403) CNN Livestream 2
403)
link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/index_Layer8.m3u8
#link=http://cnn-i.akamaihd.net/hls/live/253954/dotcomlive_2/master.m3u8
use_cookies="no"
chan_name="CNN Livestream 2" ;;
# 404) CPAC 2 Canada
404)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028033728001
use_cookies="no"
chan_name="CPAC 2 Canada" ;;
# 405) 
# 406) CNN America  
406)
#rnum=$( expr 1 + $RANDOM % 5 | awk '{print $1}' )
keyword="Live"
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/results?search_query=CNN" | grep "watch?v=" |  grep "$keyword" | head -n "$rnum" | tail -n 1 | cut -d \= -f 5 | cut -d \" -f 1)" 
link=http://cnn-lh.akamaihd.net/i/cnndebates_1@352100/master.m3u8
use_cookies="no"
chan_name="CNN Live" ;;
# 407) DVIDs TV
407) link=https://www.filmon.com/tv/dvids-tv
use_cookies="yes"
chan_name="DVIDs TV" ;;  
# 408)What America Thinks
408) link=https://www.filmon.com/tv/what-america-thinks
use_cookies="yes"
chan_name="What America Thinks" ;;  
# 409) NASA TV Public Education
409) 
keyword="NASA TV Public-Education"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Education" ;; 
# 410) NASA TV Media
410) 
keyword="Media"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/NASAtelevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="NASA TV Media" ;; 
# 411) C-SPAN 2 HD
411)
link="http://cspan2-lh.akamaihd.net/i/cspan2_1@304728/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan2nontve-lh.akamaihd.net/i/CSpan2NonTVE_1@312669/master.m3u8
use_cookies="no"
chan_name="C-SPAN 2 HD" ;;
# 412) C-SPAN 3 HD
412)
link="http://cspan3-lh.akamaihd.net/i/cspan3_1@304729/index_1000_av-p.m3u8?sd=10&rebase=on"
#link=http://cspan3nontve-lh.akamaihd.net/i/CSpan3NonTVE_1@312670/master.m3u8
use_cookies="no"
chan_name="C-SPAN 3 HD" ;;

# 413) Bloomberg Europe
413)
#link=https://www.bloomberg.com/live/europe
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_live.m3u8
#link=https://cdn-videos.akamaized.net/btv/zixi/fastly/europe/live/master.m3u8
#link=http://mediaeuwest.akamaized.net/eu/EU1000kb_live.m3u8
use_cookies="no"
chan_name="Bloomberg Europe" ;;
# 414) Bloomberg Asia
414)
#link=https://www.bloomberg.com/live/asia
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_live.m3u8
use_cookies="no"
chan_name="Bloomberg Asia" ;;

# 416) BYUTV International
416)
link=https://byubhls-i.akamaihd.net/hls/live/267282/byutvintport/master.m3u8
use_cookies="no"
chan_name="BYUTV International" ;;
#  417) Arirang Radio English 
417) 
keyword="Arirang"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Music180Arirang/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Arirang Radio English" ;;
# 418) HSN
418) 
keyword="Live Stream"
#link=http://hsn.mpl.miisolutions.net/hsn-live01/_definst_/smil:HSN1_ipad.smil/playlist.m3u8
#link=http://hsn.mpl.miisolutions.net:1935/hsn-live01/_definst_/mp4:468p500kB31/playlist.m3u8
link=https://www.youtube.com"$(curl "https://www.youtube.com/user/hsntv/videos?&view=2" | grep "$keyword" | awk ' BEGIN { RS= ":"}{ print}' | grep "watch?v=" | head -n 1 | cut -d \" -f 2)" 
use_cookies="no"
chan_name="Home Shopping Network HSN" ;;
# 419) HSN 2
419) 
keyword="HSN2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCtliQPtWcZSgYkYS70vRrzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="HSN2" ;;
# 420)  QVC 
420) 
keyword="QVC Live Stream"
link=http://qvclvp2.mmdlive.lldns.net/qvclvp2/9aa645c89c5447a8937537011e8f8d0d/manifest.m3u8
#link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/QVC/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="QVC English" ;;
# 421) The Shopping Channel TSC
421)
link=http://tscstreaming-lh.akamaihd.net/i/TSCLiveStreaming_1@91031/index_3_av-p.m3u8
use_cookies="no"
chan_name="The Shopping Channel TSC" ;;
# 422)  CTV NEWS Canada
422)
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
# 423) CPAC 3 Senate Canada
423)
link=http://players.brightcove.net/1242843915001/SJ3Tc5kb_default/index.html?videoId=5028075832001
use_cookies="no"
chan_name="CPAC 2 Senate Canada" ;;
#################### TRANSIENT ######################################## 
# 424) RUPTLY
424) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl "https://www.youtube.com/user/RuptlyTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="RUPTLY" ;;  
# 425) Made in Leeds
425)
link=http://www.dailymotion.com/video/x5eva58
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Leeds" ;;
# 426) Made in Tyne
426)
link=http://www.dailymotion.com/video/x5eva8m
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Tyne" ;;
# 427) Made in Cardiff
427)
link=http://www.dailymotion.com/video/x5ev9xg
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="Made in Cardiff" ;;
# 428) Saudi 2 TV
428)
keyword="Saudi 2"
link=https://www.filmon.com/tv/saudi-arabian-tv-2
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/index.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/1.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/2.m3u8
#link=http://wpc.55d6d.deltacdn.net/3055D6D/teb002/55D6D-channel2/3.m3u8
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SaudiChannel2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="yes"
chan_name="Saudi 2 English" ;;   
# 429) Bloomberg Australia
429)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/aus_live.m3u8
use_cookies="no"
chan_name="Bloomberg Australia" ;;
# 430) Bloomberg US Politics
430)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_politics.m3u8
use_cookies="no"
chan_name="Bloomberg US Politics" ;;
# 431) Bloomberg Live Event
431)
link=https://liveproduseast.global.ssl.fastly.net/btv/desktop/us_event.m3u8
use_cookies="no"
chan_name="Bloomberg US Live Event" ;;
# 432) Bloomberg EU Live Event
432)
link=https://liveprodeuwest.global.ssl.fastly.net/btv/desktop/eu_event.m3u8
use_cookies="no"
chan_name="Bloomberg EU Live Event" ;;
# 433) Bloomberg Asia Live Event
433)
link=https://liveprodapnortheast.global.ssl.fastly.net/btv/desktop/ap_event.m3u8
use_cookies="no"
chan_name="Bloomberg Asia Live Event" ;;



######################## PODCAST ###########################################
# 437) PBS NewsHour Video
437) 
keyword="PBS NewsHour"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PBSNewsHour/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="PBS NewsHour Video" ;;   
# 438)  CBC The National
438) 
keyword="The National"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/CBCTheNational/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 2 | tail -n 1| cut -d = -f 12 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="CBC The National" ;; 
# 439) AP Top Stories
439) 
keyword="Top"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AssociatedPress/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="AP Top Stories" ;;    
# 440) Democracy Now Headlines 
440) 
keyword="Headlines"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/democracynow/videos" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Democracy Now Headlines" ;;   

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
link=http://ooyalahd2-f.akamaihd.net/i/globalradio01_delivery@156521/master.m3u8
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
# 449) О2 ТВ Russia
449)
link=http://hls.mycdn0633430096.cdnvideo.ru/mycdn0633430096/stream1_sd.sdp/playlist.m3u8
use_cookies="no"
chan_name="O!2 TB Russia" ;;
# 450) MTV AM Russia
450) 
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
# 451) DJING Animation HD 
451) 
link=http://www.djing.com/tv/a-05.m3u8
use_cookies="no"
chan_name="DJING Animation HD" ;;
# 452) DJING Classic HD 
452) 
link=http://www.djing.com/tv/i-05.m3u8
use_cookies="no"
chan_name="DJING Classic HD" ;;
# 453) DJING Dancefloor HD
453) 
link=http://www.djing.com/tv/d-05.m3u8
use_cookies="no"
chan_name="DJING Dancefloor HD" ;;
# 454)DJING Underground HD
454) 
link=http://www.djing.com/tv/u-05.m3u8
use_cookies="no"
chan_name="DJING Underground HD" ;;
# 455)M2O Music
455) 
link="http://m2otv-lh.akamaihd.net/i/m2oTv_1@186074/index_600_av-b.m3u8"
use_cookies="no"
chan_name="M2O Music" ;;
# 456) Virgin 1
456)
#link=http://wow01.105.net/live/virgin1/chunklist.m3u8   
link=http://wow01.105.net/live/virgin1/playlist.m3u8  
use_cookies="no"
chan_name="Virgin 1" ;;
# 457) Virgin Music 2
457)
link=rtmp://fms.105.net:1935/live/virgin2
use_cookies="no"
chan_name="Virgin Music 2" ;;
# 458) Clubbing TV
458) 
link=http://stream01.yamgo.com/iPhone/HLS_TS/mptslive/clubbingtv-mobile.3gp.m3u8  
use_cookies="no"
chan_name="Clubbing TV" ;;  
# 459) Radio Monte Carlo RMC
459)
link=rtmp://fms.105.net:1935/live/rmc1
use_cookies="no"
chan_name="Radio Monte Carlo" ;; 
# 460) KPOP IDOL
460) 
keyword="KPOP" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/user/imbcevery1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KPOP IDOL" ;;
#################### REALITY / LIVE ACTION #########################
#  461) Adult Swim 
461) 
link=http://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
use_cookies="no"
chan_name="Adult Swim" ;;
# 462) Insight TV
462)
link=http://ooyalahd2-f.akamaihd.net/i/intv02_delivery@346464/master.m3u8
use_cookies="no"
chan_name="Insight TV" ;;
# 463) Yes TV
463)
link=http://hlslive.lcdn.une.net.co/v1/AUTH_HLSLIVE/YES/tu1_1.m3u8
use_cookies="no"
chan_name="Yes TV" ;;
# 464) Smile of a Child
464)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN04_delivery@186242/index_1164_av-b.m3u8
use_cookies="no"
chan_name="Smile of a Child" ;;
################################################################################
##################### ANIMATION ############################## 
# 465) PJ Masks
465) 
keyword="PJ" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCY2jUnU118sVkdj2xafiJ0g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PJ Masks" ;;
# 466) Talking Tom and Friends
466) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingFriends/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom and Friends" ;;
# 467) Talking Tom and Friends Minis
467) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TalkingTomCat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Talking Tom Minis" ;;    
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
# 470) Jasmin TV
470) 
link=http://109.71.162.112:1935/live/hd.jasminchannel.stream/PAZ_Chega_de_Guerras.m3u8 
use_cookies="no"
chan_name="Jasmin TV" ;;  
# 471) The Young Turks
471)
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheYoungTurks/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TYT The Young Turks" ;; 
# 472) DMC Sports
472) 
keyword="SPORTS" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA"  "https://www.youtube.com/channel/UCiR6nRlvEBWVHPsJRXiCyyg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="DMC Sports" ;;
# 473) Pitchoun FR
473)
link=https://www.dailymotion.com/video/x5zaibr 
use_cookies="no"
chan_name="Pitchoun FR" ;;
# 474) NRJ Hits Francais
474)
link=http://5.196.138.6:1935/live/nrjbelgique/chunklist_w1339281553.m3u8   
use_cookies="no"
chan_name="NRJ Hits Francais" ;;
# 475) Steven Universe 
475)
link=https://live.ponies.fr/hls/sug-hd/sug.m3u8
use_cookies="no"
chan_name="Steven Universe" ;;
# 476) Nature Vision
476)
link=https://hlsdpi-cdn-as4.totalstream.net/dpilive/vidilliontv/vtv/ntrnaturevision/playlist.m3u8
use_cookies="no"
chan_name="Nature Vision" ;;
# 477) Pursuit Channel
477)
link=https://hlsdpi-cdn-as4.totalstream.net/dpilive/vidilliontv/vtv/pursuitlive/playlist.m3u8
use_cookies="no"
chan_name="Pursuit Channel" ;;
# 478) Music Vox TV Old's Cool
478)
link=http://stream.cdn.smcloud.net/vox-t/vox_720p/playlist.m3u8
use_cookies="no"
chan_name="Music Vox TV " ;;
# 479) H!T Music Channel
479)
link=http://1mstream.digicable.hu/hitmusic/hitmusic.m3u8
use_cookies="no"
chan_name="H!T Music Channel" ;;
# 480) Now Music TV
480)
link=http://live.aatw.simplestreamcdn.com/now/live.m3u8
use_cookies="no"
chan_name="Now Music TV" ;;





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
# 463) 
#link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/toonami.m3u8
# use_cookies="no"
# chan_name="Toonami" ;;
# London Live 
# 460)
# link=http://bcoveliveios-i.akamaihd.net/hls/live/217434/3083279840001/master_900.m3u8
# use_cookies="no"
# chan_name="London Live" ;;
# dult Swim Animated Marathon 
# 464) 
# link=http://amd.cdn.turner.com/adultswim/big/streams/playlists/animated-marathon.m3u8
# use_cookies="no"
# chan_name="Adult Swim Animated Marathon" ;;

#  Mello TV English Jamaica
# 470)  
#link=http://mellotvnew.tulix.tv/live/smil:mellotv.smil/chunklist_w1010732594_b1128000_sleng.m3u8
#use_cookies="no"
#chan_name="Mello TV English Jamaica" ;; 
########################  RELIGIOUS PROGRAMMING   ############################
# 481) Vatican Media 
481) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vatican/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Vatican Media" ;;
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
# 489) KtO Catholique
489)
link=http://livehdkto-lh.akamaihd.net/i/LiveStream_1@178944/master.m3u8
use_cookies="no"
chan_name="KtO Catholique" ;;
# 490) CBN
490)
link=http://bcliveuniv-lh.akamaihd.net/i/iptv1_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN" ;;
# 491)CBN News
491)
link=http://bcliveuniv-lh.akamaihd.net/i/news_1@194050/master.m3u8
use_cookies="no"
chan_name="CBN News" ;;
# 492)NRB Network
492)
link=http://uni6rtmp.tulix.tv/nrbnetwork/myStream.sdp/playlist.m3u8
use_cookies="no"
chan_name="NRB Network" ;;
# 493) The Church Channel
493)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/index_1728_av-p.m3u8
use_cookies="no"
chan_name="The Church Channel" ;;
# 494) TBN
494)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN01_delivery@186239/master.m3u8
use_cookies="no"
chan_name="TBN" ;;
# 495)GOD TV (USA) 
495) 
link=http://ooyalahd2-f.akamaihd.net/i/godtv01_delivery@17341/master.m3u8
use_cookies="no"
chan_name="GOD TV (USA)" ;;
# 496) Amazing Facts TV (Christian)
496) 
keyword="AFTV"
#link=http://amazingfacts.live-s.cdn.bitgravity.com/cdn-live/_definst_/amazingfacts/live/feed01/chunklist_w1921345467.m3u8
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/AmazingFacts/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Amzaing Facts TV (Christian)" ;;
# 497) It's Supernatural! Network (Christian)
497) 
keyword="Supernatural"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/SidRoth/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="It's Supernatural! (Christian)" ;;
# 498) Sheppard's Chapel (Christian)
498) 
keyword="Chapel"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheShepherdsChapel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Sheppard's Channel" ;;
# 499) International House of Prayer (IHOP) (Christian)
499) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/IHOPkc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="International House of Prayer (Christian)" ;;
# 500) Belivers Voice of Victory Network
500) 
keyword="Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCvYVGf_JFME9dVe3WtljP1Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Belivers Voice of Victory Network" ;;
# 501) Three Angels BroadCasting
501) 
keyword="Three Angels"
#link=http://moiptvus-lh.akamaihd.net:80/i/3abnlive_1@328342/index_800_av-p.m3u8 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3ABNVideos/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Three Angels Broadcasting Network" ;; 
# 502) 3ABN Latino
502)  
keyword="3ABN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/3abnlatino/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="3ABN Latino" ;; 
# 503)Logos TV Espanol
503)  
keyword="Logos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_L2lcJZlQ8oHQMgUNNDb-w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Logos TV Espanol" ;;  
# 504) Salt and Light TV Portage Michigan
504) 
keyword="Salt"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCS1_M4LZ3o3gNmfKbZX6QGw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Salt and Light TV Portage Michigan" ;; 
# 505) LLBN TV
505) 
keyword="LLBN Christian TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/LLBNChristianTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="LLBN TV" ;; 
# 506) Rap Resurrection
506)
link=http://edge2.tikilive.com:1935/unrestricted_tikilive/36008/amlst:amKEQ2Y2gYN4/playlist.m3u8
use_cookies="no"
chan_name="Rap Resurrection";;
# 507) Hillsong Channel
507)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN02_delivery@186240/master.m3u8
use_cookies="no"
chan_name="Hillsong Channel" ;;
# 508) Al Fady TV Arabic
508) 
keyword="قناة الفادى الفضائية | قناة"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6CtFtvwAWQBLt3dx9l7arg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Fady TV Arabic" ;; 
# 509) Aghapy TV
509) 
keyword="Aghapy TV Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC97YtaFaO3lUTcG4dCmgr5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aghapy TV" ;; 
# 510) St. Marys Coptic
510) 
keyword="Live Streaming"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHbwJUahgtOKHI3e-AHdZDg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="St. Marys Coptic" ;; 
# 511) Word of God Greek
511) 
keyword="Word"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WordofGodGreece/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Word of God Greek" ;; 
# 512) Heaven TV
512) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCl4i7ZkqmgN2hQyRF4m2fWA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Heaven TV" ;; 
# 513) Rakshana TV
513) 
keyword="Rakshana TV Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/jakkulaBenhur/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rakshana" ;; 
# 514) Powervision TV
514) 
keyword="POWERVISION"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCzxfpzSF7mz8j7bNIXyZWmA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Powervision TV" ;; 
# 515) KJV Audio
515) 
keyword="KJV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/TheTwoPreachers/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="KJV Audio Bible" ;; 
# 516) Harbor Light Radio
516) 
keyword="Harbour Light Radio Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoGlUDLHffMYyJBD4j3zeDw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Harbor Light Radio" ;; 
# 517) JUCE TV
517)
link=http://acaooyalahd2-lh.akamaihd.net/i/TBN03_delivery@186241/index_1728_av-p.m3u8
use_cookies="no"
chan_name="JUCE TV" ;;
# 518) Temple Institute
518) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/henryporter2/videos" | grep "Weekly Torah" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Temple Institute" ;;
# 519) Jewish Life TV (USA)
519) 
link=http://52.40.109.131:1935/rtplive/smil:jltv.smil/playlist.m3u8
use_cookies="no"
chan_name="Jewish Life TV (USA)" ;;
# 520)Quran English Arabic
520) 
keyword="Quran Hidayah"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCUeQpcsP49uq4_mjif8r7w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Quran English Arabic" ;; 

###################  MIXER    ###################
# 521) Vatican Media English
521) 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxIsefyl9g9A5SGWA4FvGIA/videos" |  grep "$keyword" | grep "watch?v=" |  head -n 1 | cut -d / -f 2 | cut -d \" -f 1 | cut -d = -f 2 )" 
use_cookies="no"
chan_name="Vatican Media English" ;;

# 522)  DW Deutsch +     GEOregion blocked
522) 
link="http://dwstream5-lh.akamaihd.net/i/dwstream5_live@124540/master.m3u8" 
use_cookies="no"
chan_name="DW Deutsch +" ;;

# 525) STerkTV Zindi  **
525) 
keyword="STERKTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCryT-WzqeUhxKULlUAB8vVg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="STerk TV Zindi";;
# 526) Ronahi TV Zindi **
526) 
keyword="RonahiTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmtlDLeUrnSviATaoHPWGnw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Ronahi TV Zindi";; 
# 527) KNBC 4 News (Los Angeles)
527) 
link=http://knbclive-f.akamaihd.net/i/knbca1_1@13988/index_1286_av-p.m3u8
use_cookies="no"
chan_name="KNBC 4 News Los Angeles" ;;
# 528) ABC 3 News Louisiana
528) 
link=http://ktbs-lh.akamaihd.net/i/KTBS_1069@111925/master.m3u8
use_cookies="no"
chan_name="ABC 3 News (Louisiana)" ;;
# 529) WPLG 10 News Miami
529) 
link=http://play-prod1.live.anvato.net/server/play/pns-wplg-dfp/master.m3u8
use_cookies="no"
chan_name="WPLG 10 News Miami" ;;
# 530) WJXT News 4 Jacksonville
530) 
link=http://play-prod1.live.anvato.net/server/play/pns-wjxt-dfp/master.m3u8
use_cookies="no"
chan_name="WJXT News 4 Jacksonville" ;;
# 531) NBC 6 South Florida (WTVJ-TV)
531)
link=http://wtvjlive-f.akamaihd.net/i/wtvja1_1@19309/master.m3u8
use_cookies="no"
chan_name="NBC 6 South Florida WTVJ";;
# 532) WBLZ Bangor Maine
532)
link=http://wlbz-lh.akamaihd.net/i/WLBZ_Live_1@27474/master.m3u8
use_cookies="no"
chan_name="WLBZ Bangor Maine" ;; 
# 533) Euronews Francais
533) 
keyword="euronews"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewsfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="Euronews Francais" ;;  
# 534)TTB Network
534)
link=http://www.dailymotion.com/video/x14tgdi
use_cookies="no"
format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="TTB Network" ;;
# 535) Vatican Media Deutsch
535)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticande/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Deutsch" ;; 
# 536) Vatican Media Italiano
536)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanit/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media Italiano" ;; 
# 537) OIreachtas TV IE
537)    
link=https://media.heanet.ie/oirlive/oireachtas/ngrp:oireachtas.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Oireachtas TV IE" ;; 
# 538) RTE News NOW
538)    
link=http://wmsrtsp1.rte.ie/live/android.sdp/playlist.m3u8
use_cookies="no"
chan_name="RTE News NOW" ;; 
# 539) Dail Eireann IE
539)    
link=https://media.heanet.ie/oirlive/dail/ngrp:dail.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Dail Eireann IE" ;; 
# 540) Senad Eireann IE
540)    
link=https://media.heanet.ie/oirlive/seanad/ngrp:seanad.stream_all/playlist.m3u8
use_cookies="no"
chan_name="Senad Eireann IE" ;; 
# 541) India TV IN
541)    
link=http://indiatvnews-lh.akamaihd.net/i/ITV_1@199237//master.m3u8
use_cookies="no"
chan_name="India TV IN" ;; 
# 542) BSC 24 1
542) 
keyword="BSC24-第1"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/bousaishare/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 1" ;; 
# 543) BSC 24 2
543) 
keyword="BSC24-第2"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCeEkbpBLgTEHy9NP-JHnPYQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="BSC 24 2" ;; 
# 544) Earthquake 24  
544) 
keyword="地震監視・24時間LIVE" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCmw7DsSCQzRcRG6-SHE_ksg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Earthquake 24" ;; 


###################  MENU 3   #####################################
########### TELEVISIA REGIONALES MEXICO
# 561) Televisa Gudalajera Mexico
561)  
keyword="guadalajara"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisaguadalajara.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Gudalajera Mexico" ;; 
# 562) Televisia Acapuloco Mexico
562)  
keyword="acapulco"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvacapulco.tv/video-en-vivo 
use_cookies="no"
chan_name="Televisia Acapulco Mexico" ;; 
# 563) Televisia Puebla Mexico
563)  
keyword="puebla"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisapuebla.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Puebla Mexico" ;;  
# 564) Televisia Sonora Mexico
564)  
keyword="sonora"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisahermosillo.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Sonora Mexico" ;;  
# 565) Televisia Toluca Mexico
565)  
keyword="toluca"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvedomex.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Toluca Mexico" ;;  
# 566) Televisia Veracruz Mexico
566) 
keyword="veracruz"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.televisaveracruz.tv/video-en-vivo 
use_cookies="no" 
chan_name="Televisia Veracruz Mexico" ;; 
# 567) Televisia Cuernavaca Mexico
567)  
keyword="cuernavaca"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvmorelos.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Cuernavaca Mexico" ;;   
# 568) Televisia Torreon Mexico
568)  
keyword="torreon"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvlaguna.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Torreon Mexico" ;; 
# 569) Televisia Queretaro Mexico
569)  
keyword="queretaro"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Queretaro Mexico" ;; 
# 570) Televisia Aguascalientes Mexico
570)  
keyword="aguascalientes"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Aguascalientes Mexico" ;; 
# 571) Televisia Matamoros Mexico
571)  
keyword="matamoros"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Matamoros Mexico" ;; 
# 572) Televisia Monterrey Mexico
572)  
keyword="monterrey"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Monterrey Mexico" ;; 
# 573) Televisia Chihuahua Mexico
573)  
keyword="chihuahua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Chihuahua Mexico" ;; 
# 574) Televisia Mexicali Mexico
574)  
keyword="mexicali"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Chihuahua Mexico" ;; 
# 575) Televisia Tijuana
575)  
keyword="tijuana"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Tijuana Mexico" ;; 
# 576) Televisia Del Golfo
576)  
keyword="golfo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Del Golfo Mexico" ;; 
# 577) Televisia Zacatecas
577)  
keyword="zacatecas"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_mU_-rhq4phlXCNbZfFezw/videos?flow=list&sort=dd&live_view=501&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
#link=http://www.galatvqueretaro.tv/video-en-vivo  
use_cookies="no"
chan_name="Televisia Zacatecas Mexico" ;; 
####################################
# 578) Noticiero Univision MX
578)  
keyword="Noticiero"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UnivisionNoticias/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 12 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Noticiero Univision MX" ;;
# 579) 

# 580) VTV VE
580) 
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/MultimedioVTV/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VTV VE" ;;
# 581) VIVE Venezuela
581) 
keyword="VIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCg6uD_hL72AFeZuMJL5u07w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="VIVE Venezuela" ;;
# 582) Vatican Media
582)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanes/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
# 583) Televen 
583) 
keyword="Televen EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcNva2dC9BR8QR_G02xDFqw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Televen Venezuela" ;;
# 584) Impacto USA 
584)
keyword="EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/impactotv2/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Impacto USA" ;;
# 585) JN19 Telejuan Peru Catolica   
585)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canaljn19tv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="JN19 Telejuan Peru Catolica" ;;

# 586) Euronews Espanol
586)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewses/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Euronews Espanol" ;;  
# 587) UCVTV CL  Universidad Católica de Valparaíso
587)  
keyword="UCVTV EN VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/UCVTVONLINE/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UCVTV Chile" ;;
# 588) Canal 2 Cablenet San Vicente Argentina  
588)
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC6y6nCxdSnkIsQTbfO-AvBw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no" 
chan_name="Canal 2 CABLENET San Vicente Argentina" ;;
# 589) 
# 590) Canal 8 Mar del Plata
590) 
keyword="Plata"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCY0QZk2M_ZZi95S-MN1Zndg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"  
use_cookies="no"  
chan_name="Canal 8 Mar del Plata Argentina" ;; 
# 591) Canal 11 de Salta Argentina
591)  
keyword="Salta"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCy-r-BQ5BQRU6rzGS73-WBQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Canal 11 de Salta Argentina" ;;  
# 592) UNITVE AR  Universidad Nacional de Villa Maria, Córdoba ***
592) 
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_NtgyVHyQJfy3YlM6XdQdw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="UNITVE Cordoba AR" ;;
################## PARAGUAY #####################################
# 593) ABC TV Paraguay   ****
593)  
keyword="ABC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/canalabctv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="ABC TV Paraguay" ;;
################# BOLIVIA #####################################
# 594) Abya Yala Bolivia  ****
594)  
keyword="Abya Yala"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYVYGzj8t64hFAz2T-udG5Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Abya Yala Bolivia" ;;
# 595) UFRO Vision Chile *****
595)  
keyword="UFRO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC5H9zdp-3M24xWWJunhLJmQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UFRO Vision Chile" ;;  
# 596) CAMPO ABIERTO Santiago Chile
596) 
keyword="ABIERTO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCp7fI6azkQdBmsrdrrWphbw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="CAMPO ABIERTO Santiago Chile" ;;
# 597) TV Regional Chihuahua
597)
keyword="Chihuahua"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaWbH7M8-lRPwysXKVs_Odw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Regional Chihuahua Mexico" ;;
# 598) Argentiisima Satelital Argentina
598)  
keyword="Argentinisima"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/argentinisimasat/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Argentinisima Satelital Argentina" ;;  
# 599) UNITV Universidad Nacional de General Sarmiento AR
599)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWCJwDsCdRn_pwHNpLwEJcw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="UNITV Universidad Nacional de General Sarmiento AR" ;;  
# 600) TelePacifico Colombia
600) 
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCpywwd47pfQSwBO8pXZwXrw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TelePacifico Colombia" ;; 

######################## Portuguese #########################
# 601) Euronews Portugues
601)
keyword="euronews em"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/euronewspt/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Euronews Portugues" ;;
################ BRAZIL   ################################
# 602) TV Assemblelia BR
602)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCIxlLEYzjWPLb_CXpc-e74w/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Assemblelia" ;;
# 603) TV Canaco Nova
603)
keyword="Ao Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/tvcancaonova/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Canaco Nova" ;;
# 604) TV Igreja Internacional de Graca
604)
keyword="ao vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC_hwWljVyb_o3yzasx-bG2g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Igreja Internacional de Graca" ;;
# 605) TV Ales Assembleia Legeslativa
605)
keyword="Ales"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/alescomunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="TV Ales Assembleia Legeslativa" ;;
# 606) TV Boas Nova
606)
keyword="Play"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/boasnovasoficial/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Boas Nova" ;;
# 607) Fundacao Nazzare de Communicaco
607)
keyword="VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/FNComunicacao/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Fundacao Nazzare de Communicaco" ;;
# 608) STF Brazil
608)  
keyword="TV JUSTIÇA – AO VIVO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="STF Brazil" ;;  
# 609) TV Estúdio Brasil
609)
link=http://stmv2.srvstm.com:1935/tvestudiobrasil/tvestudiobrasil/playlist.m3u8 
use_cookies="no"
chan_name="TV Estúdio Brasil" ;;
# 610) Rádio Justiça - Ao Vivo  
610)  
keyword="Rádio Justiça"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/STF/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Radio Justicia" ;;  
# 611) EXA FM 93.9
611)  
keyword="EXA FM 93.9"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCWWzGVZpJsQpFYGrMTGuZcg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="EXA FM 93.9" ;; 
# 612) RIT TV BR
612)  
keyword="RIT"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCA0bOG0NUfJ855eDtHSxOkw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="RIT TV BR" ;; 
# 613) Vatican Media
613)  
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCGYSq4b4DXmtK4jyq6r-FYg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Vatican Media" ;; 
# 614) Venevision VE
614)  
keyword="Emisión"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/noticierovenevision/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Venevision VE" ;; 
# 615) Telediario AR  
615)  
keyword="en directo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC1-SmZtkXTg2ufhLMpwiRIg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="Telediario AR" ;;
# 616) TVeo Canal 41 Cordoba AR
616)  
keyword="Vivo"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC9kgE-365dvz6zJEUX1dFiw/?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"   
use_cookies="no"
chan_name="TVeo Canal 41 Cordoba AR" ;; 
# 618) PSN Tijuana Mexico
618) 
keyword="PSN"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/psntv1/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="PSN Tijuana Mexico";; 

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

#######################################################################################################
# 641) OnTV Hong Kong
641) 
keyword="東網直播"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCZ79ABUb7OO4iMiNK2QPM7g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="OnTV Hong Kong";;
# 642) Planeta Channel 2 Russia
642)
link=http://wse.planeta-online.tv:1935/live/channel_2/chunklist.m3u8
use_cookies="no"
chan_name="TBTYP TV Planeta Channel 2 Russia" ;;
# 643) Planeta Channel 3 Russia
643)
link=http://wse.planeta-online.tv:1935/live/channel_3/chunklist.m3u8
use_cookies="no"
chan_name="Planeta Channel 3 Russia" ;;
# 644) CRIME DISTRICT Francais
644)
link=http://live-s102.abweb.com/liveabs102/ngrp:crimedistrict.stream_bis/chunklist_wf1tv_b1096000.m3u8   
use_cookies="no"
chan_name="CRIME DISTRICT Francais" ;;
# 645) MANGAS Francais
645)
link=http://live-trl102.abweb.com/liveabtrl102/ngrp:mangas.stream_bis/playlist.m3u8 
use_cookies="no"
chan_name="MANGAS Francais" ;;
# 646) ANIMAUX Francais
646)
link=http://live-s102.abweb.com/liveabs102/ngrp:animaux.stream_bis/playlist.m3u8 
use_cookies="no"
chan_name="ANIMAUX Francais" ;;
# 647) Tout L'Histoire
647)
link=http://live-s101.abweb.com/liveabs101/ngrp:toutelhistoire.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="Tout L'Histoire" ;;
# 648) ACTION Francais
648)
link=http://live-s101.abweb.com/liveabs101/ngrp:action.stream_bis/playlist.m3u8  
use_cookies="no"
chan_name="ACTION Francais" ;;
# 649) Vatican Media  
649) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/vaticanfr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Vatican Media" ;;  
# 650) TV 7 Francais
650)  
link=http://tv7.hdr-tv.com:1935/live/tv7/livestream/playlist.m3u8
use_cookies="no"
chan_name="TV 7 Francais" ;;  
# 651) LCP Assemblee National France
651)
link=http://www.dailymotion.com/video/xji3qy
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="LCP Assemblee National France" ;;
# 652) Public Senate France
652)
link=http://www.dailymotion.com/video/xkxbzc
use_cookies="no"
#format=hls-720
format=hls-480
#format=hls-380
#format=hls-240
chan_name="Public Senate France" ;;
# 653) RTL En direct
653) link=https://www.dailymotion.com/video/xl1km0_regardez-rtl-en-direct-et-en-video_news
# link=http://www.dailymotion.com/video/xl1km0
use_cookies="no"
format=hls-1080
#format=hls-720
#format=hls-480
chan_name="RTL En Direct" ;;
# 654) France Inter
654) 
keyword="France Inter en direct"
link=https://www.dailymotion.com/video/x17qw0a_video-regardez-france-inter-en-direct_newsc
format=hls-720
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/videofranceinter/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"  
use_cookies="no"
chan_name="France Inter" ;; 
################################################################################## 
# 655) 24 News Pakistan HD  
655) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcmpeVbSSQlZRvHfdC-CRwg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="24 News Pakistan HD" ;; 
# 656) Image Channel IN
656) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ImgTVchannel/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Imaage Channel IN" ;;  
# 657) AP1 Nepal
657) 
keyword="AP1 Nepal"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCxwa4RK4FCq-1LR5l5Dh8vA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="AP1 Nepal" ;;  
# 658) Somoy TV Bangladesh
658) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCNUFterLJ9vpFZZ0try7sLA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Somoy TV Bangladesh" ;;  
# 659) Ekattor TV 
659) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCFwJjZhRys6yvPP8e7_Wxzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Ekattor TV" ;;  
# 660) Rtv 
660) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCR0hSGudjeZfnGL3uodU9Sw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Rtv" ;;  
# 661) PTTV Puthiya Thalaimurai IN
661) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/PTTVOnlineNews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PTTV Puthiya Thalaimurai IN" ;;  
# 662) PAK News PK
662) 
keyword="Watch"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCz2yxQJZgiB_5elTzqV7FiQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PAK News PK" ;;  
# 663) Aaj Tak TV IN
663) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/aajtaktv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aaj Tak TV IN" ;;  
# 664) Aaj News PK
664) 
keyword="Live"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCdHy-hnyIEZBHkPJecz9RtA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Aaj News PK" ;;  
# 665) 919 FM TV Trinidad 
665) 
keyword="919 fm"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCD-Z-JAX2s3mUgs0rOmZFKQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="919 FM TV Trinidad" ;; 
# 666) 
# 667) Kalaignar News
667) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCcVF2Fth-qEA4T1Lhn3CgKg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 ) " 
use_cookies="no"
chan_name="Kalaignar News" ;;
# 668) 1TV Afghanistan
668)
link=http://www.dailymotion.com/video/x63qpkr
use_cookies="no"
#format=hls-720
#format=hls-480
format=hls-380
#format=hls-240
chan_name="1TV Afghan" ;;
# 669) Arirang News 
669) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangnews/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang News TV" ;; 
# 670) Arirang TV Korean 
670) 
keyword="Arirang TV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/arirangkorean/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Arirang TV Korean" ;; 
## 
# 671) RMC INFO TALK SPORT RADIO FRANCE
671) 
### 
link=https://players.brightcove.net/876630703001/SkKvZlxI_default/index.html?videoId=2623007265001
use_cookies="no"
chan_name="RMC INFO TALK SPORT France" ;;
# 672) CNEWS France
672)
link=http://www.dailymotion.com/video/x3b68jn
# link=http://www.dailymotion.com/embed/video/x3b68jn
use_cookies="no"
format=hls-1080
#format=hls-1080@60
#format=hls-720@60
# format=hls-720
#format=hls-480
#format=hls-380
#format=hls-240
chan_name="CNEWS France" ;;

############################################# BROKEN #######################################################################

# 660) Chase & Peche   ****
# 660)
# link=http://live-s101.abweb.com/liveabs101/ngrp:chasseetpeche.stream_bis/chunklist_b1096000.m3u8
# use_cookies="no"
# chan_name="Chase & Peche" ;;
# 661) RTL 9  ****
# 661)
# link=http://live-trl01.abweb.com/livetrl01/ngrp:rtl9.stream_bis/chunklist_b96000.m3u8
# use_cookies="no"
# chan_name="RTL 9" ;;
# 656) AB3  ******
# 656)
# link=http://live-trl101.abweb.com/liveabtrl101/ngrp:ab3.stream_bis/chunklist_b1096000.m3u8 
#use_cookies="no"
#chan_name="AB3" ;;
# 659) Science et Vie  *****
# 659)
# link=http://live-trl101.abweb.com/liveabtrl101/ngrp:scienceetvie.stream_bis/chunklist_b1096000.m3u8 
# use_cookies="no"
# chan_name="Science et Vie" ;;
# 654) POLAR Francais
# 654)
# link=http://live-trl101.abweb.com/liveabtrl101/ngrp:cinepolar.stream_bis/chunklist_b1096000.m3u8 
# use_cookies="no"
# chan_name="POLAR Francais" ;;


#################################   COLUMN 4 ############################################

# 681) FOX News Channel Preview (No Audio)
681)  
link=https://fnurtmp-f.akamaihd.net/i/FNCPREV_1@143121/master.m3u8
use_cookies="no"
chan_name="FOX News Channel Preview Preview (No Audio)" ;; 
# 682) Fox News Talk
682)  
link=https://fnurtmp-f.akamaihd.net/i/FNRADIO_1@92141/master.m3u8
use_cookies="no"
chan_name="Fox News Talk" ;; 
# 683) STADIUM
683)
link=https://04476b7c682c4da8b8b4bfe23ef879c1.midas.us-east-1.amazonaws.com/v1/master/61a556f78e4547c8ab5c6297ea291d6350767ca2/Mux/hls/live/522512/mux_4/master.m3u8  
use_cookies="no"
chan_name="STADIUM" ;; 
# 684) NFL Now Live
684)
link=https://svglive3-event.level3.nfl.com/nflent3/live/nfl_now/NFLNOW.m3u8 
use_cookies="no"
chan_name="NFL Now Live" ;; 
# 685) RED BULL TV 
685)
link=https://dms.redbull.tv/v3/linear-borb/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYXRlZ29yeSI6InBlcnNvbmFsX2NvbXB1dGVyIiwiY291bnRyeV9jb2RlIjoidXMiLCJleHBpcmVzIjoiMjAxNy0wOS0xNlQxNzo0NjowMy45NjM0NjI4NDJaIiwib3NfZmFtaWx5IjoiaHR0cCIsInJlbW90ZV9pcCI6IjEwLjE1Ny4xMTIuMTQ4IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xMl81KSBBcHBsZVdlYktpdC82MDMuMi40IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xMC4xLjEgU2FmYXJpLzYwMy4yLjQiLCJ1aWQiOiJkOGZiZWYzMC0yZDhhLTQwYTUtOGNjNy0wNzgxNGJhMTliNzMifQ.Q_38FNpW3so5yrA5FQt9qBuix3dTulKpb6uQ0dRjrtY/playlist.m3u8
use_cookies="no"
chan_name="RED BULL TV" ;; 
# 686) Olympics Channel
686)
link=https://live.olympicchannel.com/ocs/channel01b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel" ;; 
# 687) Olympics Channel 2
687)
link=https://live.olympicchannel.com/ocs/channel02b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 2 " ;; 
# 688) Olympics Channel 3
688)
link=https://live.olympicchannel.com/ocs/channel03b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 3 " ;; 
# 689) Olympics Channel 4
689)
link=https://live.olympicchannel.com/ocs/channel04b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 4 " ;; 
# 690) Olympics Channel 5
690)
link=https://live.olympicchannel.com/ocs/channel05b/master.m3u8
use_cookies="no"
chan_name="Olympics Channel 5 " ;; 
# 691) NBC News Live Event
691)
link=https://nbcnews-lh.akamaihd.net/i/nbc_live11@183427/master.m3u8
use_cookies="no"
chan_name="NBC News Live Event" ;; 
# 692) Shepard Smith Breaking News
692)
link=http://fnurtmp-f.akamaihd.net/i/SHEPSMITH_1@459383/master.m3u8
use_cookies="no"
chan_name="Shepard Smith Breaking News" ;;  
# 693) WUSA9 Breaking News
693)
link=https://wusa-lh.akamaihd.net/i/WUSA_Breaking_1@98930/master.m3u8
use_cookies="no"
chan_name="WUSA9 Breaking News" ;; 
# 694) WCNC Breaking News audio
694)
link=http://wcnc-lh.akamaihd.net/i/WCNC_Breaking_1@195112/master.m3u8
use_cookies="no"
chan_name="WCNC Breaking News audio" ;; 
# 695) WCCB News Rising
695)
link=https://api.new.livestream.com/accounts/8522553/events/live/live.m3u8
use_cookies="no"
chan_name="WCCB News Rising" ;;  
# 696) UGA TV
696)
link=http://mmuga-lh.akamaihd.net/i/ctlcable_1@349875/master.m3u8
use_cookies="no"
chan_name="UGA TV" ;;   
# 697) TVW Washington State TV
697)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVWAIR_all/master.m3u8
use_cookies="no"
chan_name="TVW Washington State TV" ;; 
# 698) TVW2 Washington State TV
698)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:TVW2_all/master.m3u8
use_cookies="no"
chan_name="TVW2 Washington State TV" ;; 
# 699) Action News Now (KNVN)
699)
link=https://api.new.livestream.com/accounts/26511688/events/7954874/live.m3u8
use_cookies="no"
chan_name="Action News Now (KNVN)" ;; 
# 700) Anchorage Alaska ASD TV
700)
link=http://64.22.99.223/AnchorageSchoolsAKLIVE/_definst_/AnchorageSchoolsAKLIVE.stream/chunklist.m3u8
use_cookies="no"
chan_name="Anchorage Alaska ASD TV" ;; 
# 701) Atlanta Channel
701)
link=http://media4.tripsmarter.com:1935/LiveTV/ACVBHD/playlist.m3u8
use_cookies="no"
chan_name="Atlanta Channel" ;; 
# 702) Beach TV - 30A
702)
link=http://media4.tripsmarter.com:1935/LiveTV/DTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - 30A" ;; 
# 703) Beach TV - Panama City
703)
link=http://media4.tripsmarter.com:1935/LiveTV/BTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - Panama City" ;; 
# 704) Beach TV - Pawleys Island
704)
link=http://media4.tripsmarter.com:1935/LiveTV/MTVHD/playlist.m3u8
use_cookies="no"
chan_name="Beach TV - Pawleys Island" ;;
# 705) Bowie TV
705)
link=http://granicusliveus3-a.akamaihd.net/cityofbowie/G0466_001/playlist.m3u8
use_cookies="no"
chan_name="Bowie TV" ;;
# 706) Buffalo TV
706)
link=http://na-all15.secdn.net/pegstream3-live/play/c3e1e4c4-7f11-4a54-8b8f-c590a95b4ade/playlist.m3u8
use_cookies="no"
chan_name="Buffalo TV" ;;
# 707) Capital City Connection
707)
link=http://na-us-se13.secdn.net/pegstream3-live/play/5f0d9ca5-4e85-4c01-a426-9ec8d44c2c9c/playlist.m3u8
use_cookies="no"
chan_name="Capital City Connection" ;;
# 708) Daytona Beach TV
708)
link=http://oflash.dfw.swagit.com/live/daytonabeachfl/smil:std-4x3-1-a/chucklist.m3u8
use_cookies="no"
chan_name="Daytona Beach TV" ;;
# 709) District Knowledge Network
709)
link=http://video.oct.dc.gov/out/u/96_4.m3u8
use_cookies="no"
chan_name="District Knowledge Network" ;;
# 710) District of Columbia Network
710)
link=http://video.oct.dc.gov/out/u/DCN.m3u8
use_cookies="no"
chan_name="District of Columbia Network" ;;
# 711) Escambia TV
711)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;
# 712) FiOS1 News New Jersey 
712)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_if6bcg01/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News New Jersey" ;;
# 713) FiOS1 News Long Island
713)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_b159ee77/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News Long Island" ;;
# 714) FiOS1 News Lower Hudson Valley
714)
link=https://cdnapisec.kaltura.com/p/424341/sp/42434100/playManifest/entryId/1_is35xshu/format/applehttp/protocol/https/uiConfId/39790741/a.m3u8
use_cookies="no"
chan_name="FiOS1 News Lower Hudson Valley" ;;
# 715) Fox 5 Washington DC (WTTG-TV)
715)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="Fox 5 Washington DC (WTTG-TV)" ;;
# 716) Garland TV
716)
link=http://oflash-alt.dfw.swagit.com/live/garlandtx/smil:hd-16x9-1-a/chunklist.m3u8
use_cookies="no"
chan_name="Garland TV" ;;
# 717) Greenbelt TV
717)
link=http://granicusliveus4-a.akamaihd.net/greenbeltmd/G0610_001/chunklist.m3u8
use_cookies="no"
chan_name="Greenbelt TV" ;;
# 718) House of Representatives
718)
link=http://d3ktuc8v2sjk6m.cloudfront.net/livetv/ngrp:HouseChannel_all/chucklist.m3u8
use_cookies="no"
chan_name="House of Representatives" ;;
# 719) KRBC-TV
719)
link=http://krbc-apple-live.hls.adaptive.level3.net/stream0/master.m3u8
use_cookies="no"
chan_name="KRBC-TV" ;;
# 720) KBVR TV
720)
link=http://klive-a.akamaihd.net/dc-0/live/hls/p/391241/e/0_bthpnu1j/sd/10000/t/YwqLo1YivB_aumq-LxAuWg/master.m3u8
use_cookies="no"
chan_name="KBVR TV" ;;
# 721) KTVB
721)
link=http://ktvb-lh.akamaihd.net/i/KTVB_Shows_1@60359/master.m3u8
use_cookies="no"
chan_name="KTVB" ;;
# 722) Key TV Florida
722)
link=http://media4.tripsmarter.com:1935/LiveTV/KTVHD/chunklist_w363623166.m3u8
use_cookies="no"
chan_name="Key TV Florida" ;;
# 723) KOB4 News Albacurqe NM
723)
link=https://api.new.livestream.com/accounts/10066184/events/3399986/live.m3u8
use_cookies="no"
chan_name="KOB4 News Albacurqe NM" ;;
# 724) KPNX Breaking 1
724)
link=https://b_kpnx-f.akamaihd.net/i/KPNXBreaking_1@398330/master.m3u8
use_cookies="no"
chan_name="KPNX Breaking 1" ;;
# 725) KXAN News Austin TX NBC
725)
link=https://api.new.livestream.com/accounts/1506296/events/1569171/live.m3u8
use_cookies="no"
chan_name="KXAN News Austin TX NBC" ;;
# 726) Laurel TV
726)
link=https://crimson.ebmcdn.net/laurel/smil:laurel.smil/chunklist.m3u8
use_cookies="no"
chan_name="Laurel TV" ;;
# 727) Miami TV
727)
link=http://oflash.dfw.swagit.com/live/miamibeachfl/smil:std-16x9-1-a/chunklist_w1459206316_b878000.m3u8
use_cookies="no"
chan_name="Miami TV" ;;
# 728) NBC Bay Area (KNTV-TV)
728)
link=https://kntvlive-f.akamaihd.net/i/kntvb2_1@15530/master.m3u8
use_cookies="no"
chan_name="NBC Bay Area (KNTV-TV)" ;;
# 729) NBC Bay Area Traffic Cam (KNTV-TV)
729)
link=https://kntvlive-f.akamaihd.net/i/kntvb1_1@15530/master.m3u8
use_cookies="no"
chan_name="NBC Bay Area Traffic Cam (KNTV-TV)" ;;
# 730) NBC2 News (KTUU-TV))
730)
link=httpx://api.new.livestream.com/accounts/7987479/events/2929660/live.m3u8
use_cookies="no"
chan_name="NBC2 News (KTUU-TV)" ;;
# 731) News2 (WCBD-TV)
731)
link=https://api.new.livestream.com/accounts/8360295/events/2976321/live.m3u8
use_cookies="no"
chan_name="News2 (WCBD-TV)" ;;
# 732) News4 (WRC-TV)
732)
link=https://wrclive-f.akamaihd.net/i/wrcb1_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 (WRC-TV)" ;;
# 733)News4 White House Cam (WRC-TV)
733)
link=https://wrclive-f.akamaihd.net/i/wrcb2_1@46880/master.m3u8
use_cookies="no"
chan_name="News4 White House Cam (WRC-TV)" ;;
# 734)News5 WCYB
734)
link=https://api.new.livestream.com/accounts/8522497/events/3012727/live.m3u8
use_cookies="no"
chan_name="News5 WCYB" ;;
# 735)NewsWest 9 (KWES)
735)
link=https://api.new.livestream.com/accounts/16923548/events/4681078/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 (KWES)" ;;
# 736)New Orleans TV
736)
link=http://media4.tripsmarter.com:1935/LiveTV/NOTVHD/playlist.m3u8
use_cookies="no"
chan_name="New Orleans TV" ;;
# 737)NBC4 New York News (WNBC-TV)
737)
link=https://wnbclive-f.akamaihd.net/i/wnbca1_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV)" ;;
# 738) NBC4 New York News (WNBC-TV) alt
738)
link=https://wnbclive-f.akamaihd.net/i/wnbca2_1@13992/master.m3u8
use_cookies="no"
chan_name="NBC4 New York News (WNBC-TV) alt" ;; 
# 739) NBC5 News (WMAQ-TV)
739)
link=https://wmaqlive-f.akamaihd.net/i/wmaqa1_1@22923/master.m3u8
use_cookies="no"
chan_name="NBC5 News (WMAQ-TV)" ;;
# 740) NBC 10 News (KTEN-TV)
740)
link=https://kten-lh.akamaihd.net/i/KTEN_1079@5589/master.m3u8
use_cookies="no"
chan_name="NBC 10 News (KTEN-TV)" ;;
# 741) NBC 12 News (WWBT-TV)
741)
link=https://api.new.livestream.com/accounts/11203782/events/3629264/live.m3u8
use_cookies="no"
chan_name="NBC 12 News (WWBT-TV)" ;;
# 742) NBC 29 (WVIR-TV)
742)
link=http://wvir-lh.akamaihd.net/i/WVIR_736@78303/master.m3u8?forceCacheClearSM=530806100000
use_cookies="no"
chan_name="NBC 29 (WVIR-TV)" ;;
# 743) NBC News Channel 13 (WNYT-TV)
743)
link=https://api.new.livestream.com/accounts/12240447/events/3818578/live.m3u8
use_cookies="no"
chan_name="NBC News Channel 13 (WNYT-TV)" ;;
# 744) NewsChannel 12 KTVZ
744)
link=https://api.new.livestream.com/accounts/19128364/events/5285531/live.m3u8
use_cookies="no"
chan_name="NewsChannel 12 KTVZ" ;;
# 745) NewsWest 9 KWES Washington DC USA
745)
link=https://api.new.livestream.com/accounts/2363281/events/1763520/live.m3u8
use_cookies="no"
chan_name="NewsWest 9 KWES Washington DC USA" ;;
# 746) Orange TV  // works behind tor
746)
link=http://otv3.ocfl.net:1936/OrangeTV/smil:OrangeTV.smil/playlist.m3u8
use_cookies="no"
chan_name="Orange TV" ;;
# 747) PGCPS
747)
link=http://reflect.live.pgcps.cablecast.tv/live/WIFI-696k-360p/WIFI-696k-360p.m3u8
use_cookies="no"
chan_name="PGCPS" ;;
# 748) RyeTV
748)
link=http://oflash.dfw.swagit.com/live/ryeny/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="RyeTV" ;;
# 749) Seattle Channel
749)
link=https://wowzaprod121-i.akamaihd.net/hls/live/266526/d2ea1f60/playlist.m3u8
use_cookies="no"
chan_name="Seattle Channel" ;;
# 750) Southeastern Channel
750)
link=http://147.174.13.196/live/WIFI-1296k-540p/WIFI-1296k-540p.m3u8
use_cookies="no"
chan_name="Southeastern Channel" ;;
# 751) Temple TV
751)
link=http://streaming.temple.edu/tutvlive/_definst_/mp4:play/chunklist.m3u8
use_cookies="no"
chan_name="Temple TV" ;;
# 752) Town of Vienna Community Network [HQ]
752)
link=https://granicusliveus2-a.akamaihd.net/vienna-va/G1359_003/playlist.m3u8
use_cookies="no"
chan_name="Town of Vienna Community Network [HQ]" ;;
# 753) TSTV
753)
link=http://tstv-stream.tsm.utexas.edu/hls/livestream_hi/index.m3u8
use_cookies="no"
chan_name="TSTV" ;;
# 754) Escambia TV
754)
link=http://58bfeaf58405a.streamlock.net/live/escambiacountyfl/smil:std-4x3-1-a/playlist.m3u8
use_cookies="no"
chan_name="Escambia TV" ;;

################################################ ARAB EXTRA  #########################################################
# 761) Al Jadeed
761) 
keyword="Jadeed"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/Aljadeedlive/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Jadeed" ;; 
# 762) Alghad
762) 
keyword="Alghad"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCaJykDM6rs776xPgzVvLkzg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Al Ghad" ;; 
# 763) NTV Spor TK
763) 
keyword="NTV"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ntvsportr/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="NTV Spor TK" ;; 
# 764) TRT 4K TK
764) 
keyword="4K"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYeW6ifPBPpT3NN9F3F23xA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="TRT 4K TK" ;; 
# 765) AFAQ TV IRAQ
765) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/afaqiraq/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="AFAQ TV IRAQ" ;; 
# 766) PAL TV Palistine
766) 
keyword="PalLive"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHswbrumSJUEgCY5NRrl6Ng/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="PAL TV Palistine" ;; 
# 767) Palistine TV Palistine
767) 
keyword="البث المباشر لتلفزيون"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCm2ljvhLIpti_JUCuwID6Qw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Palistine TV Palistine" ;;
# 768) Syrian Nour Elsham 
768)
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCoSdvqo_dKMRocU51Zt8p2Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Syrian Nour Elsham " ;;
# 769) Syrian Education 
769)
keyword="البث المباشر"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UChAx9Tuto_dnJzFbQVndCKA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Syrian Education " ;;


######################################### Column 7 ######################################################
# 801)

#EXTINF:0,KHZTV
# http://rbc.streamguys.com/khztv/khztv/playlist.m3u8
#EXTINF:0,Kiss TV
# http://csm-e.tm.yospace.com/csm/extlive/boxplus01,kiss-desktop.m3u8
#EXTINF:0,Nebiset
# http://hls.nebiset.tv/nebiset.m3u8
#EXTINF:0,NRJ Hits
# http://5.196.138.6:1935/live/nrjbelgique_720p/chunklist_w1562122761.m3u8
#EXTINF:0,NRJ TV
# http://energytv.vedge.infomaniak.com/livecast/energytv/playlist.m3u8
#EXTINF:0,RitmoVision
# http://3435c1ca-lp-live.ums.ustream.tv/playlist/auditorium/channel/18739366/playlist.m3u8?token=6302570_1512075867735&appType=11&appVersion=3&ts=1512075867&chunkingType=improved&geo=US&sgn=7c5196247d694c6a813e07fc62227939ff5d171b&preferredBitrate=0&cdnHost=uhs-akamai.ustream.tv
#EXTINF:0,1Music
# http://stream.1music.hu/stream/1music.m3u8
#EXTINF:0,Bridge TV
# https://bl.webcaster.pro/media/start/free_9d6a8624a7702dddd15b6c4fbf272152_hd/65_91554723/6b805dbede42bab6bbb6c3b829e4a31b/4639979456.m3u8
#EXTINF:0,California Music Channel
# https://cmctv.ios.internapcdn.net/cmctv_vitalstream_com/live_1/CMC-TV/CMC-TV.m3u8
#EXTINF:0,Channel AKA
# http://live.aatw.simplestreamcdn.com/aka/live.m3u8
#EXTINF:0,Chilled TV
# http://live.aatw.simplestreamcdn.com/chilled/live.m3u8
#EXTINF:0,Clubland TV
# http://live.aatw.simplestreamcdn.com/clubland/live.m3u8
#EXTINF:0,The Country Network
# http://dcunilive2-lh.akamaihd.net/i/dclive_1@390829/master.m3u8
#EXTINF:0,Deluxe Music
# http://server55.livestreamingcdn.com:1935/tulixdemo/tulixdemo/playlist.m3u8
#EXTINF:0,Heart TV
# http://ooyalahd2-f.akamaihd.net/i/globalradio02_delivery@156522/master.m3u8
#EXTINF:0,Kiss TV
# http://csm-e.tm.yospace.com/csm/extlive/boxplus01,kiss-desktop.m3u8
#EXTINF:0,Now Music TV
# http://live.aatw.simplestreamcdn.com/now/live.m3u8
#EXTINF:0,Radio Monte Carlo TV
# http://tv.105.net/live/rmc1/playlist.m3u8
#EXTINF:0,RitmoVision
# http://3435c1ca-lp-live.ums.ustream.tv/playlist/auditorium/channel/18739366/playlist.m3u8?token=6302570_1512075867735&appType=11&appVersion=3&ts=1512075867&chunkingType=improved&geo=US&sgn=7c5196247d694c6a813e07fc62227939ff5d171b&preferredBitrate=0&cdnHost=uhs-akamai.ustream.tv
#EXTINF:-1,RTI HD
# http://cdn.vsnw.net:8081/interradio/720i.m3u8
#EXTINF:-1,XITE TV
# http://highvolume03.streampartner.nl:1935/vleugels_hd5/livestream/index.m3u8
#EXTINF:0,RadioU TV
#http://cdn-live-egress.rbmtv.com/rightbrainmedia-live-109/mp4:radioutv1/playlist.m3u8
#EXTINF:0,Spirit Television
#http://cdn-live-egress.rbmtv.com/rightbrainmedia-live-109/mp4:spirit1/playlist.m3u8
#EXTINF:0,Christian Hip Hop Television
# http://telvuehls_t01997-i.akamaihd.net/hls/live/218552/T01997-2/playlist.m3u8
#EXTINF:0,SupTV
# http://91.134.238.137/live/goat/index.m3u8
#EXTINF:0,TACH
# https://hlsdpi-cdn-as4.totalstream.net/dpilive/vidilliontv/vtv/tach/playlist.m3u8
#EXTINF:0,TBD
# http://content.uplynk.com/channel/1831163f97674328ad9f4b4814ed39c5.m3u8?tc=1&exp=1614631202&rn=614441536&ct=c&cid=1831163f97674328ad9f4b4814ed39c5&ad=comet&ad.adUnit=%2FTBD%2FLivestream_midroll&ad._debug=TBDNET_ssai_livestream_midroll&ad.ad_rule=1&ad.pmad=12&ad.output=xml_vmap1&sig=5d194a4e4c5a4d59023d6a39a2ba5ba82dcd817b615e9f82115c41d9b26ffd0a
#EXTINF:0,TUFF TV
# http://cdn-live-egress.rbmtv.com/rightbrainmedia-live-604/mp4:Tufftv1/playlist.m3u8
#EXTINF:-1,HD Fashion UA
#http://95.67.47.115/hls/hdfashion_ua_hi/index.m3u8
#EXTINF:0,Public TV
#http://cdn-11.bonus-tv.ru/publictv/index.m3u8
#EXTINF:0,World Fashion International
#http://cdn-01.bonus-tv.ru:8080/wfcint/index.m3u8
#EXTINF:0,Adult Swim
#https://adultswimhls-i.akamaihd.net/hls/live/238460/adultswim/main/1/master.m3u8
#EXTINF:0,Adult Swim Off The Air
#http://adultswim-vodlive.cdn.turner.com/off-the-air/stream.m3u8
#EXTINF:0,Black Jesus 24/7
#http://adultswim-vodlive.cdn.turner.com/live/black-jesus/stream.m3u8
#EXTINF:0,Eric Andre Show 24/7
#http://adultswim-vodlive.cdn.turner.com/live/eric-andre/stream.m3u8
#EXTINF:0,Mr. Pickles 24/7
#http://adultswim-vodlive.cdn.turner.com/live/mr-pickles/stream.m3u8
#EXTINF:0,Rick and Morty 24/7
#http://adultswim-vodlive.cdn.turner.com/live/rick-and-morty/stream.m3u8
#EXTINF:0,Squidbillies 24/7
#https://adultswim-vodlive.cdn.turner.com/live/squidbillies/stream_7.m3u8
#EXTINF:0,Tim and Eric 24/7
#http://adultswim-vodlive.cdn.turner.com/tim-and-eric/stream.m3u8
#EXTINF:0,Venture Bros. 24/7
#http://adultswim-vodlive.cdn.turner.com/the-venture-bros/stream.m3u8
#EXTINF:0,Williams Stream 24/7
#http://adultswim-vodlive.cdn.turner.com/live/williams-stream/stream_html5.m3u8



################### MENU 4 ########################################
###############    SPACE       ######################### 
# 841)
# 842) NASA ISS 1
842) link=https://www.youtube.com/watch?v=ddFvjfvPnqk 
use_cookies="no"
chan_name="NASA ISS 1" ;;  
# 843) 
################## LOCATIONS #############################    
# 844) Venice Italy Bridge Cam Live
844) link=https://www.youtube.com/watch?v=vPbQcM4k1Ys 
use_cookies="no"
chan_name="Venice Italy Bridge Cam" ;;
# 845)
# 846)

# 847) Jackson Hole Town Square
847) 
keyword="Square"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCEpDjqeFIGTqHwk-uULx72Q/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Jackson Hole Town Square" ;;
# 848) Jackson Hole Rustic Inn
848) link=https://www.youtube.com/watch?v=KdvHzgcElx0 
use_cookies="no"
chan_name="Jackson Hole Rustic Inn" ;;
# 849) Aosta Sarre Italy
849)
keyword="Aosta Sarre Italy"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/camillimarco/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Aosta Sarre Italy" ;;
# 850) Buenos Aires Four Seasons
850)
keyword="Buenos"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCCkRwmztPEvut3gpsgmCmzw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)"
use_cookies="no"
chan_name="Buenos Aires Four Seasons" ;;
# 851) Netherlands Amsterdam
851) 
keyword="amsterdam"
link=http://www.amsterdam-dam.com/webcam.html
#link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Amsterdam Netherlands" ;; 
# 852) Shibua Japan Community Crosswalk 
852) 
keyword="LIVE CAMERA"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/sibchtv/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Shibua Japan Crosswalk" ;;
# 853) Akiba Japan Live
853) 
keyword="Akiba" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/GETNEWSJP/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Akiba Live" ;;
# 854) Yahoo Weather Japan
854) link=https://www.youtube.com/watch?v=QbQREKdxGhM
use_cookies="no"
chan_name="Yahoo Japan Bridge" ;;
# 855) Yahoo Weather Steamy Mountains
855)  link=https://www.youtube.com/watch?v=U83waNjv2bM
use_cookies="no"
chan_name="Yahoo Japan Steamy Mountain" ;;
# 856) Naman Seoul Tower South Korea  
856) 
keyword="LIVE"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UC90AkGrousC-CDBcCL8UaSg/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Naman Seoul Tower South Korea" ;; 
# 857) Shizuoka Bridge Japan
857) link=https://www.youtube.com/watch?v=cdJthnaGO6c
use_cookies="no"
chan_name="Shizuoka Bridge Japan" ;;
# 858) Yokohama Port Japan
858) link=https://www.youtube.com/watch?v=vE58KB1AoiA
use_cookies="no"
chan_name="Yokohama Port Japan" ;;
# 859) Hokkido Weather Cams
859) link=https://www.youtube.com/watch?v=ii_JukUbJG0
use_cookies="no"
chan_name="Hokkido Weather Cams" ;;     
# 860) Mount Fuji Japan
860) link=https://www.youtube.com/watch?v=iyzGqj_xRfc
use_cookies="no"
chan_name="Mount Fuji Japan" ;;     
# 861) Netherlands Hart Beach
861) 
keyword="hartbeach"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/WebCamNL/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )"
use_cookies="no"
chan_name="Hart Beach Netherlands" ;; 
# 862)  Port du Quebec
862) 
keyword="Port"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/portqc/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Port du Quebec" ;; 
# 863) Durango Colorado USA
863) 
keyword="Durango"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCJ3zGPGUiVTwcIDyEV3xwpw/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Durango Colorado USA" ;; 
# 864)Star Dot Cam 1
864) 
keyword="Live Fish Tank"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 1 Fish Tank" ;;  
# 865) Youing Japan Route 10
865) 
keyword="Japan LIVE Camera" 
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/YOUINGmediacity/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Youing Japan Route 10" ;; 
# 866) Star Dot Cam 4
866) 
keyword="Taipei City #1/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 4 Taipei Taiwan" ;; 
# 867) Star Dot Cam 5
867) 
keyword="Taipei City #2/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 5 Taipei Taiwan" ;; 
# 868) Star Dot Cam 6
868) 
keyword="Taipei City #3/3"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/StarDotTechnologies/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Star Dot Cam 6 Taipei Taiwan" ;; 
# 869) Fine Cine London 1
869) 
keyword="LONDON PANORAMIC"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 1" ;; 
# 870) Fine Cine London 2
870) 
keyword="CITY TOUR"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 2" ;; 
# 871) Fine Cine London 3
871) 
keyword="FINE CINE™ LONDON LIVE™"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCHfPdT-hqT9EmT-yM2ZMfGA/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Fine Cine London 3" ;; 
# 872) Berlin Airport 
872) 
keyword="LIVE: Berlin Skyline Airport"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/HausTwentyfourseven/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="Berlin Airport" ;; 
# 873)
# 874) Port of Los Angeles  
874) 
keyword="Port of Los Angeles Live Stream"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/user/ThePortofLosAngeles/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1 )" 
use_cookies="no"
chan_name="Port of Los Angeles" ;; 
# 875)  ITS COM STUDIO Japan  
875) 
keyword="iTSCOM STUDIO"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCYt3d335w5qPi5vE62Mxy8g/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="ITS COM STUDIO" ;; 
# 876)  China Shoreline 
876) 
keyword="海洋博公園"
link=https://www.youtube.com/watch?v="$(curl -A "$UA" "https://www.youtube.com/channel/UCgoVZ6IWOEcJdXiefd5nmcQ/videos?&view=2" | grep "$keyword" | grep "watch?v=" | head -n 1 | cut -d = -f 11 | cut -d \" -f 1)" 
use_cookies="no"
chan_name="China Shoreline" ;;

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
 
  
