<%
'����ָ��Ŀ¼������һ�������������ļ���Ϣ��xml�ļ�

Set fso = CreateObject("scripting.filesystemobject")
Set doc=CreateObject("microsoft.xmldom")
StartPath= "D:\DM��վ\����asp"				'ɨ��Ŀ¼
xmlfile= Server.mappath("\sitexml.xml")		'xml�ļ�����λ��

Set p=doc.createProcessingInstruction("xml","version='1.0' encoding='GBK'")
doc.insertBefore p, doc.childNodes(0)
Set root=doc.CreateElement("filedata")		'������
'���ø�����'root.setattribute "autoPlayTime","5"
doc.AppendChild(root)

Call getallfile(StartPath)
Call getallfolder(StartPath)

doc.Save(xmlfile)
Set doc=Nothing
If Err.number=0 Then response.write "200 ok" &now()

Sub getallfolder(path)
  Set objfolder=fso.GetFolder(path)
  Set objSubFolders=objFolder.SubFolders :  Set objfolder=Nothing
  For each objSubFolder in objSubFolders 
    nowpath=path & "\" & objSubFolder.name
    Call getallfolder(nowpath)
    Call getallfile(nowpath)
  Next
End Sub
Sub getallfile(fold)
    Set objfiles=fso.GetFolder(fold)
    For Each objfile In objfiles.Files
		path_=CStr(LCase(Mid(objfile.Path,Len(StartPath)+1)))
    	Call savename(path_,objfile.DateLastModified,objfile.Size)
    Next
    Set objfiles=Nothing
End Sub

Sub savename(f_path,f_time,f_size)
	set childNode=doc.CreateElement("myfile")
	root.AppendChild(childNode)
	'��������
	childNode.SetAttribute "path",f_path
	childNode.SetAttribute "time",f_time
	childNode.SetAttribute "size",f_size
End Sub
%>