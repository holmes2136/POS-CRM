<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css"> 

/* default css */
 
table {
  font-size: 1em;
  line-height: inherit;
  border-collapse: collapse;
}
 
 
tr {
  
  text-align: left;
  
}
 
 
div, address, ol, ul, li, option, select {
  margin-top: 0px;
  margin-bottom: 0px;
}
 
p {
  margin: 0px;
}
 
 
pre {
  font-family: Courier New;
  white-space: pre-wrap;
  margin:0;
}
 
body {
  margin: 6px;
  padding: 0px;
  font-family: Verdana, sans-serif;
  font-size: 10pt;
  background-color: #ffffff;
  color: #000;
}
 
 
img {
  -moz-force-broken-image-icon: 1;
}
 
@media screen {
  html.pageview {
    background-color: #f3f3f3 !important;
    overflow-x: hidden;
    overflow-y: scroll;
  }
 
  
 
  body {
    min-height: 1100px;
    
    counter-reset: __goog_page__;
  }
  
  * html body {
    height: 1100px;
  }
  /* Prevent repaint errors when scrolling in Safari. This "Star-7" css hack
     targets Safari 3.1, but not WebKit nightlies and presumably Safari 4.
     That's OK because this bug is fixed in WebKit nightlies/Safari 4 :-). */
  html*#wys_frame::before {
    content: '\A0';
    position: fixed;
    overflow: hidden;
    width: 0;
    height: 0;
    top: 0;
    left: 0;
  }
  
  .pageview body {
    border-top: 1px solid #ccc;
    border-left: 1px solid #ccc;
    border-right: 2px solid #bbb;
    border-bottom: 2px solid #bbb;
    width: 648px !important;
    margin: 15px auto 25px;
    padding: 40px 50px;
  }
  /* IE6 */
  * html {
    overflow-y: scroll;
  }
  * html.pageview body {
    overflow-x: auto;
  }
  
 
  
    
    .writely-callout-data {
      display: inline-block;
      width: 0;
      height: 0;
      overflow: hidden;
    }
    
 
    .writely-footnote-marker {
      background-image: url('images/footnote_doc_icon.gif');
      background-color: transparent;
      background-repeat: no-repeat;
      width: 7px;
      overflow: hidden;
      height: 16px;
      vertical-align: top;
 
      
      -moz-user-select: none;
    }
    .editor .writely-footnote-marker {
      cursor: move;
    }
    .writely-footnote-marker-highlight {
      background-position: -15px 0;
      -moz-user-select: text;
    }
    .writely-footnote-hide-selection ::-moz-selection, .writely-footnote-hide-selection::-moz-selection {
      background: transparent;
    }
    .writely-footnote-hide-selection ::selection, .writely-footnote-hide-selection::selection {
      background: transparent;
    }
    .writely-footnote-hide-selection {
      cursor: move;
    }
 
    /* Comments */
    .writely-comment-yellow {
      background-color: #ffffd7;
    }
    .writely-comment-orange {
      background-color: #ffe3c0;
    }
    .writely-comment-pink {
      background-color: #ffd7ff;
    }
    .writely-comment-green {
      background-color: #d7ffd7;
    }
    .writely-comment-blue {
      background-color: #d7ffff;
    }
    .writely-comment-purple {
      background-color: #eed7ff;
    }
 
  
 
 
  
  .br_fix span+br:not(:-moz-last-node) {
    
    position:relative;
    
    left: -1ex
    
  }
 
  
  #cb-p-tgt {
    font-size: 8pt;
    padding: .4em;
    background-color: #ddd;
    color: #333;
  }
  #cb-p-tgt-can {
    text-decoration: underline;
    color: #36c;
    font-weight: bold;
    margin-left: 2em;
  }
  #cb-p-tgt .spin {
    width: 16px;
    height: 16px;
    background: url(//ssl.gstatic.com/docs/clipboard/spin_16o.gif) no-repeat;
  }
}
 
h6 { font-size: 8pt }
h5 { font-size: 8pt }
h4 { font-size: 10pt }
h3 { font-size: 12pt }
h2 { font-size: 14pt }
h1 { font-size: 18pt }
 
blockquote {padding: 10px; border: 1px #DDD dashed }
 
.webkit-indent-blockquote { border: none; }
 
a img {border: 0}
 
.pb {
  border-width: 0;
  page-break-after: always;
  /* We don't want this to be resizeable, so enforce a width and height
     using !important */
  height: 1px !important;
  width: 100% !important;
}
 
.editor .pb {
  border-top: 1px dashed #C0C0C0;
  border-bottom: 1px dashed #C0C0C0;
}
 
div.google_header, div.google_footer {
  position: relative;
  margin-top: 1em;
  margin-bottom: 1em;
}
 
 
/* Table of contents */
.editor div.writely-toc {
  background-color: #f3f3f3;
  border: 1px solid #ccc;
}
.writely-toc > ol {
  padding-left: 3em;
  font-weight: bold;
}
ol.writely-toc-subheading {
  padding-left: 1em;
  font-weight: normal;
}
/* IE6 only */
* html writely-toc ol {
  list-style-position: inside;
}
.writely-toc-none {
  list-style-type: none;
}
.writely-toc-decimal {
  list-style-type: decimal;
}
.writely-toc-upper-alpha {
  list-style-type: upper-alpha;
}
.writely-toc-lower-alpha {
  list-style-type: lower-alpha;
}
.writely-toc-upper-roman {
  list-style-type: upper-roman;
}
.writely-toc-lower-roman {
  list-style-type: lower-roman;
}
.writely-toc-disc {
  list-style-type: disc;
}
 
/* Ordered lists converted to numbered lists can preserve ordered types, and
   vice versa. This is confusing, so disallow it */
ul[type="i"], ul[type="I"], ul[type="1"], ul[type="a"], ul[type="A"] {
  list-style-type: disc;
}
 
ol[type="disc"], ol[type="circle"], ol[type="square"] {
  list-style-type: decimal;
}
 
/* end default css */
 
 
 
/* custom css */
 
@page {
  margin: 0pt;
  size: Letter Portrait !important;
}
@media print {
  div#Sheet {
    position: relative;
	line-height:25px;
    margin: 0pt;
    padding: 0pt;
	font-size:16px;
	font-family:Arial, Helvetica, sans-serif;
	line-height:28px;
  }
  div#Panel1 {
   /*width: 174.95999999999998pt;*/
	width: 200px;
    height: 57.6pt;
    left: 13.536000000000001pt;
    top: 36pt;
    padding-top: 7.2pt;
    padding-left: 7.2pt;
    padding-bottom: 7.2pt;
    padding-right: 7.2pt;
  	/*border:1px solid #ccc;*/
    line-height:18px;
	text-align:center;
   
  }
  
}
@media screen {
  .pageview body {
    padding: 0px !important;
    width: 816px !important;
    height: 1056px !important;
    position: relative;
  }
  div#Sheet {
    position: relative;
	float:none;
    margin: 0px;
    padding: 0px;
	font-size:16px;
	font-family:Arial, Helvetica, sans-serif;
	line-height:28px;
  }
 
  div#Panel1 {  /*增加名條寬度*/
	/*position: absolute;*/
	/*border: 1px dotted #ccc;*/
	/*width: 233.28px;*/
	/*width:300px;*/
	/*height: 76.8px;*/
	border:1px solid #ccc;
	left: 16px;
	top: 19px;
	padding-top: 9.6px;
	padding-left: 9.6px;
	padding-bottom: 9.6px;
	padding-right: 9.6px;
	line-height:18px;
	text-align:center;
	}
  
}
 
/* end custom css */
 
/* ui edited css */
 
body {
  font-family: Verdana;
  
  font-size: 10.0pt;
  line-height: normal;
  background-color: #ffffff;
}
/* end ui edited css */
 
 
/* editor CSS */
.editor a:visited {color: #551A8B}
.editor table.zeroBorder {border: 1px dotted gray}
.editor table.zeroBorder td {border: 1px dotted gray}
.editor table.zeroBorder th {border: 1px dotted gray}
 
 
.editor div.google_header, .editor div.google_footer {
  border: 2px #DDDDDD dashed;
  position: static;
  width: 100%;
  min-height: 2em;
}
 
.editor .misspell {background-color: yellow}
 
.editor .writely-comment {
  font-size: 9pt;
  line-height: 1.4;
  padding: 1px;
  border: 1px dashed #C0C0C0
}
 
 
/* end editor CSS */
 
#apDiv1 {
	position:absolute;
	left:575px;
	top:269px;
	width:221px;
	height:197px;
	z-index:1;
}
</style>


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	
	        
	IF Not IsPostBack THEN
	
		'預設送件人為上光眼鏡
		'txt_Sender.Text = "上光眼鏡"
		'預設列印限制筆數為20筆
		'ViewState("PrintCounts") = "20"
		'預設列印寬度
		ViewState("lblWidth") = "320"
		'預設列印長度
		ViewState("lblHeight") = "120"		
		'預設列印分段筆數
		ViewState("PrintPageBreak") = "14"
	END IF
        
        
	
End Sub


Private Class AddreLabel
	Private CustAddress As string 
	Private CustName As String
	
	public function getCustAddress()As String
		return me.CustAddress
	End Function
	
	public sub setCustAddress(Byval CustAddress As String)
		IF String.IsNullOrEmpty(CustAddress) THEN
			me.CustAddress = String.Empty
		Else
			me.CustAddress = CustAddress

		END IF
	End Sub
	
	public function getCustName()As String
		return me.CustName
	End Function
	
	public sub setCustName(Byval CustName As String)
		IF String.IsNullOrEmpty(CustName) THEN
			me.CustName = String.Empty
		Else
			me.CustName = CustName

		END IF
	End Sub
	
End Class

</script>

</head>
<body>

<form runat="server">

            
        <%
		Dim ret As New Collection
		Dim sql As String = ""
		'Dim CustIdGroup As String = Session("CustIds")
		
		sql = "SELECT  top 200 * FROM Customer"
	
		
		
        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		'Dim sql As String = "select * from Customer Where CustId In( " & CustIdGroup & ")"
        cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
		
		Dim reader As OleDbDataReader = cmd.ExecuteReader
		
		
		
	
	Using conn
	
	
	While reader.read
			
       	Dim lbl As New AddreLabel
			lbl.setCustAddress(reader.Item("CustAddress"))
            lbl.setCustName(reader.Item("CustName")) 
			ret.Add(lbl)
            
	End While
	End Using
  
	 


	
	Response.write("<table>")
	
%>
<%For Row As Integer = 1 to ret.count-1 Step 2%>
<%Response.write("<tr>")%>
<%Response.write("<td>")%>

<DIV id=Panel1  style="width:<%=ViewState("lblWidth")%>px;height:<%=ViewState("lblHeight")%>px">
<!--<div><asp:Label ID="lbl_Sender" runat="server"/>
</div>-->
<br />
<!--<IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg" style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT:72px;visibility:hidden">
--><br />
<div id="Sheet">
<%=Ctype(ret.Item(Row),AddreLabel).getCustAddress%>
<BR id=vrv.0>

<div style="text-align:center"><%=Ctype(ret.Item(Row),AddreLabel).getCustName%>&nbsp;收</div>
<BR id=vrv.1>
</div>
</DIV>
<%Response.write("</td>")%>
<%Response.write("<td>")%>


<DIV id=Panel1 style="width:<%=ViewState("lblWidth")%>px;height:<%=ViewState("lblHeight")%>px">
<!--<div><asp:Label ID="lbl_Sender2" runat="server"/>
</div>-->
<br />
<div id="Sheet">

<!--<IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg" style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT: 72px;visibility:hidden">
--><br />

<%=Ctype(ret.Item(Row+1),AddreLabel).getCustAddress%>
<BR id=vrv.0>


<div style="text-align:center"><%=Ctype(ret.Item(Row+1),AddreLabel).getCustName%>&nbsp;收</div>
<BR id=vrv.1></DIV>
</div>
<%Response.write("</td>")%>

<%

  Dim tempRow As double = Cdbl(Row)
  
IF tempRow - 1 <> 0 THEN
  IF (tempRow - 1 )mod 12 = 0 THEN 
	Response.write("<td id=pageBreak style='page-break-after:always'></td>")
	'response.write(tempRow & "<br>")
	'response.write(Cint((tempRow - 1) / 14) & "<br>")
	'response.write((tempRow - 1) / 14 & "<br>")
  END IF
END IF
 %>


<%Response.write("</tr>")%>



<%Next%>

<%    
	  '若列印筆數/2有餘數的話,則多印一筆空的Label
	  If ret.Count Mod 2 <> 0 Then
         %>
<DIV id=Panel1 style="width:<%=ViewState("lblWidth")%>px;height:<%=ViewState("lblHeight")%>px">
<!--<div><asp:Label ID="lbl_Sender3" runat="server"/>
</div>-->
<br />
<div id="Sheet">

<!--<IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg"  style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT: 72px;visibility:hidden">
--><br />


<%=Ctype(ret.Item(ret.Count),AddreLabel).getCustAddress%>
<BR id=vrv.0>
<div style="text-align:center"><%=Ctype(ret.Item(ret.Count),AddreLabel).getCustName%>&nbsp;收</div>
<BR id=vrv.1>
</div>
</DIV>

         
         <%
      End If
%>
<%Response.write("</table>")%>
</form>
</body>
</html>
