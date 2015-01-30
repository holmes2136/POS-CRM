<%@ WebHandler Language="C#" Class="getCustBasicInfo" %>

using System;
using System.Web;
using System.Xml.Serialization;
using VO;
using DataAccessLayer;
using Newtonsoft.Json;
using Util;
using System.IO;


public class getCustBasicInfo : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {


        #region

        HttpRequest req = context.Request;

        string CustId = req.QueryString["CustId"];

        if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }


        if (!PageUtil.IsAllowedUrl(req.UrlReferrer.LocalPath)) { throw new ArgumentException("wrong refer"); }
              
        Customer cust = Customer.CustInfo(CustId);


        string val = JsonConvert.SerializeObject(cust);
        
        context.Response.ContentType = "application/json";
        
        context.Response.Write(val);

        #endregion

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}