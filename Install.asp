<!--#include file="config/config.asp" -->
<!--#include file="config/md5_16.asp" -->
<!--#include file="config/const.asp" -->
<div style="border:1px red solid;  padding:10px; color:red;background-color: #ffffff;font-size:14px; font-weight:800; width:1000px; margin:10px auto;background-color: #ffffcc">������ʾ������ƽ̨��װ�ɹ�����ȷ����api������ͬ����Ʒ�б����Ʒ�б����������ʹ�ã���<BR>
1����Ʒ����==>��Ʒ�б�/�۸�����==>ͬ����Ʒ��۸�==>ȫ��ѡ�� Ȼ����ͬ��<BR>
2����Ʒ����==>��Ʒ����==> ����ͬ��������Ʒ-���ϼ������̱���һ��
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
	XX "<li>��������״����б�ϵͳ������<a href=Install.asp?Act=Step1><font color=blue>��ʼ��װ</font></a>�����������ƽ̨ϵͳ</li>"
	XX "<li>������Ѿ���װ�������ǳ��ָ���ʾ����<a href=Install.asp?Act=Stepdel><font color=blue>ɾ��</font></a>FTP��Ŀ¼�е�Install.asp�ļ�</li>"
	XX "</ul>"
	showHeadTail false
end sub

sub Step1()
	'��ʾ��Ȩ��Ϣ
	showHeadTail true
	license=readfile(Server.Mappath("/license.txt"))
	tdx="<textarea name='License' cols='120' rows='30' readonly>" & license & "</textarea>"
	Set tb1=new table
	tb1.addTb "60"
	tb1.addTd "height='22' align='center'","<strong>�Ķ����Э��</strong>"
	tb1.addTr "class='topbg'"
	tb1.addTd "align='center'",tdx
	tb1.addTr "class='tdbg'"

	tdx="<input name='AgreeLicense' type='checkbox' id='AgreeLicense' value='Yes' onclick='document.myform.submit.disabled=!this.checked;'><label for='AgreeLicense'>���Ѿ��Ķ���ͬ���Э��</label>"
	tb1.addTd "align='left'",tdx
	tb1.addTr "class='tdbg'"
	
	tdx="<input type=hidden name=Act value='Step2'><input name='submit' type='submit' id='submit' value=' ��һ�� ' disabled>"
	tb1.addTd "height='40' align='center' class='tdbg'",tdx
	tb1.addTr ""
	tb1.out
	showHeadTail false
end sub

sub Step2()
	Dim SX(9,4)
	SX(0,0)="admin_user" '�ֶ���
	SX(0,1)="����Ա�û���" '��ʾ��Ϣ
	SX(0,2)="�Ժ�ͨ�����û������°�װ����ƽ̨,����������" '˵��
	SX(0,3)="admin" 'Ĭ��ֵ
	SX(0,4)="yes" '�Ƿ����

	SX(1,0)="admin_pass" '�ֶ���
	SX(1,1)="����Ա����" '��ʾ��Ϣ
	SX(1,2)="��¼�����̨ʱʹ��" '˵��
	SX(1,3)="admin888" 'Ĭ��ֵ
	SX(1,4)="yes" '�Ƿ����

	SX(2,0)="companyname" '�ֶ���
	SX(2,1)="��վ����" '��ʾ��Ϣ
	SX(2,2)="����ʾ����ҳ������,Ҳ���������������֪ͨ��" '˵��
	SX(2,3)=companyname 'Ĭ��ֵ
	SX(2,4)="yes" '�Ƿ����

	SX(3,0)="companynameurl" '�ֶ���
	SX(3,1)="��վ����" '��ʾ��Ϣ
	SX(3,2)="������վ������������http://��ͷ,�����������д��Ч����,�����Ժ󲿷ֹ��ܽ��޷�ʹ��" '˵��
	SX(3,3)="http://" & Request.ServerVariables("SERVER_NAME") 'Ĭ��ֵ
	SX(3,4)="no" '�Ƿ����

	SX(4,0)="SystemAdminPath" '�ֶ���
	SX(4,1)="��̨����·��" '��ʾ��Ϣ
	SX(4,2)="�������޸�" '˵��
	SX(4,3)=SystemAdminPath 'Ĭ��ֵ
	SX(4,4)="yes" '�Ƿ����

	SX(5,0)="api_url" '�ֶ���
	SX(5,1)="�ϼ������̽ӿ�" '��ʾ��Ϣ
	SX(5,2)="���������ѯ�ϼ�������,������http://��ͷ��������ҵ���޷���ͨ" '˵��
	SX(5,3)=api_url 'Ĭ��ֵ
	SX(5,4)="yes" '�Ƿ����

	SX(6,0)="api_username" '�ֶ���
	SX(6,1)="api�����û���" '��ʾ��Ϣ
	SX(6,2)="����д����˾�Ļ�Ա�û���" '˵��
	SX(6,3)=api_username 'Ĭ��ֵ
	SX(6,4)="yes" '�Ƿ����

	SX(7,0)="api_password" '�ֶ���
	SX(7,1)="api��������" '��ʾ��Ϣ
	SX(7,2)="<font color=red>����,�˴����������д����˾��������-�����̹���-API�ӿ������е�����</font>" '˵��
	SX(7,3)=api_password 'Ĭ��ֵ
	SX(7,4)="yes" '�Ƿ����
	
	SX(8,0)="webmanagesrepwd" '�ֶ���
	SX(8,1)="����ַ���" '��ʾ��Ϣ
	SX(8,2)="�벻Ҫ�޸Ĵ�����" '˵��
	SX(8,3)=CreateRandomKey(16) 'Ĭ��ֵ
	SX(8,4)="yes" '�Ƿ����

    SX(9,0)="webmanagespwd" '�ֶ���
	SX(9,1)="��̨ר������" '��ʾ��Ϣ
	SX(9,2)="��װʱ�뱣��Ϊ��" '˵��
	SX(9,3)="" 'Ĭ��ֵ
	SX(9,4)="no" '�Ƿ����
 

	doAct=Request.Form("doAct")
	
	if doAct="" then
		Set ZZ=new table
		showHeadTail true
		
		ZZ.addTb "100"
		ZZ.addTd "height='22' colspan='2' align='center'","<strong>�����������ƽ̨��װ��</strong>"
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
		tdx="<input name='doAct' type='hidden' value='SAVE'><input name='Act' type='hidden' value='Step2'><input name='submit' type='submit' id='submit' value=' ��һ�� '>"
		ZZ.addTd "height='40' colspan='2' align='center' class='tdbg'",tdx
		ZZ.addTr ""
		ZZ.out
		showHeadTail false
	else
		for iIndex=0 to Ubound(SX)
			if SX(iIndex,4)="yes" then
				if Request.Form(SX(iIndex,0))="" then
					Response.write "<script language=javascript>alert('" & SX(iIndex,1) & "������д������Ϊ��');history.back();</script>"
					Response.end
				end if
			end if	
		next

		companynameurl=Request.Form("companynameurl")
		if lcase(left(companynameurl,7))<>"http://" then
				Response.write "<script language=javascript>alert('��˾��ַ������http://��ͷ');history.back();</script>"
				Response.end
		end if

		'�޸Ĺ����̨·��
		rename "/siteadmin",Request.Form("SystemAdminPath")
		u_name=Request.Form("admin_user")
		u_pass=Request.Form("admin_pass")
		
		if isBad(u_name,u_pass,binfo) then url_return "�������������ڼ򵥣����������á�",-1
		
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
			Response.wrtie "<script language=javascript>alert('�����¹����̨·���ĸ�ʽ��:/��ĸ');history.back();</script>"
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
	lrs("u_contract")="����Ա"
	lrs("u_contry")="CN"
	lrs("u_province")="chengdu"
	lrs("u_city")="����"
	lrs("u_address")="������ϸ��ַ���벹������"
	lrs("u_zipcode")="000000"
	lrs("u_fax")=""
	lrs("u_borrormax")=0
	lrs("u_checkmoney")=0
	lrs("u_remcount")=0
	lrs("u_usemoney")=0
	lrs("u_premoney")=0
	lrs("u_accumulate")=0
	lrs("u_resumesum")=0
	lrs("U_levelName")="��ͨ�û�"
	lrs("u_bizbid")=1
	lrs("u_namecn")="����Ա"
	lrs("u_nameEn")="english name"
	lrs("u_mode")=1

	lrs.update

	lrs.addnew

	lrs("u_name")="AgentUserVCP"
	lrs("u_level")=2
	lrs("u_type")="0"
	lrs("u_right")=0
	lrs("u_father")=0
	lrs("u_company")="VCP��ɲο��û�"
	lrs("u_telphone")="000-00000000"
	lrs("u_email")="xxx@xxx.com"
	lrs("u_desable")=false
	lrs("u_regdate")=now()
	lrs("u_password")=u_pass
	lrs("u_contract")="VCP��ɲο��û�"
	lrs("u_contry")="CN"
	lrs("u_province")="chengdu"
	lrs("u_city")="����"
	lrs("u_address")="VCP��ɼ۸񽫲ο����û������,����ɾ��!"
	lrs("u_zipcode")="000000"
	lrs("u_fax")=""
	lrs("u_borrormax")=0
	lrs("u_checkmoney")=0
	lrs("u_remcount")=0
	lrs("u_usemoney")=0
	lrs("u_premoney")=0
	lrs("u_accumulate")=0
	lrs("u_resumesum")=0
	lrs("U_levelName")="������"
	lrs("u_bizbid")=1
	lrs("u_namecn")="VCP��ɲο��û�"
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
	ZZ.addTd "height='22'","<strong>��ϲ�㣡</strong>"
	ZZ.addTr "align='center' class='title'"

	ZZ.AddTd "height='100' valign='top'","<br>ϵͳ��װ��ɣ����������ʹ��ϵͳ�ˡ�<br>Ϊ��<font color='red'>ϵͳ��ȫ</font>����������İ�ťɾ���˰�װ�ļ���Install.asp��<br><br><div align='center'><input name='delfile' type='button' id='delfile' value=' ɾ���˰�װ�ļ� ' onclick=""location='install.asp?Act=Stepdel'""></div><br>"
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