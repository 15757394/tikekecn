<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include virtual="/config/config.asp" -->

<!--#include virtual="/config/Template.inc.asp" --> 
<%
response.buffer=true
response.charset="gb2312"
u_name=Trim(requesta("param"))

if ucase(left(u_name,3))=ucase("qq_") then
response.Write("�ʺŲ�����qq_��ͷ!")
response.End()
end if

if u_name="" then 
response.Write("�ʺŴ���")
response.End()
end if


conn.open constr
	vsql="select top 1 * from userdetail where u_name='"&u_name&"'"
	set vRs=conn.execute(vsql)
	if not vRs.eof Then
	 response.Write(u_name&"�Ѿ����ڣ����������롣")
	 else
	 response.Write("y")
    end if

%>