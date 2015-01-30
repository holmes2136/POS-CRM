<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<!--#include virtual="~/site/TodayBillPlatfom/Shop/c037/Cust/SQLAccess/Connection.aspx.vb"-->

<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
		
		Dim ExportType As String = IIF(Not request.QueryString("type") Is Nothing,request.QueryString("type"),"all")
		
		Dim sql As String = ""
		
		IF ExportType = "choose" THEN
			IF Not String.IsNullOrEmpty(Session("CustIds")) THEN
				sql = Session("CustIds")
			ELSE
				sql = "select top 200 * from 客戶資料表 where CustTelPhone <> 'NoData'"

			END IF
		Else
		END IF
		
		Dim table As New DataTable

        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		
        cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
	Using conn
        table.Load(cmd.ExecuteReader)

        ExportDataTableToExcel(table)
	End Using
		'conn.Close()
			
End Sub


'傳入DataTable後, 透過Response.Write將資料寫到client端, 並指定為Txt格式

    Public Sub ExportDataTableToExcel(ByVal pDataTable As DataTable)


        Dim content As New StringBuilder

        Dim tRowCount As Integer = pDataTable.Rows.Count
        Dim tColumnCount As Integer = pDataTable.Columns.Count
        Response.Expires = 0
        Response.Clear()
        Response.Buffer = True
        Response.Charset = "utf-8"
        Response.ContentEncoding = System.Text.Encoding.UTF8
        Response.ContentType = "application/vnd.ms-word"
        Response.AddHeader("Content-Disposition", "attachment; filename=CustomerMobileList.txt")
    

		

        'For i As Integer = 0 To tColumnCount - 1


            content.Append(pDataTable.Columns(14).ColumnName)


	
       'Next
      
        content.AppendLine()
		content.AppendLine()

        For j As Integer = 0 To tRowCount - 1


      
            'For k As Integer = 0 To tColumnCount - 1
               
                content.AppendLine(pDataTable.Rows(j)(14).ToString)

                



            'Next
            
            content.AppendLine()

        Next


        Response.Write(content.ToString)


        

        Response.End()

    End Sub



</script>


</head>
<body>
</body>
</html>
