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
			Else
			sql = "select top 200 CustId As 客戶編號,CustName as 姓名,CustGender as 性別 ,CustBirthDay as 生日,CustTelPhone as 電話,CustMobile as 手機,CustEmail as 信箱,CustAddress as 地址 from 客戶資料表 "
			
			END IF
		
		END IF
		
		Dim table As New DataTable

        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
	Using conn
        table.Load(cmd.ExecuteReader)
	End Using
        ExportDataTableToExcel(table)
		
	
			
End Sub


'傳入DataTable後, 透過Response.Write將資料寫到client端, 並指定為Excel格式
Public Sub ExportDataTableToExcel(ByVal pDataTable As DataTable)

        
        Dim tRowCount As Integer = pDataTable.Rows.Count
        Dim tColumnCount As Integer = pDataTable.Columns.Count
        Response.Expires = 0
        Response.Clear()
        Response.Buffer = True
        Response.Charset = "utf-8"
        Response.ContentEncoding = System.Text.Encoding.UTF8
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=Customer.xls")
        Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>")

        Response.Write("<Table borderColor=black border=1>")
        Response.Write("<TR>")

        For i As Integer = 0 To tColumnCount - 1

            Response.Write("<TD  bgcolor = #fff8dc>")
            Response.Write(pDataTable.Columns(i).ColumnName)
            Response.Write("</TD>")


        Next
        Response.Write(" </TR>")


        For j As Integer = 0 To tRowCount - 1


            Response.Write(" <TR>")
            For k As Integer = 0 To tColumnCount - 1
                Response.Write("<TD align=\right\ x:num>")

                Response.Write(pDataTable.Rows(j)(k).ToString())
                Response.Write("</TD>")



            Next
            Response.Write("</TR>")
        Next




        Response.Write("</Table>")

        Response.End()

    End Sub




</script>


</head>
<body>
</body>
</html>
