<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/template/Tpl_04/images/spacer.gif" width="3" height="2"></td>
  </tr>
</table>
<table width="1002" border="0" align="center" cellpadding="8" cellspacing="0" class="VHostbg">
  <tr>
    <td valign="top"><a href="/">返回首页</a> |<a href="/aboutus/">关于我们</a> 
            | <a href="/aboutus/contact.asp">联系我们</a> | <a href="/customercenter/howpay.asp">付款方式</a> 
      | <a href="/agent/mode-d.asp">广告联盟</a> | <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">有问必答</a><br>
        版权所有 <%=companyname%>·严禁复制 <br>
        在线客服: 
         <%
		for each oicqitem in split(oicq,",")
		%>
         <a target=blank href=tencent://message/?uin=<%=oicqitem%>&Site=<%=companyname%>&Menu=yes><img border="0" src=http://wpa.qq.com/pa?p=1:<%=oicqitem%>:4 alt="点击发送消息给对方"><%=oicqitem%></a>
        <%next%>
        <br>
服务热线：<%=telphone%>　传真：<%=faxphone%><br>
        信息反馈：<a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">业务咨询</a> 
        <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">技术问题</a> 
        <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">问题投诉</a> 
        《中华人民共和国增值电信业务经营许可证》川B2-20030065号 <br>

</td>
  </tr>
</table>
