
	    function init(CustId){
	        
	      
			getCustInfo(CustId);
			getCustGlassesRecord3(CustId);
			//getCustGlassesRecord(CustId);
			getCustLiquidRecord(CustId);
			getCustServiceInfo(CustId);
			getCustComm(CustId);
			getCustGlassesTopRecord(CustId);
			
		}
		
	  //將客戶ID設定至Hiddent Field
	  //將取得的客戶資料設定至控制項上
      function getCustId(control){
				//document.getElementById('ctl00$ContentPlaceHolder1$hid_CustId').value = control.title;
				getCustInfo(control.title);
				//getCustGlassesRecord(control.title);
				getCustLiquidRecord(control.title);
				getCustServiceInfo(control.title);
				getCustComm(control.title);
				getCustGlassesTopRecord(control.title);
				getCustGlassesRecord3(control.title);
              	
       } 


	////////////////////鏡框分頁//////////////////////
	      
 function pageselectCallback(page_index, jq){
 		    
 	//分頁設定,一頁共幾本需要設定以下
	//items_per_page,設定以後才能呈現每頁所要呈現的元素
	//initPagination function的items_per_page參數,設定以後,Jquery便會自動分頁
	//以上參數需要一樣
	//	
	
	
		//alert(page_index) ;
 		
       	 var items_per_page = 5;  //一頁有多少筆
        
		 var offset = page_index * items_per_page;
		 var total_length = $('#hid_Gla div.custinfo').length; 
		 var new_content;
         var out = '';			
		 var i  = 1 ;

		 //計算傳回的xml文件的<div class=custinfo>的標籤有多少筆數
		
		 
		//每次呼叫便清空容器,否則會一直累加
		$('#Div_GlassesRecord').empty();
		
		out +='<table width=100% border=1><tr><td>單據編號</td><td>品名</td><td>銷售金額</td><td>餘額</td><td>銷售員</td><td>服務日期/備註</td><td>明細</td></tr>';
			
	
		
		//j必須小於一頁最多幾筆
		for(var j=0; j<items_per_page;j++){
		
	//必須小於最大筆數,否則會多出一行undefind
	if((page_index * items_per_page + i) <= total_length){ 
		 
		//alert(page_index);
		//for(var j = page_index;j<page_index + items_per_page - 1;j++){
			out+='<tr>';		
			//slice(0,1)最第一個元素,依序為兩邊+1,ex(1,2),(2,3)...etc
			 new_content = $('#hid_Gla div.custinfo').slice(offset+j,offset+i);
			//var new_content = $('#Div_GlassesRecord div.custinfo').slice(1).clone();
			
			i = i + 1;
							
			//alert(offset+j);
			
		//	out+='<td>';
//			out+=new_content.find("Serial").attr('serialval');
//			out+='</td>';

			out+='<td>';
			
			//取得BillNumber標籤的billval屬性
			out+=new_content.find("BillNumber").attr('billval');
			out+='</td>';


			out+='<td>';
			out+=new_content.find("ProductName").attr('proval');
			out+='</td>';
			
			out+='<td>';
			out+=new_content.find("SellPrice").attr('sellval');
			out+='</td>';
			
			out+='<td>';
			out+=new_content.find("Balance").attr('balval');
			out+='</td>';
			
			
			out+='<td>';
			out+=new_content.find("SalesMan").attr('salval');
			out+='</td>';

			out+='<td><font size=2>';
			out+=new_content.find("SystemTime").attr('timeval') + '<br>' + new_content.find("Contect").attr('conval');
			out+='</font></td>';
			
			//添加明細連結,參數為Serial
			var Serial = new_content.find("Serial").attr('serialval');
			out+='<td><a href="javascript:void(0);" onclick=getCustDealDetail('+ Serial +')>明細</a></td>';
			out+='</tr>';
			
			
			
			out+='</tr>';			
		}
	}//if
	
		out+='</table>';	

		//$('#Div_GlassesRecord').append(trim(out));
		document.getElementById('Div_GlassesRecord').innerHTML = out;
		
        return false;
        }


		
	  
		
		
           
       function initPagination() {
                var num_entries = $('#hid_Gla div.custinfo').length;
                //alert(num_entries);
              
                $("#Pagination").pagination(num_entries, {
					prev_text:'上一頁',
					next_text:'下一頁',
                    num_edge_entries: 2,
                    num_display_entries: 8,
                    callback: pageselectCallback,
                    items_per_page:5  //一頁幾筆
                });
             }


	function getCustGlassesRecord3(CustId){
					
		$('#hid_Gla').load('WebService/Cust/getCustGlassesRecord.ashx?CustId='+CustId,null, initPagination);
				 
			

			
	}
////////////////////////////////鏡框分頁 End /////////

	  
	   //取得客戶資料
	    function getCustInfo(CustId) {

		var d = new Date();
		var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/getCustBasicInfo.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'json',
        timeout: 5000,
		global:false,
        beforeSend: function(){
           
        },
        error : function(msg){
           
        },
        success: function(msg){
            getCustInfo2(msg);
        }
    	});
			
       
        }
        
        function getCustInfo2(response) {
        
        var CustInfo = response;
        document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustName').innerText = CustInfo.CustName;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustId').value = CustInfo.CustId;  //需使用value取值
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustTelPhone').innerText = CustInfo.CustTelPhone;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustMobile').innerText = CustInfo.CustMobile;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustEmail').innerText = CustInfo.CustEmail;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustAddress').innerText = CustInfo.CustAddr;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_Height').innerText = CustInfo.Height
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_Weight').innerText = CustInfo.Weight;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustBirth').innerText = CustInfo.CustBirthDay;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_BloodType').innerText = CustInfo.BloodType;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_JobTitle').innerText = CustInfo.JobTitle;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_MonthIncome').innerText = CustInfo.MonthIncome;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_Contect').innerText = CustInfo.Contect;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustGroup').innerHTML =CustInfo.CustGroup + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0); onclick=UpdateGroup('+ Serial +')">更新</a>';
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_Interest').innerHTML =  CustInfo.Interest + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0); onclick=UpdateCustInterest('+ Serial +')">更新</a>';
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_Habbit').innerHTML = CustInfo.Habbit + '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0); onclick=UpdateCustHabbit('+ Serial +')">更新</a>';
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_CustGender').innerText = CustInfo.CustGender;
		document.getElementById('ctl00_ContentPlaceHolder1_lbl_RealAge').innerText = CustInfo.CountRealAge(CustBirthDay);

        }
      
     
        
    
		
		
		 ///取得客戶鏡框交易資料////////////////////////////////
      function getCustGlassesRecord(CustId){
	  	var d = new Date();
	  	var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/getCustGlassesRecord.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'json',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustGlassesRecord2(msg);
        }
    	});
	  }
			
		function getCustGlassesRecord2(response) {
     
      	var out = '';
		//var CustInfo = xml.responseXML.getElementsByTagName("CustInfo");
        var record = response;
        
	out+= '<table width=100% border=1><tr><td>單據編號</td><td>品名</td><td>銷售金額</td><td>餘額</td><td>服務日期</td><td>銷售員</td><td>明細</td></tr>';

		//var CustInfo2 = CustInfo[0].childNodes; //取得CustInfo下共有幾個節點
		var CustId = document.getElementById('lbl_CustId').value;

		out+='<tr>';
		out+='<td>' + CustInfo.BillNumber + '</td>';
		out+='<td>' + CustInfo.SalesMan + '</td>';
		out+='<td>' + CustInfo.ProductName + '</td>';
		out+='<td>' + CustInfo.SellPrice + '</td>';
		out+='<td>' + CustInfo.Balance + '</td>';
		out+='<td>' + CustInfo.SystemTime + '</td>';
		
		//做呼叫取得交易明細的連結,以Serial做參數
        out+='<td><a href="javascript:void(0);" onclick=getCustDealDetail('+CustInfo.Serial+')>明細</a></td>';
		out+='</tr>';
		out +='</table>';
		
		document.getElementById('Div_GlassesRecord').innerHTML = out;
		
//		for (var i = 0;i<CustInfo.length;i++){
//			
//				out+='<tr>';
//				
//			for (var j =1;j<CustInfo2.length;j++){
//				out += '<td>';
//				out += CustInfo[i].childNodes[j].firstChild.nodeValue;
//				out += '</td>';
//			}
//				//做呼叫取得交易明細的連結,以Serial做參數
//				out+='<td><a href="javascript:void(0);" onclick=getCustDealDetail('+CustInfo[i].childNodes[0].firstChild.nodeValue+')>明細</a></td>';
//				out+='</tr>';
//		}

        }
	 
	  	///取得客戶鏡框交易資料////////////////////////////////


///取得客戶鏡框交易明細第一筆資料////////////////////////////////
      function getCustGlassesTopRecord(CustId){
	  //var CustId2 = document.getElementById('lbl_CustId').value;
		var d = new Date();
	  	var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/Glasses/getCustGlassesRecentRecord.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'json',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustGlassesTopRecord2(msg);
        }
    	});
	  }
			
		function getCustGlassesTopRecord2(response) {
        
      	var out = '';
        var CustInfo = response;
        
	out+= '<table border=1><tr class=bubble><td colspan=12>鏡框交易明細</td></tr><tr><td>單據編號</td><td>品名</td><td bgcolor=#FFFF99>右眼度數</td><td bgcolor=#FFFF99>左眼度數</td><td>鏡片種類</td><td>鏡片廠商</td><td>遠近</td><td>銷售員</td><td>送件日期</td><td>銷售金額</td><td bgcolor=#FFFF99>餘額</td><td width="30%">備註</td></tr>';
		
		var CustId = document.getElementById('ctl00_ContentPlaceHolder1_R1_ctl02_lbl_CustId').value;
        
        out+='<tr>';
        out+='<td>' + CustInfo.BillNumber + '</td>';
        out+='<td>' + CustInfo.ProductName + '</td>';
        out+='<td>' + CustInfo.RightDegrees + '</td>';
        out+='<td>' + CustInfo.LeftDegrees + '</td>';
        out+='<td>' + CustInfo.PinClass + '</td>';
        out+='<td>' + CustInfo.PinManufacturerR + '</td>';
        out+='<td>' + CustInfo.FarOrNear + '</td>';
        out+='<td>' + CustInfo.SalesMan + '</td>';
        out+='<td>' + CustInfo.PublishDay + '</td>';
        out+='<td>' + CustInfo.SellPrice + '</td>';
        out+='<td>' + CustInfo.Balance + '</td>';
        out+='<td>' + CustInfo.Contect + '</td>';
        out+='</tr>';	
	    out +='</table>';
	
	    document.getElementById('glassesRecentRecord').innerHTML =out;
							
			
        }
	 
	  	///取得客戶鏡框交易明細第一筆資料////////////////////////////////

///取得交易明細////////////////////////////////
      function getCustDealDetail(Serial){
	  //var CustId2 = document.getElementById('lbl_CustId').value;
		var d = new Date();
	  	var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/Glasses/getGlaDealDetail.aspx",
        data:'Serial='+Serial + '&ts=' + d.getTime(),
        Type: 'xml',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustDealDetail2(xml);
        }
    	});
	  }
			
		function getCustDealDetail2(xml) {
     
      	var out = '';
		var CustInfo = xml.responseXML.getElementsByTagName("CustInfo");
       
        
	out+= '<table border=1><tr class=bubble><td colspan=12>鏡框交易明細</td></tr><tr><td>單據編號</td><td>品名</td><td bgcolor=#FFFF99>右眼度數</td><td bgcolor=#FFFF99>左眼度數</td><td>鏡片種類</td><td>鏡片廠商</td><td>遠近</td><td>銷售員</td><td>送件日期</td><td>銷售金額</td><td bgcolor=#FFFF99>餘額</td><td width="30%">備註</td></tr>';
		
		var CustInfo2 = CustInfo[0].childNodes; //取得CustInfo下共有幾個節點
		var CustId = document.getElementById('lbl_CustId').value;

		
		for (var i = 0;i<CustInfo.length;i++){
			
				out+='<tr>';
				
			for (var j =1;j<CustInfo2.length;j++){
				out += '<td>';
				out += CustInfo[i].childNodes[j].firstChild.nodeValue;
				out += '</td>';
			}
				
				out+='</tr>';
		}

	
	out +='</table>';
	
	document.getElementById('glassesRecentRecord').innerHTML =out;
							
			
        }
	 
	  	///取得交易明細////////////////////////////////
		
		 ///取得客戶藥水交易資料////////////////////////////////
      function getCustLiquidRecord(CustId){
	  	var d = new Date();
	  	var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/getLiquidRecord.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'xml',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustLiquidRecord2(xml);
        }
    	});
	  }
		function getCustLiquidRecord2(xml) {
		
		var out = '';
		var CustInfo = xml.responseXML.getElementsByTagName("CustInfo");
       	var CustId = document.getElementById('ctl00_ContentPlaceHolder1_R1_ctl02_lbl_CustId').value;
		//alert(realCustId);
       		

	out+= '<table width=100% border=1><tr><td>銷售員</td><td>品名</td><td>銷售金額</td><td>餘額</td><td>服務日期</td><td>明細</td></tr>';

		var CustInfo2 = CustInfo[0].childNodes; //取得CustInfo下共有幾個節點
		for (var i = 0;i<CustInfo.length;i++){
			
				out+='<tr>';
				
			for (var j =1;j<CustInfo2.length;j++){
				out += '<td>';
				out += CustInfo[i].childNodes[j].firstChild.nodeValue;
				out += '</td>';
			}
				out+='<td><a href="#" onclick=window.open("Customer/LiquidDeal/default.aspx?Serial='+CustInfo[i].childNodes[0].firstChild.nodeValue+'","明細",config="height=300,width=400,resizable=yes,scrollbars=yes,location=yes")>明細</a></td>';
				
				out+='</tr>';
			
		}
	out +='</table>';
	
	document.getElementById('Div_LiquidRecord').innerHTML = out;
	}
	  	///取得客戶藥水交易資料////////////////////////////////
		
////////////////////客戶通訊////////////////////////////////////////////////////////////////////

    
      ///取得客戶客服資料////////////////////////////////
      function getCustServiceInfo(CustId){
	 var d = new Date();
	var xml;
	xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/getCustService.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'xml',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustServiceInfo2(xml);
        }
    	});
	  }
			
		function getCustServiceInfo2(xml) {
     
       var out = '';
		var CustInfo = xml.responseXML.getElementsByTagName("CustInfo");
       
        
	out+= '<table width=60% border=1><tr><td>經手人</td><td>時間</td><td>內容</td><td>系統</td></tr>';

		var CustInfo2 = CustInfo[0].childNodes; //取得CustInfo下共有幾個節點
		var CustId = document.getElementById('ctl00_ContentPlaceHolder1_R1_ctl02_lbl_CustId').value;
		
		for (var i = 0;i<CustInfo.length;i++){
			
				out+='<tr>';
				
			for (var j =1;j<CustInfo2.length;j++){
				out += '<td>';
				out += CustInfo[i].childNodes[j].firstChild.nodeValue;
				out += '</td>';
				
			}		
				var Serial = CustInfo[i].childNodes[0].firstChild.nodeValue;	
				out += '<td><a href="#" onclick=UpdateCS("' + Serial + '")>更新</a>&nbsp';
				out += '<a href="#" onclick=DeleteCS("'+ Serial + '")>刪除</a></td>';				
				out+='</tr>';
		}
	out +='</table>';
	
	document.getElementById('DIV_CustService').innerHTML = out;

        }
	 
	  	///取得客戶客服資料////////////////////////////////
		
		
		 ///取得客戶其他通訊資料////////////////////////////////
      function getCustComm(CustId){
	  	var d = new Date();
	  	var xml;
		xml = $.ajax({
        type: "GET",
        url: "WebService/Cust/getCustComm.ashx",
        data:'CustId='+CustId + '&ts=' + d.getTime(),
        Type: 'xml',
        timeout: 5000,
		global:false,
        beforeSend: function(){
            
        },
        error : function(msg){
            
        },
        success: function(msg){
            getCustComm2(xml);
        }
    	});
	  }
			
		function getCustComm2(xml) {
     
        var out = '';
		var CustInfo = xml.responseXML.getElementsByTagName("CustInfo");
       
        
	out+= '<table width=60% border=1><tr><td>內容</td><td>系統</td></tr>';

		var CustInfo2 = CustInfo[0].childNodes; //取得CustInfo下共有幾個節點
		for (var i = 0;i<CustInfo.length;i++){
			
				out+='<tr>';
				
			for (var j =1;j<CustInfo2.length;j++){
				out += '<td>';
				out += CustInfo[i].childNodes[j].firstChild.nodeValue;
				out += '</td>';
			}
				
				var Serial = CustInfo[i].childNodes[0].firstChild.nodeValue;	
				out += '<td><a href="#" onclick=UpdateComm("' + Serial + '")>更新</a>&nbsp';
				out += '<a href="#" onclick=DeleteComm("'+ Serial + '")>刪除</a></td>';			
				out+='</tr>';
		}
	out +='</table>';
	
	document.getElementById('Div_Comm').innerHTML = out;

        }
	 
	 ///取得客戶其他通訊資料////////////////////////////////

  ///刪除客戶通訊記錄////////////////////////////////
      function DeleteComm(Serial){
	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/Comm/Delete.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
		global:false,
        	beforeSend: function(){
            
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
	    	var CustId = document.getElementById('lbl_CustId').value;
            	getCustComm(CustId);
        	}
    		});
		}
	}
	
	
	///更新客戶服務記錄////////////////////////////////
   
	///更新客戶通訊資料////////////////////////////////
      function 	UpdateComm(Serial){
	  
	 

	MM_showHideLayers('apDiv7','','show');
	
	
	var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/Comm/getCommBySerial.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
				var Content = xml.responseXML.getElementsByTagName("Content")[0];
				var Serial = xml.responseXML.getElementsByTagName("Serial")[0];

	    		document.getElementById('txt_CommContent').value = Content.firstChild.data;
				document.getElementById('hid_CommSerial').value = Serial.firstChild.data;
 
			}
    		});
		}
		
	function  UpdateComm2(){
	  
	
	var Content = document.getElementById('txt_CommContent').value;
	var Serial = document.getElementById('hid_CommSerial').value;
	//alert(UnderTaker + '/' + ServiceContent + '/' + Serial);
	var CustId = document.getElementById('lbl_CustId').value;

	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "POST",
        	url: "WebService/Cust/Comm/Post.aspx",
			data: {'Serial':Serial,'Content':Content},
        	//data:'Serial='+Serial+'&UnderTaker=' + UnderTaker + '&SC=' + ServiceContent,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
            	getCustComm(CustId);
				MM_showHideLayers('apDiv7','','hide');
        	}
    		});
		}
	}


		
///更新客戶通訊記錄////////////////////////////////


///更新嗜好////////////////////////////////
      function 	UpdateCustHabbit(Serial){
	  
	 

	MM_showHideLayers('apDiv9','','show');
	
	
	var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/CustBasicInfo/getBasicBySerial.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
				var Habbit = xml.responseXML.getElementsByTagName("Habbit")[0];
				//var Serial = xml.responseXML.getElementsByTagName("Serial")[0];

	    		document.getElementById('txt_Habbit').value = Habbit.firstChild.data;
				document.getElementById('hid_HabbitSerial').value = Serial;
 
			}
    		});
		}
		
	function  UpdateCustHabbit2(){
	  
	
	var Habbit = document.getElementById('txt_Habbit').value;
	var Serial = document.getElementById('hid_HabbitSerial').value;
	//alert(UnderTaker + '/' + ServiceContent + '/' + Serial);
	

	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "POST",
        	url: "WebService/Cust/CustBasicInfo/Post.aspx",
			data: {'Serial':Serial,'Habbit':Habbit},
        	//data:'Serial='+Serial+'&UnderTaker=' + UnderTaker + '&SC=' + ServiceContent,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
            	getCustInfo('');
				MM_showHideLayers('apDiv9','','hide');
        	}
    		});
		}
	}


		
///更新嗜好////////////////////////////////


///更新興趣////////////////////////////////
      function 	UpdateCustInterest(Serial){
	  
	 

	MM_showHideLayers('apDiv10','','show');
	
	
	var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/CustBasicInfo/getInterestBySerial.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
				var Interest = xml.responseXML.getElementsByTagName("Interest")[0];
				//var Serial = xml.responseXML.getElementsByTagName("Serial")[0];

	    		document.getElementById('txt_Interest').value = Interest.firstChild.data;
				document.getElementById('hid_InterestSerial').value = Serial;
 
			}
    		});
		}
		
	function  UpdateCustInterest2(){
	  
	
	var Interest = document.getElementById('txt_Interest').value;
	var Serial = document.getElementById('hid_InterestSerial').value;
	//alert(UnderTaker + '/' + ServiceContent + '/' + Serial);
	

	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "POST",
        	url: "WebService/Cust/CustBasicInfo/UpdateInterest.aspx",
			data: {'Serial':Serial,'Interest':Interest},
        	//data:'Serial='+Serial+'&UnderTaker=' + UnderTaker + '&SC=' + ServiceContent,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
            	getCustInfo('');
				MM_showHideLayers('apDiv10','','hide');
        	}
    		});
		}
	}


		
///更新客戶興趣////////////////////////////////

////////////////////客戶通訊////////////////////////////////////////////////////////////////////



	//去左右空白
	function trim(strvalue) {
    		ptntrim = /(^\s*)|(\s*$)/g;
    		return strvalue.replace(ptntrim,"");
	}
	
	//取出年分,找出字串中符合4位數字
		function getMonthFromStr(CustBirthDay){
    
			var r, re;
			
			re = /(\d{4})/;
			r = CustBirthDay.match(re);
			if (r != null )
			{
			return(r[1] ) ;
			}
			return(r);

    	}
		
	//計算實際年齡
	function CountRealAge(CustBirthDay){
			 var r, re,IsValid;
			 var Age;
			 //去掉左右空白
			 CustBirthDay = trim(CustBirthDay);
			 
			 //判斷是否符合日期格式
			 re = /(^\d{4}\-\d{2}\-\d{2}$)/;
			 r = CustBirthDay.match(re);
			 if (r == null )
			 {
				IsValid = false;
			 }
			 
			 else{
				IsValid = true;
			 }
       		 //判斷是否符合日期格式
			
	//若資料庫取出的日期不是NULL而且符合日期格式
	if (CustBirthDay != null && CustBirthDay != 'undefined'){
				//alert(IsValid);
    			if (IsValid){
					var now = new Date();
					var NowYear = now.getFullYear();
					var CustBirthYear = getMonthFromStr(CustBirthDay);
					
					Age = NowYear - CustBirthYear;
					//alert(NowYear);
					//alert(Age);
	
				}
				//不符合格式則回傳NoData
				else{Age = 'NoData'};
			}
		
			//alert(Age);
			return Age;
		}
		
		
		
		//跳出視窗確認是否刪除
function confirm1(Serial){		
		 	if (confirm('確定要刪除嗎?')==false){return false}
			else{
window.open('Customer/DeleteCust.aspx?Serial=' + Serial,'Detail','config=height=600,width=800,resizable=yes,scrollbars=yes,location=yes');
			}
	
	}
	
///////////////////客戶服務記錄相關////////////////////////////////////////////////////////////

    ///刪除客戶服務記錄////////////////////////////////
      function DeleteCS(Serial){
	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/CustService/Delete.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
		global:false,
        	beforeSend: function(){
            
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
	    	var CustId = document.getElementById('lbl_CustId').value;
            	getCustServiceInfo(CustId);
        	}
    		});
		}
	}
	
	
 	///更新客戶服務記錄////////////////////////////////
      function UpdateCS2(){
	  
	var UnderTaker = document.getElementById('txt_CSUnderTaker').value;
	var ServiceContent = document.getElementById('txt_CSContent').value;
	var Serial = document.getElementById('hid_CSSerial').value;
	//alert(UnderTaker + '/' + ServiceContent + '/' + Serial);
	var CustId = document.getElementById('lbl_CustId').value;

	var xml;
	//alert(Serial);
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "POST",
        	url: "WebService/Cust/CustService/Post.aspx",
			data: {'Serial':Serial,'UnderTaker':UnderTaker,'SC':ServiceContent },
        	//data:'Serial='+Serial+'&UnderTaker=' + UnderTaker + '&SC=' + ServiceContent,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
            	getCustServiceInfo(CustId);
				MM_showHideLayers('apDiv5','','hide');
        	}
    		});
		}
	}


	///更新客戶資料////////////////////////////////
      function UpdateCS(Serial){
	  
	 

	MM_showHideLayers('apDiv5','','show');
	
	
			var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/CustService/getCsBySerial.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
				var UnderTaker = xml.responseXML.getElementsByTagName("UnderTaker")[0];
				var ServiceContent = xml.responseXML.getElementsByTagName("ServiceContent")[0];
				var Serial = xml.responseXML.getElementsByTagName("Serial")[0];

	    		document.getElementById('txt_CSUnderTaker').value = UnderTaker.firstChild.data;
				document.getElementById('txt_CSContent').value = ServiceContent.firstChild.data;
				document.getElementById('hid_CSSerial').value = Serial.firstChild.data;
		
				
				
            
        	}
    		});
		}
		
		function Cancel(){
		
				MM_showHideLayers('apDiv5','','hide');
				document.getElementById('txt_CSUnderTaker').value = '';
				document.getElementById('txt_CSContent').value = '';

				
		}
		
		
		

///////////////////客戶服務記錄相關////////////////////////////////////////////////////////////
		
		function HideGlaDetail(){
			document.getElementById('glassesRecentRecord').style.visibility='hidden';
			
		}

		function ShowGlaDetail(){
			document.getElementById('glassesRecentRecord').style.visibility='visible';
			
		}
/////////////////////////////////////////////////////////////////////////////////////////////

/////群組相關/////////////////////////////////////////////////////////////////////////////////
	
	function getAllGroup(){
		var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Group/getAllGroup.aspx",
        	data:'',
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
	
            		
    var results = xml.responseXML.getElementsByTagName("name");
    var term = document.getElementById('drop_Group');
    
    var option = null;
    for(var i = 0; i < results.length; i++) {
        option = document.createElement("option");
        option.appendChild(document.createTextNode(results[i].firstChild.nodeValue));
        term.appendChild(option);
		
    }
        	}
    		});
	
	}
	
	
	function UpdateGroup(Serial){
			
			MM_showHideLayers('apDiv12','','show');
			getAllGroup();  //取得所有群組
			
	}
	
	function UpdateGroup2(){
			
			var s = document.getElementById('drop_Group');
            var groupName;
            for(var i=0;i<s.options.length;i++){     
                
               groupName = s.options[s.selectedIndex].text; 
                
            }
			
			
			var Serial = document.getElementById('hid_GroupSerial2').value;
	

			var xml;
	
	if(Serial == 'NoData'){
		return false;
   	}else{
		
		xml = $.ajax({
        	type: "POST",
        	url: "WebService/Group/UpdateGroup.aspx",
			data: {'Serial':Serial,'CustGroup':groupName},
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            
        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
            	getCustServiceInfo('');
				MM_showHideLayers('apDiv12','','hide');
        	}
    		});
		}
	}
	
		function AddGroup(){
				 
	 

	MM_showHideLayers('apDiv5','','show');
	
	
			var xml;
	//alert(Serial);
	
		
		xml = $.ajax({
        	type: "GET",
        	url: "WebService/Cust/Group/AddGroup.aspx",
        	data:'Serial='+Serial,
        	Type: 'xml',
        	timeout: 5000,
			global:false,
        	beforeSend: function(){
            	
				//document.body.bgColor="#eeeeee";

        	},
        	error : function(msg){
            
        	},
        	success: function(msg){
				var UnderTaker = xml.responseXML.getElementsByTagName("UnderTaker")[0];
				var ServiceContent = xml.responseXML.getElementsByTagName("ServiceContent")[0];
				var Serial = xml.responseXML.getElementsByTagName("Serial")[0];

	    		document.getElementById('txt_CSUnderTaker').value = UnderTaker.firstChild.data;
				document.getElementById('txt_CSContent').value = ServiceContent.firstChild.data;
				document.getElementById('hid_CSSerial').value = Serial.firstChild.data;
			}
    		});
				
				
            
        	
		}


/////群組相關/////////////////////////////////////////////////////////////////////////////////

