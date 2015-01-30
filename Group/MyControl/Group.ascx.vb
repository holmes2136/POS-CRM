imports System.Data
imports System.Data.OleDB

Partial Class Group
    Inherits System.Web.UI.UserControl


 


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


		Dim dt As DataTable = GetData()
		'Response.write(dt.rows.count)
     	R1.DataSource = dt.DefaultView
   		R1.DataBind()
	 


    End Sub
	
	
	Private Function GetData()As DataTable
		
		Dim connStr As String = ConfigurationManager.AppSettings("MM_CONNECTION_STRING_linkC001")
		
		Dim dt As DataTable
		Dim conn As New OleDBConnection
		conn.connectionString = connStr
		
	
		Dim cmd As New OleDBCommand
		
		cmd.CommandText = "SELECT  群組,Count(CustId)As Counts,識別碼 FROM (類別群組 a LEFT JOIN Customer b On  a.群組 = b.CustGroup) GROUP BY 群組,識別碼 "
		
		cmd.Connection = conn
		conn.open
		
		USING conn
			dt = New DataTable
			dt.Load(cmd.ExecuteReader) 
		END USING
		
		RETURN dt
	
	
	End Function

    
End Class