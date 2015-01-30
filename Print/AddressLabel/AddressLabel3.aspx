<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<!--#include virtual="~/site/TodayBillPlatfom/Shop/c037/Cust/SQLAccess/Connection.aspx.vb"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>地址名條</title>

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
		ViewState("PrintCounts") = "20"
		'預設列印寬度
		ViewState("lblWidth") = "320"
		'預設列印長度
		ViewState("lblHeight") = "120"		
		'預設列印分段筆數
		ViewState("PrintPageBreak") = "14"
	END IF
        
	
End Sub

  Protected Sub btn_SendValue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_SendValue.Click
		
		'lbl_Sender.Text = txt_Sender.Text.Trim
		'lbl_Sender2.Text = txt_Sender.Text.Trim
		'lbl_Sender3.Text = txt_Sender.Text.Trim
		
		'設定限制列印筆數
		ViewState("PrintCounts") = Rad_Counts.SelectedValue
		'設定限制列印寬度
		'ViewState("lblWidth") = Request.Form("drop_Width")
		'設定限制列印長度
		'ViewState("lblHeight") = Request.Form("drop_Height")
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
<script type="text/javascript">
<!--
function MM_scanStyles(obj, prop) { //v9.0
  var inlineStyle = null; var ccProp = prop; var dash = ccProp.indexOf("-");
  while (dash != -1){ccProp = ccProp.substring(0, dash) + ccProp.substring(dash+1,dash+2).toUpperCase() + ccProp.substring(dash+2); dash = ccProp.indexOf("-");}
  inlineStyle = eval("obj.style." + ccProp);
  if(inlineStyle) return inlineStyle;
  var ss = document.styleSheets;
  for (var x = 0; x < ss.length; x++) { var rules = ss[x].cssRules;
	for (var y = 0; y < rules.length; y++) { var z = rules[y].style;
	  if(z[prop] && (rules[y].selectorText == '*[ID"' + obj.id + '"]' || rules[y].selectorText == '#' + obj.id)) {
        return z[prop];
  }  }  }  return "";
}

function MM_getProp(obj, prop) { //v8.0
  if (!obj) return ("");
  if (prop == "L") return obj.offsetLeft;
  else if (prop == "T") return obj.offsetTop;
  else if (prop == "W") return obj.offsetWidth;
  else if (prop == "H") return obj.offsetHeight;
  else {
    if (typeof(window.getComputedStyle) == "undefined") {
	    if (typeof(obj.currentStyle) == "undefined"){
		    if (prop == "P") return MM_scanStyles(obj,"position");
        else if (prop == "Z") return MM_scanStyles(obj,"z-index");
        else if (prop == "V") return MM_scanStyles(obj,"visibility");
	    } else {
	      if (prop == "P") return obj.currentStyle.position;
        else if (prop == "Z") return obj.currentStyle.zIndex;
        else if (prop == "V") return obj.currentStyle.visibility;
	    }
    } else {
	    if (prop == "P") return window.getComputedStyle(obj,null).getPropertyValue("position");
      else if (prop == "Z") return window.getComputedStyle(obj,null).getPropertyValue("z-index");
      else if (prop == "V") return window.getComputedStyle(obj,null).getPropertyValue("visibility");
    }
  }
}

function MM_dragLayer(objId,x,hL,hT,hW,hH,toFront,dropBack,cU,cD,cL,cR,targL,targT,tol,dropJS,et,dragJS) { //v9.01
  //Copyright 2005-2006 Adobe Macromedia Software LLC and its licensors. All rights reserved.
  var i,j,aLayer,retVal,curDrag=null,curLeft,curTop,IE=document.all;
  var NS=(!IE&&document.getElementById); if (!IE && !NS) return false;
  retVal = true; if(IE && event) event.returnValue = true;
  if (MM_dragLayer.arguments.length > 1) {
    curDrag = document.getElementById(objId); if (!curDrag) return false;
    if (!document.allLayers) { document.allLayers = new Array();
      with (document){ if (NS) { var spns = getElementsByTagName("span"); var all = getElementsByTagName("div");
        for (i=0;i<spns.length;i++) if (MM_getProp(spns[i],'P')) allLayers[allLayers.length]=spns[i];}
        for (i=0;i<all.length;i++) {
	        if (MM_getProp(all[i],'P')) allLayers[allLayers.length]=all[i]; 
        }
    } }
    curDrag.MM_dragOk=true; curDrag.MM_targL=targL; curDrag.MM_targT=targT;
    curDrag.MM_tol=Math.pow(tol,2); curDrag.MM_hLeft=hL; curDrag.MM_hTop=hT;
    curDrag.MM_hWidth=hW; curDrag.MM_hHeight=hH; curDrag.MM_toFront=toFront;
    curDrag.MM_dropBack=dropBack; curDrag.MM_dropJS=dropJS;
    curDrag.MM_everyTime=et; curDrag.MM_dragJS=dragJS;
  
    curDrag.MM_oldZ = MM_getProp(curDrag,'Z');
    curLeft = MM_getProp(curDrag,'L');
    if (String(curLeft)=="NaN") curLeft=0; curDrag.MM_startL = curLeft;
    curTop = MM_getProp(curDrag,'T');
    if (String(curTop)=="NaN") curTop=0; curDrag.MM_startT = curTop;
    curDrag.MM_bL=(cL<0)?null:curLeft-cL; curDrag.MM_bT=(cU<0)?null:curTop-cU;
    curDrag.MM_bR=(cR<0)?null:curLeft+cR; curDrag.MM_bB=(cD<0)?null:curTop+cD;
    curDrag.MM_LEFTRIGHT=0; curDrag.MM_UPDOWN=0; curDrag.MM_SNAPPED=false; //use in your JS!
    document.onmousedown = MM_dragLayer; document.onmouseup = MM_dragLayer;
    if (NS) document.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
    } else {
    var theEvent = ((NS)?objId.type:event.type);
    if (theEvent == 'mousedown') {
      var mouseX = (NS)?objId.pageX : event.clientX + document.body.scrollLeft;
      var mouseY = (NS)?objId.pageY : event.clientY + document.body.scrollTop;
      var maxDragZ=null; document.MM_maxZ = 0;
      for (i=0; i<document.allLayers.length; i++) { aLayer = document.allLayers[i];
        var aLayerZ = MM_getProp(aLayer,'Z');
        if (aLayerZ > document.MM_maxZ) document.MM_maxZ = aLayerZ;
        var isVisible = (MM_getProp(aLayer,'V')).indexOf('hid') == -1;
        if (aLayer.MM_dragOk != null && isVisible) with (aLayer) {
          var parentL=0; var parentT=0;
          if (NS) { parentLayer = aLayer.parentNode;
            while (parentLayer != null && parentLayer != document && MM_getProp(parentLayer,'P')) {
              parentL += parseInt(MM_getProp(parentLayer,'L')); parentT += parseInt(MM_getProp(parentLayer,'T'));
              parentLayer = parentLayer.parentNode;
              if (parentLayer==document) parentLayer = null;
          } } else if (IE) { parentLayer = aLayer.parentElement;       
            while (parentLayer != null && MM_getProp(parentLayer,'P')) {
              parentL += MM_getProp(parentLayer,'L'); parentT += MM_getProp(parentLayer,'T');
              parentLayer = parentLayer.parentElement; } }
          var tmpX=mouseX-((MM_getProp(aLayer,'L'))+parentL+MM_hLeft);
          var tmpY=mouseY-((MM_getProp(aLayer,'T'))+parentT+MM_hTop);
          if (String(tmpX)=="NaN") tmpX=0; if (String(tmpY)=="NaN") tmpY=0;
          var tmpW = MM_hWidth;  if (tmpW <= 0) tmpW += MM_getProp(aLayer,'W');
          var tmpH = MM_hHeight; if (tmpH <= 0) tmpH += MM_getProp(aLayer,'H');
          if ((0 <= tmpX && tmpX < tmpW && 0 <= tmpY && tmpY < tmpH) && (maxDragZ == null
              || maxDragZ <= aLayerZ)) { curDrag = aLayer; maxDragZ = aLayerZ; } } }
      if (curDrag) {
        document.onmousemove = MM_dragLayer;
        curLeft = MM_getProp(curDrag,'L');
        curTop = MM_getProp(curDrag,'T');
        if (String(curLeft)=="NaN") curLeft=0; if (String(curTop)=="NaN") curTop=0;
        MM_oldX = mouseX - curLeft; MM_oldY = mouseY - curTop;
        document.MM_curDrag = curDrag;  curDrag.MM_SNAPPED=false;
        if(curDrag.MM_toFront) {
          var newZ = parseInt(document.MM_maxZ)+1;
          eval('curDrag.'+('style.')+'zIndex=newZ');
          if (!curDrag.MM_dropBack) document.MM_maxZ++; }
        retVal = false; if(!NS) event.returnValue = false;
    } } else if (theEvent == 'mousemove') {
      if (document.MM_curDrag) with (document.MM_curDrag) {
        var mouseX = (NS)?objId.pageX : event.clientX + document.body.scrollLeft;
        var mouseY = (NS)?objId.pageY : event.clientY + document.body.scrollTop;
        var newLeft = mouseX-MM_oldX; var newTop  = mouseY-MM_oldY;
        if (MM_bL!=null) newLeft = Math.max(newLeft,MM_bL);
        if (MM_bR!=null) newLeft = Math.min(newLeft,MM_bR);
        if (MM_bT!=null) newTop  = Math.max(newTop ,MM_bT);
        if (MM_bB!=null) newTop  = Math.min(newTop ,MM_bB);
        MM_LEFTRIGHT = newLeft-MM_startL; MM_UPDOWN = newTop-MM_startT;
        if (NS){style.left = newLeft + "px"; style.top = newTop + "px";}
        else {style.pixelLeft = newLeft; style.pixelTop = newTop;}
        if (MM_dragJS) eval(MM_dragJS);
        retVal = false; if(!NS) event.returnValue = false;
    } } else if (theEvent == 'mouseup') {
      document.onmousemove = null;
      if (NS) document.releaseEvents(Event.MOUSEMOVE);
      if (NS) document.captureEvents(Event.MOUSEDOWN); //for mac NS
      if (document.MM_curDrag) with (document.MM_curDrag) {
        if (typeof MM_targL =='number' && typeof MM_targT == 'number' &&
            (Math.pow(MM_targL-(MM_getProp(document.MM_curDrag,'L')),2)+
             Math.pow(MM_targT-(MM_getProp(document.MM_curDrag,'T')),2))<=MM_tol) {
          if (NS) {style.left = MM_targL + "px"; style.top = MM_targT + "px";}
          else {style.pixelLeft = MM_targL; style.pixelTop = MM_targT;}
          MM_SNAPPED = true; MM_LEFTRIGHT = MM_startL-MM_targL; MM_UPDOWN = MM_startT-MM_targT; }
        if (MM_everyTime || MM_SNAPPED) eval(MM_dropJS);
        if(MM_dropBack) {style.zIndex = MM_oldZ;}
        retVal = false; if(!NS) event.returnValue = false; }
      document.MM_curDrag = null;
    }
    if (NS) document.routeEvent(objId);
  } return retVal;
}
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
</head>
<body onload="MM_dragLayer('apDiv1','',0,0,0,0,true,false,-1,-1,-1,-1,513,256,50,'',false,'')">
<form  runat="server">
 <div id="apDiv1">
 	<table width="100%"  border="1" bgcolor="#FFFFFF">
    
    <tr>
    
    <td colspan="3"  bgcolor="#c3d9ff" align="right"><a href="#" onclick="MM_showHideLayers('apDiv1','','hide')">關閉</a></td>
    </tr>
  
    	
        <tr>
       	  <td>列印筆數</td>
            <td>
            <asp:RadioButtonList ID="Rad_Counts" RepeatDirection="Horizontal"  runat="server">
            <asp:ListItem Value="20" Selected="true">20</asp:ListItem>
            <asp:ListItem Value="40">40</asp:ListItem>
            <asp:ListItem Value="60">60</asp:ListItem>
        	</asp:RadioButtonList>
    
          </td>
        </tr>
        <tr>
         <td colspan="2"> <asp:Button ID="btn_SendValue" runat="server" Text="確認"/></td>
        </tr>
    </table>
    <br />
   
 </div>
<%
		Dim ret As New Collection
		Dim sql As String = ""
		Dim CustIdGroup As String = Session("CustIds")
		IF NOT Session("CustIds")IS NOTHING THEN
			sql = Session("CustIds")
		ELSE
			sql = "SELECT  * FROM 客戶資料表"
		END IF
		
		
        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		'Dim sql As String = "select * from Customer Where CustId In( " & CustIdGroup & ")"
        cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
		
		Dim reader As OleDbDataReader = cmd.ExecuteReader
		
		
		
	
	Using conn
	
	Dim limit As Integer = 0 
	
	
		While reader.read
			If limit < ViewState("PrintCounts") THEN
			Dim lbl As New AddreLabel
				lbl.setCustAddress(reader.Item("CustAddress"))
				lbl.setCustName(reader.Item("CustName")) 
				ret.Add(lbl)
			END IF
				limit = limit + 1
		End While
		
	
	  
	End Using
   			
	   	 		

    %>
    
  
<%
	
	
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
	
  

<!--<DIV id=Panel2><IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg" style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT: 68px"> Name<BR id=vrv.0>Address<BR id=vrv.1>City State Zip Code</DIV>

<DIV id=Panel3><IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg" style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT: 68px"> Name<BR id=vrv.0>Address<BR id=vrv.1>City State Zip Code</DIV>

<DIV id=Panel4><IMG id=r.pj0 src="dhhg7wbj_69hb88jwgq_b.jpg" style="FLOAT: left; MARGIN: 0pt 1em 0pt 0pt; WIDTH: 41px; HEIGHT: 68px"> Name<BR id=vrv.0>
  Address<BR id=vrv.1>City State Zip Code</DIV>
-->


</form>
</body>
</html>
