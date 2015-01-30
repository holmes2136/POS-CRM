<%@ WebHandler Language="C#" Class="getCustComm" %>

using System;
using System.Web;
using System.Xml.Serialization;
using VO;
using DataAccessLayer;
using Newtonsoft.Json;
using Util;
using System.IO;


public class getCustComm : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        HttpRequest req = context.Request;

        string CustId = req.QueryString["CustId"];

        if (string.IsNullOrEmpty(CustId)) { throw new ArgumentException("CustId"); }

        if (!PageUtil.IsAllowedUrl(req.UrlReferrer.LocalPath)) { throw new ArgumentException("wrong refer"); }

        
        Comm co = Comm.CommInfo(CustId);

        XmlSerializer ser = new XmlSerializer(co.GetType());

        //string val = JsonConvert.SerializeObject(cust);

        StringWriter sw = new StringWriter();

        ser.Serialize(sw, co);

        //context.Response.ContentType = "application/json";
        context.Response.ContentType = "text/xml";

        context.Response.Write(sw.ToString());
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}