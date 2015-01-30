<%@ WebHandler Language="C#" Class="getLiquidRecord" %>

using System;
using System.Web;
using System.Data;


public class getLiquidRecord : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        //cmd.CommandText = "SELECT * FROM 日報表2  Where CustId = ? ORDER BY PublishDay DESC"

        //HttpRequest req = context.Request;

        //string CustId = req.QueryString["CustId"];

        //if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }

        //DataTable dt = LiquidOrders.getLiquidOrders(CustId);

        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}