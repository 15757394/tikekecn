<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include virtual="/config/config.asp" -->
<!--#include virtual="/config/uercheck.asp" -->
<!--#include virtual="/config/Template.inc.asp" --> 
<!--#include virtual="/config/ParseCommand.asp" -->
<%
server.ScriptTimeout=9999
check_is_master(6)
conn.open constr
user_name=""
u_level=""
if isDatenow then

'���� 5��һ�����
    if clng(weekday(now))=6 then
	 call Syn_vpsjf() 'ͬ������������
	end if

	response.write "�����һ�ε�½<br>"
	 call isnoteset(mailset_r,smsset_r )
	 call DemoAlarm()'����֪ͨ
	 call pastnote()'����֪ͨ
	 call DeleteExpiredData()'ɾ������
	 call cleanAPILOG() 'ɾ��3��ǰ��API��־
	 call isapiconnection()'���api�����Ƿ���ȷ
	 call getdomainState()'��������״̬��ɾ����ɾ������
	
	 response.write "���в������"
end if
conn.close
sub getdomainState()
end sub
sub isapiconnection()
		response.write "���ڽ���api�ӿ����Ӽ��<br>"
		optCode="other" & vbcrlf
		optCode=optCode & "test" & vbcrlf
		optCode=optCode & "entityname:test" & vbcrlf & "." & vbcrlf
		retCode=Pcommand(optCode,Session("user_name"))
		if left(retCode,3)<>"200" then
			%>
          <div style="border:#FF9900 solid 1px; background:#ffffcc; width:300px">
          <TABLE cellSpacing=0 cellPadding=0 width="97%" border=0 align="center">
          <tr><td><span class="STYLE8">*����:</span></td>
          </tr>
          <tr><td>&nbsp;&nbsp;����ҵ���޷�����.�������api�ӿڵ�ַ��api�˺Ż������Ƿ�������ȷ</td>
          </tr>
          <tr><td align="right"><a href="/SiteAdmin/SystemSet/EditConfig.asp"><font color=blue>[����]</font></a>&nbsp;<a href="http://www.agentsys.cn/help/list.asp?unid=372" target="_blank"><font color=blue>[����]</font></a></td>
          </tr>
          </TABLE>
         </div>
            <%
		end if
end sub
sub cleanAPILOG()
	conn.execute("delete from ActionLog where LogType='API' and datediff('d',addTime,now())>1")
end sub

Sub DemoAlarm()'����֪ͨ
	if not mailset_r then exit sub
		response.write "���ڽ�������֪ͨ<br>"
	'----------------��������֪ͨ'''''''''''''''''''''''
		testsql="SELECT a.s_comment, a.s_buydate, b.u_email,b.u_name,b.msn_msg FROM (vhhostlist a inner join UserDetail b ON a.S_ownerid = b.u_id) WHERE DATEDIFF('d',s_buydate, now()) in (3,7) AND s_buytest =true"
		
		
	set testrs=conn.execute(testsql)
		user_name=""
		do while not testrs.eof
			Days=Datediff("d",testrs("s_buydate"),now())
			
			if Days=3 then
				Subject="������������ֹͣWEB���ʵ�֪ͨ!"
				Mtxt=Mtxt & "���ڸ�������������ҳ���ʹ��ܼ������رա�"
			else
				Subject="������������ɾ����֪ͨ!"
				Mtxt=Mtxt & "���ڸ���������������ɾ��,������Ҫ����������ʱ���ء�"
			end if
			
				
				user_name=testrs("u_name")
				getStr="s_buydate="& testrs("s_buydate") &"," & _
						"Days="& days &"," & _
					   "s_comment="& testrs("s_comment") &"," & _
					   "mtxt="& Mtxt
				mailbody=redMailTemplate("auto_vhosttest.txt",getStr)
				
				
				call sendmail(testrs("u_email"),Subject,mailbody)
				testrs.moveNext
			
			
		Loop
		testrs.close
		set testrs=nothing

'''''''''''''''''''''�����ʾ�֪ͨ'''''''''''''''
		testsql="SELECT a.m_bindname, a.m_buydate, b.u_email, b.u_contract,b.u_name,b.msn_msg FROM (mailsitelist a inner JOIN UserDetail b ON a.m_ownerid = b.u_id) WHERE DATEDIFF('d',m_buydate, now()) in (10,14) AND m_buytest =true"

set testrs=conn.execute(testsql)
	
	do while not testrs.eof
		Days=Datediff("d",testrs("m_buydate"),now())
		
			if Days=3 then
				Subject="�����ʾּ���ֹͣ��֪ͨ!"
				Mtxt=Mtxt & "���ڸ������ʾַ��ʹ��ܼ������رա�"
			else
				Subject="�����ʾּ���ɾ����֪ͨ!"
				Mtxt=Mtxt & "���ڸ������ʾּ�����ɾ��,������Ҫ����������ʱ���ء�"
			end if
			user_name=testrs("u_name")
			getStr="m_buydate="& testrs("m_buydate") &"," & _
					"Days="& days &"," & _
				   "m_bindname="& testrs("m_bindname") &"," & _
				   "mtxt="& Mtxt
			mailbody=redMailTemplate("auto_mailtest.txt",getStr)
			call sendmail(testrs("u_email"),Subject,mailbody)
		
	
		
		testrs.moveNext
	Loop
	testrs.close
	set testrs=nothing
end Sub

sub pastnote()
	if not mailset_r and not smsset_r then exit sub
	response.write "���ڽ��й�������֪ͨ<br>"
	day_level_1=30	
	day_level_2=15
	day_level_3=3
	'''''''''''''''''''����''''''''''''''''''
	Subject="��������֪ͨ"
	mobnumC=""
	Sqlhost="Select  a.s_comment,a.s_bindings,a.s_ProductId,a.s_buydate,a.s_year,DateDiff('d',now(),DateAdd('yyyy',s_year,s_buydate)) as day_level,b.u_email,b.u_name,b.msn_msg from (vhhostlist a inner join userdetail b on a.S_ownerid = b.u_id) where DateDiff('d',now(),DateAdd('yyyy',s_year,s_buydate)) in ("& day_level_1&","& day_level_2 &","& day_level_3 &")"
	
	set hostRs=conn.execute(sqlhost)
	if not hostRs.eof then
		do while not hostRs.eof 
			s_comment=hostRs("s_comment")
			s_buydate=hostRs("s_buydate")
			s_year=hostRs("s_year")
			s_bindings=hostRs("s_bindings")
			s_ProductId=hostRs("s_ProductId")
			day_level=hostRs("day_level")
			u_email=hostRs("u_email")
			user_name=hostRs("u_name")
			expridate=formatdatetime(dateAdd("yyyy",s_year,s_buydate),2)
			renewprice=GetNeedPrice(user_name,s_ProductId,1,"renew")
			if not isnumeric(renewprice) then response.Write( "<font color=red>" & s_ProductId & "</font>" ) 
			if mailset_r then
				getStr="s_buydate="& s_buydate &"," & _
					   "s_comment="& s_comment &"," & _
					   "expridate="& expridate &"," & _
					   "renewprice="& renewprice &"," & _
					   "s_bindings="& s_bindings
					   
				mailbody=redMailTemplate("auto_hostexpri.txt",getStr)
				call sendmail(u_email,Subject,mailbody)
			end if
			if smsset_r then
				getStr="s_comment="& gotTopic(s_comment,8) &  ",expridate="& expridate
				smsbody=redMailTemplate("sms_auto_hostexpri.txt",getStr)
				mobnum=hostRs("msn_msg")
				if IsValidMobileNo(mobnum) and smsbody<>"" then
					if mobnumC<>mobnum then
						smsreturn = httpSendSMS(mobnum,smsbody)
						
					end if
					mobnumC=mobnum
				end if
				
			end if
		hostRs.movenext
		loop
	end if
	hostRs.close
	set hostRs=nothing
	'''''''''''''''''''����''''''''''''''''''''
	Subject="��������֪ͨ"
	mobnumC=""
	sqldomain="Select  a.strDomain,a.isreglocal,a.proid,a.years,a.regdate,DateDiff('d',now(),DateAdd('yyyy',years,regdate)) as day_level,b.u_email,b.u_name,b.msn_msg from (domainlist a inner join userdetail b on a.userid=b.u_id) where isreglocal=0 and DateDiff('d',now(),DateAdd('yyyy',years,regdate)) in ("& day_level_1&","& day_level_2 &","& day_level_3 &")"
	set domainRs=conn.execute(sqldomain)
	if not domainRs.eof then
		do while not domainRs.eof
			domainname=domainRs("strDomain")
			regdate=domainRs("regdate")
			years=domainRs("years")
			proid=domainRs("proid")
			expridate=formatdatetime(dateadd("yyyy",years,regdate),2)
			u_email=domainRs("u_email")
			user_name=domainRs("u_name")
			renewprice=GetNeedPrice(user_name,proid,1,"renew")
			if mailset_r then
			
				getStr="domainname="& domainname &"," & _
					   "expridate="& expridate &"," & _
					   "renewprice="& renewprice
					  
					   
				mailbody=redMailTemplate("auto_domainexpri.txt",getStr)
				call sendmail(u_email,Subject,mailbody)
			end if
		
			if smsset_r then
				getStr="domainname="& gotTopic(domainname,8) & ",expridate="& expridate
				smsbody=redMailTemplate("sms_auto_domainexpri.txt",getStr)
				mobnum=domainRs("msn_msg")
				if IsValidMobileNo(mobnum) and smsbody<>"" then
					if mobnumC<>mobnum then
						smsreturn = httpSendSMS(mobnum,smsbody)
						
					end if
					mobnumC=mobnum
				end if
				
			end if
		domainRs.movenext
		loop
	end if
	domainRs.close
	set domainRs=nothing
	''''''''''''''''''''�ʾ�'''''''''''''''''''''
	Subject="�ʾ�����֪ͨ"
	mobnumC=""
	sqlmail="Select a.m_bindname,a.m_ProductId,a.m_buydate,a.m_years,DateDiff('d',now(),DateAdd('yyyy',m_years,m_buydate)) as day_level,b.u_email,b.u_name,b.msn_msg from (mailsitelist a inner join userdetail b on a.m_ownerid = b.u_id) where m_free=0 and DateDiff('d',now(),DateAdd('yyyy',m_years,m_buydate)) in ("& day_level_1&","& day_level_2 &","& day_level_3 &")"
	
	set mailRs=conn.execute(sqlmail)
		if not mailRs.eof then
				do while not mailRs.eof 
					m_bindname= mailRs("m_bindname")
					m_buydate= mailRs("m_buydate")
					m_year= mailRs("m_years")
					m_ProductId= mailRs("m_ProductId")
					day_level= mailRs("day_level")
					u_email= mailRs("u_email")
					user_name= mailRs("u_name")
					expridate=formatdatetime(dateAdd("yyyy",m_year,m_buydate),2)
					renewprice=GetNeedPrice(user_name,m_ProductId,1,"renew")
					if mailset_r then
						getStr="m_buydate="& m_buydate &"," & _
							   "m_bindname="& m_bindname &"," & _
							   "expridate="& expridate &"," & _
							   "m_ProductId="& m_ProductId &"," & _
							   "renewprice="& renewprice
	
							   
						mailbody=redMailTemplate("auto_mailexpri.txt",getStr)
						call sendmail(u_email,Subject,mailbody)
					end if
					if smsset_r then
						getStr="m_bindname="& gotTopic(m_bindname,8) & ",expridate="& expridate
						smsbody=redMailTemplate("sms_auto_mailexpri.txt",getStr)
						mobnum=mailRs("msn_msg")
						if IsValidMobileNo(mobnum) and smsbody<>"" then
							if mobnumC<>mobnum then
								smsreturn = httpSendSMS(mobnum,smsbody)
							end if
							mobnumC=mobnum
						end if
						
					end if
				mailRs.movenext
				loop
	end if
	mailRs.close
	set mailRs=nothing
	'''''''''''''''''mssql''''''''''''''''''''''''
	Subject="mssql����֪ͨ"
	mobnumC=""
	sqlmssql="Select a.dbname,a.dbsize,a.dbproid,a.dbyear,a.dbbuydate,b.u_email,b.u_name,b.msn_msg from (databaselist a inner join userdetail b on a.dbu_id=b.u_id) where datediff('d',now(),dateadd('yyyy',dbyear,dbbuydate)) in ("& day_level_1&","& day_level_2 &","& day_level_3 &")"
	set mssqlRs=conn.execute(sqlmssql)
	if not mssqlRs.eof then
		do while not mssqlRs.eof
			dbname=mssqlRs("dbname")
			dbsize=mssqlRs("dbsize")
			dbyear=mssqlRs("dbyear")
			dbbuydate=mssqlRs("dbbuydate")
			dbproid=mssqlRs("dbproid")
					u_email= mssqlRs("u_email")
					user_name= mssqlRs("u_name")
					expridate=formatdatetime(dateAdd("yyyy",dbyear,dbbuydate),2)
					renewprice=GetNeedPrice(user_name,dbproid,1,"renew")
					if mailset_r then
						getStr="dbname="& dbname &"," & _
							   "dbsize="& dbsize &"," & _
							   "expridate="& expridate &"," & _
							   "dbproid="& dbproid &"," & _
							   "renewprice="& renewprice
	
							   
						mailbody=redMailTemplate("auto_mssqlexpri.txt",getStr)
						call sendmail(u_email,Subject,mailbody)
					end if
					if smsset_r then
						getStr="dbname="& gotTopic(dbname,8) & ",expridate="& expridate
						smsbody=redMailTemplate("sms_auto_mssqlexpri.txt",getStr)
						mobnum=mssqlRs("msn_msg")
						if IsValidMobileNo(mobnum) and smsbody<>"" then
							if mobnumC<>mobnum then
								smsreturn = httpSendSMS(mobnum,smsbody)
							end if
							mobnumC=mobnum
						end if
						
					end if
		mssqlRs.movenext
		loop
	end if
	mssqlRs.close
	set mssqlRs=nothing
	''''''''''''''��������'''''''''''''
	Subject="������������֪ͨ"
	mobnumC=""
	sqlserver="Select [id],[name],[email],allocateip,[starttime],[years],moneypermonth,alreadypay,StartTime,[fax] as msn_msg from hostrental where start=1 and DateDiff('d',now(),DateAdd('m',AlreadyPay,starttime)) in ("& day_level_1&","& day_level_2 &","& day_level_3 &")"
	set sRs=conn.execute(sqlserver)
	if not sRs.eof then
		do while not sRs.eof
			allocateip=sRs("allocateip")
			AlreadyPay=sRs("AlreadyPay")
			StartTime=sRs("StartTime")
			renewprice=srs("MoneyPerMonth")
			
			u_email=sRs("email")
			user_name=sRs("name")
			expridate=formatDateTime(DateAdd("m",AlreadyPay,StartTime),2)
					if mailset_r then
						getStr= "allocateip="& allocateip &"," & _
								"renewprice="& renewprice &"," & _
								"expridate="& expridate
							mailbody=redMailTemplate("auto_serverexpri.txt",getStr)
							call sendmail(u_email,Subject,mailbody)
					end if	
					if smsset_r then
						getStr="allocateip="& gotTopic(allocateip,8) & ",expridate="& expridate
						smsbody=redMailTemplate("sms_auto_serverexpri.txt",getStr)
						mobnum=sRs("msn_msg")
						if IsValidMobileNo(mobnum) and smsbody<>"" then
							if mobnumC<>mobnum then
								smsreturn = httpSendSMS(mobnum,smsbody)
							end if
							mobnumC=mobnum
						end if
						
					end if	   
		sRs.movenext
		loop
	end if
	sRs.close
	set sRs=nothing
end sub
sub DeleteExpiredData()
	response.write "����ɾ����������<br>"
	sql="delete from domainlist where Datediff('d',dateAdd('yyyy',years,regdate),now())>30"
   '���� 
   sql1="delete from vhhostlist where Datediff('d',dateAdd('yyyy',s_year,s_buydate),now())>30"
   '����
   sql2="delete from mailsitelist where Datediff('d',dateAdd('yyyy',m_years,m_buydate),now())>30"
   'mssql
   sql3="delete from databaselist where Datediff('d',dateAdd('yyyy',dbyear,dbbuydate),now())>30"
   '����host
   sql4="delete from vhhostlist where DateDiff('d',dateAdd('d',7,s_buyDate),now())>0 and s_buytest=true"
   '����mail
   sql5="delete from mailsitelist where DateDiff('d',dateAdd('d',15,m_buyDate),now())>0 and m_buytest=true"
   '����mssql
   sql6="delete from databaselist where DateDiff('d',dateAdd('d',7,dbbuyDate),now())>0 and dbbuytest=true"
   conn.execute sql
   conn.execute sql1
   conn.execute sql2
   conn.execute sql3
   conn.execute sql4
   conn.execute sql5
   conn.execute sql6
  set fileobj=server.createobject("scripting.filesystemobject")
  			Set f = fso.GetFolder(server.mappath("/"))
			Set fc = f.Files'�ļ�
			for each myfiles in fc
				if instr(myfiles.name,"AgentLogs") and right(myfiles.name,4)=".xml" then
					fileobj.Deletefile myfiles,true
				end if
			next
			set fc=nothing
			set f=nothing
  set fileobj=nothing
end sub

function isDatenow()
	isDatenow=false
	xmlpath=server.mappath("/database/data.xml")
	set objDoms=Server.CreateObject("Microsoft.XMLDOM")
	set myobject=isnodes("pageset","managerRegDate",xmlpath,1,objDoms)
	set mytype=myobject.selectSingleNode("@date")
	if mytype is nothing then
			myobject.setAttribute "date",date()
			objDoms.save(xmlpath)
	end if
	set mytype=nothing
	mydate=myobject.attributes.getNamedItem("date").nodeValue
	if mydate<>"" and isdate(mydate) then
		if dateDiff("d",Date(),trim(mydate))<0 then
			isDatenow=true
		end if
	else
		isDatenow=true
	end if
	if isDatenow then
		myobject.setAttribute "date",date()
		objDoms.save(xmlpath)
	end if
	set myobject=nothing
	set objDoms=nothing
end function
function isnoteset(byref mailset_r,byref smsset_r )
	mailset_r=false
	smsset_r=false
	xmlpath=server.mappath("/database/data.xml")
	set objDoms=Server.CreateObject("Microsoft.XMLDOM")
	set myobject=isnodes("pageset","noteset",xmlpath,1,objDoms)
	set mytype=myobject.selectSingleNode("@mailset")
	if mytype is nothing then
			myobject.setAttribute "mailset",1
			objDoms.save(xmlpath)
	end if
	set mytype=nothing
	set myprice=myobject.selectSingleNode("@smsset")
	if myprice is nothing then
		myobject.setAttribute "smsset",0
		objDoms.save(xmlpath)
	end if
	set myprice=nothing
	
	mailset=myobject.attributes.getNamedItem("mailset").nodeValue
	smsset=myobject.attributes.getNamedItem("smsset").nodeValue
	if mailset=1 then mailset_r=true
	if smsset=1 then smsset_r=true
	set myobject=nothing
	set objDoms=nothing
end function
' �û���,��Ʒid,��������,����ʽnew��renew
function GetNeedPrice(byval u_name,byval Proid,byval buyyear,byval buytype)
		u_level=1
		u_id=0
		needPrice=0
		firstPrice=0
		if Proid="" or buyyear="" or buytype="" then exit function
		if not isnumeric(buyyear) or buyyear<=0 then buyyear=1
		u_name=trim(u_name)&""
		usersql="select u_id,u_level from userdetail where u_name<>'' and u_name='"& u_name &"'"
		set urs=conn.execute(usersql)
		if not urs.eof then
			u_id=urs("u_id")
			u_level=urs("u_level")
		end if
		urs.close
		set urs=nothing
		if isnumeric(buyyear) then buyyear=ccur(buyyear)
			select case buytype
				case "new"
						set prs=conn.execute("select iif(isnull(proPrice),0,proPrice) from UserPrice where u_id<>0 and proid='"& Proid &"' and u_id="& u_id)
						if not prs.eof then
							firstPrice=ccur(prs(0))
						end if
						prs.close
						set prs=nothing
						if firstPrice<=0 then
							 set prs0=conn.execute("select top 1 iif(isnull(p_firstPrice),0,p_firstPrice) from pricelist where p_u_level="& u_level &" and p_proId='"& proid &"'")
							  if not prs0.eof then
									firstPrice=ccur(prs0(0))
							  end if
							  prs0.close
							  set prs0=nothing
						end if
						
					 
					  if buyyear>1 or (firstPrice=0 and buyyear=1) then
						if firstPrice>0 then buyyear=buyyear-1
						set prs=conn.execute("select iif(isnull(newPrice),0,newPrice) from RegisterDomainPrice where  User_name<>'' and User_name='"& u_name &"' and ProId='"& proid &"' and NeedYear>1 and NeedYear="& buyyear)
						 if not prs.eof then
						 	price=ccur(prs(0))
							if price>0 then
								needPrice=firstPrice + price
							end if
						 end if
						 prs.close
						 set prs=nothing
						 if needPrice<=0 then
						 	set prs0=conn.execute("select top 1 iif(isnull(newPrice),0,newPrice) from registerDomainPrice where UserLevel="& u_level & " and NeedYear="& buyyear & " and NeedYear>1 and ProId='"& ProId &"'")
							if not prs0.eof then
								price=ccur(prs0(0))
								if price>0 then
									needPrice=firstPrice + price
								end if
							end if
							prs0.close
							set prs0=nothing
						 end if
						 if needPrice=0 then
							set prs1=conn.execute("select top 1 iif(isnull(p_price),0,p_price) from pricelist where p_u_level="& u_level &" and p_proId='"& proid &"'")
							if not prs1.eof then
								price=ccur(prs1(0))
								if price>0 then
									needPrice=firstPrice + price * buyyear
								end if
							end if
							prs1.close
							set prs1=nothing
							if needPrice<=0 then
								set prs0=conn.execute("select iif(isnull(p_price),0,p_price) from productlist where p_proId='"& proid &"'")
								if not prs0.eof then
									price=ccur(prs0(0))
									if price>0 then
										needPrice=firstPrice + price * buyyear
									end if
								else
									'Response.write "500 û���������͵Ĳ�Ʒ" & proid
									'Response.end
									GetNeedPrice="δ֪":exit function
								end if
								prs0.close
								set prs0=nothing
							end if
							
						end if
					 else
					 	needPrice=firstPrice
					 end if
					case "renew"
						  set prs=conn.execute("select top 1 iif(isnull(p_firstPrice_renew),0,p_firstPrice_renew) from pricelist where p_u_level="& u_level &" and p_proId='"& proid &"'")
					  if not prs.eof then
							firstPrice=ccur(prs(0))
					  end if
					  prs.close
					  set prs=nothing
					  if buyyear>1 or (firstPrice=0 and buyyear=1) then
							if firstPrice>0 then buyyear=buyyear-1
							set prs=conn.execute("select iif(isnull(RenewPrice),0,RenewPrice) from RegisterDomainPrice where User_name<>'' and User_name='"& u_name &"' and ProId='"& proid &"' and NeedYear>1 and NeedYear="& buyyear)
							if not prs.eof then
								price=ccur(prs(0))
								if price>0 then
									needPrice=firstPrice + price
								end if
							end if
							prs.close
							set prs=nothing
							if needPrice<=0 then
								set prs0=conn.execute("select top 1 iif(isnull(RenewPrice),0,RenewPrice) from registerDomainPrice where UserLevel="& u_level & " and NeedYear="& buyyear & " and NeedYear>1 and ProId='"& proid &"'")
								if not prs0.eof then
									price=ccur(prs0(0))
									if price>0 then
										needPrice=firstPrice + price
									end if
								end if
								prs0.close
								set prs0=nothing
							end if
							
							
							if needPrice=0 then
								set prs1=conn.execute("select top 1 iif(isnull(p_price_renew),0,p_price_renew) from pricelist where p_u_level="& u_level &" and p_proId='"& proid &"'")
								if not prs1.eof then
									price=ccur(prs1(0))
									if price>0 then
										needPrice=firstPrice + price * buyyear
									end if
								end if
								prs1.close
								set prs1=nothing
								if needPrice<=0 then
									set prs1=conn.execute("select top 1 iif(isnull(p_price),0,p_price) from pricelist where p_u_level="& u_level &" and p_proId='"& proid &"'")
									if not prs1.eof then
										price=ccur(prs1(0))
										if price>0 then
											needPrice=firstPrice + price * buyyear
										end if
									end if
									prs1.close
									set prs1=nothing
									if needPrice<=0 then
										set prs0=conn.execute("select iif(isnull(p_price),0,p_price) from productlist where p_proId='"& proid &"'")
										if not prs0.eof then
											price=ccur(prs0(0))
											if price>0 then
												needPrice=firstPrice + price * buyyear
											end if
										else
											'Response.write "500 û���������͵Ĳ�Ʒ"  & proid
											'Response.end
											GetNeedPrice="δ֪":exit function
										end if
										prs0.close
										set prs0=nothing
									end if
								end if
							end if
					  else
					 	needPrice=firstPrice
					  end if
		   end select
		   GetNeedPrice=needPrice
end function



%>