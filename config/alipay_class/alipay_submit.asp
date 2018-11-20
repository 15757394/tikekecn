<%
' ������AlipaySubmit
' ���ܣ�֧�������ӿ������ύ��
' ��ϸ������֧�������ӿڱ���HTML�ı�����ȡԶ��HTTP����
' �汾��3.2
' �޸����ڣ�2011-03-31
' ˵����
' ���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
' �ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο�
%>

<!--#include file="alipay_function.asp"-->

<%

Class AlipaySubmit

	''
	' ����Ҫ�����֧�����Ĳ�������
	' param sParaTemp ����ǰ�Ĳ�������
	' param key ���װ�ȫУ����
	' param sign_type ǩ������
	' param input_charset �����ʽ
	' return Ҫ����Ĳ�������
	Private Function BuildRequestPara(sParaTemp, key, sign_type, input_charset)
		Dim mysign
		'����ǩ����������
		sPara = FilterPara(sParaTemp)
		
		'�����������������
		sParaSort = SortPara(sPara)
		
		'���ǩ�����
		mysign = BuildMysign(sParaSort, key, sign_type, input_charset)
		
		'ǩ�������ǩ����ʽ���������ύ��������
		nCount = ubound(sParaSort)
		Redim Preserve sParaSort(nCount+1)
		sParaSort(nCount+1) = "sign="&mysign
		Redim Preserve sParaSort(nCount+2)
		sParaSort(nCount+2) = "sign_type="&sign_type

		BuildRequestPara = sParaSort
	End Function
	
	''
	' ����Ҫ�����֧�����Ĳ��������ַ���
	' param sParaTemp ����ǰ�Ĳ�������
	' param key ���װ�ȫУ����
	' param sign_type ǩ������
	' param input_charset �����ʽ
	' return Ҫ����Ĳ��������ַ���
	Private Function BuildRequestParaToString(sParaTemp, key, sign_type, input_charset)
		Dim sRequestData
		'��ǩ�������������
		sPara = BuildRequestPara(sParaTemp, key, sign_type, input_charset)
		'�Ѳ�����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
		sRequestData = CreateLinkString(sPara)
		
		BuildRequestParaToString = sRequestData
	End Function

	''
	' �����ύ����HTML����
	' param sParaTemp ����ǰ�Ĳ�������
	' param key ���װ�ȫУ����
	' param sign_type ǩ������
	' param input_charset �����ʽ
	' param gateway ���ص�ַ
	' param sMethod �ύ��ʽ������ֵ��ѡ��post��get
	' param sButtonValue ȷ�ϰ�ť��ʾ����
	' return �ύ����HTML�ı�
	Public Function BuildFormHtml(sParaTemp, key, sign_type, input_charset, gateway, sMethod, sButtonValue)
		Dim sHtml, nCount
		'�������������
		sPara = BuildRequestPara(sParaTemp, key, sign_type, input_charset)
		
		sHtml = "<form id='alipaysubmit' name='alipaysubmit' action='"& gateway &"_input_charset="&input_charset&"' method='"&sMethod&"'>"
		
		nCount = ubound(sPara)
		For i = 0 To nCount
			'��sPara���������Ԫ�ظ�ʽ��������=ֵ���ָ��
			iPos = Instr(sPara(i),"=")			'���=�ַ���λ��
			nLen = Len(sPara(i))				'����ַ�������
			sItemName = left(sPara(i),iPos-1)	'��ñ�����
			sItemValue = right(sPara(i),nLen-iPos)'��ñ�����ֵ
		
			sHtml = sHtml & "<input type='hidden' name='"& sItemName &"' value='"& sItemValue &"'/>"
		next

		'submit��ť�ؼ��벻Ҫ����name����
		'sHtml = sHtml & "<input type='submit' value='"&sButtonValue&"'></form>"
		
		sHtml = sHtml & "<script>document.forms['alipaysubmit'].submit();</script>"
		
		BuildFormHtml = sHtml
	End Function
	
	''
	' ����ģ��Զ��HTTP��GET���󣬻�ȡ֧�����ķ���XML�������
	' param sParaTemp ����ǰ�Ĳ�������
	' param key ���װ�ȫУ����
	' param sign_type ǩ������
	' param input_charset �����ʽ
	' param gateway ���ص�ַ
	' return ֧��������XML�������
	Public Function SendGetInfo(sParaTemp, key, sign_type, input_charset, gateway)
		Dim sUrl, objHttp, objXml, sXmlData
		'��������������ַ���
		sRequestData = BuildRequestParaToString(sParaTemp, key, sign_type, input_charset)
		'���������ַ
		sUrl = gateway & sRequestData

		'��ȡԶ������
		Set objHttp=Server.CreateObject("Microsoft.XMLHTTP")
		'���Microsoft.XMLHTTP���У���ô���滻����������д��볢��
		'Set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		'objHttp.setOption 2, 13056
		objHttp.open "GET", sUrl, False, "", ""
		objHttp.send()
		Set objXml=Server.CreateObject("Microsoft.XMLDOM")
		objXml.Async=true
		objXml.ValidateOnParse=False
		objXml.Load(objHttp.ResponseXML)
		Set objHttp = Nothing
		
		SendGetInfo = objXml
	End Function

End Class

%>