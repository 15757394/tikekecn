<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="/template/Tpl_04/images/spacer.gif" width="3" height="2"></td>
  </tr>
</table>
<table width="1002" border="0" align="center" cellpadding="8" cellspacing="0" class="VHostbg">
  <tr>
    <td valign="top"><a href="/">������ҳ</a> |<a href="/aboutus/">��������</a> 
            | <a href="/aboutus/contact.asp">��ϵ����</a> | <a href="/customercenter/howpay.asp">���ʽ</a> 
      | <a href="/agent/mode-d.asp">�������</a> | <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">���ʱش�</a><br>
        ��Ȩ���� <%=companyname%>���Ͻ����� <br>
        ���߿ͷ�: 
         <%
		for each oicqitem in split(oicq,",")
		%>
         <a target=blank href=tencent://message/?uin=<%=oicqitem%>&Site=<%=companyname%>&Menu=yes><img border="0" src=http://wpa.qq.com/pa?p=1:<%=oicqitem%>:4 alt="���������Ϣ���Է�"><%=oicqitem%></a>
        <%next%>
        <br>
�������ߣ�<%=telphone%>�����棺<%=faxphone%><br>
        ��Ϣ������<a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">ҵ����ѯ</a> 
        <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">��������</a> 
        <a href="/manager/default.asp?page_main=/Manager/question/subquestion.asp">����Ͷ��</a> 
        ���л����񹲺͹���ֵ����ҵ��Ӫ����֤����B2-20030065�� <br>

</td>
  </tr>
</table>