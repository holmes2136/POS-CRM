<%@ WebHandler Language="C#" Class="getCustGlassesRecord" %>

using System;
using System.Web;
using VO;
using DataAccessLayer;
using Newtonsoft.Json;
using Util;
using System.IO;
using System.Xml.Serialization;
using System.Data;
using System.Text;

public class getCustGlassesRecord : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        
        HttpRequest req = context.Request;

        string CustId = req.QueryString["CustId"];

        if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }

        if (!PageUtil.IsAllowedUrl(req.UrlReferrer.LocalPath)) { throw new ArgumentException("wrong refer"); }

        DataTable dt = GlassesOrders.getGlassesOrders(CustId);
      
        StringBuilder sb = new StringBuilder();


        //sb.Append("<div class='custinfo'>");
        //sb.Append("<CustInfo>");

        //string Serial = "NoData";
        //string BillNumber = "NoData";
        //string SalesMan = "NoData";
        //string ProductName = "NoData";
        //string SellPrice = "NoData";
        //string Balance = "NoData";
        //string SystemTime = "NoData";

        //if (dt.Rows.Count > 0)
        //{
        //    for (int i = 0; i <= dt.Rows.Count - 1; i++)
        //    {

        //        Serial = dt.Rows[i]["Serial"].ToString();
        //        BillNumber = dt.Rows[i]["BillNumber"].ToString();
        //        SalesMan = dt.Rows[i]["SalesMan"].ToString();
        //        ProductName = dt.Rows[i]["ProductName"].ToString();
        //        SellPrice = dt.Rows[i]["SellPrice"].ToString();
        //        Balance = dt.Rows[i]["Balance"].ToString();
        //        SystemTime = dt.Rows[i]["SystemTime"].ToString();

        //        sb.AppendFormat("<Serial2 serialval2='{0}'>{1}</Serial2>", Serial, Serial);
        //        sb.AppendFormat("<Serial serialval='{0}'>{1}</Serial>", Serial, Serial);
        //        sb.AppendFormat("<BillNumber billval='{0}'>{1}</BillNumber>", BillNumber, BillNumber);
        //        sb.AppendFormat("<SalesMan salval='{0}'>{1}</SalesMan>", SalesMan, SalesMan);
        //        sb.AppendFormat("<ProductName proval='{0}'>{1}</ProductName>", ProductName, ProductName);
        //        sb.AppendFormat("<SellPrice sellval='{0}'>{1}</SellPrice>", SellPrice, SellPrice);
        //        sb.AppendFormat("<Balance balval='{0}'>{1}</Balance>", Balance, Balance);
        //        sb.AppendFormat("<SystemTime timeval='{0}'>{1}</SystemTime>", SystemTime, SystemTime);

        //    }
        //}
        //else {

        //        sb.AppendFormat("<Serial2 serialval2='{0}'>{1}</Serial2>", Serial, Serial);
        //        sb.AppendFormat("<Serial serialval='{0}'>{1}</Serial>", Serial, Serial);
        //        sb.AppendFormat("<BillNumber billval='{0}'>{1}</BillNumber>", BillNumber, BillNumber);
        //        sb.AppendFormat("<SalesMan salval='{0}'>{1}</SalesMan>", SalesMan, SalesMan);
        //        sb.AppendFormat("<ProductName proval='{0}'>{1}</ProductName>", ProductName, ProductName);
        //        sb.AppendFormat("<SellPrice sellval='{0}'>{1}</SellPrice>", SellPrice, SellPrice);
        //        sb.AppendFormat("<Balance balval='{0}'>{1}</Balance>", Balance, Balance);
        //        sb.AppendFormat("<SystemTime timeval='{0}'>{1}</SystemTime>", SystemTime, SystemTime);
        //}
        
        //sb.Append("</CustInfo>");
        //sb.Append("</div>");


        context.Response.ContentType = "application/json";
        context.Response.Write(sb.ToString());
      
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}