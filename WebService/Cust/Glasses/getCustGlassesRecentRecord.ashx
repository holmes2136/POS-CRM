<%@ WebHandler Language="C#" Class="getCustGlassesRecentRecord" %>

using System;
using System.Web;
using System.Text;
using System.Web.Script.Serialization;
using System.Data;
using Newtonsoft.Json;


public class getCustGlassesRecentRecord : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {


        HttpRequest req = context.Request;

        string CustId = req.QueryString["CustId"];

        if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }


        GlassesOrders orders = GlassesOrders.getLatestGlassesOrders(CustId);

        string json = JsonConvert.SerializeObject(orders);
        //StringBuilder sb = new StringBuilder();


        //sb.Append("<div class='custinfo'>");
        //sb.Append("<CustInfo>");

        //string Serial = "NoData";
        //string BillNumber = "NoData";
        //string ProductName = "NoData";
        //string RightDegrees = "NoData";
        //string LeftDegrees = "NoData";
        //string PinClass = "NoData";
        //string PinManufacturerR = "NoData";
        //string FarOrNear = "NoData";
        //string SalesMan = "NoData";
        //string PublishDay = "NoData";
        //string SellPrice = "NoData";
        //string Balance = "NoData";
        //string Contect = "NoData";

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
        //        RightDegrees = dt.Rows[i]["RightDegrees"].ToString();
        //        LeftDegrees = dt.Rows[i]["LeftDegrees"].ToString();
        //        PinClass = dt.Rows[i]["PinClass"].ToString();
        //        PinManufacturerR = dt.Rows[i]["PinManufacturerR"].ToString();
        //        FarOrNear = dt.Rows[i]["FarOrNear"].ToString();
        //        PublishDay = dt.Rows[i]["PublishDay"].ToString();
        //        Contect = dt.Rows[i]["Contect"].ToString();
                
        //        sb.AppendFormat("<Serial2 serialval2='{0}'>{1}</Serial2>", Serial, Serial);
        //        sb.AppendFormat("<Serial serialval='{0}'>{1}</Serial>", Serial, Serial);
        //        sb.AppendFormat("<BillNumber billval='{0}'>{1}</BillNumber>", BillNumber, BillNumber);
        //        sb.AppendFormat("<SalesMan salval='{0}'>{1}</SalesMan>", SalesMan, SalesMan);
        //        sb.AppendFormat("<ProductName proval='{0}'>{1}</ProductName>", ProductName, ProductName);
        //        sb.AppendFormat("<SellPrice sellval='{0}'>{1}</SellPrice>", SellPrice, SellPrice);
        //        sb.AppendFormat("<Balance balval='{0}'>{1}</Balance>", Balance, Balance);
        //        sb.AppendFormat("<RightDegrees RightDegreesval='{0}'>{1}</RightDegrees>", RightDegrees, RightDegrees);
        //        sb.AppendFormat("<LeftDegrees LeftDegreesval='{0}'>{1}</LeftDegrees>", LeftDegrees, LeftDegrees);
        //        sb.AppendFormat("<RightDegrees RightDegreesval='{0}'>{1}</RightDegrees>", RightDegrees, RightDegrees);
        //        sb.AppendFormat("<RightDegrees RightDegreesval='{0}'>{1}</RightDegrees>", RightDegrees, RightDegrees);

                
        //    }
        //}
        //else
        //{

        //    sb.AppendFormat("<Serial2 serialval2='{0}'>{1}</Serial2>", Serial, Serial);
        //    sb.AppendFormat("<Serial serialval='{0}'>{1}</Serial>", Serial, Serial);
        //    sb.AppendFormat("<BillNumber billval='{0}'>{1}</BillNumber>", BillNumber, BillNumber);
        //    sb.AppendFormat("<SalesMan salval='{0}'>{1}</SalesMan>", SalesMan, SalesMan);
        //    sb.AppendFormat("<ProductName proval='{0}'>{1}</ProductName>", ProductName, ProductName);
        //    sb.AppendFormat("<SellPrice sellval='{0}'>{1}</SellPrice>", SellPrice, SellPrice);
        //    sb.AppendFormat("<Balance balval='{0}'>{1}</Balance>", Balance, Balance);
        //    sb.AppendFormat("<SystemTime timeval='{0}'>{1}</SystemTime>", LeftDegrees, LeftDegrees);
        //}

        //sb.Append("</CustInfo>");
        //sb.Append("</div>");


        context.Response.ContentType = "application/json";
        context.Response.Write(json);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}