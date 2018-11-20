<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!--#include virtual="/manager/config/config.asp" -->
<!--#include virtual="/config/uercheck.asp" -->
<%call needregSession()%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>用户管理后台-在线支付</title>
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
		alert('请正确输入预付款金额');
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
          <div class="tab">在线支付</div>
          <div class="table_out">

<table width="100%" border="0" cellpadding="3" cellspacing="0" class="border">
<form name="form1" action="onlinePayMore.asp" method="post">
  <tr>
    <td align="right" nowrap="nowrap" class="tdbg"><strong>选择支付网关:</strong></td>
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
            <td width="34%" height="60" align="center" nowrap="nowrap"><img src="onlineImg/2.gif" width="96" height="37" alt="默认支付接口" title="默认支付接口" /></td>
            <td width="7%"><input type="radio" name="paytype" value="defaultpay" <%=checked%>></td>
            <td width="59%" nowrap="nowrap">手续费:<%=defaultpay_fy%></td>
          </tr>
          <%end if%>
          <%if tenpay then
		  	checked=""
		  	if cur=0 then checked=" checked "
		  	cur=cur+1
			
			%>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/3.gif" alt="财付通支付" title="财付通支付" /></td>
            <td><input type="radio" name="paytype" value="tenpay" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=tenpay_fy%></td>
          </tr>
          <%end if%>
          <%if yeepay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			
		  %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/1.jpg" alt="易宝支付" title="易宝支付" /></td>
            <td><input type="radio" name="paytype" value="yeepay" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=yeepay_fy%></td>
          </tr>
          <%end if%>
          <%if alipay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/2.gif" width="96" height="37" alt="支付宝支付" title="支付宝支付" /></td>
            <td><input type="radio" name="paytype" value="alipay" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=alipay_fy%></td>
          </tr>
          <%end if%>
            <%if kuaiqian then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/4.jpg" title="快钱支付v1.0" alt="快钱支付v1.0"/></td>
            <td><input type="radio" name="paytype" value="kuaiqian" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=kuaiqian_fy%></td>
          </tr>
          <%end if%>
           <%if kuaiqian2 then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/4.jpg" alt="快钱支付v2.0" title="快钱支付v2.0" /></td>
            <td><input type="radio" name="paytype" value="kuaiqian2" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=kuaiqian2_fy%></td>
          </tr>
          <%end if%>
           <%if cncard then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/5.jpg" title="云网支付" alt="云网支付" /></td>
            <td><input type="radio" name="paytype" value="cncard" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=cncard_fy%></td>
          </tr>
          <%end if%>
          <%if chinabank then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/6.jpg" alt="网银在线支付" title="网银在线支付" /></td>
            <td><input type="radio" name="paytype" value="chinabank" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=chinabank_fy%></td>
          </tr>
          <%end if%>
          
          <%if shengpay then
		  		checked=""
		  		if cur=0 then checked=" checked "
		  		cur=cur+1
			 %>
          <tr>
            <td height="60" align="center" nowrap="nowrap"><img src="onlineImg/7.jpg" alt="盛付通支付" title="盛付通支付" /></td>
            <td><input type="radio" name="paytype" value="shengpay" <%=checked%>></td>
            <td nowrap="nowrap">手续费:<%=shengpay_fy%></td>
          </tr>
          <%end if%>


       
      </table></td>
  </tr>
  <%if cur>=1 then%>
  <tr>
    <td align="right" nowrap="nowrap" class="tdbg"><font color="#FF0000"><strong>预付款金额:</strong></font></td>
    <td class="tdbg"><input name="payMoney" type="text"  onkeyup="this.value=this.value.replace(/\D/g,'')" size="10" maxlength="10" onafterpaste="this.value=this.value.replace(/\D/g,'')" value="<%=paymoney%>">
      元(<font color="#FF0000">只能输入整数</font>)</td>
  </tr>
  <tr>
    <td colspan="2" align="center" class="tdbg"><input type="submit" value="下 一 步" onclick="return dosub(this.form)"></td>
  </tr>
  <%else%>
   <tr>
    <td colspan="2" class="tdbg">对不起，管理员没有启用在线支付功能.</td>
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
