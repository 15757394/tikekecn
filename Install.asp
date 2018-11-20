<!--#include file="config/config.asp" -->
<!--#include file="config/md5_16.asp" -->
<!--#include file="config/const.asp" -->
<div style="border:1px red solid;  padding:10px; color:red;background-color: #ffffff;font-size:14px; font-weight:800; width:1000px; margin:10px auto;background-color: #ffffcc">友情提示：代理平台安装成功并正确配置api后，请先同步产品列表和赠品列表否则不能正常使用！！<BR>
1、产品管理==>产品列表/价格设置==>同步产品或价格==>全部选中 然后点击同步<BR>
2、产品管理==>赠品管理==> 批量同步所有赠品-与上级服务商保持一致
</div>
<%

class table
	private tbinfo,tdinfo

	public sub addTb(width)
		tbinfo=vbcrlf & "<table width='" & width & "%' border='0' align='center' cellpadding='2' cellspacing='1' Class='border'>" & vbcrlf
	end sub

	public sub addTr(attribute)
		tbinfo=tbinfo & vbcrlf & "<tr " & attribute & ">"
		tbinfo=tbinfo & vbcrlf & tdinfo & "</tr>" & vbcrlf
		tdinfo=""
	end sub

	public sub addTd(attribute,info)
		tdinfo=tdinfo &  "<td " & attribute & ">" & info & "</td>" & vbcrlf
	end sub

	public sub out()
		tbinfo=tbinfo & vbcrlf &  "</table>" & vbcrlf
		XX tbinfo
	end sub
end class

function readfile(xfilename)
	Set fso=createobject(objName_FSO)
	if fso.fileExists(xfilename) then
		set otxt=fso.opentextfile(xfilename,1,false)
		readfile=otxt.readall()
		otxt.close:set otxt=nothing
	end if
	set fso=nothing
end function

sub savefile(xfilename,content)
	Set fso=createobject(objName_FSO)
	if fso.fileExists(xfilename) then
		set otxt=fso.opentextfile(xfilename,2,false)
		otxt.write(content)
		otxt.close:set otxt=nothing
	end if
	set fso=nothing
end sub

Sub XX(z)
	Response.write z
end Sub

sub showHeadTail(isHead)
 if isHead then
	XX "<HTML><HEAD><TITLE></TITLE>"
	XX "<META http-equiv=Content-Type content=""text/html; charset=gb2312"">"
	XX "<LINK href=""SiteAdmin/css/Admin_Style.css"" rel=stylesheet>"
	XX "<body leftmargin='2' topmargin='0' marginwidth='0' marginheight='0'>"
	XX "<form name=myform action=" & Request.ServerVariables("SCRIPT_NAME") & " method=post>"
 else
	XX "</form>"
	XX "</body>"
	XX "</html>"
 end if
end sub

sub Step0()
	showHeadTail true
	XX "<BR><ul>"
	XX "<li>如果您是首次运行本系统，请点击<a href=Install.asp?Act=Step1><font color=blue>开始安装</font></a>西部数码代理平台系统</li>"
	XX "<li>如果您已经安装，但还是出现该提示，请<a href=Install.asp?Act=Stepdel><font color=blue>删除</font></a>FTP根目录中的Install.asp文件</li>"
	XX "</ul>"
	showHeadTail false
end sub

sub Step1()
	'提示版权信息
	showHeadTail true
	license=readfile(Server.Mappath("/license.txt"))
	tdx="<textarea name='License' cols='120' rows='30' readonly>" & license & "</textarea>"
	Set tb1=new table
	tb1.addTb "60"
	tb1.addTd "height='22' align='center'","<strong>阅读许可协议</strong>"
	tb1.addTr "class='topbg'"
	tb1.addTd "align='center'",tdx
	tb1.addTr "class='tdbg'"

	tdx="<input name='AgreeLicense' type='checkbox' id='AgreeLicense' value='Yes' onclick='document.myform.submit.disabled=!this.checked;'><label for='AgreeLicense'>我已经阅读并同意此协议</label>"
	tb1.addTd "align='left'",tdx
	tb1.addTr "class='tdbg'"
	
	tdx="<input type=hidden name=Act value='Step2'><input name='submit' type='submit' id='submit' value=' 下一步 ' disabled>"
	tb1.addTd "height='40' align='center' class='tdbg'",tdx
	tb1.addTr ""
	tb1.out
	showHeadTail false
end sub

sub Step2()
	Dim SX(9,4)
	SX(0,0)="admin_user" '字段名
	SX(0,1)="管理员用户名" '提示信息
	SX(0,2)="以后通过此用户管理新安装代理平台,可任意设置" '说明
	SX(0,3)="admin" '默认值
	SX(0,4)="yes" '是否必须

	SX(1,0)="admin_pass" '字段名
	SX(1,1)="管理员密码" '提示信息
	SX(1,2)="登录管理后台时使用" '说明
	SX(1,3)="admin888" '默认值
	SX(1,4)="yes" '是否必须

	SX(2,0)="companyname" '字段名
	SX(2,1)="网站名称" '提示信息
	SX(2,2)="将显示在网页标题中,也会出现在您的续费通知中" '说明
	SX(2,3)=companyname '默认值
	SX(2,4)="yes" '是否必须

	SX(3,0)="companynameurl" '字段名
	SX(3,1)="网站域名" '提示信息
	SX(3,2)="您的网站域名，必须以http://开头,请务必认真填写有效域名,否则以后部分功能将无法使用" '说明
	SX(3,3)="http://" & Request.ServerVariables("SERVER_NAME") '默认值
	SX(3,4)="no" '是否必须

	SX(4,0)="SystemAdminPath" '字段名
	SX(4,1)="后台管理路径" '提示信息
	SX(4,2)="不建议修改" '说明
	SX(4,3)=SystemAdminPath '默认值
	SX(4,4)="yes" '是否必须

	SX(5,0)="api_url" '字段名
	SX(5,1)="上级服务商接口" '提示信息
	SX(5,2)="不清楚请咨询上级服务商,必须以http://开头，否则您业务将无法开通" '说明
	SX(5,3)=api_url '默认值
	SX(5,4)="yes" '是否必须

	SX(6,0)="api_username" '字段名
	SX(6,1)="api连接用户名" '提示信息
	SX(6,2)="请填写在我司的会员用户名" '说明
	SX(6,3)=api_username '默认值
	SX(6,4)="yes" '是否必须

	SX(7,0)="api_password" '字段名
	SX(7,1)="api连接密码" '提示信息
	SX(7,2)="<font color=red>警告,此处密码必须填写在我司管理中心-代理商管理-API接口配置中的密码</font>" '说明
	SX(7,3)=api_password '默认值
	SX(7,4)="yes" '是否必须
	
	SX(8,0)="webmanagesrepwd" '字段名
	SX(8,1)="随机字符串" '提示信息
	SX(8,2)="请不要修改此内容" '说明
	SX(8,3)=CreateRandomKey(16) '默认值
	SX(8,4)="yes" '是否必须

    SX(9,0)="webmanagespwd" '字段名
	SX(9,1)="后台专属密码" '提示信息
	SX(9,2)="安装时请保护为空" '说明
	SX(9,3)="" '默认值
	SX(9,4)="no" '是否必须
 

	doAct=Request.Form("doAct")
	
	if doAct="" then
		Set ZZ=new table
		showHeadTail true
		
		ZZ.addTb "100"
		ZZ.addTd "height='22' colspan='2' align='center'","<strong>西部数码代理平台安装向导</strong>"
		ZZ.AddTr "class='topbg'"

		for iIndex = 0 to Ubound(SX)
			tdx="<strong>" &SX(iIndex,1) & ":</strong>"			
			ZZ.addTd "width='15%' class='tdbg5' align='right'",tdx
			tdx="<input name='" & SX(iIndex,0) & "' type='text' value='" & SX(iIndex,3) & "' size='50' maxlength='255'>"
			if SX(iIndex,2)<>"" then tdx=tdx & "&nbsp;" & SX(iIndex,2)
			ZZ.addTd "",tdx
			if iIndex=8 or iIndex=9 then
			ZZ.AddTr "style='display:none'"
			else
			ZZ.AddTr "class='tdbg'"
			end if
		next
		tdx="<input name='doAct' type='hidden' value='SAVE'><input name='Act' type='hidden' value='Step2'><input name='submit' type='submit' id='submit' value=' 下一步 '>"
		ZZ.addTd "height='40' colspan='2' align='center' class='tdbg'",tdx
		ZZ.addTr ""
		ZZ.out
		showHeadTail false
	else
		for iIndex=0 to Ubound(SX)
			if SX(iIndex,4)="yes" then
				if Request.Form(SX(iIndex,0))="" then
					Response.write "<script language=javascript>alert('" & SX(iIndex,1) & "必须填写，不能为空');history.back();</script>"
					Response.end
				end if
			end if	
		next

		companynameurl=Request.Form("companynameurl")
		if lcase(left(companynameurl,7))<>"http://" then
				Response.write "<script language=javascript>alert('公司网址必须以http://开头');history.back();</script>"
				Response.end
		end if

		'修改管理后台路径
		rename "/siteadmin",Request.Form("SystemAdminPath")
		u_name=Request.Form("admin_user")
		u_pass=Request.Form("admin_pass")
		
		if isBad(u_name,u_pass,binfo) then url_return "您输入的密码过于简单，请重新设置。",-1
		
		Set oreg=new regexp
		oreg.ignorecase=true
		constFile=Server.Mappath("/config/const.asp")
		FileContent=readfile(constFile)

		for iIndex=0 to Ubound(SX)
			oreg.pattern=SX(iIndex,0) & "\s*=\s*""[^\n\r""]*"""
			if oreg.test(FileContent) then
				formValue=Trim(Request.Form(SX(iIndex,0)))
				FileContent=oreg.replace(FileContent,SX(iIndex,0) & "=" & """" & formValue & """")
			end if
		next

		savefile constFile,FileContent

		
		
		u_pass=md5_16(u_pass)
		addAdminUser u_name,u_pass
		addSystemVar

		Response.Redirect "Install.asp?Act=Step3"
	end if
end sub

sub rename(sdir,ndir)
	set oreg=new regexp
	oreg.pattern="^/\w+$"
	if not oreg.test(ndir) then
			Response.wrtie "<script language=javascript>alert('错误，新管理后台路径的根式是:/字母');history.back();</script>"
			Response.end			
	end if

	Set fso=createobject(objName_FSO)
	sdir=Server.MapPath(sdir)
	ndir=Server.MapPath(ndir)
	if sdir<>ndir then
		if not fso.folderExists(ndir) and fso.folderExists(sdir) then
			fso.movefolder sdir,ndir
		end if
	end if
	set fso=nothing
end sub

sub addAdminUser(u_name,u_pass)
	conn.open constr
	conn.execute("delete from userdetail where u_name='" & u_name & "'")
	conn.execute("delete from fuser where username='" & u_name & "'")	
	conn.execute("delete from userdetail where u_name='AgentUserVCP'")

	Set lrs=createobject("adodb.recordset")
	lrs.open "userdetail",conn,3,3
	
	lrs.addnew

	lrs("u_name")=u_name
	lrs("u_level")=1
	lrs("u_type")="111111"
	lrs("u_right")=0
	lrs("u_father")=0
	lrs("u_company")=Request.Form("companyname")
	lrs("u_telphone")="000-00000000"
	lrs("u_email")="xxx@xxx.com"
	lrs("u_desable")=false
	lrs("u_regdate")=now()
	lrs("u_password")=u_pass
	lrs("u_contract")="管理员"
	lrs("u_contry")="CN"
	lrs("u_province")="chengdu"
	lrs("u_city")="城市"
	lrs("u_address")="您的详细地址，请补充完整"
	lrs("u_zipcode")="000000"
	lrs("u_fax")=""
	lrs("u_borrormax")=0
	lrs("u_checkmoney")=0
	lrs("u_remcount")=0
	lrs("u_usemoney")=0
	lrs("u_premoney")=0
	lrs("u_accumulate")=0
	lrs("u_resumesum")=0
	lrs("U_levelName")="普通用户"
	lrs("u_bizbid")=1
	lrs("u_namecn")="管理员"
	lrs("u_nameEn")="english name"
	lrs("u_mode")=1

	lrs.update

	lrs.addnew

	lrs("u_name")="AgentUserVCP"
	lrs("u_level")=2
	lrs("u_type")="0"
	lrs("u_right")=0
	lrs("u_father")=0
	lrs("u_company")="VCP提成参考用户"
	lrs("u_telphone")="000-00000000"
	lrs("u_email")="xxx@xxx.com"
	lrs("u_desable")=false
	lrs("u_regdate")=now()
	lrs("u_password")=u_pass
	lrs("u_contract")="VCP提成参考用户"
	lrs("u_contry")="CN"
	lrs("u_province")="chengdu"
	lrs("u_city")="城市"
	lrs("u_address")="VCP提成价格将参考该用户代理价,不可删除!"
	lrs("u_zipcode")="000000"
	lrs("u_fax")=""
	lrs("u_borrormax")=0
	lrs("u_checkmoney")=0
	lrs("u_remcount")=0
	lrs("u_usemoney")=0
	lrs("u_premoney")=0
	lrs("u_accumulate")=0
	lrs("u_resumesum")=0
	lrs("U_levelName")="代理商"
	lrs("u_bizbid")=1
	lrs("u_namecn")="VCP提成参考用户"
	lrs("u_nameEn")="english name"
	lrs("u_mode")=1

	lrs.update

	lrs.close:set lrs=nothing
	conn.close
end sub

sub Step3()
	showHeadTail true
	Set ZZ=new table
	ZZ.addTb "50"
	ZZ.addTd "height='22'","<strong>恭喜你！</strong>"
	ZZ.addTr "align='center' class='title'"

	ZZ.AddTd "height='100' valign='top'","<br>系统安装完成！现在你可以使用系统了。<br>为了<font color='red'>系统安全</font>，请点击下面的按钮删除此安装文件（Install.asp）<br><br><div align='center'><input name='delfile' type='button' id='delfile' value=' 删除此安装文件 ' onclick=""location='install.asp?Act=Stepdel'""></div><br>"
	ZZ.AddTr "class='tdbg'"

	ZZ.out
	showHeadTail false
end sub

sub StepDel(Xfile)
	Set fso=createobject(objName_FSO)
	fso.deletefile(Server.MapPath(Xfile))
	Set fso=nothing	
	Response.Redirect "default.asp"
end sub

Act=Request("Act")

select case Act
	case "Step1"
		Step1
	case "Step2"
		Step2
	case "Step3"
		Step3
	case "Stepdel"
		StepDel "/install.asp"
	case else
		Step0
end select

sub addSystemVar()
	conn.open constr
	set lrs=conn.Execute("select count(*) from systemvar")
	if lrs(0)<>1 then
		conn.Execute("delete from systemvar")
		conn.Execute("insert into systemvar (reboot,noteonindex) values ("&PE_False&","&PE_False&")")
	end if
	lrs.close
	set lrs=nothing
	conn.close
end sub
%>