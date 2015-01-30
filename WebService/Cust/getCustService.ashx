<%@ WebHandler Language="C#" Class="getCustService" %>

using System;
using System.Web;
using Newtonsoft.Json;
using Util;

public class getCustService : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {


        HttpRequest req = context.Request;

        string CustId = req.QueryString["CustId"];

        if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }

        if (!PageUtil.IsAllowedUrl(req.UrlReferrer.LocalPath)) { throw new ArgumentException("wrong refer"); }

        CallCenter cc = CallCenter.getCallCenter(CustId);

        string val = JsonConvert.SerializeObject(cc);
        
        context.Response.ContentType = "application/json";

        context.Response.Write(val);
    
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}