<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<!--#include virtual="~/site/CRM/SQLAccess/Connection.aspx.vb" -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
		'Response.write(Session("CustIds"))
		
		'Dim CustIdGroup As String = Session("CustIds")
		
		
		Dim table As New DataTable
        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		'Dim sql As String = "select * from Customer Where CustId In( " & CustIdGroup & ")"
        Dim sql As String = ""
		IF NOT Session("CustIds")IS NOTHING THEN
			sql = Session("CustIds")
		ELSE
			sql = "SELECT  * FROM 客戶資料表"
		END IF
		cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()

        table.Load(cmd.ExecuteReader)

        ExportDataTableToExcel(table)
		
	
			
			
End Sub


'傳入DataTable後, 並指定為Excel格式
Public Sub ExportDataTableToExcel(ByVal pDataTable As DataTable)

        
        Dim tRowCount As Integer = pDataTable.Rows.Count
        Dim tColumnCount As Integer = pDataTable.Columns.Count
        Response.Expires = 0
        Response.Clear()
        Response.Buffer = True
        Response.Charset = "utf-8"
        Response.ContentEncoding = System.Text.Encoding.UTF8
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("Content-Disposition", "attachment; filename=CustomerList.txt")
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
