<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include virtual="/manager/config/config.asp" -->
<!--#include virtual="/config/uercheck.asp" -->
<%call needregSession()%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�û������̨-����֧��</title>
<link href="<%=managercss1%>" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=managercss2%>" type="text/css" />


<%
cur=0
'defaultpay,tenpay,yeepay,alipay
'fy,userid,userpass,account
paymoney=requesta("paymoney")
if not isnumeric(paymoney&"") then paymoney=""
%>
<script language=javascript>
function dosub(v)
{
	var p=v.payMoney;
	var xx=false
	var rexg=/^\d+\.?\d{0,2}$/
	if(rexg.test(p.value)){
		
		if (p.value.substr(p.value.length-1,1)!='.'){
			xx=true
		}
	}
	if (!xx){
		alert('����ȷ����Ԥ������');
		p.focus();
		return false;
	}
	return true;

}
</script>
</head>
<body id="thrColEls">

<div class="Style2009"> 
  <!--#include virtual="/manager/top.asp" -->
  <div id="MainContentDIV"> 
    <!--#include virtual="/manager/manageleft.asp" -->
    <div id="MainRight">
      <div class="new_right"> 
        <!--#include virtual="/manager/pulictop.asp" -->
        
        <div class="main_table">
          <div class="tab">����֧��</div>
          <div class="table_out">

<table width="100%" border="0" cellpadding="3" cellspacing="0" class="border">
<form name="form1" action="onlinePayMore.asp" method="post">
  <tr>
    <td align="right" nowrap="nowrap" class="tdbg"><strong>ѡ��֧������:</strong></td>
    <td class="tdbg">
    <style>
	.bx tr{ border-bottom:1px #CCC solid;}
	</style>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="bx">
        
          <%if defaultpay then
		  	checked=""
		  	if cur=0 then checked=" checked "
		  	cur=cur+1
			
		  %>
          <tr>
            <td width="34%" height="60" align="center" nowrap="nowrap"><img src="onlineImg/2.gif" width="96" height="37" alt="Ĭ��֧���ӿ�" title="Ĭ��֧���ӿ�" /></td>
            <td width="7%"><input type="radio" name="paytype" value="defaultpay" <%=checked%>></td>
            <td width="59%" nowrap="nowrap">������:<%=defaultpay_fy%></td>
          </tr>
          <%end if%>
          <%if tenpay then
		  	checked=""
		  	if cur=0 then checked=" checked "
		  	cur=cur+1
			
			%>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/3.gif" alt="�Ƹ�֧ͨ��" title="�Ƹ�֧ͨ��" /></td>
            <td><input type="radio" name="paytype" value="tenpay" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=tenpay_fy%></td>
          </tr>
          <%end if%>
          <%if yeepay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			
		  %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/1.jpg" alt="�ױ�֧��" title="�ױ�֧��" /></td>
            <td><input type="radio" name="paytype" value="yeepay" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=yeepay_fy%></td>
          </tr>
          <%end if%>
          <%if alipay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/2.gif" width="96" height="37" alt="֧����֧��" title="֧����֧��" /></td>
            <td><input type="radio" name="paytype" value="alipay" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=alipay_fy%></td>
          </tr>
          <%end if%>
            <%if kuaiqian then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/4.jpg" title="��Ǯ֧��v1.0" alt="��Ǯ֧��v1.0"/></td>
            <td><input type="radio" name="paytype" value="kuaiqian" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=kuaiqian_fy%></td>
          </tr>
          <%end if%>
           <%if kuaiqian2 then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/4.jpg" alt="��Ǯ֧��v2.0" title="��Ǯ֧��v2.0" /></td>
            <td><input type="radio" name="paytype" value="kuaiqian2" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=kuaiqian2_fy%></td>
          </tr>
          <%end if%>
           <%if cncard then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/5.jpg" title="����֧��" alt="����֧��" /></td>
            <td><input type="radio" name="paytype" value="cncard" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=cncard_fy%></td>
          </tr>
          <%end if%>
          <%if chinabank then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/6.jpg" alt="��������֧��" title="��������֧��" /></td>
            <td><input type="radio" name="paytype" value="chinabank" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=chinabank_fy%></td>
          </tr>
          <%end if%>
          
          <%if shengpay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/7.jpg" alt="ʢ��֧ͨ��" title="ʢ��֧ͨ��" /></td>
            <td><input type="radio" name="paytype" value="shengpay" <%=checked%>></td>
            <td nowrap="nowrap">������:<%=shengpay_fy%></td>
          </tr>
          <%end if%>


       
      </table></td>
  </tr>
  <%if cur>=1 then%>
  <tr>
    <td align="right" nowrap="nowrap" class="tdbg"><font color="#FF0000"><strong>Ԥ������:</strong></font></td>
    <td class="tdbg"><input name="payMoney" type="text"  onkeyup="this.value=this.value.replace(/\D/g,'')" size="10" maxlength="10" onafterpaste="this.value=this.value.replace(/\D/g,'')" value="<%=paymoney%>">
      Ԫ(<font color="#FF0000">ֻ����������</font>)</td>
  </tr>
  <tr>
    <td colspan="2" align="center" class="tdbg"><input type="submit" value="�� һ ��" onclick="return dosub(this.form)"></td>
  </tr>
  <%else%>
   <tr>
    <td colspan="2" class="tdbg">�Բ��𣬹���Աû����������֧������.</td>
  	</tr>
  <%end if%>
   </form>
</table>

          
          
          
            
          </div>
        </div>
      </div>
    </div>
  </div>
 <!--#include virtual="/manager/bottom.asp" -->
</div>






</body>
</html>
